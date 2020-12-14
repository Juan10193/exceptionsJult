/**
 * @File Name          : takedownTableDocumentsWrapper_cls.cls
 * @Description        : 
 * @Author             : eduardo.amiens@outlook.com
 * @Group              : 
 * @Last Modified By   : jhernandez@anivia.mx
 * @Last Modified On   : 14/8/2019 11:06:41
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      		      Modification
 *==============================================================================
 * 1.0    30/7/2019 17:53:37   eduardo.amiens@outlook.com     Initial Version
**/
public with sharing class takedownTableDocumentsWrapper_cls {
    public class TableElement {
        @AuraEnabled
        public Id     id                                {get;set;}
        @AuraEnabled
        public String name                          {get;set;}
        @AuraEnabled
        public String TKD_fm_validation             {get;set;}
        @AuraEnabled
        public string TKD_ls_Status                 {get;set;}
        @AuraEnabled
        public string TKD_pd_Takedown_CP            {get;set;}
        @AuraEnabled
        public string TKD_txt_Content_Version_ID    {get;set;}
        @AuraEnabled
        public String TKD_txt_Document_ID           {get;set;}
        @AuraEnabled
        public String TKD_txt_Extension             {get;set;}
        @AuraEnabled
        public String TKD_ls_asset_type             {get;set;}
        @AuraEnabled
        public String AccountId                     {get;set;}
        @AuraEnabled
        public String TKD_pk_factura 				{get;set;}
        @AuraEnabled
        public String TKD_txt_currencyCode			{get;set;}
        @AuraEnabled
        public Decimal TKD_num_totalCost			{get;set;}
        
        
        public String Base64                        {get;set;} 

        
    }   
}