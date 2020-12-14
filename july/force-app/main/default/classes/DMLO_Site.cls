/**
 * @File Name          : DMLO_Site.cls
 * @Description        : 
 * @Author             : eduardo.villegas@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : eduardo.villegas@engeniumcapital.com
 * @Last Modified On   : 16/12/2019 12:30:40
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    16/12/2019   eduardo.villegas@engeniumcapital.com     Initial Version
**/
public with sharing class DMLO_Site {
    public static void deleteSite(TKD_Site__c Site){
        System.debug(LoggingLevel.INFO,'Inicia DMLO_Site.deleteSites ');
        if(Schema.sObjectType.TKD_Site__c.isDeletable()){
            Database.DeleteResult resultOperation = Database.delete(Site, true);
                if (resultOperation.isSuccess()) {
                    // Operation was successful, so get the ID of the record that was processed
                    System.debug('Successfully deleted Site');
                }
                else {
                    // Operation failed, so get all errors                
                    for(Database.Error e : resultOperation.getErrors()) {
                        System.debug('An error has been ocurred while trying to delete a record ');
                        System.debug(LoggingLevel.ERROR,'e.getStatusCode() ' + e.getStatusCode());
                        System.debug(LoggingLevel.ERROR,'e.getFields() ' + e.getFields());
                        System.debug(LoggingLevel.ERROR,'e.getMessage() ' + e.getMessage());
                    }
                }
        } else{
            System.debug('No tiene acceso a eliminar supplier');
        }

    }
}