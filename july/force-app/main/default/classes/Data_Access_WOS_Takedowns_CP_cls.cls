/**
 * @File Name          : Data_Access_WOS_Takedowns_CP_cls.cls
 * @Description        : 
 * @Author             : eduardo.villegas@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : eduardo.villegas@engeniumcapital.com
 * @Last Modified On   : 10/10/2019 10:51:56
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    10/10/2019   eduardo.villegas@engeniumcapital.com     Initial Version
**/
public without sharing class Data_Access_WOS_Takedowns_CP_cls {
    
    /**
    * @description 
    * @author eduardo.villegas@engeniumcapital.com | 10/10/2019 
    * @param id takedownId 
    * @return Takedowns_Contingency_plan__c 
    **/
    public static Takedowns_Contingency_plan__c getAllFields(id takedownId){
        Takedowns_Contingency_plan__c takedown_cp = new Takedowns_Contingency_plan__c();
            takedown_cp = [SELECT Id, OwnerId, IsDeleted, Name, CurrencyIsoCode, CreatedDate, CreatedById, 
                                                          LastModifiedDate, LastModifiedById, SystemModstamp, LastActivityDate, LastViewedDate, 
                                                          LastReferencedDate, CPL_ExchangeRateCreditOfLine__c, CPL_ck_Delay_Funding__c, 
                                                          CPL_ck_Waivers_Asset_Management__c, Customer_Name__c, Customer_Name__r.name, CPL_ck_Waivers_Importaciones__c, 
                                                          CPL_da_DateSentDocumentsToClient__c, CPL_da_Funding_Date__c, CPL_ls_Operation_Unit__c, 
                                                          CPL_lsm_Documents_for_Tollgate_1__c, CPL_lsm_Documents_for_Tollgate_2__c, 
                                                          CPL_nu_Movement_in_credit_line__c, CPL_nu_NumApprovers__c, CPL_rb_Entity_Name_CP__c, 
                                                          CPL_rb_Opp__c, CPL_rb_approver_control_desk__c, CPL_rb_import_approver__c, 
                                                          CPL_fm_Currency_of_the_line_of_credit__c, CPL_ls_Product__c, CPL_ls_Stage__c, 
                                                          CPL_ls_Status__c, CPL_nu_TD_Echange_Rate__c, TDAmount__c, CPL_tx_OLFM_Contract_Number__c, 
                                                          CPL_dt_booking_date__c, CPL_fm_Volume_USD_Amount__c, CPL_ck_Start_of_leasing__c, 
                                                          CPL_ls_Deal_Category__c, CPI_Funding_Date_Month__c, CLI_txt_Id_TD_Forecast__c, 
                                                          CPI_ck_Questionary_Received__c, CPI_ck_Questionary_sent__c, Takedowns_forecast__c, 
                                                          CLI_dv_Amount__c, CLI_lsInvoice_Currency__c, CLI_nu_PP_Number__c, CLI_rb_Inside_Sales_Owner__c, 
                                                          CLI_txt_Inside_Sales_Comments__c, CPL_ls_Start_of_leasing__c, teststatus__c, CLI_rb_Inside_Sales_Owner__r.name,
                                                          Contract_Annex_Number__c, Financing_Needs__c, Amount_Supplier_1__c, AnnexToGo_Version_Type__c, 
                                                          Invoice_Currency_Supplier_1__c, Takedown_Funded_Date__c, Aging_Tollgate_1_Funded__c, 
                                                          Annex_Pricing_SuperTrump__c, TKD_rb_Pricin_CA__c, TKD_rb_Pricin_CA__r.ES3_fm_Pricing_Super_Trump__c,
                           								  Supplier_Name_1__c, Foreign_Suplier_1__c, Supplier_Name_2__c, 
                                                          Supplier_Name_3__c, Foreign_Supplier_2__c, Foreign_Supplier_3__c, Return_Conditions__c, 
                                                          Foreing_Supplier1__c, Foreign_Supplier2__c, Foreign_Supplier3__c, Supplier_1_Bank_Account__c, 
                                                          Amount_Supplier_2__c, Invoice_Currency_Supplier_2__c, Supplier_2_Bank_Account__c, 
                                                          Amount_Supplier_3__c, Invoice_Currency_Supplier_3__c, Supplier_3_Bank_Account__c, 
                                                          Customer_Bank_Account__c, Credit_Approval_Files__c, Tollgate_1_Date__c, 
                                                          Control_Desk_Analyst__c, Post_Fundings_Tasks__c, annex__c, Customer_Bank_Account2__c, 
                                                          Other__c, other_amount__c, Virtual_Account__c, CLABE__c, Acoount_USD__c, Term__c, 
                                                          Line_of_Business__c, InsuranceToGo__c, Contract_Unit__c, InsuranceToGo_not_Closed__c, 
                                                          TKD_ls_asset_type__c, 
                                                          Takedown_Costo_total_de_unidades__c,
                           								  TKD_rb_Pricin_CA__r.name, TKD_rb_Pricin_CA__r.ES3_rb_Pricing__c,	TKD_rb_Pricin_CA__r.ES3_rb_Pricing__r.name
                                                          FROM Takedowns_Contingency_plan__c
                                                        where id = :takedownId ];         
        return takedown_cp;
    }

}