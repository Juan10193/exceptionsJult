global class CreditBureauApprovalProcess_batchRequest implements Database.Batchable<sObject>,   Database.AllowsCallouts {
    
    private id opportunityId;
    
    global CreditBureauApprovalProcess_batchRequest(id opportunityId){
        this.opportunityId = opportunityId;
        
    }
	global Database.QueryLocator start(Database.BatchableContext BC) {
        String query = 'SELECT Id, Name, LMM_rb_Opportunity__c,'
           + '(select id, name, LMM_ls_Status__c, LMM_tl_JSON_Request__c from Requests_Credit_Bureau1__r)'
           + 'FROM LMM_Credit_Bureau_Approval_Process__c where LMM_rb_Opportunity__c = \'' + opportunityId + '\'';
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext BC, List<LMM_Credit_Bureau_Approval_Process__c> listLMM_Credit_Bureau_Approval_Process) {
        system.debug('inicia listLMM_Credit_Bureau_Approval_Process ' + listLMM_Credit_Bureau_Approval_Process);
        list<LMM_Request_Credit_Bureau__c> listLMM_Request_Credit_Bureau = new list<LMM_Request_Credit_Bureau__c>(); 
        for (LMM_Credit_Bureau_Approval_Process__c LMM_Credit_Bureau_Approval_Process : listLMM_Credit_Bureau_Approval_Process){   
            for(LMM_Request_Credit_Bureau__c LMM_Request_Credit_Bureau : LMM_Credit_Bureau_Approval_Process.Requests_Credit_Bureau1__r){
            	try {  
					string bodyResponse = EIV_EntityCallout.createCreditBureau(LMM_Request_Credit_Bureau.LMM_tl_JSON_Request__c).getBody();
					/*string bodyResponse = '{'
                          + '"requestId" : 5601,'
                          + '"status" : {'
                          + '"code" : "Request ID : 5601",'
                          + '"message" : "Success",'
                          + '"detail" : "S"'
                          + '}'
                        + '}'; */
                    system.debug('bodyResponse ' + bodyResponse);
                    Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(bodyResponse);
                    system.debug('results ' + results);
                    Map<string,object> classObject = (map<string,object>) results.get('status');
                    string detail = (string) classObject.get('detail');
                    system.debug('detail ' + detail);
                    LMM_Request_Credit_Bureau.LMM_ls_Status__c = 'VALIDATED';
                    system.debug('LMM_Request_Credit_Bureau ' + LMM_Request_Credit_Bureau);
                    listLMM_Request_Credit_Bureau.add(LMM_Request_Credit_Bureau); 
                    /*
                    if(string.isNotEmpty(detail) && detail.equals('S')){
                                                  
                    } else if(string.isNotEmpty(detail) && detail.equals('F')){
                        LMM_Request_Credit_Bureau.LMM_ls_Status__c = 'VALIDATED';
                        system.debug('LMM_Request_Credit_Bureau ' + LMM_Request_Credit_Bureau);
                        listLMM_Request_Credit_Bureau.add(LMM_Request_Credit_Bureau); 
                    }*/
                    
                } catch (Exception e) {         
                    System.debug('Error:' + e.getMessage() + 'LN:' + e.getLineNumber() );           
                }    
            }        	
       	}
        system.debug('listLMM_Request_Credit_Bureau ' + listLMM_Request_Credit_Bureau);
        CreditBureauApprovalProcess_Helper.unlockRequestCreditBureau(listLMM_Request_Credit_Bureau);
        update listLMM_Request_Credit_Bureau;
        CreditBureauApprovalProcess_Helper.lockRequestCreditBureau(listLMM_Request_Credit_Bureau);
    }   

    global void finish(Database.BatchableContext BC){    
    }
}