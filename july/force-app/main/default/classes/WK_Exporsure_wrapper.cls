/**
 * @File Name          : WK_Exporsure_wrapper.cls
 * @Description        : 
 * @Author             : juandedios.hernandez@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : juandedios.hernandez@engeniumcapital.com
 * @Last Modified On   : 4/9/2019 20:55:00
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    4/9/2019   juandedios.hernandez@engeniumcapital.com     Initial Version
**/
public class WK_Exporsure_wrapper {
    public class inicial{
        public contrato contracts					{get; set;}
        public Status status       					{get; set;}
    }
   
    public class Contract {
        @AuraEnabled public Integer partyId     					{get; set;}
        @AuraEnabled public String partyName						{get; set;}
        @AuraEnabled public Integer economicGroupId				{get; set;}
        @AuraEnabled public String economicGroupName				{get; set;}
        @AuraEnabled public String oracleAccountNumber			{get; set;}
        @AuraEnabled public String contractNumber				{get; set;}
        @AuraEnabled public String curency						{get; set;}
        @AuraEnabled public String productName					{get; set;}
        @AuraEnabled public double contractOec					{get; set;}
        @AuraEnabled public double exposure						{get; set;}
        @AuraEnabled public double openItemsAr					{get; set;}
        @AuraEnabled public Integer daysDueAr					{get; set;}
        @AuraEnabled public Integer openItemsDlq					{get; set;}
        @AuraEnabled public Integer daysDueDlq					{get; set;}
        @AuraEnabled public String vertical						{get; set;}
        @AuraEnabled public Integer nbv							{get; set;}
        @auraEnabled public string entityMasterCreditApproval {get;Set;}
    }
    public class contrato{
        public List<Contract> contract				{get; set;}
    }
    public class Status {
        public String code							{get; set;}
        public String message						{get; set;}
        public String detail						{get; set;}
    }
}