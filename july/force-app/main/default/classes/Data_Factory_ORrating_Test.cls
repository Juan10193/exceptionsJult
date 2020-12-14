@Istest
public class Data_Factory_ORrating_Test {
    public static TBO005_OR_rating__c createNewOrating(){
        TBO005_OR_rating__c orating = new TBO005_OR_rating__c();
        orating.Name ='OR12';
        insert orating;
        return orating;
    }
}