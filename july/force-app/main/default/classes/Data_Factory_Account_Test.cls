@IStest
public class Data_Factory_Account_Test {
    
    public static Account createNewAccount(string name){
        Account acc= new Account();
        //Account Detail
        acc.Name=name;
        acc.ACC_rb_SIC_Code__c=Data_Factory_SICcode_Test.createNewSICcode().Id;
        //Company Size
        acc.ACC_dv_Sales_Annual_Revenue__c=10000.00;        
        //Address Information
        acc.BillingCity='Mexico';
        acc.BillingCountry='México';
        acc.BillingStreet='Piloto';
        acc.BillingPostalCode='68690';
        acc.BillingState='Ciudad de México';
        
        insert acc;
        System.debug('Cuenta creada: '+ acc);
        return acc;
    }

}