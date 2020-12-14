@Istest
public class Data_Factory_Progress_Payment_Test {
    public static Progress_Payment__c createProgressPayment(string takedownId, Id opportunityId){
        Progress_Payment__c progress = new Progress_Payment__c();
   		progress.CurrencyIsoCode ='MXN';
        progress.PPE_ls_DayOfTheMonthOfGenerationOfFee__c ='0';
        progress.PPE_rb_User_ISC__c = system.UserInfo.getUserId();
        progress.PPE_txid_Original_Takedown_CP__c = takedownId;
        progress.PPF_ck_Stop_Charge_Fee__c =false;
        progress.PPF_dt_Commencement__c = Date.today().addYears(-1);
        progress.PPF_rb_Opportunity__c =opportunityId;
        progress.PPF_rb_Original_Takedown_ProgressPayment__c =takedownId;
        progress.PPF_rb_Takedown__c =takedownId;
        insert progress;
        return progress;
        
    }
}