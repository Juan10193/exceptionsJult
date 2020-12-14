@Istest
private class Data_Access_EC_QuoteTest {
	@Istest
    static void getQuoteByIdTest(){
        EC_Quote__c a = new EC_Quote__c();
        insert a;
        Data_Acess_EC_Quote.getQuoteById(a.Id);
        Opportunity opp = new Opportunity();
        opp.Amount = 10000;
        opp.Name ='MI OPP';
        opp.RecordTypeId =  Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName().get('OPP_LMM').getRecordTypeId();
        opp.StageName ='Nuevo';
        opp.CloseDate = Date.today();
        insert opp;
        Data_Acess_EC_Quote.getQuotesByOpId(opp.Id);
        try{
             Data_Acess_EC_Quote.getQuoteByIdOp(opp.Id);
        }catch(Exception e){
            system.debug('error');
            system.debug(e);
        }
       
    }
    
    
    	@Istest
    static void getQuoteByIdTest2(){
        EC_Quote__c a = new EC_Quote__c();
        insert a;
        Data_Acess_EC_Quote.getQuotesByOpId2(a.Id);
        Opportunity opp = new Opportunity();
        opp.Amount = 10000;
        opp.Name ='MI OPP';
        opp.RecordTypeId =  Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName().get('OPP_LMM').getRecordTypeId();
        opp.StageName ='Nuevo';
        opp.CloseDate = Date.today();
        insert opp;
        Data_Acess_EC_Quote.getQuotesByOpId2(opp.Id);
        try{
             Data_Acess_EC_Quote.getQuotesByOpId2(opp.Id);
        }catch(Exception e){
            system.debug('error');
            system.debug(e);
        }
       
    }
}