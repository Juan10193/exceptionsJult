public class AccountUpdateLastDateFundedOP {
    private List<Opportunity> oldListOpportunity;
    private List<Opportunity> newListOpportunity; 
    
    public AccountUpdateLastDateFundedOP(List<Opportunity> oldListOpportunity, List<Opportunity> newListOpportunity){
        this.oldListOpportunity = oldListOpportunity;
        this.newListOpportunity = newListOpportunity;        
    }
    public set<id> getSetAccountIDByOpp(){
        set<id> accountIdSet = new set<id>();
        for (Opportunity opp : this.oldListOpportunity) {
            string recordtypeid = string.valueOf(opp.RecordTypeId);
            string devname = Schema.getGlobalDescribe().get('Opportunity').getDescribe().getRecordTypeInfosById().get(recordtypeid).getDeveloperName();
            if(devname !='OPP_LMM'){
                accountIdSet.add(opp.AccountId);
            }
        }
        return accountIdSet;
    }
    public set<id> getSetAccountIDByOppFunded(){
        set<id> accountIdSet = new set<id>();
        for(Opportunity opp : this.newListOpportunity){
            string recordtypeid = string.valueOf(opp.RecordTypeId);
            string devname = Schema.getGlobalDescribe().get('Opportunity').getDescribe().getRecordTypeInfosById().get(recordtypeid).getDeveloperName();
            if (opp.StageName.equals('Funded') && devname !='OPP_LMM') {
                accountIdSet.add(opp.AccountId);
            }    
        }
        return accountIdSet;
    }
    public void updateCA(set<id> accountIdSet, boolean isDeleteOperation){
        Map<Id, Date> accountLastFundedDateMap = new Map<Id, Date>();
        for(Opportunity opp : Data_Access_Opportunity_cls.getFundedDateByAccountID(accountIdSet)){
            string recordtypeid = string.valueOf(opp.RecordTypeId);
            string devname = Schema.getGlobalDescribe().get('Opportunity').getDescribe().getRecordTypeInfosById().get(recordtypeid).getDeveloperName();
            if(devname !='OPP_LMM'){
                Id accountId = opp.AccountId;
                Date fundedDate = opp.OPP_fh_Funded_Date__c;                
                if ((accountLastFundedDateMap.size() == 0) || (accountLastFundedDateMap.get(accountId) == null)) {
                    if (fundedDate != null) {
                        accountLastFundedDateMap.put(accountId, fundedDate);
                    }
                } 
            }   
        }
        List<Account> accUpdtList = new List<Account>();
        for(Account acc : Data_Access_Account.getLastFundedDateByAccountID(accountIdSet)){
            Date lastFundedDate = accountLastFundedDateMap.get(acc.Id);
            if (lastFundedDate != null) {
                acc.ACC_fh_Last_Date_Funded_Opportunity__c = lastFundedDate;
                accUpdtList.add(acc);
            } else if (isDeleteOperation 
                       && (acc.ACC_fh_Last_Date_Funded_Opportunity__c != null) && (lastFundedDate == null)) {
                           acc.ACC_fh_Last_Date_Funded_Opportunity__c = null;
                           accUpdtList.add(acc);
                       }    
        }
        if (accUpdtList.size() > 0) {
            DMLO_Account.deletDocument(accUpdtList);
        }
    }
    
}