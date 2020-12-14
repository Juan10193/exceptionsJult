/**
 * @File Name          : DMLO_Contact.cls
 * @Description        : 
 * @Author             : eduardo.villegas@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : eduardo.villegas@engeniumcapital.com
 * @Last Modified On   : 11/12/2019 10:00:08
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    11/12/2019   eduardo.villegas@engeniumcapital.com     Initial Version
**/
public with sharing class DMLO_Contact {
    public DMLO_Contact() {

    }
    public static void deleteContact(list<contact> listcontact){
        System.debug(LoggingLevel.INFO,'Inicia DMLO_Contact.deleteContact ');
        if(Schema.sObjectType.contact.isDeletable()){
            list<Database.DeleteResult> resultOperation = Database.delete(listcontact, true);
            for(Database.DeleteResult result : resultOperation){
                if (result.isSuccess()) {
                    // Operation was successful, so get the ID of the record that was processed
                    System.debug('Successfully deleted Contact');
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