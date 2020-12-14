public with sharing class DMLO_Asset_cls {
    public static void deletDocument(List<Asset> listAsset){
        System.debug(LoggingLevel.INFO,'Inicia deletDocument');
        if(Schema.sObjectType.Asset.isDeletable()){
            Database.DeleteResult[] drList = Database.delete(listAsset, false);
            // Iterate through each returned result
            for(Database.DeleteResult dr : drList) {
                if (dr.isSuccess()) {
                    // Operation was successful, so get the ID of the record that was processed
                    System.debug('Successfully deleted Asset with ID: ' + dr.getId());
                }
                else {
                    // Operation failed, so get all errors                
                    for(Database.Error e : dr.getErrors()) {
                        System.debug(LoggingLevel.ERROR,'e.getStatusCode() ' + e.getStatusCode());
                        System.debug(LoggingLevel.ERROR,'e.getFields() ' + e.getFields());
                        System.debug(LoggingLevel.ERROR,'e.getMessage() ' + e.getMessage());
                    }
                }
            }
        } else{
            System.debug('No tiene acceso a eliminar asset');
        }
    }

}