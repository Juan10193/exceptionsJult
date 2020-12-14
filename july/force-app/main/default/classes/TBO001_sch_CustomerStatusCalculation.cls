global without sharing class TBO001_sch_CustomerStatusCalculation implements Schedulable {
	Set<Id> 	accountIdSet	{get; set;}
    
    public TBO001_sch_CustomerStatusCalculation(Set<Id> accIdSet) {
    	this.accountIdSet = accIdSet;
    }
    
    public void execute(SchedulableContext sc) {
        Database.executeBatch(new TBO001_bch_CustomerStatusCalculation(accountIdSet), 200);
    }
}