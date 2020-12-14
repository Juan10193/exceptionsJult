public class ES4_Controller_EVAL {
    
    public List<SelectOption> option_Term_Months {get; set;}
    public List<SelectOption> option_Max_Months {get; set;}
    public list<SelectOption> colateral_Type{get; set;}
    public list<SelectOption> colateral_Desq{get; set;}
    public list<SelectOption> Manufacture{get; set;}
    public list<SelectOption> Models{get; set;}
    public list<SelectOption> Years{get; set;}
    public ES2_WraperRequest req                        {get;set;}
    public List<EIV_EntityWrapClass> entities           {get;set;}
    public EIV_DetailWrapClass detail                   {get;set;}
    public string idReg						            {get;set;}
    public string idcloneass							{get;set;}
    public ES4_wraper_EVAL_Assets ASS 			        {get;set;}
    public ES4_Wraper_EVAL_Valuation VALL		        {get;set;}
    public ES4_Wraper_EVAL_Endorsement ENDO 	        {get;set;}
    public list<ES2_WraperRequest> dts 		            {get;set;}
    //para workflow
    public boolean sendbtn								{get;set;}
    public boolean aceptbtn								{get;set;}
    public boolean onhdbtn								{get;set;}
    public boolean EFA                                  {get;set;}
    public boolean FMV                                  {get;set;}
    public boolean reworkbtn							{get;set;}
    public boolean rejbtn								{get;set;}
    public boolean preaprbtn							{get;set;}
    public boolean aprbtn								{get;set;}
    public boolean Aaprbtn								{get;set;}
    public boolean cancelbtn							{get;set;}
    public boolean btentbtn								{get;set;}
    public boolean btoppbtn								{get;set;}
    public boolean reasingbtn							{get;set;}
    public boolean editbtn								{get;set;}
    public boolean Ncombtn								{get;set;}
    public boolean Ndocbtn								{get;set;}
    public boolean backToEnBtn                          {get;set;}
    public boolean backToOpbtn                          {get;set;}
    public boolean backToTKD							{get;set;}
    //para madar datos
    public String sServiceURL 							{get;set;}
    public string UrlAppDoctos {get;set;}
    public string EncriptationType {get;set;}
    public string KeyEncriptation {get;set;}
    public string URL_Servicio_Externa {get;set;}
    public string partyId	{get;Set;}
    public string oracleAccountName {get;set;}
    public String sSSO 									{get;set;}
    public String typeS 									{get;set;}
    
    public String nameDoc 								{get;set;}
    public String idDoc 								{get;set;}
    public String requestIdDoc 							{get;set;}
    public String partyIdDoc 							{get;set;}
    public string oraId									{get;set;}
    public string docType								{get;set;}
    //para descargar doctos
    public string docId  								{get;set;}
    public string docUrl								{get;set;}
    public string cddate								{get;set;}
    public boolean urlflag								{get;set;}
    public string backUrl								{get;set;}
    public list <string> doctypess {get;Set;}
    public string doctiposString {get;set;}
    
    //para subir excel Asset
    public Blob csvFileBodyAss{get;set;}
    public string csvAsStringAss{get;set;}
    public String dataAss{get;set;}
    public String[] csvFileLinesAss{get;set;}
    //para subir excel Valuation
    public Blob csvFileBodyVal{get;set;}
    public string csvAsStringVal{get;set;}
    public String dataVal{get;set;}
    public String[] csvFileLinesVal{get;set;}
    
    //para las listas
    public string type    {get;Set;}
    public string man {get;Set;}
    public string model {get;set;}
    public string modelYear {get;Set;}
    public string mancam{get;set;}
    public string manlist{get;set;}
    public string colaBox{get;Set;}
    public string colaDescBox{get;set;}
    public string manufacBox{get;Set;}
    public string modelBox{get;set;}
    public string AyearBox{get;set;}
    public boolean equipodeTecnologiaException {get;set;}

    public Datetime fechaContent                              {get;set;}
    public Datetime startfecha                                {get;set;}
    public Boolean lightn {get;set;}
    public Boolean visual {get;Set;}
    
    
    
    public string k{get;set;}
    
    //para ver insurance
    public String sIdChild                                {get;set { sIdChild = value; System.debug('value sIdChild OEJ: '+value); }}
    public String sIdTypeRequest                          {get;set { sIdTypeRequest = value; System.debug('value sIdTypeRequest OEJ: '+value); }}      
    
    
    
    //para encriptarURl
    public string encodedTextAES									{get;set;}
    public EIV_EntityWrapClass entity								{get;set;}
    
    public String sEntityMasterIdSelected;
    public String getsEntityMasterIdSelected() {
        return this.sEntityMasterIdSelected;
    }
    
    
    
    
    public void setsEntityMasterIdSelected(String sEntityMasterIdSelected) {
        if(entities != null && entities.size()>0)
        {
            for (EIV_EntityWrapClass f : entities) 
            {  
                if(f.Party_Id == sEntityMasterIdSelected )
                {
                    
                    this.entity = f;
                    this.sEntityMasterIdSelected = sEntityMasterIdSelected;
                }                                                            
            }            
        }
        
        	
        
        if( String.isBlank(sEntityMasterIdSelected)  )
        {
            req.pOutPartyId = '';
            req.pOutPartyName = '';
        }
            
    }    
    
    public void cargaDummy()
    {
        this.ENDO = new ES4_Wraper_EVAL_Endorsement();
        this.VALL = new ES4_Wraper_EVAL_Valuation();
        this.ASS = new ES4_wraper_EVAL_Assets();
        this.ASS.pOutEVAssetActiveFlag = 'Y';
        this.ASS.pOutEVAssetAssetId  = '11111';
        this.ASS.pOutEVAssetAssetModel = 'MONSTER';
        this.ASS.pOutEVAssetAssetModelYear  = '2018';
        this.ASS.pOutEVAssetCollateralDescription  = 'TRANSPORTATION ACCESSORIES';
        this.ASS.pOutEVAssetCollateralId ='1111';
        this.ASS.pOutEVAssetCollateralType='TRANSPORTATION - TRUCK';
        this.ASS.pOutEVAssetConditionType='NEW';
        this.ASS.pOutEVAssetCreatedBy='19101';
        this.ASS.pOutEVAssetCreationDate='11/11/11';
        this.ASS.pOutEVAssetCurrencyType='MXN';
        this.ASS.pOutEVAssetExchangeRate='1000';
        this.ASS.pOutEVAssetFreightCost='0';
        this.ASS.pOutEVAssetImportFlag='Y';
        this.ASS.pOutEVAssetInstallationCost='0';
        this.ASS.pOutEVAssetInsuranceType='Customer';
        this.ASS.pOutEVAssetLastUpdateDate='12/12/12';
        this.ASS.pOutEVAssetLastUpdatedBy='19102';
        this.ASS.pOutEVAssetManufacturer='OTHER';
        this.ASS.pOutEVAssetMultLocationFlag='N';
        this.ASS.pOutEVAssetNameCreatedBy='pancho';
        this.ASS.pOutEVAssetNameUpdatedBy='fulano';
        this.ASS.pOutEVAssetOracleFACategory='';
        this.ASS.pOutEVAssetOracleFACategoryID='11111';
        this.ASS.pOutEVAssetOracleFASubcategory='';
        this.ASS.pOutEVAssetParkingCost='0';
        this.ASS.pOutEVAssetPhysicalCatType='';
        this.ASS.pOutEVAssetQuantity='1';
        this.ASS.pOutEVAssetRapidTagFlag='Y';
        this.ASS.pOutEVAssetRequestId='1234';
        this.ASS.pOutEVAssetSoftwareCost='0';
        this.ASS.pOutEVAssetTotalCost='1000';
        this.ASS.pOutEVAssetTrainingCost='0';
        this.ASS.pOutEVAssetUnitCost='0';
        this.ASS.pOutEVAssetUnitTax='0';
        this.ASS.pOutEVAssetWarrantyCost='0';

        this.ENDO.pOutEVEndActiveFlag='Y';
        this.ENDO.pOutEVEndAssetId='11111';
        this.ENDO.pOutEVEndAttributeType='';
        this.ENDO.pOutEVEndComment='hola mundo';
        this.ENDO.pOutEVEndCreatedBy='19101';
        this.ENDO.pOutEVEndCreationDate='11/11/11';
        this.ENDO.pOutEVEndEndorsementId='22222';
        this.ENDO.pOutEVEndLastUpdateDate='12/12/12';
        this.ENDO.pOutEVEndLastUpdatedBy='19102';
        this.ENDO.pOutEVEndNameCreatedBy='pancho';
        this.ENDO.pOutEVEndNameUpdatedBy='fulano';
        this.ENDO.pOutEVEndRequestId='1234';
        this.ENDO.pOutEVEndUomType='1';
        this.ENDO.pOutEVEndValueOther='1';
        this.ENDO.pOutEVEndValueType='1';
        
        this.ASS.pOutEVEndorsementTBL.add(ENDO);
        
        this.VALL.pOutEVValActiveFlag='Y';
        this.VALL.pOutEVValAssetId ='11111';
        this.VALL.pOutEVValCreatedBy='19101';
        this.VALL.pOutEVValCreationDate='11/11/11';
        this.VALL.pOutEVValFMVAmount='1000';
        this.VALL.pOutEVValFMVPercent='10';
        this.VALL.pOutEVValInsurancePrima='0';
        this.VALL.pOutEVValLastUpdateDate='12/12/12';
        this.VALL.pOutEVValLastUpdatedBy='19102';
        this.VALL.pOutEVValNameCreatedBy='pancho';
        this.VALL.pOutEVValNameUpdatedBy='fulano';
        this.VALL.pOutEVValNRVAmount='1000';
        this.VALL.pOutEVValNRVPercent='20';
        this.VALL.pOutEVValOLVAmount='1000';
        this.VALL.pOutEVValOLVPercent='30';
        this.VALL.pOutEVValRequestId='1234';
        this.VALL.pOutEVValRVAmount='1000';
        this.VALL.pOutEVValRVPercent='40';
        this.VALL.pOutEVValTermMonths='0';
        this.VALL.pOutEVValValuationId='33333';
        this.ASS.pOutEVValuationTBL.add(VALL);
        
        
    }
    
    public void cargaDummy2()
    {
        this.ENDO = new ES4_Wraper_EVAL_Endorsement();
        this.VALL = new ES4_Wraper_EVAL_Valuation();
        this.ASS = new ES4_wraper_EVAL_Assets();
        this.ASS.pOutEVAssetActiveFlag = 'Y';
        this.ASS.pOutEVAssetAssetId  = '11111';
        this.ASS.pOutEVAssetAssetModel = 'MONSTER';
        this.ASS.pOutEVAssetAssetModelYear  = '2018';
        this.ASS.pOutEVAssetCollateralDescription  = 'TRANSPORTATION ACCESSORIES';
        this.ASS.pOutEVAssetCollateralId ='1111';
        this.ASS.pOutEVAssetCollateralType='TRANSPORTATION - TRUCK';
        this.ASS.pOutEVAssetConditionType='NEW';
        this.ASS.pOutEVAssetCreatedBy='19101';
        this.ASS.pOutEVAssetCreationDate='11/11/11';
        this.ASS.pOutEVAssetCurrencyType='MXN';
        this.ASS.pOutEVAssetExchangeRate='1000';
        this.ASS.pOutEVAssetFreightCost='0';
        this.ASS.pOutEVAssetImportFlag='Y';
        this.ASS.pOutEVAssetInstallationCost='0';
        this.ASS.pOutEVAssetInsuranceType='Customer';
        this.ASS.pOutEVAssetLastUpdateDate='12/12/12';
        this.ASS.pOutEVAssetLastUpdatedBy='19102';
        this.ASS.pOutEVAssetManufacturer='OTHER';
        this.ASS.pOutEVAssetMultLocationFlag='N';
        this.ASS.pOutEVAssetNameCreatedBy='pancho';
        this.ASS.pOutEVAssetNameUpdatedBy='fulano';
        this.ASS.pOutEVAssetOracleFACategory='';
        this.ASS.pOutEVAssetOracleFACategoryID='11111';
        this.ASS.pOutEVAssetOracleFASubcategory='';
        this.ASS.pOutEVAssetParkingCost='0';
        this.ASS.pOutEVAssetPhysicalCatType='';
        this.ASS.pOutEVAssetQuantity='1';
        this.ASS.pOutEVAssetRapidTagFlag='Y';
        this.ASS.pOutEVAssetRequestId='1234';
        this.ASS.pOutEVAssetSoftwareCost='0';
        this.ASS.pOutEVAssetTotalCost='1000';
        this.ASS.pOutEVAssetTrainingCost='0';
        this.ASS.pOutEVAssetUnitCost='0';
        this.ASS.pOutEVAssetUnitTax='0';
        this.ASS.pOutEVAssetWarrantyCost='0';

        this.ENDO.pOutEVEndActiveFlag='Y';
        this.ENDO.pOutEVEndAssetId='11111';
        this.ENDO.pOutEVEndAttributeType='';
        this.ENDO.pOutEVEndComment='hola mundo';
        this.ENDO.pOutEVEndCreatedBy='19101';
        this.ENDO.pOutEVEndCreationDate='11/11/11';
        this.ENDO.pOutEVEndEndorsementId='22222';
        this.ENDO.pOutEVEndLastUpdateDate='12/12/12';
        this.ENDO.pOutEVEndLastUpdatedBy='19102';
        this.ENDO.pOutEVEndNameCreatedBy='pancho';
        this.ENDO.pOutEVEndNameUpdatedBy='fulano';
        this.ENDO.pOutEVEndRequestId='1234';
        this.ENDO.pOutEVEndUomType='1';
        this.ENDO.pOutEVEndValueOther='1';
        this.ENDO.pOutEVEndValueType='1';
        
        this.ASS.pOutEVEndorsementTBL.add(ENDO);
        
        this.VALL.pOutEVValActiveFlag='Y';
        this.VALL.pOutEVValAssetId ='11111';
        this.VALL.pOutEVValCreatedBy='19101';
        this.VALL.pOutEVValCreationDate='11/11/11';
        this.VALL.pOutEVValFMVAmount='1000';
        this.VALL.pOutEVValFMVPercent='10';
        this.VALL.pOutEVValInsurancePrima='0';
        this.VALL.pOutEVValLastUpdateDate='12/12/12';
        this.VALL.pOutEVValLastUpdatedBy='19102';
        this.VALL.pOutEVValNameCreatedBy='pancho';
        this.VALL.pOutEVValNameUpdatedBy='fulano';
        this.VALL.pOutEVValNRVAmount='1000';
        this.VALL.pOutEVValNRVPercent='20';
        this.VALL.pOutEVValOLVAmount='1000';
        this.VALL.pOutEVValOLVPercent='30';
        this.VALL.pOutEVValRequestId='1234';
        this.VALL.pOutEVValRVAmount='1000';
        this.VALL.pOutEVValRVPercent='40';
        this.VALL.pOutEVValTermMonths='0';
        this.VALL.pOutEVValValuationId='33333';
        this.ASS.pOutEVValuationTBL.add(VALL);
        
        
    }
    
    public void cargaValuation(){
        
        this.VALL = new ES4_Wraper_EVAL_Valuation();
        
        this.VALL.pOutEVValActiveFlag='Y';
        this.VALL.pOutEVValAssetId ='11111';
        this.VALL.pOutEVValCreatedBy='19101';
        this.VALL.pOutEVValCreationDate='11/11/11';
        this.VALL.pOutEVValFMVAmount='1000';
        this.VALL.pOutEVValFMVPercent='10';
        this.VALL.pOutEVValInsurancePrima='0';
        this.VALL.pOutEVValLastUpdateDate='12/12/12';
        this.VALL.pOutEVValLastUpdatedBy='19102';
        this.VALL.pOutEVValNameCreatedBy='pancho';
        this.VALL.pOutEVValNameUpdatedBy='fulano';
        this.VALL.pOutEVValNRVAmount='1000';
        this.VALL.pOutEVValNRVPercent='20';
        this.VALL.pOutEVValOLVAmount='1000';
        this.VALL.pOutEVValOLVPercent='30';
        this.VALL.pOutEVValRequestId='1234';
        this.VALL.pOutEVValRVAmount='1000';
        this.VALL.pOutEVValRVPercent='40';
        this.VALL.pOutEVValTermMonths='0';
        this.VALL.pOutEVValValuationId='33333';
        
    }
    public void cargaEndorsement(){
        this.ENDO = new ES4_Wraper_EVAL_Endorsement();
        
        this.ENDO.pOutEVEndActiveFlag='Y';
        this.ENDO.pOutEVEndAssetId='11111';
        this.ENDO.pOutEVEndAttributeType='';
        this.ENDO.pOutEVEndComment='hola mundo';
        this.ENDO.pOutEVEndCreatedBy='19101';
        this.ENDO.pOutEVEndCreationDate='11/11/11';
        this.ENDO.pOutEVEndEndorsementId='22222';
        this.ENDO.pOutEVEndLastUpdateDate='12/12/12';
        this.ENDO.pOutEVEndLastUpdatedBy='19102';
        this.ENDO.pOutEVEndNameCreatedBy='pancho';
        this.ENDO.pOutEVEndNameUpdatedBy='fulano';
        this.ENDO.pOutEVEndRequestId='1234';
        this.ENDO.pOutEVEndUomType='1';
        this.ENDO.pOutEVEndValueOther='1';
        this.ENDO.pOutEVEndValueType='1';
        
    }
    
    public ES4_Controller_EVAL(){
        colateraltype();
        
        this.req = new ES2_WraperRequest();
        
        mancam= 'none';
        //manlist = 'none';
        csvFileLinesASS = new String[]{};
            this.partyId =  Test.isRunningTest() ? '1234' :(String)System.currentPageReference().getParameters().get('PartyId'); 
        	this.oracleAccountName =  Test.isRunningTest() ? '1234' :(String)System.currentPageReference().getParameters().get('OracleAccountName'); 
            this.req.pOutRequestId =  Test.isRunningTest() ? '1234' :(String)System.currentPageReference().getParameters().get('requestId'); 
        string bckflag = (String)System.currentPageReference().getParameters().get('from');
        if(bckflag == 'Opportunity'){ backToEnBtn = false;
        }else{
            backToEnBtn = true;
        }
        if(bckflag =='Opportunity'){backToOpbtn = true;
        }else{
            backToOpbtn = false;
        }
        
        if(bckflag =='Takedown'){
            backToTKD = true;
            backToOpbtn = false;
            backToEnBtn = false;
        }
        string contentDateLightning = Test.isRunningTest() ?'2020/11/05 12:16:37':[Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='ContentEntityMaster'][0].EIV_tx_parameter__c;
        this.fechaContent = DateTime.valueOfGmt(contentDateLightning.replaceAll('/','-'));
        this.sServiceURL = Test.isRunningTest() ? 'hola mundo' :[Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='URL_Servicio'][0].EIV_tx_parameter__c; 
        this.sSSO = Test.isRunningTest() ? '666' : [Select EmployeeNumber From User Where Id = :UserInfo.getUserId()][0].EmployeeNumber;  
        this.UrlAppDoctos = Test.isRunningTest() ? 'https://test.com' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='UrlAppDoctos'][0].EIV_tx_parameter__c; 
        this.EncriptationType = Test.isRunningTest() ? 'AES128' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='EncriptationType'][0].EIV_tx_parameter__c; 
        this.KeyEncriptation = Test.isRunningTest() ? 'https://test.com' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='KeyEncriptation'][0].EIV_tx_parameter__c; 
        this.URL_Servicio_Externa = Test.isRunningTest() ? 'https://test.com' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='URL_Servicio_Externa'][0].EIV_tx_parameter__c;
        Items_Term_Months();
        Items_Max_Months();
       
        
        if ( String.isNotBlank(this.req.pOutRequestId) )
        {
            //es una consulta
            Map<string,object>jsonResponse =null;
            
            
            //jsonResponse = (Map<string,object>)JSON.deserializeUntyped(ES2_jsonDummy.entitymasterToJson());
            jsonResponse = EIV_EntityExtencionCalloutClass.callBackGetRequestDetailsOne(this.sSSO, 'SF', this.sServiceURL, this.req.pOutRequestId);
           
            Map<String, Object> mapRequests = (Map<String, Object>)jsonResponse.get('requests');
            if(mapRequests==null)
            {
                
            }   
            else
            {
                ES2_Controller_KWYPMoralFill rellena = new  ES2_Controller_KWYPMoralFill();
                
                list<ES2_WraperRequest> dts = new list<ES2_WraperRequest>();
                dts = rellena.rellenarHeader(mapRequests);
                if(dts.size()>0)
                {
                    req = dts[0];
                    this.startfecha =Datetime.valueOfGmt(this.req.pOutStartDate.replaceALL('T',' '));
                    if(this.startfecha < this.fechaContent){
                        this.lightn = false;
                        this.visual = true;
                    }else{
                        this.lightn = true;
                        this.visual = false;
                    }
                }
                
                get_csv();
                get_csv_val();
                yesnobtn();
                muestra();
                prende();
                
                
                
            }
            
        }
        else
        {
            this.req.EVALOBJ.pOutEVProductType =  Test.isRunningTest() ? 'hola mundo' :(String)System.currentPageReference().getParameters().get('productype');
            this.req.EVALOBJ.pOutEVCurrencyType =  Test.isRunningTest() ? 'hola mundo' :(String)System.currentPageReference().getParameters().get('currencyTpe');
            this.req.pOutRequestId =  Test.isRunningTest() ? '123' :(String)System.currentPageReference().getParameters().get('requestId');    
            this.req.pOutPartyName = (String) System.currentPageReference().getParameters().get('OracleAccountName');
            
            this.req.pOutPartyId = (String)System.currentPageReference().getParameters().get('PartyId');
            this.req.pOutSourceOpId = Test.isRunningTest() ? '123' :(String)System.currentPageReference().getParameters().get('Oppid');
            this.req.pOutSourceAccountName = Test.isRunningTest() ? 'hola mundo' :(String)System.currentPageReference().getParameters().get('AccountName');
            this.req.pOutSourceAccountId = Test.isRunningTest() ? '123' :(String)System.currentPageReference().getParameters().get('AccountId');
            this.req.pOutSourceTopParentId = Test.isRunningTest() ? '123' :(String)System.currentPageReference().getParameters().get('TopParentID');
            this.req.pOutsourceTopParentName  = Test.isRunningTest() ? 'hola' :(String) System.currentPageReference().getParameters().get('TopParentName');
            req.pOutCreatedBy = sSSO;
            req.pOutUpdatedBy=sSSO;
            req.pOutRequestedBy = sSSO;
            req.pOutStartDate = System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00'));
            req.pOutLastUpdateDate = System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00'));
            req.pOutActiveFlag = 'Y';
            muestra();
            prende();
        }
    } 
    public list<Integer> templeteval(){
        integer [] terms = new Integer[3];
        List<Integer> listmax = new List<Integer>();
        if(req.EVALOBJ.pOutEVSpecialTermMonths01 != ''){ terms[0]=integer.valueOf(pasnullnum(req.EVALOBJ.pOutEVSpecialTermMonths01));           }
        if(req.EVALOBJ.pOutEVSpecialTermMonths02 != ''  ){ terms[1]=integer.valueOf(pasnullnum(req.EVALOBJ.pOutEVSpecialTermMonths02));       }
        if(req.EVALOBJ.pOutEVSpecialTermMonths03 !='' ){  terms[2]=integer.valueOf(pasnullnum(req.EVALOBJ.pOutEVSpecialTermMonths03));     }
        
        for(integer i=0;i<=integer.valueOf(req.EVALOBJ.pOutEVResidualMaxTermMonths);i+=12){      listmax.add(i);        }
        if(terms.size()>0){
            for(integer b=0; b<terms.size();b++){
                if(terms[b] != 0 && math.mod(integer.valueOf(terms[b]), 12) != 0){               listmax.add(terms[b]);                }
                
            } 
        }else{
               
        }
        
        listmax.sort();
        return listmax;
    }
    
    public void muestra(){
        if(req.pOutRequestStatus == 'IN PROCESS'){
            EFA = true;
            FMV = true;
            
        }else{
            EFA = false;
            FMV = false;
        }
    }
    
    public List<SelectOption> colateraltype(){
        colateral_Type = new List<SelectOption>();
        list<AggregateResult> a = [SELECT COLATERAL_TYPE__c  FROM Catalogo_Colaterals__c GROUP BY COLATERAL_TYPE__c];
        colateral_Type.add(new SelectOption('',''));
        for(integer d=0;d<a.size();d++){
            string colaS=String.valueOf(a[d].get('COLATERAL_TYPE__c'));
            colateral_Type.add(new SelectOption(colaS,colaS));
        }
        return colateral_Type;
        
    }
    public void colateraldesq(){
        type = ApexPages.currentPage().getParameters().get('one');
        colateral_Desq = new List<SelectOption>();
        list<AggregateResult> a = [
            SELECT COLATERAL_DESCRIPTION__c FROM Catalogo_Colaterals__c WHERE COLATERAL_TYPE__c =:type GROUP BY COLATERAL_DESCRIPTION__c];
        colateral_Desq.add(new SelectOption('',''));
        for(integer d=0;d<a.size();d++){  string colaS=String.valueOf(a[d].get('COLATERAL_DESCRIPTION__c')); colateral_Desq.add(new SelectOption(colaS,colaS));   }
        
    }
    
    public List<SelectOption> getEntitiesOptions(){        
        List<SelectOption> listEntitiesOptions = new List<SelectOption>(); 
        
        if ( String.isBlank(this.req.pOutSourceAccountId) && String.isBlank(this.req.pOutSourceTopParentId))
        {
            String partyIdGetURL = test.isRunningTest()?'123':(String)System.currentPageReference().getParameters().get('PartyId');
			String oracleAccountNameGetURL = test.isRunningTest()?'123':System.currentPageReference().getParameters().get('OracleAccountName');  
            if( String.isBlank(partyIdGetURL) || String.isBlank(oracleAccountNameGetURL)) { partyIdGetURL = req.pOutPartyId; oracleAccountNameGetURL = req.pOutPartyName;  }
            listEntitiesOptions.add(new SelectOption(partyIdGetURL,oracleAccountNameGetURL));
            entity = new EIV_EntityWrapClass();
            entity.Party_Id = (String)System.currentPageReference().getParameters().get('PartyId');
            entity.Oracle_Account_Name = (String)System.currentPageReference().getParameters().get('OracleAccountName');
        }
        else
        {
            if(String.isNotBlank(req.pOutPartyId) && String.isNotBlank(req.pOutPartyName))    { listEntitiesOptions.add(new SelectOption(req.pOutPartyId,req.pOutPartyName));  }
            listEntitiesOptions.add(new SelectOption('','SELECTION'));
            
            
            //Carga de entities
            getListEntities();
            
            if(entities.size()>0)
            {
                for(EIV_EntityWrapClass entit : this.entities ){         
                   
                    if(req.pOutPartyId != entit.Party_Id)    {   listEntitiesOptions.add(new SelectOption(entit.Party_Id, entit.Oracle_Account_Name));          }                    
                }
                
                if(backToEnBtn == true){  	listEntitiesOptions.add(new SelectOption(this.req.pOutPartyId, this.req.pOutPartyName ));    sEntityMasterIdSelected =this.partyId;    	}
            }
            
            
        }
        
        return listEntitiesOptions;
        
        
    }    
    
    public void maufactur(){
        man = ApexPages.currentPage().getParameters().get('two');
        Manufacture = new List<SelectOption>();
        list<AggregateResult> a = [SELECT MANUFACTURER__c FROM Catalogo_Colaterals__c WHERE COLATERAL_TYPE__c = :type AND COLATERAL_DESCRIPTION__c =:man  GROUP BY MANUFACTURER__c];
       
        Manufacture.add(new SelectOption('',''));
        integer b = a.size();
       
        /*if(b == 1){
system.debug('voy a desbloquear campo');
mancam = 'Block';
system.debug('voy a desbloquear campo ' + mancam);
}else{*/
        
        //manlist = 'Block';
        for(integer d=0;d<a.size();d++){  string colaS=String.valueOf(a[d].get('MANUFACTURER__c'));  Manufacture.add(new SelectOption(colaS,colaS));    }
        
    }
    
    
    public void model_list(){
        Model = ApexPages.currentPage().getParameters().get('tree');
        Models = new List<SelectOption>();
        list<AggregateResult> a = [
            SELECT MODEL__c FROM Catalogo_Colaterals__c WHERE COLATERAL_TYPE__c =:type AND COLATERAL_DESCRIPTION__c =:man AND MANUFACTURER__c =:Model  GROUP BY MODEL__c];
        Models.add(new SelectOption('',''));
        for(integer d=0;d<a.size();d++){  string colaS=String.valueOf(a[d].get('MODEL__c'));  Models.add(new SelectOption(colaS,colaS));   }          
    }

    @RemoteAction
    public static string OracleFAID (string Ctype, string Cdesc){
       list<Catalogo_Colaterals__c> a =[SELECT Oracle_FA_Category_ID__c FROM Catalogo_Colaterals__c WHERE COLATERAL_TYPE__c =:Ctype AND COLATERAL_DESCRIPTION__c =:Cdesc];
        
        string b = string.valueOf(a[0].get('Oracle_FA_Category_ID__c'));
       
        if(b==null){
            b='';
        }
        
        return b; 
    }  
    
    public void years_list(){
        modelYear = ApexPages.currentPage().getParameters().get('four');
        Years = new List<SelectOption>();
        list<AggregateResult> a = [SELECT MODEL_YEAR__c FROM Catalogo_Colaterals__c WHERE COLATERAL_TYPE__c =:type AND COLATERAL_DESCRIPTION__c =:man AND MANUFACTURER__c =:model AND MODEL__c =:modelYear  GROUP BY MODEL_YEAR__c];
        Years.add(new SelectOption('',''));
        Years.add(new SelectOption('----','----'));
        for(integer d=0;d<a.size();d++){ string colaS=String.valueOf(a[d].get('MODEL_YEAR__c'));  if(colaS != null){      Years.add(new SelectOption(colaS,colaS));      }
            
        }         
    }
    
    public void prende(){
        
        if(req.pOutPartyName == ''){    btentbtn = false;
        }else{
            btentbtn = true;  
        }
        if(req.pOutSourceOpId == ''){   btoppbtn = false;
        }else{
            btentbtn = false;
        }
    }
    
    public PageReference editEVAL()
    {
        //falta logica del guardado
        /////***////
        req.pOutUpdatedBy = sSSO;
        
        setsEntityMasterIdSelected( this.req.pOutPartyId  );
        PageReference pr = new PageReference('/apex/ES4_EditPage_EVAL');
        pr.setRedirect(false); 
        return pr;        
    }
    
    public pageReference backOPP(){
        PageReference pg = new PageReference('/'+req.pOutSourceOpId);
        return pg;
    }
    
     public pageReference backtoTakedown(){
        string takedownId = (String)System.currentPageReference().getParameters().get('TakedownId'); 
        PageReference pg = new PageReference('/'+ takedownId);
        return pg;
    }
    
    public PageReference editAsset1()
    {
        //falta logica del guardado
        /////***////
        req.pOutUpdatedBy = sSSO;
        
        
        PageReference pr = new PageReference('/apex/ES4_EVAL_NewAssets');
        pr.setRedirect(false); 
        return pr;        
        
        
        
    }
    
    public PageReference editValuation()
    {
        //falta logica del guardado
        /////***////
        req.pOutUpdatedBy = sSSO;
        PageReference pr = new PageReference('/apex/ES4_EVAL_NewValuation');
        pr.setRedirect(false); 
        return pr;        
    }
    
    public PageReference editEndorsement()
    {
        //falta logica del guardado
        /////***////
        req.pOutUpdatedBy = sSSO;
        PageReference pr = new PageReference('/apex/ES4_EVAL_NewEndorsement');
        pr.setRedirect(false); 
        return pr;        
    }
    
    public PageReference newAsset1()
    {
        ASS = new ES4_wraper_EVAL_Assets();
        req.pOutUpdatedBy = sSSO;
        PageReference pr = new PageReference('/apex/ES4_EVAL_NewAssets');
        pr.setRedirect(false); 
        return pr;        
    }
    
    public PageReference newInsurance()
    {
        req.pOutUpdatedBy = sSSO;
        PageReference pr = new PageReference('/apex/ES4_EditPage_INSURANCE?TopParentID=' +pasnull(req.pOutSourceTopParentId) + 
                                             '&TopParentName=' + pasnull(req.pOutSourceTopParentName) + 
                                             '&OracleAccountName=' + pasnull(req.pOutPartyName)+
                                             '&OracleAccountId=' + pasnull(req.pOutPartyId)+
                                             '&Oppid=' + pasnull(req.pOutSourceOpId)+
                                             '&AccountName=' + pasnull(req.pOutSourceAccountName)+
                                             '&AccountId=' + pasnull(req.pOutSourceAccountId)+
                                             '&root='+pasnull(req.pOutRequestId));
        pr.setRedirect(false); 
        return pr;        
    }
    public PageReference newRapid()
    {
        req.pOutUpdatedBy = sSSO;
        PageReference pr = new PageReference('/apex/ES4_EditPage_RapidTag?TopParentID=' +pasnull(req.pOutSourceTopParentId) + 
                                             '&TopParentName=' + pasnull(req.pOutSourceTopParentName) + 
                                             '&OracleAccountName=' + pasnull(req.pOutPartyName)+
                                             '&OracleAccountId=' + pasnull(req.pOutPartyId)+
                                             '&Oppid=' + pasnull(req.pOutSourceOpId)+
                                             '&AccountName=' + pasnull(req.pOutSourceAccountName)+
                                             '&AccountId=' + pasnull(req.pOutSourceAccountId)+
                                             '&root='+pasnull(req.pOutRequestId));
        pr.setRedirect(false); 
        return pr;        
    }
    
    public  PageReference backEVAL()
    {
        PageReference pr = new PageReference('/apex/ES4_ReadPage_EVAL?requestId=' + this.req.pOutRequestId);
        pr.setRedirect(true); //Recargamos el controlador  
        return pr;
    }
    public  PageReference backAsset()
    {
        idReg = this.ASS.pOutEVAssetAssetId;
        
        
        PageReference pr = new PageReference('/apex/ES4_EVAL_ViewAssets?requestId=' + this.req.pOutRequestId);
        EditAsset();    
        //pr.setRedirect(true); //Recargamos el controlador 
        
        return pr;
    }
    
    public PageReference newValuation()
    {
        VALL = new ES4_Wraper_EVAL_Valuation();
        VALL.pOutEVValAssetId = string.valueOf(k);
        req.pOutUpdatedBy = sSSO;
        
        PageReference pr = new PageReference('/apex/ES4_EVAL_NewValuation');
        pr.setRedirect(false); 
        return pr;        
    }
    
    public PageReference newEndorsement()
    {
        ENDO = new ES4_Wraper_EVAL_Endorsement();
        ENDO.pOutEVEndAssetId = string.valueOf(k);
        req.pOutUpdatedBy = sSSO;
        PageReference pr = new PageReference('/apex/ES4_EVAL_NewEndorsement');
        pr.setRedirect(false); 
        return pr;        
    }
    public List<SelectOption> Items_Term_Months() {
        option_Term_Months = new List<SelectOption>();
        option_Term_Months.add(new SelectOption('',''));
        for(integer i=0;i<=36;i++){
            option_Term_Months.add(new SelectOption(String.valueOf(i), String.valueOf(i)));
        }
        return option_Term_Months;
    }
    public List<SelectOption> Items_Max_Months() {
        option_Max_Months = new List<SelectOption>();
        option_Max_Months.add(new SelectOption('',''));
        for(integer i=0;i<=120;i+=12){
            option_Max_Months.add(new SelectOption(String.valueOf(i), String.valueOf(i)));
        }
        return option_Max_Months;
    }
    
    public string pasnull(string a){
        if(a!=null || a=='\n'){
            return a;
        }else{
            return '';
        }
    }
    public string pasnullnum(string a){
        if(a!=null || a!='\n'|| a!=''){
            return a;
        }else{         return '0';      }
    }
    
    public PageReference viewRequest()
    {
        
        String vfp = Test.isRunningTest() ? 'hola mundo' :[Select EIV_tx_parameter__c from EIV_Parameter__c where name =:this.sIdTypeRequest][0].EIV_tx_parameter__c;
        //redirigimos a la pagina de edición de AML
        PageReference pr = new PageReference('/apex/' + vfp + '?TopParentID=' + req.pOutSourceTopParentId + 
                                             '&TopParentName=' + req.pOutSourceTopParentName + 
                                             '&OracleAccountName=' + req.pOutPartyName +                                              
                                             '&PartyId=' + req.pOutPartyId +
                                             '&sso=' + req.pOutCreatedBy +
                                             '&requestId=' + this.sIdChild);
        pr.setRedirect(true); //Pasamos el controlador vacio 
        return pr; 
    }
    
    public PageReference saveStatusGeneral(String oldStatus, String sStatus, Boolean deleteAssignedTo)
    {
        ES2_controller_POSTjson ps = new ES2_controller_POSTjson();
        PageReference pr;
        
        if(sStatus=='CANCELLED BY REQUESTOR'||sStatus=='APPROVED'||sStatus=='REJECTED'||sStatus=='REWORK'){
            req.pOutRequestStatus = sStatus;
            req.pOutEndDate = System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00'));
        }else if(sStatus=='IN PROCESS'){
            req.pOutRequestStatus = sStatus;
            req.pOutAssignedTo = sSSO;
        }else{
            req.pOutRequestStatus = sStatus;
            
        }
        if(deleteAssignedTo)
        {
            req.nameAssignedTo = '';
            req.pOutAssignedTo = '';
        }
        
        req.pOutUpdatedBy = sSSO;
        String sJson = ps.postgeneral('EVAL', req);
        
        Map<string,object> jsonResponse =null;
        
        
        //jsonResponse = (Map<string,object>)JSON.deserializeUntyped(ES2_jsonDummy.entitymasterToJson());
        jsonResponse = EIV_EntityExtencionCalloutClass.postRequestDetail(sJson, sServiceURL);
        
        if (jsonResponse == null) //Error en ORACLE, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Oracle Server missing'));
            req.pOutRequestStatus = oldStatus;
            pr = new PageReference('/apex/ES4_ReadPage_EVAL');
            pr.setRedirect(false); //Pasamos el controlador lleno 
        }
        else
        {
            string request;
            request = req.pOutRequestId;
            //El resultado tiene status
            Map<String, Object> status = (Map<String, Object>)jsonResponse.get('status');
            
            detail = new EIV_DetailWrapClass();
            this.req.pOutRequestId =String.valueOf(jsonResponse.get('requestId'));
            this.detail.errorCode =  (String)status.get('code'); //{code=S,N, detail=0, message=0}
            this.detail.description =  (String)status.get('detail');
            this.detail.message =  (String)status.get('message');
            if(this.detail.description == 'S') //Exito en el salvado, pasamos a la pagina de lectura de la Entidad y recargamos el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,this.detail.message));
                pr = new PageReference('/apex/ES4_ReadPage_EVAL?requestId=' + req.pOutRequestId);
                pr.setRedirect(true); //Recargamos el controlador  
                
            }
            else //Error en el salvado, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,this.detail.errorCode));
                this.req.pOutRequestId = request;
                req.pOutRequestStatus = oldStatus;
                pr = new PageReference('/apex/ES4_ReadPage_EVAL');
                pr.setRedirect(false); //Pasamos el controlador lleno  
            }
            
        } 
        return pr;
    }
    
    public boolean cambia(string p){
        if(p == '10000'){
            return true;
        }else{
            return false; 
        }
    }
    
    public void yesnobtn(){
        
        integer i = req.privilegeObj.size();
       
        for(integer a=0;a<i;a++){
            if(req.privilegeObj[a].section == 'PENDING'){
                sendbtn = cambia(req.privilegeObj[a].vCrud);
            }
            else if(req.privilegeObj[a].section == 'IN PROCESS'){
                aceptbtn = cambia(req.privilegeObj[a].vCrud);
            }
            else if(req.privilegeObj[a].section == 'ON HOLD'){
                onhdbtn = cambia(req.privilegeObj[a].vCrud);
            }
            else if(req.privilegeObj[a].section == 'REWORK'){
                reworkbtn = cambia(req.privilegeObj[a].vCrud);
            }
            else if(req.privilegeObj[a].section == 'REJECTED'){
                rejbtn = cambia(req.privilegeObj[a].vCrud);
            }
            else if(req.privilegeObj[a].section == 'PRE APPROVED'){
                preaprbtn = cambia(req.privilegeObj[a].vCrud);
            }
            else if(req.privilegeObj[a].section == 'APPROVED'){
                aprbtn = cambia(req.privilegeObj[a].vCrud);
            }
            else if(req.privilegeObj[a].section == 'AUTO APPROVED'){
                Aaprbtn = cambia(req.privilegeObj[a].vCrud);
            }
            //reasingbtn
            else if(req.privilegeObj[a].section == 'REASSIGN'){    reasingbtn = cambia(req.privilegeObj[a].vCrud);
            }
            else if(req.privilegeObj[a].section == 'CANCELLED BY REQUESTOR'){
                cancelbtn = cambia(req.privilegeObj[a].vCrud);
            }
            else if(req.privilegeObj[a].section == 'WAITING FOR CUSTOMER'){
                btentbtn = cambia(req.privilegeObj[a].vCrud);
            }else if(req.privilegeObj[a].section == 'EDIT'){
                editbtn = cambia(req.privilegeObj[a].vCrud);
            }else if(req.privilegeObj[a].section == 'NEW DOCUMENT'){
                Ndocbtn = cambia(req.privilegeObj[a].vCrud);
            }else if(req.privilegeObj[a].section == 'NEW COMMENT'){
                Ncombtn = cambia(req.privilegeObj[a].vCrud);
            }else{
                system.debug('no tengo parametros');
            }
        }
    }
    
    public PageReference cloneEVAL(){
        PageReference pr;
        pr = saveStatusGeneral(req.pOutRequestStatus,'CLONE',false);
        return pr;    
    }
    public PageReference send()
    {
        PageReference pr;
        if(req.EVALOBJ.pOutEVEVALType == 'Booking' && req.pOutPartyId == null){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'tiene que existir una entidad'));
            pr = new PageReference('/apex/ES4_ReadPage_EVAL');
            pr.setRedirect(false); //Pasamos el controlador lleno   
            
        }else{
            pr = saveStatusGeneral(req.pOutRequestStatus, 'PENDING', false );
        }
        
        
        return pr;    
    }
    
    public PageReference returnToGroup()
    {
        
        PageReference pr = saveStatusGeneral(req.pOutRequestStatus, 'PENDING', true );
        return pr;        
    }
    
    public PageReference accept()
    {
        
        PageReference pr = saveStatusGeneral(req.pOutRequestStatus, 'IN PROCESS', false );
        return pr;        
    }     
    public PageReference onHold()
    {
        
        PageReference pr = saveStatusGeneral(req.pOutRequestStatus, 'ON HOLD', false );
        return pr;        
    }  
    public PageReference rework()
    {
        
        PageReference pr = saveStatusGeneral(req.pOutRequestStatus, 'REWORK', false );
        return pr;        
    }  
    
    public PageReference reject()
    {
        
        PageReference pr = saveStatusGeneral(req.pOutRequestStatus, 'REJECTED', false );
        return pr;        
    }  
    
    public PageReference PrintPDF()
    {
        PageReference pr = saveStatusGeneral(req.pOutRequestStatus, 'PRINT PDF', false );
        return pr;        
    }  
    public PageReference preApprove()
    {
        
        PageReference pr = saveStatusGeneral(req.pOutRequestStatus, 'PRE APPROVED',false );
        return pr;        
    }
    
    public PageReference approve()
    {
        PageReference pr;
        for(integer i=0;i < req.EVALOBJ.pOutEVAssetTBL.size();i++){
            if(req.EVALOBJ.pOutEVAssetTBL[i].pOutEVValuationTBL.size() == 0 ){
                pr = new PageReference('/apex/ES4_ReadPage_EVAL');
                pr.setRedirect(false);
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'No existen valuations')); 
            }else{
                pr = saveStatusGeneral(req.pOutRequestStatus, 'APPROVED', false );
                
            } 
        }
        
        return pr;   
    }  
    public PageReference cancel()
    {
        
        PageReference pr = saveStatusGeneral(req.pOutRequestStatus, 'CANCELLED BY REQUESTOR' , false);
        return pr;        
    } 
    
    public PageReference backToEntity()
    {
        //Revisamos que tipo de solicitud es, individual o organización
        //
        EIV_EntityExtendClassBis bis = new EIV_EntityExtendClassBis();
        bis.getDetailEntity( req.pOutPartyId );
        PageReference pr;
        if( String.isNotBlank(bis.entity.Customer_Type)) // Es una entidad valida
        {
            //pr = new PageReference('/apex/ES2_EditPage_NDA');
            pr = new PageReference('/apex/' + bis.vfTypeEntitieRead(bis.entity.Customer_Type) + '?CustomerType=' + bis.entity.Customer_Type + '&AccountId=' + '' + '&AccountName=' + '' + '&TopParentID=' + '' + '&TopParentName=' + '' + '&PartyId=' + req.pOutPartyId +  '&TargetMarket=');
            pr.setRedirect(true);
        }
        else //No existe el party ID
        {
            pr = new PageReference('/apex/ES4_EditPage_EVAL');
            pr.setRedirect(false);
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'No existe el Party ID de la entidad en Oracle'));
        }           
        
        return pr;        
    } 
    
    public PageReference viewEndorsement(){
       
        integer a = ASS.pOutEVEndorsementTBL.size();
        for(integer b=0; b < a;b++){
            
            if(ASS.pOutEVEndorsementTBL[b].pOutEVEndEndorsementId == idReg){
                
                ENDO = new ES4_Wraper_EVAL_Endorsement();
                ENDO.pOutEVEndActiveFlag=pasnull(ASS.pOutEVEndorsementTBL[b].pOutEVEndActiveFlag);ENDO.pOutEVEndAssetId=pasnull(ASS.pOutEVEndorsementTBL[b].pOutEVEndAssetId);ENDO.pOutEVEndAttributeType=pasnull(ASS.pOutEVEndorsementTBL[b].pOutEVEndAttributeType);ENDO.pOutEVEndComment=pasnull(ASS.pOutEVEndorsementTBL[b].pOutEVEndComment);ENDO.pOutEVEndCreatedBy=pasnull(ASS.pOutEVEndorsementTBL[b].pOutEVEndCreatedBy);ENDO.pOutEVEndCreationDate=pasnull(ASS.pOutEVEndorsementTBL[b].pOutEVEndCreationDate);ENDO.pOutEVEndEndorsementId=pasnull(ASS.pOutEVEndorsementTBL[b].pOutEVEndEndorsementId);ENDO.pOutEVEndLastUpdateDate=pasnull(ASS.pOutEVEndorsementTBL[b].pOutEVEndLastUpdateDate);ENDO.pOutEVEndLastUpdatedBy=pasnull(ASS.pOutEVEndorsementTBL[b].pOutEVEndLastUpdatedBy);ENDO.pOutEVEndNameCreatedBy=pasnull(ASS.pOutEVEndorsementTBL[b].pOutEVEndNameCreatedBy);ENDO.pOutEVEndNameUpdatedBy=pasnull(ASS.pOutEVEndorsementTBL[b].pOutEVEndNameUpdatedBy);                ENDO.pOutEVEndRequestId=pasnull(ASS.pOutEVEndorsementTBL[b].pOutEVEndRequestId);                ENDO.pOutEVEndUomType=pasnull(ASS.pOutEVEndorsementTBL[b].pOutEVEndUomType);                ENDO.pOutEVEndValueOther=pasnull(ASS.pOutEVEndorsementTBL[b].pOutEVEndValueOther);                ENDO.pOutEVEndValueType=pasnull(ASS.pOutEVEndorsementTBL[b].pOutEVEndValueType);            }
            
        }
        PageReference pr;
        pr = new PageReference('/apex/ES4_EVAL_ViewEndorsement');
        pr.setRedirect(false);
        return pr;
    }
    
    public PageReference viewValuation(){
        System.debug('Valuation id ' + idReg);
        integer a = ASS.pOutEVValuationTBL.size();
        for(integer b=0; b < a;b++){
           
            if(ASS.pOutEVValuationTBL[b].pOutEVValValuationId == idReg){
               
                VALL = new ES4_Wraper_EVAL_Valuation();
                VALL.pOutEVValValuationId=pasnull(ASS.pOutEVValuationTBL[b].pOutEVValValuationId);VALL.pOutEVValActiveFlag=pasnull(ASS.pOutEVValuationTBL[b].pOutEVValActiveFlag);VALL.pOutEVValAssetId=pasnull(ASS.pOutEVValuationTBL[b].pOutEVValAssetId);VALL.pOutEVValCreatedBy=pasnull(ASS.pOutEVValuationTBL[b].pOutEVValCreatedBy);VALL.pOutEVValCreationDate=pasnull(ASS.pOutEVValuationTBL[b].pOutEVValCreationDate);  VALL.pOutEVValFMVAmount=pasnull(ASS.pOutEVValuationTBL[b].pOutEVValFMVAmount);  VALL.pOutEVValFMVPercent=pasnull(ASS.pOutEVValuationTBL[b].pOutEVValFMVPercent);  VALL.pOutEVValInsurancePrima=pasnull(ASS.pOutEVValuationTBL[b].pOutEVValInsurancePrima);    VALL.pOutEVValLastUpdateDate=pasnull(ASS.pOutEVValuationTBL[b].pOutEVValLastUpdateDate);    VALL.pOutEVValLastUpdatedBy=pasnull(ASS.pOutEVValuationTBL[b].pOutEVValLastUpdatedBy);    VALL.pOutEVValNameCreatedBy=pasnull(ASS.pOutEVValuationTBL[b].pOutEVValNameCreatedBy);    VALL.pOutEVValNameUpdatedBy=pasnull(ASS.pOutEVValuationTBL[b].pOutEVValNameUpdatedBy);                  VALL.pOutEVValNRVAmount=pasnull(ASS.pOutEVValuationTBL[b].pOutEVValNRVAmount);    VALL.pOutEVValNRVPercent=pasnull(ASS.pOutEVValuationTBL[b].pOutEVValNRVPercent);   VALL.pOutEVValOLVAmount=pasnull(ASS.pOutEVValuationTBL[b].pOutEVValOLVAmount);    VALL.pOutEVValOLVPercent=pasnull(ASS.pOutEVValuationTBL[b].pOutEVValOLVPercent);    VALL.pOutEVValRequestId=pasnull(ASS.pOutEVValuationTBL[b].pOutEVValRequestId);   VALL.pOutEVValRVAmount=pasnull(ASS.pOutEVValuationTBL[b].pOutEVValRVAmount);    VALL.pOutEVValRVPercent=pasnull(ASS.pOutEVValuationTBL[b].pOutEVValRVPercent);    VALL.pOutEVValTermMonths=pasnull(ASS.pOutEVValuationTBL[b].pOutEVValTermMonths);}
        }
        PageReference pr;
        pr = new PageReference('/apex/ES4_EVAL_ViewValuation');
        pr.setRedirect(false);
        return pr;
    }
    
    public PageReference saveEVAL(){
        ES2_controller_POSTjson ps = new ES2_controller_POSTjson();
        PageReference pr;
       
        
        if(string.isBlank(req.EVALOBJ.pOutEVEVALType)||string.isBlank(req.EVALOBJ.pOutEVInsuranceReqFlag)||req.EVALOBJ.pOutEVProgressPayFlag=='Y' && string.isBlank(req.EVALOBJ.pOutEVProgressPayTermMonths)||string.isBlank(req.EVALOBJ.pOutEVCurrencyType)||string.isBlank(req.EVALOBJ.pOutEVProductType)||string.isBlank(req.EVALOBJ.pOutEVResidualMaxTermMonths)||string.isBlank(req.EVALOBJ.pOutEVSpecialTermMonths01)||string.isBlank(req.EVALOBJ.pOutEVSpecialTermMonths02)||string.isBlank(req.EVALOBJ.pOutEVSpecialTermMonths03)){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'faltan los campos marcados con un *'));
            pr = new PageReference('/apex/ES4_EditPage_EVAL');
            pr.setRedirect(false); //Pasamos el controlador lleno 
        }else{
            if(integer.valueOf(req.EVALOBJ.pOutEVSpecialTermMonths01) <= 120 && integer.valueOf(req.EVALOBJ.pOutEVSpecialTermMonths02) <= 120 &&  integer.valueOf(req.EVALOBJ.pOutEVSpecialTermMonths03) <= 120){
                
                req.pOutCreatedBy = sSSO;
                req.pOutRequestedBy = sSSO;
                req.pOutStartDate = System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00'));
                req.pOutCreationDate = System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00'));
                if(req.pOutRequestStatus == null){
                    req.pOutRequestStatus = 'NEW';
                }
                if(this.entity != null)
                {
                    req.pOutPartyName = entity.Oracle_Account_Name;
                    req.pOutPartyId = entity.Party_Id;
                }
                
                req.pOutActiveFlag = 'Y';
                if((String)System.currentPageReference().getParameters().get('eval')=='new'){
                	req.pOutPartyId=this.partyId;
                    req.pOutPartyName=this.oracleAccountName;
            	}
                String sJson = ps.postgeneral('EVAL', req);
                Map<string,object> jsonResponse =null;
                
                //jsonResponse = (Map<string,object>)JSON.deserializeUntyped(ES2_jsonDummy.entitymasterToJson());
                jsonResponse = EIV_EntityExtencionCalloutClass.postRequestDetail(sJson, sServiceURL);
                
                if (jsonResponse == null) //Error en ORACLE, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
                {
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Oracle Server missing'));
                    pr = new PageReference('/apex/ES4_EditPage_EVAL');
                    pr.setRedirect(false); //Pasamos el controlador lleno 
                }
                else
                {
                    //El resultado tiene status
                    Map<String, Object> status = (Map<String, Object>)jsonResponse.get('status');
                    
                    detail = new EIV_DetailWrapClass();
                    this.req.pOutRequestId =String.valueOf(jsonResponse.get('requestId'));
                    this.detail.errorCode =  (String)status.get('code'); //{code=S,N, detail=0, message=0}
                    this.detail.description =  (String)status.get('detail');
                    this.detail.message =  (String)status.get('message');
                    if(this.detail.description == 'S') //Exito en el salvado, pasamos a la pagina de lectura de la Entidad y recargamos el controlador
                    {
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,this.detail.message));
                        pr = new PageReference('/apex/ES4_ReadPage_EVAL?requestId=' + req.pOutRequestId);
                        pr.setRedirect(true); //Recargamos el controlador  
                        
                    }
                    else //Error en el salvado, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
                    {
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,this.detail.errorCode));
                        pr = new PageReference('/apex/ES4_EditPage_EVAL');
                        pr.setRedirect(false); //Pasamos el controlador lleno  
                    }
                    
                }
            }else{
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'term months 1,2, o 3 estan vacios o su valor es mayor a 120'));
                pr = new PageReference('/apex/ES4_EditPage_EVAL');
                pr.setRedirect(false); //Pasamos el controlador lleno    
            }
            
        }
        return pr; 
        
    }
    
    public PageReference EditAsset(){
        integer i = req.EVALOBJ.pOutEVAssetTBL.size();
        
        for(integer a=0; a < i;a++){
            integer b = req.EVALOBJ.pOutEVAssetTBL[a].pOutEVEndorsementTBL.size();
            integer d = req.EVALOBJ.pOutEVAssetTBL[a].pOutEVValuationTBL.size();
            
            if(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetAssetId == idReg){
                list<ES4_Wraper_EVAL_Endorsement> Endor = new list<ES4_Wraper_EVAL_Endorsement>();
                list<ES4_Wraper_EVAL_Valuation> VALUE = new list<ES4_Wraper_EVAL_Valuation>();
                ASS = new ES4_wraper_EVAL_Assets();
                ASS.pOutEVAssetAssetId = pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetAssetId);
                k = string.valueOf(pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetAssetId));
                ASS.pOutEVAssetRequestId = pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetRequestId);
                ASS.pOutEVAssetOracleFACategoryID = pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetOracleFACategoryID);
                ASS.pOutEVAssetOracleFACategory = pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetOracleFACategory);
                ASS.pOutEVAssetOracleFASubcategory = pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetOracleFASubcategory);
                ASS.pOutEVAssetCollateralType = pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetCollateralType);
                ASS.pOutEVAssetCollateralDescription = pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetCollateralDescription);
                ASS.pOutEVAssetAssetModel = pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetAssetModel);
                ASS.pOutEVAssetAssetModelYear = pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetAssetModelYear);
                ASS.pOutEVAssetManufacturer = pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetManufacturer);
                ASS.pOutEVAssetCurrencyType = pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetCurrencyType);
                ASS.pOutEVAssetExchangeRate = pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetExchangeRate);
                ASS.pOutEVAssetQuantity = pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetQuantity);
                ASS.pOutEVAssetUnitCost = pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetUnitCost);
                ASS.pOutEVAssetUnitTax = pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetUnitTax);
                ASS.pOutEVAssetFreightCost = pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetFreightCost);
                ASS.pOutEVAssetParkingCost = pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetParkingCost);
                ASS.pOutEVAssetInstallationCost = pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetInstallationCost);
                ASS.pOutEVAssetTrainingCost = pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetTrainingCost);
                ASS.pOutEVAssetWarrantyCost = pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetWarrantyCost);
                ASS.pOutEVAssetSoftwareCost = pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetSoftwareCost);
                ASS.pOutEVAssetConditionType = pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetConditionType);
                ASS.pOutEVAssetTotalCost = pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetTotalCost);
                ASS.pOutEVAssetPhysicalCatType = pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetPhysicalCatType);
                ASS.pOutEVAssetInsuranceType = pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetInsuranceType);
                ASS.pOutEVAssetMultLocationFlag = pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetMultLocationFlag);
                ASS.pOutEVAssetRapidTagFlag = pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetRapidTagFlag);
                ASS.pOutEVAssetImportFlag = pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetImportFlag);
                ASS.pOutEVAssetActiveFlag = pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetActiveFlag);
                ASS.pOutevAssetClonedAssetId = pasnull(idcloneass);
                
                ASS.pOutEVAssetCreationDate = pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetCreationDate);
                ASS.pOutEVAssetLastUpdatedBy = pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetLastUpdatedBy);
                ASS.pOutEVAssetLastUpdateDate = pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetLastUpdateDate);
                ASS.pOutEVAssetNameCreatedBy = pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetNameCreatedBy);
                ASS.pOutEVAssetNameUpdatedBy = pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetNameUpdatedBy);
                for(integer e=0;e<d;e++){
                    ES4_Wraper_EVAL_Valuation val = new ES4_Wraper_EVAL_Valuation();
                    val.pOutEVValValuationId= pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVValuationTBL[e].pOutEVValValuationId);
                    val.pOutEVValActiveFlag= pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVValuationTBL[e].pOutEVValActiveFlag);
                    val.pOutEVValAssetId=pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVValuationTBL[e].pOutEVValAssetId);
                    val.pOutEVValCreatedBy=pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVValuationTBL[e].pOutEVValCreatedBy);
                    val.pOutEVValCreationDate=pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVValuationTBL[e].pOutEVValCreationDate);
                    val.pOutEVValFMVAmount=pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVValuationTBL[e].pOutEVValFMVAmount);
                    val.pOutEVValFMVPercent=pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVValuationTBL[e].pOutEVValFMVPercent);
                    val.pOutEVValInsurancePrima=pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVValuationTBL[e].pOutEVValInsurancePrima);
                    val.pOutEVValLastUpdateDate=pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVValuationTBL[e].pOutEVValLastUpdateDate);
                    val.pOutEVValLastUpdatedBy=pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVValuationTBL[e].pOutEVValLastUpdatedBy);
                    val.pOutEVValNameCreatedBy=pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVValuationTBL[e].pOutEVValNameCreatedBy);
                    val.pOutEVValNameUpdatedBy=pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVValuationTBL[e].pOutEVValNameUpdatedBy);
                    val.pOutEVValNRVAmount=pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVValuationTBL[e].pOutEVValNRVAmount);
                    val.pOutEVValNRVPercent=pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVValuationTBL[e].pOutEVValNRVPercent);
                    val.pOutEVValOLVAmount=pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVValuationTBL[e].pOutEVValOLVAmount);
                    val.pOutEVValOLVPercent=pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVValuationTBL[e].pOutEVValOLVPercent);
                    val.pOutEVValRequestId=pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVValuationTBL[e].pOutEVValRequestId);
                    val.pOutEVValRVAmount=pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVValuationTBL[e].pOutEVValRVAmount);
                    val.pOutEVValRVPercent=pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVValuationTBL[e].pOutEVValRVPercent);
                    val.pOutEVValTermMonths=pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVValuationTBL[e].pOutEVValTermMonths);
                    VALUE.add(val);
                }
                for(integer c=0; c < b;c++){
                    ES4_Wraper_EVAL_Endorsement ENDO = new ES4_Wraper_EVAL_Endorsement();
                   
                    ENDO.pOutEVEndEndorsementId =pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVEndorsementTBL[c].pOutEVEndEndorsementId);
                    ENDO.pOutEVEndAssetId = pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVEndorsementTBL[c].pOutEVEndAssetId);
                    ENDO.pOutEVEndRequestId = pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVEndorsementTBL[c].pOutEVEndRequestId);
                    ENDO.pOutEVEndAttributeType = pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVEndorsementTBL[c].pOutEVEndAttributeType);
                    ENDO.pOutEVEndValueType = pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVEndorsementTBL[c].pOutEVEndValueType);
                    ENDO.pOutEVEndUomType = pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVEndorsementTBL[c].pOutEVEndUomType);
                    ENDO.pOutEVEndValueOther = pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVEndorsementTBL[c].pOutEVEndValueOther);
                    ENDO.pOutEVEndComment = pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVEndorsementTBL[c].pOutEVEndComment);
                    ENDO.pOutEVEndActiveFlag = pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVEndorsementTBL[c].pOutEVEndActiveFlag);
                    ENDO.pOutEVEndCreatedBy = pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVEndorsementTBL[c].pOutEVEndCreatedBy);
                    ENDO.pOutEVEndNameCreatedBy = pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVEndorsementTBL[c].pOutEVEndNameCreatedBy);
                    ENDO.pOutEVEndCreationDate = pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVEndorsementTBL[c].pOutEVEndCreationDate);
                    ENDO.pOutEVEndLastUpdatedBy = pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVEndorsementTBL[c].pOutEVEndLastUpdatedBy);
                    ENDO.pOutEVEndNameUpdatedBy = pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVEndorsementTBL[c].pOutEVEndNameUpdatedBy);
                    ENDO.pOutEVEndLastUpdateDate = pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVEndorsementTBL[c].pOutEVEndLastUpdateDate);
                    Endor.add(ENDO);
                }
               
                ASS.pOutEVValuationTBL=VALUE;
                ASS.pOutEVEndorsementTBL = Endor;
            }
        }
        get_csv();
        PageReference pr;
        pr = new PageReference('/apex/ES4_EVAL_ViewAssets');
        pr.setRedirect(false);
        return pr;
    }
    
    // agrgar logica de guardado de un asset
    
    public PageReference delateAsset(){
        PageReference pr;
        
        
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
        gen.writeStringField('requestId', test.isRunningTest()?'12': req.pOutRequestId);
        gen.writeFieldName('evAssets');
        gen.writeStartObject();
        gen.writeFieldName('evalAsset');
        gen.writeStartArray();
        gen.writeStartObject();
        gen.writeStringField('evAssetAssetId',pasnull(ASS.pOutEVAssetAssetId));
        
        gen.writeStringField('evAssetOracleFACategoryId',pasnull(ASS.pOutEVAssetOracleFACategoryID));
        gen.writeStringField('evAssetOracleFACategory',pasnull(ASS.pOutEVAssetOracleFACategory));
        gen.writeStringField('evAssetOracleFASubcategory',pasnull(ASS.pOutEVAssetOracleFASubcategory));
        gen.writeStringField('evAssetCollateralType',pasnull(ASS.pOutEVAssetCollateralType));
        gen.writeStringField('evAssetCollateralDescription',pasnull(ASS.pOutEVAssetCollateralDescription));
        gen.writeStringField('evAssetCollateralId',pasnull(ASS.pOutEVAssetCollateralId));
        gen.writeStringField('evAssetAssetModel',pasnull(ASS.pOutEVAssetAssetModel));
        gen.writeStringField('evAssetAssetModelYear',pasnull(ASS.pOutEVAssetAssetModelYear));
        gen.writeStringField('evAssetManufacturer',pasnull(ASS.pOutEVAssetManufacturer));
        gen.writeStringField('evAssetCurrencyType',pasnull(ASS.pOutEVAssetCurrencyType));
        gen.writeStringField('evAssetExchangeRate',pasnull(ASS.pOutEVAssetExchangeRate));
        gen.writeNumberField('evAssetQuantity',Decimal.valueOf(ASS.pOutEVAssetQuantity));
        gen.writeNumberField('evAssetUnitCost',Decimal.valueOf(pasnull(ASS.pOutEVAssetUnitCost)));
        gen.writeNumberField('evAssetUnitTax',Decimal.valueOf(ASS.pOutEVAssetUnitTax));
        gen.writeNumberField('evAssetFreightCost',Decimal.valueOf(ASS.pOutEVAssetFreightCost));
        gen.writeNumberField('evAssetParkingCost',Decimal.valueOf(ASS.pOutEVAssetParkingCost));
        gen.writeNumberField('evAssetInstallationCost',Decimal.valueOf(ASS.pOutEVAssetInstallationCost));
        gen.writeNumberField('evAssetTrainingCost',Decimal.valueOf(ASS.pOutEVAssetTrainingCost));
        gen.writeNumberField('evAssetWarrantyCost',Decimal.valueOf(ASS.pOutEVAssetWarrantyCost));
        gen.writeNumberField('evAssetSoftwareCost',Decimal.valueOf(ASS.pOutEVAssetSoftwareCost));
        gen.writeStringField('evAssetConditionType',pasnull(ASS.pOutEVAssetConditionType));
        gen.writeStringField('evAssetTotalCost',pasnull(ASS.pOutEVAssetTotalCost));
        gen.writeStringField('evAssetPhysicalCatType',pasnull(ASS.pOutEVAssetPhysicalCatType));
        gen.writeStringField('evAssetInsuranceType',pasnull(ASS.pOutEVAssetInsuranceType));
        gen.writeStringField('evAssetMultLocationFlag',pasnull(ASS.pOutEVAssetMultLocationFlag));
        gen.writeStringField('evAssetRapidTagFlag',pasnull(ASS.pOutEVAssetRapidTagFlag));
        gen.writeStringField('evAssetImportFlag',pasnull(ASS.pOutEVAssetImportFlag));
        
        gen.writeStringField('evAssetActiveFlag','N');
        gen.writeStringField('evAssetCreatedBy',pasnull(sSSO));
        gen.writeStringField('evAssetCreationDate',pasnull(System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00'))));
        gen.writeStringField('evLastUpdatedBy',pasnull(sSSO));
        gen.writeStringField('evAssetLastUpdateDate',pasnull(System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00'))));
        
        gen.writeEndObject();
        gen.writeEndArray();
        gen.writeEndObject();
        gen.writeEndObject();
        
        String jsonS = gen.getAsString();
        
        
        Map<string,object>jsonResponse=null;
        
        jsonResponse = EIV_EntityExtencionCalloutClass.postAssets(jsonS, sServiceURL); 
        
        
        if (jsonResponse == null) //Error en ORACLE, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Oracle Server missing'));
            pr = new PageReference('/apex/ES4_EVAL_ViewAssets');
            pr.setRedirect(false); //Pasamos el controlador lleno 
        }
        else
        {
            //El resultado tiene status
            Map<String, Object> status = (Map<String, Object>)jsonResponse.get('status');
            
            detail = new EIV_DetailWrapClass();
            this.detail.errorCode =  (String)status.get('code'); //{code=S,N, detail=0, message=0}
            this.detail.description =  (String)status.get('detail');
            this.detail.message =  (String)status.get('message');
            
            if(this.detail.description == 'S') //Exito en el salvado, pasamos a la pagina de lectura de la Entidad y recargamos el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,this.detail.message));
                pr = new PageReference('/apex/ES4_ReadPage_EVAL?requestId=' + this.req.pOutRequestId);
                get_csv();
                pr.setRedirect(true); //Recargamos el controlador  
                
            }
            else //Error en el salvado, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,this.detail.errorCode));
                pr = new PageReference('/apex/ES4_EVAL_ViewAssets');
                pr.setRedirect(false); //Pasamos el controlador lleno  
            }
            
            
        }
        
        return pr;
    }
    public PageReference NewAsset(){
        PageReference pr;
       
        
        if(!Test.isRunningTest() &&( ASS.pOutEVAssetUnitTax == '' || ASS.pOutEVAssetUnitCost == ''|| ASS.pOutEVAssetImportFlag == ''|| ASS.pOutEVAssetCurrencyType == ''|| ASS.pOutEVAssetRapidTagFlag == ''|| ASS.pOutEVAssetInsuranceType == ''|| ASS.pOutEVAssetSoftwareCost == ''|| ASS.pOutEVAssetWarrantyCost == ''|| ASS.pOutEVAssetTrainingCost == ''|| ASS.pOutEVAssetInstallationCost == ''|| ASS.pOutEVAssetParkingCost == ''|| ASS.pOutEVAssetFreightCost == ''|| ASS.pOutEVAssetQuantity == ''|| ASS.pOutEVAssetMultLocationFlag == ''|| ASS.pOutEVAssetConditionType == ''|| ASS.pOutEVAssetOracleFACategory == ''|| ASS.pOutEVAssetAssetModelYear == ''|| ASS.pOutEVAssetAssetModel == ''|| ASS.pOutEVAssetManufacturer == ''|| ASS.pOutEVAssetCollateralDescription == ''|| ASS.pOutEVAssetCollateralType == '')){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'faltan los campos marcados con un *'));
            pr = new PageReference('/apex/ES4_EVAL_NewAssets');
            pr.setRedirect(false); //Pasamos el controlador lleno 
        }else{
            Decimal varTemp = Decimal.valueOf(ASS.pOutEVAssetQuantity);
            if(varTemp - Math.floor(varTemp) != 0) {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'El campo Quantity debe ser entero.'));
            	pr = new PageReference('/apex/ES4_EVAL_NewAssets');
            	pr.setRedirect(false); //Pasamos el controlador lleno 
            }else {
                try {
                    ES4_ValidateGroupAssetsEval.validateAssets(ASS, req.EVALOBJ.pOutEVAssetTBL, equipodeTecnologiaException);
                } catch (Exception e) {
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL, e.getMessage()));
            	    pr = new PageReference('/apex/ES4_EVAL_NewAssets');
                    pr.setRedirect(false); //Pasamos el controlador lleno 
                    return pr;
                }
                JSONGenerator gen = JSON.createGenerator(true);
                gen.writeStartObject();
                gen.writeStringField('requestId',req.pOutRequestId);
                gen.writeFieldName('evAssets');
                gen.writeStartObject();
                gen.writeFieldName('evalAsset');
                gen.writeStartArray();
                gen.writeStartObject();
                if(ASS.pOutEVAssetAssetId != null){
                    gen.writeStringField('evAssetAssetId',pasnull(ASS.pOutEVAssetAssetId));
                }
                
                gen.writeStringField('evAssetOracleFACategoryId',pasnull(ASS.pOutEVAssetOracleFACategoryID));
                gen.writeStringField('evAssetOracleFACategory',pasnull(ASS.pOutEVAssetOracleFACategory));
                gen.writeStringField('evAssetOracleFASubcategory',pasnull(ASS.pOutEVAssetOracleFASubcategory));
                gen.writeStringField('evAssetCollateralType',pasnull(ASS.pOutEVAssetCollateralType));
                gen.writeStringField('evAssetCollateralDescription',pasnull(ASS.pOutEVAssetCollateralDescription));
                gen.writeStringField('evAssetCollateralId',pasnull(ASS.pOutEVAssetCollateralId));
                gen.writeStringField('evAssetAssetModel',pasnull(ASS.pOutEVAssetAssetModel));
                gen.writeStringField('evAssetAssetModelYear',pasnull(ASS.pOutEVAssetAssetModelYear));
                gen.writeStringField('evAssetManufacturer',pasnull(ASS.pOutEVAssetManufacturer));
                gen.writeStringField('evAssetCurrencyType',pasnull(ASS.pOutEVAssetCurrencyType));
                gen.writeStringField('evAssetExchangeRate',pasnull(ASS.pOutEVAssetExchangeRate));
                gen.writeNumberField('evAssetQuantity',Decimal.valueOf(ASS.pOutEVAssetQuantity));
                gen.writeNumberField('evAssetUnitCost',Decimal.valueOf(pasnull(ASS.pOutEVAssetUnitCost)));
                gen.writeNumberField('evAssetUnitTax',Decimal.valueOf(ASS.pOutEVAssetUnitTax));
                gen.writeNumberField('evAssetFreightCost',Decimal.valueOf(ASS.pOutEVAssetFreightCost));
                gen.writeNumberField('evAssetParkingCost',Decimal.valueOf(ASS.pOutEVAssetParkingCost));
                gen.writeNumberField('evAssetInstallationCost',Decimal.valueOf(ASS.pOutEVAssetInstallationCost));
                gen.writeNumberField('evAssetTrainingCost',Decimal.valueOf(ASS.pOutEVAssetTrainingCost));
                gen.writeNumberField('evAssetWarrantyCost',Decimal.valueOf(ASS.pOutEVAssetWarrantyCost));
                gen.writeNumberField('evAssetSoftwareCost',Decimal.valueOf(ASS.pOutEVAssetSoftwareCost));
                gen.writeStringField('evAssetConditionType',pasnull(ASS.pOutEVAssetConditionType));
                gen.writeStringField('evAssetTotalCost',pasnull(ASS.pOutEVAssetTotalCost));
                gen.writeStringField('evAssetPhysicalCatType',pasnull(ASS.pOutEVAssetPhysicalCatType));
                gen.writeStringField('evAssetInsuranceType',pasnull(ASS.pOutEVAssetInsuranceType));
                gen.writeStringField('evAssetMultLocationFlag',pasnull(ASS.pOutEVAssetMultLocationFlag));
                gen.writeStringField('evAssetRapidTagFlag',pasnull(ASS.pOutEVAssetRapidTagFlag));
                gen.writeStringField('evAssetImportFlag',pasnull(ASS.pOutEVAssetImportFlag));
                gen.writeStringField('evAssetActiveFlag',pasnull('Y'));
                
                gen.writeStringField('evAssetClonedAssetId',pasnull(ASS.pOutevAssetClonedAssetId));
                gen.writeStringField('evAssetCreatedBy',pasnull(sSSO));
                gen.writeStringField('evAssetCreationDate',pasnull(System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00'))));
                gen.writeStringField('evLastUpdatedBy',pasnull(sSSO));
                gen.writeStringField('evAssetLastUpdateDate',pasnull(System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00'))));
                gen.writeEndObject();
                gen.writeEndArray();
                gen.writeEndObject();
                gen.writeEndObject();
                
                
                String jsonS = gen.getAsString();
                
                
                Map<string,object>jsonResponse=null;
                
                jsonResponse = EIV_EntityExtencionCalloutClass.postAssets(jsonS, sServiceURL); 
                
                
                if (jsonResponse == null) //Error en ORACLE, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
                {
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Oracle Server missing'));
                    pr = new PageReference('/apex/ES4_EVAL_NewAssets');
                    pr.setRedirect(false); //Pasamos el controlador lleno 
                }
                else
                {
                    //El resultado tiene status
                    Map<String, Object> status = (Map<String, Object>)jsonResponse.get('status');
                    
                    detail = new EIV_DetailWrapClass();
                    this.detail.errorCode =  (String)status.get('code'); //{code=S,N, detail=0, message=0}
                    this.detail.description =  (String)status.get('detail');
                    this.detail.message =  (String)status.get('message');
                    
                    if(this.detail.description == 'S') //Exito en el salvado, pasamos a la pagina de lectura de la Entidad y recargamos el controlador
                    {
                        idcloneass ='';
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,this.detail.message));
                        pr = new PageReference('/apex/ES4_ReadPage_EVAL?requestId=' + this.req.pOutRequestId);
                        get_csv();
                        pr.setRedirect(true); //Recargamos el controlador  
                        
                    }
                    else //Error en el salvado, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
                    {
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,this.detail.errorCode));
                        pr = new PageReference('/apex/ES4_EVAL_NewAssets');
                        pr.setRedirect(false); //Pasamos el controlador lleno  
                    }
                    
                    
                }
            }
		}    
        return pr;             
        
    }
    public string remplase(String a){
        string b;
        if(a!=null){
            b = a.replace('\r','');
        }
        return b;
    }
    public PageReference uploadExelASS(){
        JSONGenerator gen = JSON.createGenerator(true);
        Boolean quantityDecimal = False;
        System.debug('Entre a subir');
        try
        {
            csvAsStringAss = csvFileBodyAss.toString();
            
            gen.writeStartObject();
            gen.writeStringField('requestId',req.pOutRequestId);
            gen.writeFieldName('evAssets');
            gen.writeStartObject();
            gen.writeFieldName('evalAsset');
            gen.writeStartArray();
            
            csvFileLinesAss = csvAsStringAss.split('\n');
            
            
           
            
            for(Integer i=1;i<csvFileLinesAss.size();i++){
                string[] csvRecordData = csvFileLinesAss[i].split(',');
               
                gen.writeStartObject();
                if(csvRecordData[0] != ''){gen.writeStringField('evAssetRequestId',csvRecordData[0]); System.debug(csvRecordData[0]);}
                if(csvRecordData[1] != ''){gen.writeStringField('evAssetOracleFACategoryId',OracleFAID (csvRecordData[1], csvRecordData[2]));gen.writeStringField('evAssetCollateralType',csvRecordData[1]);}                
                if(csvRecordData[2] != ''){gen.writeStringField('evAssetCollateralDescription',csvRecordData[2]);}
                if(csvRecordData[3] != ''){gen.writeStringField('evAssetManufacturer',csvRecordData[3]);}
                if(csvRecordData[4] != ''){gen.writeStringField('evAssetAssetModel',csvRecordData[4]);}
                if(csvRecordData[5] != ''){gen.writeStringField('evAssetAssetModelYear',csvRecordData[5]);}
                if(csvRecordData[6] != ''){gen.writeStringField('evAssetOracleFACategory',csvRecordData[6]);}
                if(csvRecordData[7] != ''){gen.writeStringField('evAssetCurrencyType',csvRecordData[7]); System.debug(csvRecordData[7]);}
                if(csvRecordData[8] != ''){
            		gen.writeNumberField('evAssetQuantity',Decimal.valueOf(csvRecordData[8]));
                    System.debug(Decimal.valueOf(csvRecordData[8]));
                    Decimal temp = Decimal.valueOf(csvRecordData[8]);
                    if((temp - Math.floor(temp) != 0) && quantityDecimal == false) {
                        quantityDecimal = true;
                    }
                }
                if(csvRecordData[9] != ''){gen.writeNumberField('evAssetUnitCost',double.valueOf(csvRecordData[9]));}
                if(csvRecordData[10] != ''){gen.writeNumberField('evAssetUnitTax',double.valueOf(csvRecordData[10]));}
                if(csvRecordData[11] != ''){gen.writeNumberField('evAssetFreightCost',double.valueOf(csvRecordData[11]));}
                if(csvRecordData[12] != ''){gen.writeNumberField('evAssetParkingCost',double.valueOf(csvRecordData[12]));}
                if(csvRecordData[13] != ''){gen.writeNumberField('evAssetInstallationCost',double.valueOf(csvRecordData[13]));}
                if(csvRecordData[14] != ''){gen.writeNumberField('evAssetTrainingCost',double.valueOf(csvRecordData[14]));}
                if(csvRecordData[15] != ''){gen.writeNumberField('evAssetWarrantyCost',double.valueOf(csvRecordData[15]));}
                if(csvRecordData[16] != ''){gen.writeNumberField('evAssetSoftwareCost',double.valueOf(csvRecordData[16]));}
                if(csvRecordData[17] != ''){gen.writeStringField('evAssetConditionType',csvRecordData[17]);}
                if(csvRecordData[18] != ''){gen.writeStringField('evAssetInsuranceType',csvRecordData[18]);}
                if(csvRecordData[19] != ''){gen.writeStringField('evAssetMultLocationFlag',csvRecordData[19]);}
                if(csvRecordData[20] != ''){gen.writeStringField('evAssetRapidTagFlag',csvRecordData[20]);}
                if(csvRecordData[21] != ''){gen.writeStringField('evAssetImportFlag',csvRecordData[21]);}
                gen.writeStringField('evAssetActiveFlag',pasnull('Y'));
                gen.writeStringField('evAssetCreatedBy',pasnull(sSSO));
                gen.writeStringField('evAssetCreationDate',pasnull(System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00'))));
                gen.writeStringField('evLastUpdatedBy',pasnull(sSSO));
                gen.writeStringField('evAssetLastUpdateDate',pasnull(System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00'))));
                gen.writeEndObject();
            }
            gen.writeEndArray();
            gen.writeEndObject();
            gen.writeEndObject();
        }
        catch (Exception e)   { ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR,'An error has occured while importin data Please make sure input csv file is correct');       ApexPages.addMessage(errorMessage);        }
        
        
        
        PageReference pr;
        String jsonS = gen.getAsString();
       
        Map<string,object>jsonResponse=null;
        
        jsonResponse = EIV_EntityExtencionCalloutClass.postAssets(jsonS, sServiceURL); 
        
        
        if (jsonResponse == null) //Error en ORACLE, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Oracle Server missing'));
            pr = new PageReference('/apex/ES4_ReadPage_EVAL');
            pr.setRedirect(false); //Pasamos el controlador lleno 
        }
        else if (quantityDecimal) {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Quantity debe ser entero.'));
            pr = new PageReference('/apex/ES4_ReadPage_EVAL');
            pr.setRedirect(false); //Pasamos el controlador lleno 
        }
        
        else
        {
            //El resultado tiene status
            Map<String, Object> status = (Map<String, Object>)jsonResponse.get('status');
            
            detail = new EIV_DetailWrapClass();
            this.detail.errorCode =  (String)status.get('code'); //{code=S,N, detail=0, message=0}
            this.detail.description =  (String)status.get('detail');
            this.detail.message =  (String)status.get('message');
            
            if(this.detail.description == 'S') //Exito en el salvado, pasamos a la pagina de lectura de la Entidad y recargamos el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,this.detail.message));
                pr = new PageReference('/apex/ES4_ReadPage_EVAL?requestId=' + this.req.pOutRequestId);
                get_csv();
                pr.setRedirect(true); //Recargamos el controlador  
                
            }
            else //Error en el salvado, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,this.detail.errorCode));
                pr = new PageReference('/apex/ES4_ReadPage_EVAL');
                pr.setRedirect(false); //Pasamos el controlador lleno  
            }
            
            
        }
        return pr;
        
    }
    
    public void get_csv() {
        String filecontent;
        filecontent = 'ASSET_ID'+','+'COLATERAL_TYPE'+','+'COLATERAL_DESCRIPTION'+','+'ASSET_MANUFACTURER'+','+'ASSET_MODEL'+','+'ASSET_MODEL_YEAR'+','+'ASSET_DESCRIPTION'+','+'CURRENCY_TYPE'
            +','+'QUANTITY'+','+'UNIT_COST'+','+'UNIT_TAX'+','+'FREIGHT_COST'+','+'PARKING_COST'+','+'INSTALLATION_COST'+
            ','+'TRAINING_COST'+','+'WARRANTY_COST'+','+'SOFTWARE_COST'+','+'CONDITION_TYPE'+','+'INSURANCE_TYPE'+','+
            'MULT_LOCATION_FLAG'+','+'RAPID_TAG_FLAG'+','+'IMPORT_FLAG'+','+'No_Tocar'+'\n';
        
        integer i = req.EVALOBJ.pOutEVAssetTBL.size();
        
        for(integer a=0; a < i;a++){
            System.debug('tenemos estos Assetes ' + req.EVALOBJ.pOutEVAssetTBL[a]);
            filecontent += pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetAssetId)+ ',' +pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetCollateralType)+ ',' +pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetCollateralDescription)
                + ','+pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetManufacturer)+ ',' +pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetAssetModel)+ ',' +pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetAssetModelYear)  
                + ',' +pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetOracleFACategory)+ ',' +pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetCurrencyType) +',' +pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetQuantity)+ ',' +pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetUnitCost)
                + ',' +pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetUnitTax)+ ',' +pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetFreightCost)
                + ',' +pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetParkingCost)+ ',' +pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetInstallationCost)
                + ',' +pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetTrainingCost)+ ',' +pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetWarrantyCost)
                + ',' +pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetSoftwareCost)+ ',' +pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetConditionType)
                + ',' +pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetInsuranceType)
                + ',' +pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetMultLocationFlag)+ ',' +pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetRapidTagFlag)
                + ',' +pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetImportFlag)+ '\n';
        }
        
        dataASS = EncodingUtil.base64Encode(Blob.valueOf(filecontent));
    }
    
    public void get_csv_val() {
        String filecontent;
        filecontent = 'ASSET_ID'+','+'ASSET_DESCRIPTION'+','+'VALUATION_ID'+','+'TERM_MONTHS'+','
            +'FMV_AMOUNT'+','+'NRV_AMOUNT'+','+'OLV_AMOUNT'+','+'RV_AMOUNT'+','
            +'FMV_PERCENT'+','+'NRV_PERCENT'+','+'OLV_PERCENT'+','+'RV_PERCENT'+','+'INSURANCE_PRIMA'+','+'No_Tocar'+'\n';
        
        integer i = req.EVALOBJ.pOutEVAssetTBL.size();
        
        system.debug('tengo un tamaño de ' + i);
        for(integer a=0; a < i;a++){
            integer b = req.EVALOBJ.pOutEVAssetTBL[a].pOutEVValuationTBL.size();
            if(b == 0){
                list<integer> d = templeteval();
                for(integer c=0; c<d.size();c++){    filecontent +=pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetAssetId)+ ',' +pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetOracleFACategory)+ ',' +''+ ',' +d[c]+ ',' +''+ ',' +''+ ',' +''+ ',' +''+ ',' +''+ ',' +''+ ',' +''+ ',' +'' + ',' +''+ '\n';                }
                
            }
            else{
                for(integer c=0;c<b;c++){
                    System.debug('tenemos estos Assetes ' + b);
                    
                    //   
                    
                    filecontent += pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetAssetId)+ ',' +pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVAssetOracleFACategory)+ ','+pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVValuationTBL[c].pOutEVValValuationId)
                        + ',' +pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVValuationTBL[c].pOutEVValTermMonths)+ ',' 
                        +pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVValuationTBL[c].pOutEVValFMVAmount) + ',' +pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVValuationTBL[c].pOutEVValNRVAmount)+ ','  +pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVValuationTBL[c].pOutEVValOLVAmount)+ ','  +pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVValuationTBL[c].pOutEVValRVAmount)
                        +','+pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVValuationTBL[c].pOutEVValFMVPercent)+ ',' +pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVValuationTBL[c].pOutEVValNRVPercent)+ ','+pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVValuationTBL[c].pOutEVValOLVPercent)+ ','+pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVValuationTBL[c].pOutEVValRVPercent)
                        + ','  +pasnull(req.EVALOBJ.pOutEVAssetTBL[a].pOutEVValuationTBL[c].pOutEVValInsurancePrima)+ '\n';
                }
            }
            
        }
       
        dataVal = EncodingUtil.base64Encode(Blob.valueOf(filecontent));
    }
    
       public PageReference uploadExelVAL(){
           /*filecontent = 'ASSET_ID'+','+'ASSET_DESCRIPTION'+','+'VALUATION_ID'+','+'TERM_MONTHS'+','
            +'FMV_AMOUNT'+','+'NRV_AMOUNT'+','+'OLV_AMOUNT'+','+'RV_AMOUNT'+','
            +'FMV_PERCENT'+','+'NRV_PERCENT'+','+'OLV_PERCENT'+','+'RV_PERCENT'+','+'INSURANCE_PRIMA'+','+'No_Tocar'+'\n';*/
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
        gen.writeStringField('requestId',req.pOutRequestId);
        gen.writeFieldName('evalValuations');
        gen.writeStartObject();
        gen.writeFieldName('evalValuation');
        gen.writeStartArray();
        csvAsStringVal = csvFileBodyVal.toString();
        csvFileLinesVal = csvAsStringVal.split('\n');
        
        try{
            System.debug(csvFileLinesVal);
            for(Integer i=1;i<csvFileLinesVal.size();i++){
                
                
                csvFileLinesVal[i].replace('\n',',');
                string[] csvRecordDatas = csvFileLinesVal[i].split(',');
                csvRecordDatas.add(',');
                gen.writeStartObject();
                
                if(csvRecordDatas[0] != ''){gen.writeNumberField('evValAssetId',Integer.valueOf(csvRecordDatas[0]));}
                if(csvRecordDatas[2] != ''){gen.writeNumberField('evValValuationId',Integer.valueOf(csvRecordDatas[2]));}
                if(csvRecordDatas[3] != ''){gen.writeNumberField('evValTermMonths',Integer.valueOf(csvRecordDatas[3]));}
                if(csvRecordDatas[4] != ''){gen.writeNumberField('evValFmvAmount',Double.valueOf(csvRecordDatas[4]));}
                if(csvRecordDatas[5] != ''){gen.writeNumberField('evValNrvAmount',Double.valueOf(csvRecordDatas[5]));}
                if(csvRecordDatas[6] != ''){gen.writeNumberField('evValOlvAmount',Double.valueOf(csvRecordDatas[6]));}
                if(csvRecordDatas[7] != ''){gen.writeNumberField('evValRvAmount',Double.valueOf(csvRecordDatas[7]));}
                if(csvRecordDatas[8] != ''){gen.writeNumberField('evValFmvPercent',Double.valueOf(csvRecordDatas[8]));}
                if(csvRecordDatas[9] != ''){gen.writeNumberField('evValNrvPercent',Double.valueOf(csvRecordDatas[9]));}
                if(csvRecordDatas[10] != ''){gen.writeNumberField('evValOlvPercent',Double.valueOf(csvRecordDatas[10]));}
                if(csvRecordDatas[11] != ''){gen.writeNumberField('evValRvPercent',Double.valueOf(csvRecordDatas[11]));}
                if(csvRecordDatas[12] != ''){gen.writeNumberField('evValInsurancePrima',Double.valueOf(csvRecordDatas[12]));}
                gen.writeStringField('evValActiveFlag',pasnull('Y'));
                gen.writeStringField('evValCreatedBy',pasnull(sSSO));
                gen.writeStringField('evValCreationDate',pasnull(System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00'))));
                gen.writeStringField('evValLastUpdatedBy',pasnull(sSSO));
                gen.writeStringField('evValLastUpdateDate',pasnull(System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00'))));
                
                gen.writeEndObject();
                
            }
        }
        catch (Exception e)
        {
            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR,'An error has occured while importin data Please make sure input csv file is correct');
            ApexPages.addMessage(errorMessage);
        }
        
        gen.writeEndArray();
        gen.writeEndObject();
        gen.writeEndObject();
        
        PageReference pr;
        String jsonS = gen.getAsString();
        System.debug('jsonS--' +jsonS);
        Map<string,object>jsonResponse=null;
        
        jsonResponse = EIV_EntityExtencionCalloutClass.postValuations(jsonS, sServiceURL);
        
        
        if (jsonResponse == null) //Error en ORACLE, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Oracle Server missing'));
            pr = new PageReference('/apex/ES4_ReadPage_EVAL');
            pr.setRedirect(false); //Pasamos el controlador lleno 
        }
        else
        {
            //El resultado tiene status
            Map<String, Object> status = (Map<String, Object>)jsonResponse.get('status');
            
            detail = new EIV_DetailWrapClass();
            this.detail.errorCode =  (String)status.get('code'); //{code=S,N, detail=0, message=0}
            this.detail.description =  (String)status.get('detail');
            this.detail.message =  (String)status.get('message');
            
            if(this.detail.description == 'S') //Exito en el salvado, pasamos a la pagina de lectura de la Entidad y recargamos el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,this.detail.message));
                pr = new PageReference('/apex/ES4_ReadPage_EVAL?requestId=' + this.req.pOutRequestId);
                get_csv();
                pr.setRedirect(true); //Recargamos el controlador  
                
            }
            else //Error en el salvado, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,this.detail.errorCode));
                pr = new PageReference('/apex/ES4_ReadPage_EVAL');
                pr.setRedirect(false); //Pasamos el controlador lleno  
            }
            
            
        }
        return pr;
        
    }
    
    public PageReference NewEndodorsement(){
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
        gen.writeNumberField('requestId',Test.isRunningTest()?1234:Integer.valueOf(req.pOutRequestId));
        gen.writeFieldName('evalEndorsement');
        gen.writeStartObject();
        if(ENDO.pOutEVEndEndorsementId != null){
            gen.writeNumberField('evEndEndorsementId',Integer.valueOf(ENDO.pOutEVEndEndorsementId));
        }
        gen.writeNumberField('evEndAssetId',Integer.valueOf(ASS.pOutEVAssetAssetId));
        
        gen.writeStringField('evEndAttributeType',pasnull(ENDO.pOutEVEndAttributeType));
        gen.writeStringField('evEndValueType',pasnull(ENDO.pOutEVEndValueType));
        gen.writeStringField('evEndUomType',pasnull(ENDO.pOutEVEndUomType));
        gen.writeStringField('evEndValueOther',pasnull(ENDO.pOutEVEndValueOther));
        gen.writeStringField('evEndComment',pasnull(ENDO.pOutEVEndComment));
        
        gen.writeStringField('evEndActiveFlag',pasnull('Y'));
        gen.writeStringField('evEndCreatedBy',pasnull(sSSO));
        gen.writeStringField('evEndCreationDate',pasnull(System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00'))));
        gen.writeStringField('evEndLastUpdatedBy',pasnull(sSSO));
        gen.writeStringField('evEndLastUpdateDate',pasnull(System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00'))));
        gen.writeEndObject();
        gen.writeEndObject();
        
        PageReference pr;
        String jsonS = gen.getAsString();
        System.debug('Nuevo endorsment');
        system.debug(jsonS);
        
        Map<string,object>jsonResponse=null;
        
        jsonResponse = EIV_EntityExtencionCalloutClass.postendorsement(jsonS, sServiceURL); 
       
        
        if (jsonResponse == null ) //Error en ORACLE, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Oracle Server missing'));
            pr = new PageReference('/apex/ES4_EVAL_NewValuations');
            pr.setRedirect(false); //Pasamos el controlador lleno 
        }
        else
        {
            //El resultado tiene status
            Map<String, Object> status = (Map<String, Object>)jsonResponse.get('status');
            
            detail = new EIV_DetailWrapClass();
            this.detail.errorCode =  (String)status.get('code'); //{code=S,N, detail=0, message=0}
            this.detail.description =  (String)status.get('detail');
            this.detail.message =  (String)status.get('message');
            
            if(this.detail.description == 'S') //Exito en el salvado, pasamos a la pagina de lectura de la Entidad y recargamos el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,this.detail.message));
                pr = new PageReference('/apex/ES4_ReadPage_EVAL?requestId=' + this.req.pOutRequestId);
                pr.setRedirect(true); //Recargamos el controlador  
                
            }
            else //Error en el salvado, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,this.detail.errorCode));
                pr = new PageReference('/apex/ES4_EVAL_NewValuations');
                pr.setRedirect(false); //Pasamos el controlador lleno  
            }
            
            
        }    
        return pr;
    }
    
    public PageReference NewValua(){
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
        gen.writeStringField('requestId',req.pOutRequestId);
        gen.writeFieldName('evalValuations');
        gen.writeStartObject();
        gen.writeFieldName('evalValuation');
        gen.writeStartArray();
        gen.writeStartObject();
        if(VAll.pOutEVValValuationId != null){
            gen.writeStringField('evValValuationId',VAll.pOutEVValValuationId);
        }
        gen.writeStringField('evValAssetId',ASS.pOutEVAssetAssetId);
        gen.writeStringField('evValTermMonths',pasnull(VALL.pOutEVValTermMonths));
        gen.writeStringField('evValFmvAmount',pasnull(VALL.pOutEVValFMVAmount));
        gen.writeStringField('evValFmvPercent',pasnull(VALL.pOutEVValFMVPercent));
        gen.writeStringField('evValNrvAmount',pasnull(VALL.pOutEVValNRVAmount));
        gen.writeStringField('evValNrvPercent',pasnull(VALL.pOutEVValNRVPercent));
        gen.writeStringField('evValOlvAmount',pasnull(VALL.pOutEVValOLVAmount));
        gen.writeStringField('evValOlvPercent',pasnull(VALL.pOutEVValOLVPercent));
        gen.writeStringField('evValRvAmount',pasnull(VALL.pOutEVValRVAmount));
        gen.writeStringField('evValRvPercent',pasnull(VALL.pOutEVValRVPercent));
        gen.writeStringField('evValInsurancePrima',pasnull(VALL.pOutEVValInsurancePrima));
        
        gen.writeStringField('evValActiveFlag',pasnull('Y'));
        gen.writeStringField('evValCreatedBy',pasnull(sSSO));
        gen.writeStringField('evValCreationDate',pasnull(System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00'))));
        gen.writeStringField('evValLastUpdatedBy',pasnull(sSSO));
        gen.writeStringField('evValLastUpdateDate',pasnull(System.String.valueOf(System.Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.000-00:00'))));
        gen.writeEndObject();
        gen.writeEndArray();
        gen.writeEndObject();
        gen.writeEndObject();
        PageReference pr;
        String jsonS = gen.getAsString();
        
        
        Map<string,object>jsonResponse=null;
        system.debug('JSON VALUATION');
        system.debug(jsonS);
        
        jsonResponse = EIV_EntityExtencionCalloutClass.postValuations(jsonS, sServiceURL); 
        
        
        if (jsonResponse == null) //Error en ORACLE, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Oracle Server missing'));
            pr = new PageReference('/apex/ES4_EVAL_NewValuation');
            pr.setRedirect(false); //Pasamos el controlador lleno 
        }
        else
        {
            //El resultado tiene status
            Map<String, Object> status = (Map<String, Object>)jsonResponse.get('status');
            System.debug('Received the following JSON response of status OEJ01:' + status);
            detail = new EIV_DetailWrapClass();
            this.detail.errorCode =  (String)status.get('code'); //{code=S,N, detail=0, message=0}
            this.detail.description =  (String)status.get('detail');
            this.detail.message =  (String)status.get('message');
            
            if(this.detail.description == 'S') //Exito en el salvado, pasamos a la pagina de lectura de la Entidad y recargamos el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,this.detail.message));
                pr = new PageReference('/apex/ES4_ReadPage_EVAL?requestId=' + this.req.pOutRequestId);
                pr.setRedirect(true); //Recargamos el controlador  
                
            }
            else //Error en el salvado, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,this.detail.errorCode));
                pr = new PageReference('/apex/ES4_EVAL_NewValuation');
                pr.setRedirect(false); //Pasamos el controlador lleno  
            }
            
            
        }    
        return pr;
    }
    
    public PageReference newcoment()
    {
        //falta logica del guardado
        /////***////
        
        PageReference pr = new PageReference('/apex/ES2_EditPage_ADD_COMENTARIOS?TopParentID=' +this.req.pOutsourceTopParentId+ 
                                             '&TopParentName=' + this.req.pOutsourceTopParentName + 
                                             '&OracleAccountName=' + this.req.pOutPartyName +  
                                             '&PartyId='+this.req.pOutPartyId+
                                             '&requestId='+this.req.pOutRequestId +
                                             '&dir=EVAL');
        pr.setRedirect(false); //Pasamos el controlador vacio  
        return pr;        
    }
    
    public PageReference recarga(){
        PageReference pr;
        pr= new PageReference('/apex/ES4_ReadPage_EVAL?requestId=' + req.pOutRequestId + '&sso' + sSSO);
        pr.setRedirect(true);
        return pr;
    }

    @RemoteAction
    public static string deleteDocument(string requestIdDoc, string oraId,string docUrl,string docType,string docId,string nameDoc, string requestId)
    {
        System.debug('ids------->' + requestIdDoc +' '+ oraId+ ' ' + docUrl+ ' '+ docType + ' '+ docId + ' ' + nameDoc);
        //ES2_Controller_DOCUMENTOS controller = new ES2_Controller_DOCUMENTOS();
        
        //String resultado = controller.DeleteDocs(req.pOutPartyId , requestIdDoc, nameDoc, idDoc);
        //String resultado = Test.isRunningTest() ? 'vacio' : controller.DeleteDocs(req.pOutPartyId, requestIdDoc, nameDoc, idDoc, req.pOutSourceAccountId , req.pOutSourceTopParentId ,req.pOutSourceTopParentName, req.pOutPartyName, req.pOutEGPartyId, req.pOutEGPartyName);
        string resultado = ES2_Controller_DOCUMENTOS.deleteDoc(requestIdDoc, oraId, docUrl, docType, docId, nameDoc);
        
        string a='';
        
        //Error en ORACLE, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
        if (resultado.contains('ERROR')) 
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,resultado));
             a='ERROR';
        }
        else {string backUrl = System.Url.getSalesforceBaseURL().toExternalForm() + '/one/one.app#/alohaRedirect/apex/ES4_ReadPage_EVAL?requestId='+ requestId;  a=backUrl; } 
        return a;
    }
    

    @RemoteAction  
    public static string  newdocument(string DocTypesObj, string requestId, string partyId, String pOutEGPartyName,string sso)
    {
        
        String URL_Servicio_Externa = Test.isRunningTest() ? 'https://test.com' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='URL_Servicio_Externa'][0].EIV_tx_parameter__c; 
        string KeyEncriptation =Test.isRunningTest() ? 'https://test.com' : [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='KeyEncriptation'][0].EIV_tx_parameter__c; 
        string EncriptationType = Test.isRunningTest() ? 'AES128' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='EncriptationType'][0].EIV_tx_parameter__c; 
        string UrlAppDoctos = Test.isRunningTest() ? 'https://test.com' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='UrlAppDoctos'][0].EIV_tx_parameter__c; 
        string backUrl = System.Url.getSalesforceBaseURL().toExternalForm() + '/one/one.app#/alohaRedirect/apex/ES4_ReadPage_EVAL?requestId='+ requestId;
       

       
		
        Datetime dt = Datetime.now();
		Long l = dt.getTime();
		Long f = l ;
		system.debug(l);
		system.debug(f);
		
        string cddate = string.valueOf(DateTime.newInstance(f));
        system.debug('Hora local: ' +  cddate);
        

        STRING clearText = 'requestId='+ requestId + '&documentType=['+DocTypesObj +']&partyId='+ partyId + '&partyName=' + pOutEGPartyName + '&sso=' +sso + '&urlserver='+ URL_Servicio_Externa + '&backUrl=' +backUrl + '&cddate=' + cddate;
        System.debug('url sin enc-----><'+ clearText);
        Blob key = Blob.valueOf(KeyEncriptation);
        Blob textoEncB = Crypto.encryptWithManagedIV(EncriptationType, key, Blob.valueOf(clearText));
        String textoEnc = EncodingUtil.base64Encode(textoEncB);
        string encodedTextAES = UrlAppDoctos + '/xxec_episodioIVDocuments-vcDocuments-context-root/faces/documentUploadFile.jspx?params=' + textoEnc ;
        return encodedTextAES;
    }

    @RemoteAction
    public static string downloadDoctos(string docId, string RequestId){
     	String URL_Servicio_Externa = Test.isRunningTest() ? 'https://test.com' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='URL_Servicio_Externa'][0].EIV_tx_parameter__c; 
        string KeyEncriptation =Test.isRunningTest() ? 'https://test.com' : [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='KeyEncriptation'][0].EIV_tx_parameter__c; 
        string EncriptationType = Test.isRunningTest() ? 'AES128' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='EncriptationType'][0].EIV_tx_parameter__c; 
        string UrlAppDoctos = Test.isRunningTest() ? 'https://test.com' :  [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='UrlAppDoctos'][0].EIV_tx_parameter__c; 
          

        Datetime dt = Datetime.now();
		Long l = dt.getTime();
		Long f = l ;
		system.debug(l);
		system.debug(f);
		
        string cddate = string.valueOf(DateTime.newInstance(f));
       
        string backUrl = System.Url.getSalesforceBaseURL().toExternalForm() + '/one/one.app#/alohaRedirect/apex/ES4_ReadPage_EVAL?requestId='+ RequestId;
        
        STRING clearText = 'contentDocId='+ docId + '&backUrl=' +backUrl +'&urlserver='+ URL_Servicio_Externa + '&cddate=' + cddate;
        Blob key = Blob.valueOf(KeyEncriptation);
        Blob textoEncB = Crypto.encryptWithManagedIV(EncriptationType, key, Blob.valueOf(clearText));
        String textoEnc = EncodingUtil.base64Encode(textoEncB);
        string encodedTextAES = UrlAppDoctos + '/xxec_episodioIVDocuments-vcDocuments-context-root/faces/documentDownloadFile.jspx?params=' + textoEnc;
        
        return encodedTextAES;
    }
    
    public void doctypesList(){
        this.doctypess = new list<string>();
        for(integer i=0; i<=req.DocTypesObj.size()-1; i++){ string docname = req.DocTypesObj[i].name; doctypess.add(docname);  }
        doctiposString =string.join(doctypess, (','));
    }
    
    public void passUrlback(){
        backUrl = ApexPages.currentPage().getParameters().get('one');
    }
    public void getListEntities()
    {
        //Se carga en el controlador el TopParent, se coloca en el AcountId del que se van a buscar las entidades 
        ////AccountId=0015B00000SUIBD&AccountName=Una+Prueba&TopParentID=&TopParentName=&PartyId=, Method=GET]
        //Enviaremos
        //PartyId, pasado pro la URL
        //SSO obtenido de consulta de EmployeeNumber 
        //Aplication code, que sera siempre SF
        Map<String, Object> jsonResponse = null;
        entities = new List<EIV_EntityWrapClass>();
        if( String.isBlank(this.req.pOutSourceTopParentId)) {jsonResponse = EIV_EntityExtencionCalloutClass.callBackEntitiesOfTopParent(this.req.pOutSourceAccountId,sSSO,this.sServiceURL);          }
        else
        {
            jsonResponse = EIV_EntityExtencionCalloutClass.callBackEntitiesOfTopParent(test.isRunningTest()?'123' : this.req.pOutSourceTopParentId,sSSO,this.sServiceURL);
        }
        
        
        if (jsonResponse == null){ ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Oracle Server missing')); }
        else
        {
            //El resultado tiene status
            Map<String, Object> status = (Map<String, Object>)jsonResponse.get('status');
            
            detail = new EIV_DetailWrapClass();
            //this.detail.errorCode =  (String)status.get('code'); //{code=0, detail=0, message=0}
            this.detail.description =  (String)status.get('detail');
            this.detail.message =  (String)status.get('message');
            
            if(this.detail.message == 'S')
            {
                
                //El resultado tiene entityInfo 
                Map<String, Object> entityInfo = (Map<String, Object>)jsonResponse.get('entityInfo');
                
                
                //EntityInfo tiene privilege de la entidad
                Map<String, Object> entityPriv = (Map<String, Object>)entityInfo.get('privilege');
                               
                //Respuesta OK
                
                Map<String, Object> entitiesL = (Map<String, Object>)entityInfo.get('entities');
               
                if(entitiesL == null) //no traemos contactos
                {
                    System.debug('Este Top Parent no tiene entidades'); 
                }
                else
                {
                    entities = new List<EIV_EntityWrapClass>();
                    List<Object> entitiesList = (List<Object>)entitiesL.get('entity');
                    for(Object a : entitiesList) {  Map<String, Object> newAdd = (Map<String, Object>) a;  entities.add(responseToEntityObj(newAdd));               }
                    
                   
                    
                }         
                
                
            }
            else       {               ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,this.detail.description));            }   
        }
    }
    public EIV_EntityWrapClass responseToEntityObj(Map<String, Object> entityDetail)
    {
        
        EIV_EntityWrapClass etty = new EIV_EntityWrapClass();
        etty.entityName                    = (String)entityDetail.get('entityName');
        etty.Customer_Name                 = (String)entityDetail.get('customerName');
        //etty.Customer_Alias                = (String)buro.get('customerAlias');    
        etty.Customer_Type                 = (String)entityDetail.get('customerType');
        etty.Party_Id                      = String.valueOf(entityDetail.get('partyID'));
        etty.Customer_Status               = (String)entityDetail.get('customerStatus');
        etty.Cust_AccountId                = (String)entityDetail.get('custAccountId');
        etty.Top_Parent_ID                 = (String)entityDetail.get('topParentId');
        etty.Top_Parent_Name               = (String)entityDetail.get('topParentName');
        etty.Account_ID                    = (String)entityDetail.get('sFaccountID');
        etty.SF_Account_Name               = (String)entityDetail.get('sfAccountName');
        etty.RFC                           = (String)entityDetail.get('rfc');
        etty.TIN                           = (String)entityDetail.get('tin');
        etty.Economic_Group_ID             = String.valueOf(entityDetail.get('economicGroupId'));
        etty.Economic_Group_Name           = (String)entityDetail.get('economicGroupName');
        etty.EconomicGroupPartyId          = (String)entityDetail.get('economicGroupPartyId');
        //etty.Limited_information_entity    = booleanToString((Boolean)entityDetail.get('limitedInformationEntity'));
        etty.Tax_Regime                    = (String)entityDetail.get('taxRegime');
        //etty.Foreign_Entity                = booleanToString((Boolean)entityDetail.get('foreignEntity'));
        etty.Nationality                   = (String)entityDetail.get('nationality');
        etty.Oracle_Account_Number         = (String)entityDetail.get('oracleAccountNumber');
        etty.CURP                          = (String)entityDetail.get('curp');
        etty.Prefix                        = (String)entityDetail.get('prefix');
        etty.First_Name                    = (String)entityDetail.get('firstName');
        etty.Middle_Name                   = (String)entityDetail.get('middleName');
        etty.First_Last_Name               = (String)entityDetail.get('firstLastName');
        etty.Second_Last_Name              = (String)entityDetail.get('secondLastName');
        etty.Sales_Representative          = (String)entityDetail.get('salesRepresentative');
        //etty.Supplier_Flag                 = booleanToString((Boolean)entityDetail.get('supplierFlag'));
        etty.Legal_Name_sin_denominacion   = (String)entityDetail.get('legalName');
        etty.Company_Legal_Name_termination= (String)entityDetail.get('companyLegalNameTermination');
        etty.Oracle_Account_Name           = (String)entityDetail.get('oracleAccountName');
        //etty.vfSNameRead                   = vfTypeEntitieRead(etty.Customer_Type);   
        return etty;       
    }
}