@isTest
private class Eng_SuperTRUMPPQCloneControllerTests {
    
	static testMethod void testMyController()
	{
		PageReference pageRef = Page.Pricing_Quote_Clone_Engenium;
		Test.setCurrentPage(pageRef);
		IST__SuperTRUMP_Pricing_Quote__c pq = Eng_SuperTRUMPTestUtilities.createPricingQuote();
		ApexPages.StandardController stdController = new ApexPages.StandardController(pq);
		Eng_SuperTRUMPPQCloneController controller = new Eng_SuperTRUMPPQCloneController(stdController);
		
		System.assertEquals(controller.recordName, controller.stPQCloneController.recordName);
		
		controller.actionNavigate = 'back';
		controller.actionURL = 'url';
		controller.actionView = 'view';
		
		System.assertEquals('back', controller.actionNavigate);
		System.assertEquals('url', controller.actionURL);
		System.assertEquals('view', controller.actionView);
		
		ApexPages.Message testMessage1 = new ApexPages.Message(ApexPages.Severity.ERROR, 'Test error message');
		ApexPages.Message testMessage2 = new ApexPages.Message(ApexPages.Severity.WARNING, 'Test warning message');
		ApexPages.addMessage(testMessage1);
		ApexPages.addMessage(testMessage2);
		controller.accumulateMessages();
		System.Test.clearApexPageMessages();
		controller.dispenseMessages();
		ApexPages.Message[] pageMessages = ApexPages.getMessages();
		System.assertEquals(2, pageMessages.size());
		System.assertEquals('Test error message', pageMessages[0].getSummary());
		System.assertEquals(ApexPages.Severity.ERROR, pageMessages[0].getSeverity());
		System.assertEquals('Test warning message', pageMessages[1].getSummary());
		System.assertEquals(ApexPages.Severity.WARNING, pageMessages[1].getSeverity());
		controller.dispenseMessages();
		System.Test.clearApexPageMessages();
		ApexPages.addMessage(testMessage1);
		controller.accumulateMessages();
		System.assertEquals(1, controller.msgs.size());		
		System.Test.clearApexPageMessages();
		controller.accumulateMessages();
		System.assertEquals(0, controller.msgs.size());
		
		System.Test.clearApexPageMessages();		
		controller.pgref = null;
		ApexPages.addMessage(testMessage1);
		controller.accumulateMessages();
		System.Test.clearApexPageMessages();
		PageReference pref = controller.executeST();
		System.assertEquals(null, pref);
	}
	
	static testmethod void testExecuteST()
	{
        PageReference pageRef = Page.Pricing_Quote_Clone_Engenium;
        Test.setCurrentPage(pageRef);
        IST__SuperTRUMP_Pricing_Quote__c quote = Eng_SuperTRUMPTestUtilities.createPricingQuote();
        TestSuperTrumpCloneController internalController = new TestSuperTrumpCloneController();
        ApexPages.StandardController stdController = new ApexPages.StandardController(quote);
        Eng_SuperTRUMPPQCloneController controller = new Eng_SuperTRUMPPQCloneController(stdController, internalController);
        ID RecordId = ID.valueOf(quote.Id);
        internalController.SetReturnValue(ControllerMethod.CLONE, quote.Id);
        
        PageReference pref = controller.executeST();
		
        System.assertEquals(null, pref);
		
        Test.startTest();
        controller.cloneRecord();
        pref = controller.executeST();
        Test.stopTest();
		
        System.assertEquals(null, pref);
	}
	
	static testmethod void testCloneRecord()
	{
        IST__SuperTRUMP_Pricing_Quote__c quote = Eng_SuperTRUMPTestUtilities.createPricingQuote();
        TestSuperTrumpCloneController internalController = new TestSuperTrumpCloneController();
        ApexPages.StandardController stdController = new ApexPages.StandardController(quote);
        Eng_SuperTRUMPPQCloneController controller = new Eng_SuperTRUMPPQCloneController(stdController, internalController);
        ID RecordId = ID.valueOf(quote.Id);
        internalController.SetReturnValue(ControllerMethod.CLONE, quote.Id);
        
        Test.startTest();
        PageReference pref = controller.cloneRecord();
        Test.stopTest();
        
        System.assertEquals(null, pref);
	}
    
    static testMethod void testCancel()
    {
        IST__SuperTRUMP_Pricing_Quote__c quote = new IST__SuperTRUMP_Pricing_Quote__c();
        TestSuperTrumpCloneController internalController = new TestSuperTrumpCloneController();
        ApexPages.StandardController stdController = new ApexPages.StandardController(quote);
        Eng_SuperTRUMPPQCloneController controller = new Eng_SuperTRUMPPQCloneController(stdController, internalController);
        internalController.SetReturnValue(ControllerMethod.CANCEL, stdController.cancel());
        
        Test.startTest();
        PageReference pref = controller.cancel();
        Test.stopTest();
        
        System.assertEquals(stdController.cancel().getURL(), pref.getURL());
    }

    static testMethod void testSuperTrumpEditControllerImpl()
    {	
        Opportunity opp = new Opportunity(
            Name = 'Test Opportunity',
            StageName = 'Lead',
            Amount = 1000000.00,
            CloseDate = Date.today().addYears(1),
            OPP_ls_Line_of_Business__c='Equipment', 
            OPP_ls_Collateral__c='Agricultural Equipment'
        );
        
        insert opp;
        opp = [SELECT Id, Name, LastModifiedDate, LastModifiedById, SystemModstamp FROM Opportunity WHERE Id = :opp.Id][0];
        // clone the object so it has all attributes exception the id. This causes the edit controller to immediately
        // fail when trying to save.
        opp = opp.clone(false, true, true, true);
        ApexPages.StandardController stdContr = new ApexPages.StandardController(opp);
        
        IST.SuperTRUMPCloneController cloneController = new IST.SuperTRUMPCloneController(stdContr);
        Eng_SuperTRUMPPQCloneController.SuperTrumpCloneControllerImpl containerContr = new Eng_SuperTRUMPPQCloneController.SuperTrumpCloneControllerImpl(cloneController);
                
        // ignore any errors - just calling for code coverage.  The actual saves is tested elsewhere
        try{
            containerContr.cloneRecord();
        }
        catch(Exception e){} // ignore - just calling for code coverage.
        try{
        	containerContr.cancel();
        }
        catch(Exception e){} // ignore - just calling for code coverage.
    }

    private class TestSuperTrumpCloneController implements Eng_SuperTRUMPPQCloneController.SuperTrumpCloneController
    {    	
        Map<ControllerMethod, Object> returnValues = new Map<ControllerMethod, Object>();

        public String cloneRecord(){
            ControllerMethod method = ControllerMethod.CLONE;
            return (String) getReturnValue(method);
        }

        public PageReference cancel(){
        	ControllerMethod method = ControllerMethod.CANCEL;
        	return (PageReference) getReturnValue(method);
        }
         
        public void setReturnValue(ControllerMethod method, Object value){
            returnValues.put(method, value);
        }
        
        private Object getReturnValue(ControllerMethod method){
            Object returnValue = returnValues.get(method);
            if (returnValue instanceof Exception){
                throw (Exception) returnValue;
            }
            return returnValue;
        }
    }
    
    private enum ControllerMethod {
            CLONE, CANCEL
    }
}