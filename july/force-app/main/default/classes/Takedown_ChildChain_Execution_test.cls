@istest
public class Takedown_ChildChain_Execution_test {
    @testSetup static void testSetUp() {
		list<EIV_Parameter__c> parameters = Test.loadData(EIV_Parameter__c.sobjectType, 'parametrosTest');
        Takedown_Invoice__c tkd_invoice = Data_Factory_TakedownInvoice_Test.createTakedownInvoiceToValidation('xml');
	}
    static testmethod void test1() {
        List<takedownTableDocumentsWrapper_cls.TableElement> listTableElement = new List<takedownTableDocumentsWrapper_cls.TableElement>();
    	Takedown_Invoice__c tkd_invoice = [select id, name, TKD_pd_Takedown_CP__c, TKD_txt_Content_Version_ID__c,
                                          TKD_txt_Document_ID__c, TKD_txt_Extension__c, TKD_pd_Takedown_CP__r.TKD_ls_asset_type__c,
                                          TKD_pd_Takedown_CP__r.CPL_rb_Opp__r.AccountId from Takedown_Invoice__c limit 1];
        takedownTableDocumentsWrapper_cls.TableElement tableElement = new takedownTableDocumentsWrapper_cls.TableElement();
       	tableElement.id = tkd_invoice.id;
        tableElement.name = tkd_invoice.Name;
        tableElement.TKD_fm_validation = 'test';
        tableElement.TKD_ls_Status = 'test';
        tableElement.TKD_pd_Takedown_CP = tkd_invoice.TKD_pd_Takedown_CP__c;
        tableElement.TKD_txt_Content_Version_ID = tkd_invoice.TKD_txt_Content_Version_ID__c;
        tableElement.TKD_txt_Document_ID = tkd_invoice.TKD_txt_Document_ID__c;
        tableElement.TKD_txt_Extension = tkd_invoice.TKD_txt_Extension__c;
        tableElement.TKD_ls_asset_type = tkd_invoice.TKD_pd_Takedown_CP__r.TKD_ls_asset_type__c;
        tableElement.AccountId = tkd_invoice.TKD_pd_Takedown_CP__r.CPL_rb_Opp__r.AccountId;
        listTableElement.add(tableElement);
        listTableElement.add(tableElement);
        TakedownTableDocumentsService_cls tkd_DocuService = new TakedownTableDocumentsService_cls();        
        List<Takedown_Wrapper_SATVal_OL_cls.SATValRequest> listSATValRequest = new List<Takedown_Wrapper_SATVal_OL_cls.SATValRequest>(); 
        listSATValRequest = tkd_DocuService.fillWrapperRequest(listTableElement);
        try{
        	Test.startTest();        
            System.enqueueJob(new Takedown_ChildChain_Execution_cls(listSATValRequest,tkd_invoice.TKD_pd_Takedown_CP__r.CPL_rb_Opp__r.AccountId));
            Test.stopTest();    
        }catch(Exception e){
        	system.debug('Exception e ' + e);    
        }
        
    }/*
    @istest
    static void execute(){
        string stringResponse = '{"access_token":"0bd709f8-049a-406a-98ca-b46a70ced19c","token_type":"bearer","expires_in":299,"scope":"test"}';
        String testEndpoint = '	https://apps.engeniumcapital.com:18080/uaa/oauth/token';
        
        EIV_Parameter__c parameters = new EIV_Parameter__c();
        parameters.name = 'fecha limite';
        parameters.EIV_tx_parameter__c = '01/12/2018';
        insert parameters;
        Takedown_Invoice__c tkd_invoice = Data_Factory_TakedownInvoice_Test.createTakedownInvoice('xml');
        list<Takedown_Wrapper_SATVal_OL_cls.SATValRequest> listTakedown_Wrapper_SATVal = new list<Takedown_Wrapper_SATVal_OL_cls.SATValRequest>();
        Takedown_Wrapper_SATVal_OL_cls.SATValRequest SATValRequest = new Takedown_Wrapper_SATVal_OL_cls.SATValRequest();
        SATValRequest.assetType = 'Transporte (Tractocamiones)';
        SATValRequest.channel = '3';
        SATValRequest.documentId = tkd_invoice.TKD_txt_Document_ID__c;
        SATValRequest.mimeTypeXML = 'xml';
        SATValRequest.organizationId = UserInfo.getOrganizationId();
        SATValRequest.ssoId = '100000001';
        SATValRequest.takedownId = tkd_invoice.TKD_pd_Takedown_CP__c;
        listTakedown_Wrapper_SATVal.add(SATValRequest);
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseHandler_cls(testEndpoint,stringResponse , 'GET', 'application/json', 200));
        Takedown_ChildChain_Execution_cls tkd_child = new  Takedown_ChildChain_Execution_cls(listTakedown_Wrapper_SATVal, tkd_invoice.TKD_pd_Takedown_CP__r.CPL_rb_Opp__r.AccountId);
        tkd_child.execute(null);
    }
*/
}