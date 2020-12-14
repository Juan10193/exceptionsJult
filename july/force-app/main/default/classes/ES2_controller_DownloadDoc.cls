public class ES2_controller_DownloadDoc {
    public ES2_WraperDoc req {get;set;}
	public EIV_DetailWrapClass detail                   {get;set;}
    public String sServiceURL 							{get;set;}
    public String sSSO 									{get;set;} 
    public String doctod {get;set;}
    
    public ES2_controller_DownloadDoc(){
        this.req = new ES2_WraperDoc();
        this.req.contentDocId = Test.isRunningTest() ? 'contentDocId' : (String)System.currentPageReference().getParameters().get('contentDocId');
        this.sServiceURL = Test.isRunningTest() ? 'https://www.test.com' : [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='URL_Servicio'][0].EIV_tx_parameter__c; 
        this.sSSO = Test.isRunningTest() ? '9999' : [Select EmployeeNumber From User Where Id = :UserInfo.getUserId()][0].EmployeeNumber;  
        
        if ( String.isNotBlank(this.req.contentDocId) ){
            
             Map<string,object>jsonResponse =null;
            jsonResponse = Test.isRunningTest() ? new Map<string, object>() :  EIV_EntityExtencionCalloutClass.callBackGetDocument(this.sServiceURL, this.req.contentDocId);
            Map<String, Object> mapRequests = (Map<String, Object>)jsonResponse;
            //System.debug('postRequestDetail JJ: ' + mapRequests);
           
            
            ES2_DocumentFill rellena = new ES2_DocumentFill();
            
            list<ES2_WraperDoc>dts = new list<ES2_WraperDoc>();
            
            dts = rellena.rellenarDoc(mapRequests);
            if(dts.size()>0)
                {
                    req = dts[0];
                }
           			
        }
    }
    
    public string getDoc(){
        doctod = req.docContentB64;
        return doctod;
    }
}