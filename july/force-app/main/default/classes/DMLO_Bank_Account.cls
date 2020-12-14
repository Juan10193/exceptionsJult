/**
 * @File Name          : DMLO_Bank_Account.cls
 * @Description        : 
 * @Author             : eduardo.villegas@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : eduardo.villegas@engeniumcapital.com
 * @Last Modified On   : 11/12/2019 10:00:15
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    11/12/2019   eduardo.villegas@engeniumcapital.com     Initial Version
**/
public with sharing class DMLO_Bank_Account {
    public DMLO_Bank_Account() {

    }
    public static void deleteBankAccount(list<Bank_Account__c> listBankAccount){
        System.debug(LoggingLevel.INFO,'Inicia DMLO_Bank_Account.deleteBankAccount ');
        if(Schema.sObjectType.Bank_Account__c.isDeletable()){
            list<Database.DeleteResult> resultOperation = Database.delete(listBankAccount, true);
            for(Database.DeleteResult result : resultOperation){
                if (result.isSuccess()) {
                    // Operation was successful, so get the ID of the record that was processed
                    System.debug('Successfully deleted BankAccount');
                }
                else {
                    // Operation failed, so get all errors                
                    for(Database.Error e : result.getErrors()) {
                        System.debug(LoggingLevel.ERROR,'e.getStatusCode() ' + e.getStatusCode());
                        System.debug(LoggingLevel.ERROR,'e.getFields() ' + e.getFields());
                        System.debug(LoggingLevel.ERROR,'e.getMessage() ' + e.getMessage());
                    }
                }
            }
        } else{
            System.debug('No tiene acceso a eliminar supplier');
        }

    }

}