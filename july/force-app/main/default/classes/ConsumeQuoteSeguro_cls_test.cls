@isTest 
private class ConsumeQuoteSeguro_cls_test {
    static testMethod void testPostCallout() {
        
        PageReference pageRef = new PageReference('https://engeniumcapital--qa.my.salesforce.com/');
        ApexPages.StandardController cont;
        Test.setCurrentPage(pageRef);
		Test.setMock(HttpCalloutMock.class, new ConsumeQuoteSeguroMock());
		ConsumeQuoteSeguro_cls instancia = new ConsumeQuoteSeguro_cls();
		ConsumeQuoteSeguro_cls.credentialValidation();
		ConsumeQuoteSeguro_cls.createdQuote('');
    }
}