@isTest
    public class Data_Access_WOS_Opportunity_Test {
    @isTest static void Data_Access_Test() {
        Opportunity opp = Data_Factory_Opportunity_Test.createNewOpportunityTypeWK();
        System.debug('Oportinidad creada: '+ opp);
        opp =  Data_Access_WOS_Opportunity_cls.getOpportunityAllfields(opp.Id);
    }
}