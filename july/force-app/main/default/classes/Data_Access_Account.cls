public class Data_Access_Account {
    public static list<Account> getLastFundedDateByAccountID(set<id> accountIdSet){
        list<Account> listAccount = new list<Account>();
        if(Schema.sObjectType.Account.isAccessible()){
            listAccount = [SELECT Id, ACC_fh_Last_Date_Funded_Opportunity__c FROM Account WHERE Id IN :accountIdSet ORDER BY Id];
        }
        return listAccount;
    }

}