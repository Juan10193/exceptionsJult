/**
 * @File Name          : DMLO_Supplier.cls
 * @Description        : 
 * @Author             : eduardo.villegas@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : eduardo.villegas@engeniumcapital.com
 * @Last Modified On   : 16/12/2019 12:36:14
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    11/12/2019   eduardo.villegas@engeniumcapital.com     Initial Version
**/
public class DMLO_Supplier {
    public static boolean deletSupplier(Supplier__c supplierToDelete){
        boolean success = false;
        System.debug(LoggingLevel.INFO,'Inicia DMLO_Supplier ' + supplierToDelete);
        if(Schema.sObjectType.Supplier__c.isDeletable()){
            //Supplier__c supplierToDelete = new Supplier__c();
            //supplierToDelete.id = recordId;
            Database.DeleteResult resultOperation = Database.delete(supplierToDelete, false);
                if (resultOperation.isSuccess()) {
                    success = true;
                    // Operation was successful, so get the ID of the record that was processed
                    System.debug('Successfully deleted Supplier with ID: ');
                }
                else {
                    // Operation failed, so get all errors                
                    for(Database.Error e : resultOperation.getErrors()) {
                        System.debug(LoggingLevel.ERROR,'e.getStatusCode() ' + e.getStatusCode());
                        System.debug(LoggingLevel.ERROR,'e.getFields() ' + e.getFields());
                        System.debug(LoggingLevel.ERROR,'e.getMessage() ' + e.getMessage());
                    }
                }
        } else{
            System.debug('No tiene acceso a eliminar supplier');
        }
        return success;
    }

}