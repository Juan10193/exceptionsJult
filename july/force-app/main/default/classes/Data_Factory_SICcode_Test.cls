@Istest
public class Data_Factory_SICcode_Test {
     public static TBO002_SIC_code__c  createNewSICcode(){
         
        TBO002_SIC_code__c SICcode = new TBO002_SIC_code__c();
         
        SICcode.Name='999';
        SICcode.OwnerId=UserInfo.getUserId();
        insert SICcode;         
        System.debug('SIC code creado : '+ SICcode);         
        return SICcode;
    }

}