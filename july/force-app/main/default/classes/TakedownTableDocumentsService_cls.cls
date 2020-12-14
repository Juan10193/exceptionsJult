/**
 * @File Name          : TakedownTableDocumentsService_cls.cls
 * @Description        : 
 * @Author             : eduardo.amiens@outlook.com
 * @Group              : 
 * @Last Modified By   : jhernandez@anivia.mx
 * @Last Modified On   : 14/8/2019 10:24:08
 * @Modification Log   :  
 *==============================================================================
 * Ver         Date                     Author      		      Modification
 *==============================================================================
 * 1.0    30/7/2019 12:21:05   eduardo.amiens@outlook.com     Initial Version
**/
public with sharing class TakedownTableDocumentsService_cls {
	private final String channel_Val_SAT_ENG 	= '3';
    private final String channel_Val_ENG 		= '2';
    private final String channel_Val_SAT 		= '1';
    private final String mimeTypePDF 			= 'application/pdf';
    private final String mimeTypeXML 			= 'text/xml';
    private final String docTypeXML 			= 'xml';
    private final String docTypePDF 			= 'pdf';
    private user currentUser 					{get;set;}
    private id orgID 							{get;set;}
    private id AccountID						{get;set;}

    public TakedownTableDocumentsService_cls() {
        //Obtiene datos del usuario para buscar el sso o employee number
		this.currentUser = Data_Access_User_cls.getUser(UserInfo.getUserId()); 
        //Obtiene el id de organización
    	this.orgID 		 = UserInfo.getOrganizationId();
    }
   
    public void validateInvoices(List<takedownTableDocumentsWrapper_cls.TableElement> listTableElement){
        system.debug(LoggingLevel.INFO, 'Inicia validateInvoices');
        //Limpia la lista de elementos, evita que se validen documentos PDF, además 
        listTableElement = cleanList(listTableElement);
        
        //Ensambla el wrapper para crear un json
        List<Takedown_Wrapper_SATVal_OL_cls.SATValRequest> listSATValRequest = new List<Takedown_Wrapper_SATVal_OL_cls.SATValRequest>(); 
        listSATValRequest = fillWrapperRequest(listTableElement);
        
        //Pone los documentos en estatus en proceso
        updateStatusValidateData(listTableElement);
        
        //Inicia los chain para validar archivos con WS
        validateData(listSATValRequest);
    }
    
    public List<takedownTableDocumentsWrapper_cls.TableElement> cleanList(List<takedownTableDocumentsWrapper_cls.TableElement> listTableElement){
        set<id> 		setContent_Version_ID 	= new set<id>();
        set<id> 		setTakedownIds 			= new set<id>();
        
        List<takedownTableDocumentsWrapper_cls.TableElement> listTableElementOnlyXML = new List<takedownTableDocumentsWrapper_cls.TableElement>();
        //Extrae los id de contentversion para obtener los archivos a procesar
        //Extrae los index de la lista para los elementos de tipo xml, mas tarde se eliminaran de la lista
        this.AccountID = listTableElement.get(0).AccountId;
        System.debug('this.AccountID ' + this.AccountID);
        //
        for(takedownTableDocumentsWrapper_cls.TableElement tableElement : listTableElement){
            system.debug('tableElement.TKD_ls_asset_type ' + tableElement.TKD_ls_asset_type);
            system.debug('tableElement.TKD_pd_Takedown_CP ' + tableElement.TKD_pd_Takedown_CP);
            setTakedownIds.add(tableElement.TKD_pd_Takedown_CP);
        }
        set<id> setAvoidTakedownInvoice = Data_Access_Takedown_Invoice_cls.getTakedownToAvoid(setTakedownIds);
        
        for(takedownTableDocumentsWrapper_cls.TableElement tableElement : listTableElement){ 
            System.debug('tableElement.TKD_pd_Takedown_CP ' + tableElement.id);
            if((String.isNotBlank(tableElement.TKD_txt_Extension) && !tableElement.TKD_txt_Extension.equals(this.docTypeXML)) 
               || (setAvoidTakedownInvoice.contains(tableElement.id))){
             	System.debug('Se omite el elemento ' + listTableElement.indexOf(tableElement) + ' ya que no es un formato xml o ya fue validado');            
            }else{
                listTableElementOnlyXML.add(tableElement);
            	setContent_Version_ID.add(tableElement.TKD_txt_Content_Version_ID);    
            }            
        }
		
        //Convierte los archivos de content a base64
        for(ContentVersion conVer : Data_Access_ContentVersion.getInvoicesTakedownByID(setContent_Version_ID)){  
            for(takedownTableDocumentsWrapper_cls.TableElement tableElement : listTableElementOnlyXML){
                if(tableElement.TKD_txt_Content_Version_ID.equals(conVer.id)){
                	tableElement.Base64 = EncodingUtil.base64Encode(conVer.VersionData); 
                }
            }    
        }
        return listTableElementOnlyXML;
    }
    
    public List<Takedown_Wrapper_SATVal_OL_cls.SATValRequest> fillWrapperRequest(List<takedownTableDocumentsWrapper_cls.TableElement> listTableElement){
        List<Takedown_Wrapper_SATVal_OL_cls.SATValRequest> listSATValRequest = new List<Takedown_Wrapper_SATVal_OL_cls.SATValRequest>(); 
        for(takedownTableDocumentsWrapper_cls.TableElement TableElement : listTableElement){
        	Takedown_Wrapper_SATVal_OL_cls.SATValRequest request = new Takedown_Wrapper_SATVal_OL_cls.SATValRequest();
            request.assetType       = TableElement.TKD_ls_asset_type;
            request.channel 		= channel_Val_SAT_ENG;
            request.documentId 		= TableElement.TKD_txt_Document_ID;
            request.mimeTypeXML 	= this.mimeTypeXML;
            request.organizationId 	= this.orgID;
            request.ssoId 			= this.currentUser.EmployeeNumber;
            request.takedownId 		= tableElement.TKD_pd_Takedown_CP;
            system.debug('tableElement.Base64 ' + tableElement.Base64);
            request.xmlBase64 		= tableElement.Base64; 
            //System.debug('request.assetType' + request.assetType);
            listSATValRequest.add(request);
        }
        return listSATValRequest;
    }
    
    public void updateStatusValidateData(List<takedownTableDocumentsWrapper_cls.TableElement> listTableElement){
        List<Takedown_Invoice__c> documentsInProcess = new List<Takedown_Invoice__c>();
        for(takedownTableDocumentsWrapper_cls.TableElement  tableElement : listTableElement){
            Takedown_Invoice__c documentInProcess = new Takedown_Invoice__c();
            documentInProcess.Id = tableElement.id;
            documentInProcess.TKD_ls_SAT_Status__c = 'action:change_record_type';
            documentInProcess.TKD_ls_Eng_Status__c = 'action:change_record_type';
            documentsInProcess.add(documentInProcess);            
        }
        DMLO_Takedown_Invoice_cls.upsertInvoices(documentsInProcess);        
    }
    
    public void validateData(List<Takedown_Wrapper_SATVal_OL_cls.SATValRequest> listSATValRequest){
    	if(!test.isRunningTest())
        if(listSATValRequest.size() > 0){
           	System.enqueueJob(new Takedown_ParentChain_Execution_cls(listSATValRequest,this.AccountID));
        }
    }
    
    public void validateRefactura(List<takedownTableDocumentsWrapper_cls.TableElement> listTableElement){
        updateStatusValidateDataRefactura(listTableElement);
        
        ValidacionReFacturacionInvoice.validateTotalCostAsset(listTableElement);
    }
    
    public void updateStatusValidateDataRefactura(List<takedownTableDocumentsWrapper_cls.TableElement> listTableElement){
        List<Takedown_Invoice__c> documentsInProcess = new List<Takedown_Invoice__c>();
        for(takedownTableDocumentsWrapper_cls.TableElement  tableElement : listTableElement){
            Takedown_Invoice__c documentInProcess = new Takedown_Invoice__c();
            if(tableElement.TKD_pk_factura == '' || tableElement.TKD_pk_factura == null) {
                documentInProcess.Id = tableElement.id;
                documentInProcess.TKD_txt_refactura_message__c = 'You must select takedown invoice';
            	documentInProcess.TKD_pk_Refactura_status__c = 'action:close';
            }
            else {
                documentInProcess.Id = tableElement.id;
                documentInProcess.TKD_pk_Refactura_status__c = 'action:change_record_type';
            }
            
            documentsInProcess.add(documentInProcess);            
        }
        DMLO_Takedown_Invoice_cls.upsertInvoices(documentsInProcess);        
    }
}