public class Takedown_XLSX_Contract_Import_lwc_cls {    
    @AuraEnabled(cacheable=true)
    public static Takedown_Wrapper_Contract_Import_cls.Contract_Import getContractImport(id objectId){  
        Takedown_XLSX_CI_Service_cls xlsxCIService = new Takedown_XLSX_CI_Service_cls();
        system.debug('objectId ' + objectId);
        //system.debug('xlsCIService.makeContractImport(objectId); ' + objectId + xlsxCIService.makeContractImport(objectId));
        return	xlsxCIService.makeContractImport(objectId);        
    }
}