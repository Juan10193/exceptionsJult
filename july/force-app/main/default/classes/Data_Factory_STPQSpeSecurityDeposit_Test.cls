@Istest
public class Data_Factory_STPQSpeSecurityDeposit_Test {
    public static ST_PQ_Specified_Security_Deposit__c createSTPQSpecifiedSecurityDeposit(Id pricingPQId){
        ST_PQ_Specified_Security_Deposit__c securityDeposit = new ST_PQ_Specified_Security_Deposit__c();
        securityDeposit.Amount__c =1200;
        securityDeposit.Received__c = Date.today();
        securityDeposit.Pricing_Quote__c =pricingPQId;
        securityDeposit.Returned__c =Date.today();
        securityDeposit.stExternalID__c = '123121';
        insert securityDeposit;
        return securityDeposit;
    }
}