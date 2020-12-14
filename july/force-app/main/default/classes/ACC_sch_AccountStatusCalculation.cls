global without sharing class ACC_sch_AccountStatusCalculation implements Schedulable {
	public 	Map<String, String>	statusRuleResultMap	{get; set;}
    
    global ACC_sch_AccountStatusCalculation(Map<String, String> stsResultMap) {
        this.statusRuleResultMap = stsResultMap;
    }
    
    public void execute(SchedulableContext sc) {
        Database.executeBatch(new ACC_bch_AccountStatusCalculation(statusRuleResultMap), 200);
    }
}