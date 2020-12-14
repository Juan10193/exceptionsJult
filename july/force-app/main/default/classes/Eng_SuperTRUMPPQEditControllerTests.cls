@isTest
private class Eng_SuperTRUMPPQEditControllerTests {
	
    // this is used to create fake ids so we don't have interact with the database to get an id
    private static Integer fakeIdNumber = 0;

    private static ID getFakeId(DescribeSObjectResult describeObj)
    {
        String result = String.valueOf(fakeIdNumber++);
        String fakeId = describeObj.getKeyPrefix() + '0'.repeat(12 - result.length()) + result;
        return ID.valueOf(fakeId);
    }

	static testMethod void testMyController()
	{
		PageReference pageRef = Page.Pricing_Quote_Edit_Engenium;
		Test.setCurrentPage(pageRef);
		IST__SuperTRUMP_Pricing_Quote__c pq = Eng_SuperTRUMPTestUtilities.createPricingQuote();
		ApexPages.StandardController stdController = new ApexPages.StandardController(pq);
		Eng_SuperTRUMPPQEditController controller = new Eng_SuperTRUMPPQEditController(stdController);
		
		System.assertEquals(controller.sfData, controller.stPQEditController.sfData);
		System.assertEquals(controller.isSF1, controller.stPQEditController.isSF1);
		System.assertEquals(controller.sfDataInfo, controller.stPQEditController.sfDataInfo);
		System.assertEquals(controller.sfDynamic, controller.stPQEditController.sfDynamic);
		System.assertEquals(controller.sfCustomHeaders, controller.stPQEditController.sfCustomHeaders);
		System.assertEquals(controller.fieldSecurity, controller.stPQEditController.fieldSecurity);
		System.assertEquals(controller.resourceName, controller.stPQEditController.resourceName);
		System.assertEquals(controller.securityToken, controller.stPQEditController.securityToken);
		System.assertEquals(controller.token, controller.stPQEditController.token);
		System.assertEquals(controller.stURL, controller.stPQEditController.stURL);
		System.assertEquals(controller.sfURL, controller.stPQEditController.sfURL);
		System.assertEquals(controller.sfNamespace, controller.stPQEditController.sfNamespace);
		System.assertEquals(controller.helpURL, controller.stPQEditController.helpURL);
		System.assertEquals(controller.objId, controller.stPQEditController.ObjId);
		System.assertEquals(controller.sfQuoteName, controller.stPQEditController.sfQuoteName);
		System.assertEquals(controller.sfUserId, controller.stPQEditController.sfUserId);
		System.assertEquals(controller.databaseTransactionState, controller.stPQEditController.databaseTransactionState);
		System.assertEquals(controller.lastModifiedById, controller.stPQEditController.lastModifiedById);
		System.assertEquals(controller.getLastModifiedByUser(), controller.stPQEditController.getLastModifiedByUser());
		
		controller.actionNavigate = 'back';
		controller.actionURL = 'url';
		controller.actionView = 'view';
		controller.timeZoneOffset = '480';
		controller.transactionState = EncodingUtil.base64Encode(Blob.valueOf('hi'));
		controller.sfRetdata = 'return data';
		
		System.assertEquals('back', controller.actionNavigate);
		System.assertEquals('url', controller.actionURL);
		System.assertEquals('view', controller.actionView);
		System.assertEquals('480', controller.timeZoneOffset);
		System.assertEquals(EncodingUtil.base64Encode(Blob.valueOf('hi')), controller.transactionState);
		System.assertEquals('return data', controller.sfRetdata);
		
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
		
		try
        {
             throw new SuperTRUMPPricingQuoteEditException ('Pricing quote exception');   
        }
        catch(Exception e)
        {
            controller.handlePageException(e);
        }
		pageMessages = ApexPages.getMessages();
		System.assertEquals(1, pageMessages.size());
		System.assertEquals('Pricing quote exception', pageMessages[0].getSummary());
		System.assertEquals(ApexPages.Severity.ERROR, pageMessages[0].getSeverity());
		
		controller.pgref = null;
		ApexPages.addMessage(testMessage1);
		controller.accumulateMessages();
		System.Test.clearApexPageMessages();
		PageReference pref = controller.executeST();
		System.assertEquals(null, pref);
	}
	
	static testmethod void testQuickSave()
	{
        IST__SuperTRUMP_Pricing_Quote__c quote = new IST__SuperTRUMP_Pricing_Quote__c();
        TestSuperTrumpEditController internalController = new TestSuperTrumpEditController();
        ApexPages.StandardController stdController = new ApexPages.StandardController(quote);
        Eng_SuperTRUMPPQEditController controller = new Eng_SuperTRUMPPQEditController(stdController, internalController);
        internalController.SetReturnValue(ControllerMethod.QUICK_SAVE, null);
        
        Test.startTest();
        controller.quicksave();
        Test.stopTest();
        
        System.assertEquals(null, controller.pgRef);
	}
	
