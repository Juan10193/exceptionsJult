@isTest
private class Eng_SuperTRUMPPQInsertControllerTests
{
	static testMethod void testInsertController()
	{
		PageReference pageRef = Page.Pricing_Quote_Insert_Engenium;
		Test.setCurrentPage(pageRef);
		IST__SuperTRUMP_Pricing_Quote__c pq = Eng_SuperTRUMPTestUtilities.createPricingQuote();
		ApexPages.StandardController stdController = new ApexPages.StandardController(pq);
		Eng_SuperTRUMPPQInsertController controller = new Eng_SuperTRUMPPQInsertController(stdController);
		
		System.assertEquals(controller.pq, controller.stPQInsertController.pq);
		
		controller.actionNavigate = 'back';
		controller.actionURL = 'url';
		controller.actionView = 'view';
		controller.timeZoneOffset = '480';
		
		System.assertEquals('back', controller.actionNavigate);
		System.assertEquals('url', controller.actionURL);
		System.assertEquals('view', controller.actionView);
		System.assertEquals('480', controller.timeZoneOffset);
		
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
        PageReference pref = controller.executeST();
				
		ApexPages.addMessage(testMessage1);
		controller.accumulateMessages();
		System.Test.clearApexPageMessages();
		pref = controller.executeST();
		System.assertEquals(null, pref);
	}
    static testMethod void testDeleteController()
	{
		PageReference pageRef = Page.Pricing_Quote_Insert_Engenium;
		Test.setCurrentPage(pageRef);
		IST__SuperTRUMP_Pricing_Quote__c pq = Eng_SuperTRUMPTestUtilities.createPricingQuote();
		ApexPages.StandardController stdController = new ApexPages.StandardController(pq);
		Eng_SuperTRUMPPQInsertController controller = new Eng_SuperTRUMPPQInsertController(stdController);
		
		System.assertEquals(controller.pq, controller.stPQInsertController.pq);
		
		controller.actionNavigate = 'back';
		controller.actionURL = 'url';
		controller.actionView = 'view';
		controller.timeZoneOffset = '480';
		
		System.assertEquals('back', controller.actionNavigate);
		System.assertEquals('url', controller.actionURL);
		System.assertEquals('view', controller.actionView);
		System.assertEquals('480', controller.timeZoneOffset);
		
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
        system.debug('Test ' + controller.msgs.size());
        pq = Eng_SuperTRUMPTestUtilities.createPricingQuote();
        system.debug('Test1 ' + controller.msgs.size());
		System.assertEquals(0, controller.msgs.size());
        PageReference pref = controller.executeST();
				
		ApexPages.addMessage(testMessage1);
		controller.accumulateMessages();
		System.Test.clearApexPageMessages();
		pref = controller.executeST();
		System.assertEquals(null, pref);
        controller.Cancel();
        controller.Save();
	}
	
	static testMethod void testTemplateOptions()
	{
		IST__SuperTRUMP_Pricing_Quote__c pq = Eng_SuperTRUMPTestUtilities.createPricingQuote();
		ApexPages.StandardController stdController = new ApexPages.StandardController(pq);
		Eng_SuperTRUMPPQInsertController controller = new Eng_SuperTRUMPPQInsertController(stdController);
		
		List<SelectOption> listOptions = controller.getTemplateOptions();
		System.assertEquals('- Select One -', listOptions[0].getLabel());
	}
}