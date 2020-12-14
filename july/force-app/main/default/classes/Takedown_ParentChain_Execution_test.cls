@istest
public class Takedown_ParentChain_Execution_test {
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
            System.enqueueJob(new Takedown_ParentChain_Execution_cls(listSATValRequest,tkd_invoice.TKD_pd_Takedown_CP__r.CPL_rb_Opp__r.AccountId));
            Test.stopTest();    
        }catch(Exception e){
        	system.debug('Exception e ' + e);    
        }
        
    }

}