	static testmethod void testSave()
	{
        IST__SuperTRUMP_Pricing_Quote__c quote = new IST__SuperTRUMP_Pricing_Quote__c();
        TestSuperTrumpEditController internalController = new TestSuperTrumpEditController();
        ApexPages.StandardController stdController = new ApexPages.StandardController(quote);
        Eng_SuperTRUMPPQEditController controller = new Eng_SuperTRUMPPQEditController(stdController, internalController);
        internalController.SetReturnValue(ControllerMethod.SAVE, stdController.cancel());
        
        Test.startTest();
        controller.save();
        Test.stopTest();
        
        System.assertEquals(stdController.cancel().getURL(), controller.pgRef.getURL());
	}
	
	static testmethod void testSaveAs()
	{
        IST__SuperTRUMP_Pricing_Quote__c quote = new IST__SuperTRUMP_Pricing_Quote__c();
        TestSuperTrumpEditController internalController = new TestSuperTrumpEditController();
        ApexPages.StandardController stdController = new ApexPages.StandardController(quote);
        Eng_SuperTRUMPPQEditController controller = new Eng_SuperTRUMPPQEditController(stdController, internalController);
        quote.Id = getFakeId(sObjectType.IST__SuperTRUMP_Pricing_Quote__c);
        String response = quote.Id + '~' + DateTime.now() + '~' + UserInfo.getUserId();
        internalController.SetReturnValue(ControllerMethod.SAVE_AS, response);
        
        Test.startTest();
        controller.saveAs();
        Test.stopTest();
        
        System.assertEquals(0, ApexPages.getMessages().size());
        System.assertNotEquals(null, controller.pgref);
	}
	
    static testMethod void testSaveAs_ErrorMessage()
    {
        IST__SuperTRUMP_Pricing_Quote__c quote = new IST__SuperTRUMP_Pricing_Quote__c();
        TestSuperTrumpEditController internalController = new TestSuperTrumpEditController();
        ApexPages.StandardController stdController = new ApexPages.StandardController(quote);
        Eng_SuperTRUMPPQEditController controller = new Eng_SuperTRUMPPQEditController(stdController, internalController);
        String errmsg = 'You have FAILED!';
        internalController.SetReturnValue(ControllerMethod.SAVE_AS, errmsg);
        
        Test.startTest();
        controller.saveAs();
        Test.stopTest();
        
        System.assertEquals(1, ApexPages.getMessages().size());
    }
    
    static testMethod void testCancel()
    {
        IST__SuperTRUMP_Pricing_Quote__c quote = new IST__SuperTRUMP_Pricing_Quote__c();
        TestSuperTrumpEditController internalController = new TestSuperTrumpEditController();
        ApexPages.StandardController stdController = new ApexPages.StandardController(quote);
        Eng_SuperTRUMPPQEditController controller = new Eng_SuperTRUMPPQEditController(stdController, internalController);
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
        
        IST.SuperTRUMPPricingQuoteEditController editController = new IST.SuperTRUMPPricingQuoteEditController(stdContr);
        Eng_SuperTRUMPPQEditController.SuperTrumpEditControllerImpl containerContr = new Eng_SuperTRUMPPQEditController.SuperTrumpEditControllerImpl(editController);
        
        System.assertEquals(containerContr.getTimezoneOffset(), editController.timeZoneOffset);
        System.assertEquals(containerContr.getTransactionState(), editController.transactionState);
        System.assertEquals(containerContr.getSalesforceRetData(), editController.sfRetData);
        System.assertEquals(containerContr.getQuoteId(), editController.objId);
        
        // ignore any errors - just calling for code coverage.  The actual saves is tested elsewhere
        try{
            containerContr.quicksave();
        }
        catch(Exception e){} // ignore - just calling for code coverage.
        try{
            containerContr.save();
        }
        catch(Exception e){} // ignore - just calling for code coverage.
        try{
            containerContr.saveAs();
        }
        catch(Exception e){} // ignore - just calling for code coverage.
        try{
        	containerContr.cancel();
        }
        catch(Exception e){} // ignore - just calling for code coverage.
    }
    
    private class SuperTRUMPPricingQuoteEditException extends Exception {}

    private class TestSuperTrumpEditController implements Eng_SuperTRUMPPQEditController.SuperTrumpEditController
    {
        public String timezoneOffset;
        public String transactionState;
        public String salesforceRetData;
        public String quoteId;
        public String getTimezoneOffset(){ return timezoneOffset; }
        public String getTransactionState(){ return transactionState; }
        public String getSalesforceRetData(){ return salesforceRetData; }
        public String getQuoteId(){ return quoteId; }
    	
        Map<ControllerMethod, Object> returnValues = new Map<ControllerMethod, Object>();

        public PageReference quicksave(){
            ControllerMethod method = ControllerMethod.QUICK_SAVE;
            return (PageReference) getReturnValue(method);
        }
        public PageReference save(){
            ControllerMethod method = ControllerMethod.SAVE;
            return (PageReference) getReturnValue(method);
        }
        public String saveAs(){
            ControllerMethod method = ControllerMethod.SAVE_AS;
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
            QUICK_SAVE, SAVE, SAVE_AS, CANCEL
    }
}