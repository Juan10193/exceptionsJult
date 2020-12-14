/**
 * @File Name          : TKD_supplierInTD_NewSupplierWrapper.cls
 * @Description        : 
 * @Author             : eduardo.amiens@outlook.com
 * @Group              : 
 * @Last Modified By   : eduardo.amiens@outlook.com
 * @Last Modified On   : 08-04-2020
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    18/12/2019   eduardo.villegas@engeniumcapital.com     Initial Version
**/
public class TKD_supplierInTD_NewSupplierWrapper {
    public class Supplier{
        @AuraEnabled
        public string Id                                {get;set;}
        @AuraEnabled
        public string Name                              {get;set;}
        @AuraEnabled
        public string TKD_tx_Vendor_name_alternative    {get;set;}
        @AuraEnabled
        public string TKD_tx_Vat_Registration_Num       {get;set;}
        @AuraEnabled
        public string TKD_ls_Tipo_de_tercero            {get;set;}
        @AuraEnabled
        public string Nacionalidad                      {get;set;}
        @AuraEnabled
        public string TKD_ls_Pais_de_residencia         {get;set;}
        @AuraEnabled
        public list<Site> sites                         {get;set;}
    }
    public class Site{
        @AuraEnabled
        public string Id                                {get;set;}
        @AuraEnabled
        public boolean Pay_Site_Flag                    {get;set;} 
        @AuraEnabled
        public boolean primaryPaySiteFlag               {get;set;} 
        @AuraEnabled
        public string Tkd_at_Address_line_1             {get;set;}
        @AuraEnabled
        public string Tkd_at_Address_line_2             {get;set;}
        @AuraEnabled
        public string Tkd_tx_City                       {get;set;}
        @AuraEnabled
        public string TKD_tx_Country                    {get;set;}
        @AuraEnabled
        public string Name                              {get;set;}
        @AuraEnabled
        public string Tkd_ls_Org_Name                   {get;set;}
        @AuraEnabled
        public string tkd_tf_phone                      {get;set;}
        @AuraEnabled
        public string TKD_ls_State                      {get;set;}
        @AuraEnabled
        public string Tkd_tx_Zip                        {get;set;}
        @AuraEnabled
        public string TKD_Vat_code                      {get;set;}
        @AuraEnabled
        public string currencyIso                      {get;set;}        
        @AuraEnabled
        public list<BankAccount> bankAccount            {get;set;}
        @AuraEnabled
        public list<SupplierContact> supplierContact    {get;set;}
    }
    public class BankAccount {
        @AuraEnabled
        public string Id                                        {get;set;}
        @AuraEnabled
        public string Name                                      {get;set;}
        @AuraEnabled
        public string Bank_Account_Name                         {get;set;}
        @AuraEnabled
        public string Bank_Name                                 {get;set;}
        @AuraEnabled
        public string Bank_Account_Currency                     {get;set;}
        
        @AuraEnabled 
        public string Contexto                                  {get;set;}
        @AuraEnabled 
        public string Tipo_BIC                                  {get;set;}
        @AuraEnabled 
        public string Codigo_BIC                                {get;set;}
        @AuraEnabled 
        public string Nombre_Banco_intermediadio                {get;set;}
        @AuraEnabled 
        public string Tipo                                      {get;set;}
        @AuraEnabled
        public string Codigo                                    {get;set;}
        @AuraEnabled
        public string Pago_a_Cuenta_Concentradora               {get;set;}
        @AuraEnabled
        public string Pago_a_Cta_Concentradora_RN               {get;set;}
    }
    public class SupplierContact {
        @AuraEnabled
        public string Id            {get;set;}
        @AuraEnabled
        public string firstName     {get;set;}
        @AuraEnabled
        public string lastName      {get;set;}
        @AuraEnabled
        public string Phone         {get;set;}
        @AuraEnabled
        public string emailAddress  {get;set;}
    }

}