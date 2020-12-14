/**
 * @File Name          : DMLO_Exposure_cls.cls
 * @Description        : 
 * @Author             : juandedios.hernandez@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : juandedios.hernandez@engeniumcapital.com
 * @Last Modified On   : 5/9/2019 21:48:03
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    4/9/2019   juandedios.hernandez@engeniumcapital.com     Initial Version
**/
public with sharing class DMLO_Exposure_cls {
    
    public static Wk_wrapper_resultsOperationsDt.SaveRecords upsertContracts(List<WK_Exporsure__c> contracts){
        Wk_wrapper_resultsOperationsDt.SaveRecords resultado = new  Wk_wrapper_resultsOperationsDt.SaveRecords();
        
        Schema.SObjectField exporsureExternalId = WK_Exporsure__c.Fields.Contract_Number__c;
        List<Database.UpsertResult> resulOperation = Database.upsert(contracts, exporsureExternalId, false );
        for(Database.UpsertResult result : resulOperation){
            if (result.isSuccess()) {
                // Operation was successful, so get the ID of the record that was processed
                System.debug('Success inserted Exporsure. Exporsure ID: ' + result.getId());
                Wk_wrapper_resultsOperationsDt.Results res = new Wk_wrapper_resultsOperationsDt.Results();
                res.resultId = string.valueOf(result.getId());
                system.debug(res);
                resultado.results.add(res);
            }else {
                // Operation failed, so get all errors                
                for(Database.Error err : result.getErrors()) {
                    System.debug('The following error has occurred.');                    
                    System.debug(err.getStatusCode() + ': ' + err.getMessage());
                    System.debug('Exporsure fields that affected this error: ' + err.getFields());
                    Wk_wrapper_resultsOperationsDt.Errores errors =new Wk_wrapper_resultsOperationsDt.Errores();
                    errors.code = string.valueOf(err.getStatusCode());
                    errors.error =string.valueOf(err.getMessage());
                    resultado.errors.add(errors);
                }
            }    
        }

        return resultado;
    }

    public static void deleteExposure(WK_Exporsure__c exp){
        Delete exp;
    }
}