/**
 * @File Name          : wk_TableExporsurelwc_controller_cls.cls
 * @Description        : 
 * @Author             : juandedios.hernandez@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : juandedios.hernandez@engeniumcapital.com
 * @Last Modified On   : 12/9/2019 13:56:11
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    3/9/2019   juandedios.hernandez@engeniumcapital.com     Initial Version
**/
public with sharing class Wk_TableExporsurelwc_controller_cls {

    @AuraEnabled(cacheable=true)
    public static string getEntitiesECGroup(string partyId){
        return WK_Exporsure_callout.getEntsEGroup(partyId);
    }

    @AuraEnabled(cacheable = true)
    public static list<ES2_Obj_EntityMasterInCreditApproval__c> getEintitesInca(string caId){
        List<ES2_Obj_EntityMasterInCreditApproval__c> entidades = Data_Access_EntityMastInCApproval_cls.getEntitiesInCa(caId);
        return entidades;
    }

    @AuraEnabled(cacheable = true)
    public static string getExporsure(string economicGId){
        return WK_Exporsure_callout.getExporsure(economicGId);
    }

    @AuraEnabled(cacheable = true)
    public static list<WK_Exporsure__c> getLinkedEntities(string economicId){
        Decimal ecgruipId;
        if(String.isNotBlank(economicId)){
            ecgruipId = Decimal.valueOf(economicId);
        }
        return Data_Access_Exporsure_cls.getLinkedExporsures(ecgruipId);
    }

    @AuraEnabled
    public  static Wk_wrapper_resultsOperationsDt.SaveRecords saveContracts(list<WK_Exporsure_wrapper.Contract> contracts){
       List<WK_Exporsure__c> exposures = new List<WK_Exporsure__c>();
       
       for (WK_Exporsure_wrapper.Contract cont : contracts) {
            WK_Exporsure__c expo = new WK_Exporsure__c();
            //expo.WK_Entity_Master_in_Credit_Approval__c =cont.entityMasterCreditApproval;
            expo.Contract_Number__c = cont.contractNumber;
            expo.WK_contractNumber__c = cont.contractNumber;
            expo.WK_contractOec__c = cont.contractOec;
            expo.WK_currency__c = cont.curency;
            expo.WK_days_Due_Ar__c = cont.daysDueAr;
            expo.WK_days_Due_Dlq__c = cont.daysDueDlq;
            expo.WK_economicGroupId__c = cont.economicGroupId;
            expo.WK_economicGroupName__c = cont.economicGroupName;
            expo.WK_exposure__c = string.valueOf(cont.exposure);
            expo.WK_nbv__c = cont.nbv;
            expo.WK_open_Items_Ar__c = cont.openItemsAr;
            expo.WK_open_Items_Dlq__c = cont.openItemsDlq;
            expo.WK_oracleAccountNumber__c = cont.oracleAccountNumber;
            expo.WK_nu_partyId__c = cont.partyId;
            expo.WK_party_name__c = cont.partyName;
            expo.Name = cont.productName;
            expo.vertical__c = cont.vertical;
            exposures.add(expo);
       }

      Wk_wrapper_resultsOperationsDt.SaveRecords resultado= DMLO_Exposure_cls.upsertContracts(exposures);
      return resultado;
    }

    @AuraEnabled
    public static void deleteOnly(string contractNumber){
      WK_Exporsure__c exp = Data_Access_Exporsure_cls.getExposure(contractNumber);
      DMLO_Exposure_cls.deleteExposure(exp);
    }
}