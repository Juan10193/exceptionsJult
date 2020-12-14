@RestResource (urlMapping='/TakedownDETAILS/*')
global class Takedown_seguro_details {
    
    @HttpGet
    global static void infoTakedown() {
        RestRequest restReq = RestContext.request;
        RestResponse restRes = RestContext.response;
        String idTakedown = restReq.params.get('idTakedown');
        
        List<Wrapper_seguro_details> detailTakedownCP = new List<Wrapper_seguro_details>();
        List<TakedownContent.Identifiers> identifiers = new List<TakedownContent.Identifiers>();
        List<TakedownContentOld.Identifiers> identifiersOLD = new List<TakedownContentOld.Identifiers>();
        WrapperTakedownSeguro.seguroInformacion cotizacionSeguro = new WrapperTakedownSeguro.seguroInformacion(); 
        
        Asset[] allAsset = new Asset[]{};
		Cotizacion_seguro__c [] allCotizacionSeguro = new Cotizacion_seguro__c[]{};
            
            Takedowns_Contingency_plan__c takedownCP = [SELECT Id,Owner.Name,CreatedDate, Name, CurrencyIsoCode,
            RecordTypeId,createdBy.Name,LastModifiedDate, LastModifiedBy.Name,CPL_ExchangeRateCreditOfLine__c,
            CPL_ck_Delay_Funding__c,CPL_ck_Waivers_Asset_Management__c,CPL_ck_Waivers_Importaciones__c,
            CPL_da_DateSentDocumentsToClient__c,CPL_lsm_Documents_for_Tollgate_1__c,
            CPL_lsm_Documents_for_Tollgate_2__c,CPL_nu_Movement_in_credit_line__c,CPL_nu_NumApprovers__c,
            CPL_rb_Entity_Name_CP__r.Name, CPL_rb_Opp__r.Name, CPL_rb_approver_control_desk__c,CPL_rb_import_approver__c,
            CPL_ls_Stage__c, CPL_ls_Status__c,
            CPL_nu_TD_Echange_Rate__c,TDAmount__c,CPL_dt_booking_date__c,
            CPL_fm_Volume_USD_Amount__c, CPL_ck_Start_of_leasing__c,CPL_ls_Deal_Category__c, CPI_Funding_Date_Month__c,
            CLI_txt_Id_TD_Forecast__c, CPI_ck_Questionary_Received__c,CPI_ck_Questionary_sent__c,Takedowns_forecast__r.Name,
            CLI_dv_Amount__c,CLI_lsInvoice_Currency__c,CLI_nu_PP_Number__c , CLI_rb_Inside_Sales_Owner__r.Name,
            CLI_txt_Inside_Sales_Comments__c, CPL_ls_Start_of_leasing__c, teststatus__c, Financing_Needs__c, Amount_Supplier_1__c,
            AnnexToGo_Version_Type__c, Invoice_Currency_Supplier_1__c, Takedown_Funded_Date__c, Aging_Tollgate_1_Funded__c,
            Annex_Pricing_SuperTrump__r.Name, Supplier_Name_1__c, Foreign_Suplier_1__c, Supplier_Name_2__c, Supplier_Name_3__c,
            Foreign_Supplier_2__c, Foreign_Supplier_3__c, Return_Conditions__c, Foreing_Supplier1__c, Foreign_Supplier2__c,
            Foreign_Supplier3__c, Supplier_1_Bank_Account__c, Amount_Supplier_2__c, Invoice_Currency_Supplier_2__c, Supplier_2_Bank_Account__c,
            Amount_Supplier_3__c, Invoice_Currency_Supplier_3__c, Supplier_3_Bank_Account__c, Customer_Bank_Account__c, Concepts_to_Net__c, 
            Credit_Approval_Files__c, Tollgate_1_Date__c, Control_Desk_Analyst__r.Name, Post_Fundings_Tasks__c, annex__c, Customer_Bank_Account2__r.Name, 
            Other__c, other_amount__c, Virtual_Account__c, CLABE__c, Acoount_USD__c, Line_of_Business__c, InsuranceToGo__c, Contract_Unit__c, 
            InsuranceToGo_not_Closed__c, True_Lease_Contract__c, Customer_Name__c, TKD_ls_asset_type__c, Takedown_Costo_total_de_unidades__c, 
            Account_Id__c, TD_fm_Party_Id__c, TKD_Approval_Process_Step__c, TKD_In_Document_Management__c, TKD_Legal_Assestment__c, 
            TKD_Pre_Tollgate_1_Docs__c, TKD_Pre_Tollgate_2_Val__c, TKD_Suppilers_Documents__c, TKD_Tollgate_1_Val__c, TKD_Tollgate_2_Val__c, 
            TKD_at_Cancelation_comments__c, TKD_ca_Approve_Asset_Breakdown__c, TKD_ca_Block_AB__c, TKD_ca_Block_invoices__c, TKD_ca_Booked__c, 
            TKD_ca_Notify_to_Prebook__c, TKD_ca_Pre_Book_Registry__c, TKD_fm_Opportunity_expiration_date__c, TKD_fm_Ora_AccountName__c, 
            TKD_fm_Remaining_days_to_expiration_date__c, TKD_fm_Top_Parent_Account__c, TKD_fm_Top_Parent_Name__c, TKD_ls_Invoices_approval_status__c, 
            TKD_rb_Pricin_CA__c, TKD_tl_Invoices_approval_comments__c, TKD_tollgate2_Review__c, TKD_tx_enqueuejob_id__c, 
            TKD_Invoices_without_suppliers_Loan__c, TKD_Invoices_without_suppliers_No_Loan__c, Audit_Control_Desk_Full_Name__c, 
            Control_Desk_Analyst_Full_Name_TG1__c, Control_Desk_Analyst_Full_Name_TG2__c, Created_Date__c, Days_from_converted_to_closed__c, 
            Comments_Name_Invoice__c, Stage_AP_Finish_Date__c, Days_in_Current_Stage__c, Stage_Converted_Finish_Date__c, 
            Stage_Document_Management_Finish_Date__c, Stage_In_Signature_Finish_Date__c, Stage_Registry_Finish_Date__c, Stage_Tollgate_1_Finish_Date__c, 
            Stage_Tollgate_2_Finish_Date__c, Stage_Treasury_Finish_Date__c, Rejection_types_and_subtypes_TG1__c, Rejection_types_and_subtypes_TG2__c, 
            TKD_Legal_Team_Member__r.Name, RecordType_Name__c, TKD_Approved_Suppliers__c, TD_Amount_Currency__c, Times_AP__c, Times_Converted__c, 
            Times_Document_Management__c, Times_In_Signature_Stage__c, Times_Registry_Stage__c, Times_Tollgate_1_Stage__c, Times_Tollgate_2_Stage__c, 
            Times_Treasury__c, Times_Rejected__c, OLFM_Vertical__c, Times_Tollgate_1_Rejected__c, Times_Tollgate_2_Rejected__c, Days_in_Converted_Stage__c, 
            Days_in_Registry_Stage__c, Days_in_Signature_Stage__c, Days_in_Tollagate_1_Stage__c, Days_in_Tollgate_2_Stage__c, Days_in_AP__c, 
            Days_in_Document_Management__c, Days_in_Treasury__c, Stage_AP_Date__c, Stage_Converted_Date__c, Stage_Document_Management_Date__c, 
            Stage_In_Signature_Date__c, Stage_Registry_Date__c, Stage_Tollgate_1_Date__c, Stage_Tollgate_2_Date__c, Stage_Treasury_Date__c, 
            Time_in_Current_Stage__c, SR_re_Seguro_No_Financiado__c, SR_re_Excepcion_de_Seguro_no_financiado__c, Date_TKI_No_Submitted__c, 
            Date_TKI_In_Approval__c, Date_TKI_Rejected__c, Date_TKI_Approved__c, Date_TKI_Rework__c, LMM_rb_EC_Quote__c, Days_In_TKI_No_Submitted__c, 
            Days_In_TKI_In_Approval__c, Days_In_TKI_Rejected__c, Days_In_TKI_Approved__c, Days_In_TKI_Rework__c, TKD_tx_Arrendador__c, TKD_tx_Numero_de_Cuenta__c, 
            TKD_tx_Banco__c, TKD_tx_ABA__c, TKD_tx_SWIFT__c, TKD_ca_Registry_delay_funding__c, TKI_No_Submitted_Check__c, TKI_In_Approval_Check__c, 
            TKI_Rework_Check__c, TKI_Rejected_Check__c, Times_in_TKI_In_Approval__c, Times_in_TKI_Rejected__c, Times_in_TKI_Rework__c, TKD_ls_Visto_bueno_finanzas__c,
            TKD_ls_takedown_stage__c,  CPL_tx_OLFM_Contract_Number__c, Contract_Annex_Number__c,CPL_ls_Operation_Unit__c, 
            CPL_da_Funding_Date__c, Term__c, CPL_fm_Currency_of_the_line_of_credit__c, CPL_ls_Product__c,
            TKD_LinkedEval__c,
            (SELECT Id,Owner.Name,IsDeleted,Name,CurrencyIsoCode,LastActivityDate,LastViewedDate,
            LastReferencedDate,TKD_Documments_Validation__c,TKD_Validation_Hits__c,
            TKD_ca_Invoices_with_suppliers__c,TKD_rb_SupplierInApproval__c,TKD_tx_Hits__c,TKD_tx_IdSupplier__c,
            tkd_ls_Stage_AML__c,tkd_ls_Stage_Supplier__c,tkd_ls_Stage__c,TKD_re_Total_suppliers__c
             FROM Suppliers_in_approval__r),  
            Nombre_cliente__c,TKD_rb_Pricin_CA__r.Name,TKD_rb_Pricin_CA__r.ES3_rb_Credit_approval_CP__r.Name,TKD_rb_Pricin_CA__r.ES3_fm_Pricing_Super_Trump__c,
            (SELECT Id,IsDeleted,Name,CurrencyIsoCode,LastActivityDate,
            LastViewedDate,LastReferencedDate,TKD_rb_Takedown_CP__c,TKD_Entity_Master_in_Credit_Approval__c,
            Enitty_Master_In_CA_ID__c,TKD_fm_EntityUrl__c,TKD_tx_RequestId__c, CreatedBy.FirstName, CreatedBy.LastName  FROM Legal_Assessments_In_TD__r),
            (SELECT Id,Owner.Name,IsDeleted,Name,CurrencyIsoCode,RecordTypeId,
            LastViewedDate,LastReferencedDate,Takedown_CP__c,Document_Type__c,
            Reason_for_Exception__c,Approver__c,Requester_Comments__c,Approver_Comments__c,
            Stage__c,Due_Date__c,Status__c,Takedown_Amount__c,Customer_Name__c,Takedown_Amount_USD__c,
            Service_Level_Agreement_Days__c,Takedown_Status__c,Commitment_Date__c,Close_Date__c,
            Blanket_Insurance_Policy_Type__c,Blanket_Insurance_Policy_Start_Date__c,Blanket_Insurance_Policy_End_Date__c,
            Blanket_Insurance_Policy_Aging__c,Exception_Type__c,Sr_Underwriter__c,Control_Desk_Analyst__c,
            Product__c,Supplier_Customer__c,Other_Approver__c,No_Remediation_Details__c,
            No_Remdiation_Approver_Comments__c,Approve_Date__c,Days_Open__c,Closing_Bucket__c,Credit_Approval__r.Name
            FROM WaiversToGo__r), (SELECT Id,Owner.Name,IsDeleted,Name,CurrencyIsoCode,RecordTypeId,LastActivityDate,
            LastViewedDate,LastReferencedDate,Budget_Gain_on_Sales__c,Budget_Year__c,Buy_Out_Return_All__c,
            Call_Option_Percentage__c,Call_Option__c,Collateral_Insights__c,Collateral__c,Comments__c,
            Customer_Name__c,Customer_Notification_Contact__c,Customer__c,EOL_Execution__c,EOL_R__c,
            EOL_Recomendation_Comments__c,EOL_Strategic_Expert__c,Early_Buy_Out_Date__c,Early_Buy_Out_EBO__c,
            Early_Buy_Out_Percentage__c,Early_Termination_Notification_Days__c,End_of_Leasing_Date__c,
            Estimated_Fair_Market_Value_RV__c,Evergreen_Extension__c,Evergreen_Paid__c,Evergreen_Payments__c,Evergreen__c,
            Extension_Evergreen_In_Of_Months__c,Fair_Market_Value_Amount__c,Gain_On_Sale__c,Higher_Of__c,
            Historic_Evergreen__c,Last_Termination_Value_TV__c,Lock_Fee__c,Loss_Pool__c,
            Notification_Days_In_Evergreen_Extension__c,Notification__c,OLFM_Contract_Number__c,
            Originator_Name__c,Originator__c,Prepayment_Penalty_Year_1__c,Prepayment_Penalty_Year_2__c,
            Prepayment_Penalty_Year_3__c,Prepayment_Penalty_Year_4__c,Prepayment_Penalty_Year_5__c,Product_Change__c,
            Purchase_Customer_Notification_Days__c,Purchase_Notification_Date__c,Purchase_Option__c,
            Put_Option_Percentage__c,Put_Option__c,Release__c,Repurchase__c,Residual_Value_Amount__c,Residual_Value__c,
            Return_Customer_Notification_Days__c,Return_Notification_Date__c,Return__c,Revision_Status__c,
            Sale_To_Customer__c,Side_Letter__c,Stage__c,Takedown_CP__c,This_Year_Budget_Evergreen__c,
            Vendor_Agreements_Comments__c,Vendor_Name__c,Economic_Group__c,Transaction_End_Date__c,EOLIM__r.Name,
            Side_Leter_Percentage__c,Purchase_Option_Percentage__c,Originator_final__c,Customer_Final__c,
            Economic_Group_Name__c,Economic_Group_Final__c,Region__c,Original_Equipment_Cost__c,Update_Date__c,
            Gain_on_Sale_Budget_Vs_Actual__c,This_Year_Budget_Evergreen_amount__c,Evergreen_Pmts_Budget_Vs_Actual__c,
            Budget_EOL_Gain_GOS_EVG__c,Actual_EOL_Gain_GOS_EVG__c,EOL_Gain_Budget_Vs_Actual__c,Contract_Annex__c,Unit__c,
            Line_of_Business__c,Early_Termination__c,Sale_to_Customer_D__c,Release_D__c,Return_D__c,Product_Change_D__c,
            Email_originator__c,Evergreen_P__c,Sale_to_Customer_P__c,Return_P__c,Release_P__c,Product_Change_P__c,
            Gain_On_Sale_Summary__c,THis_Year_Budget_Gain_on_Sale__c,This_Year_Budget_Evergreen_MXN__c,
            THis_Year_Budget_Gain_on_Sale_MXN__c,Commercial__c,Commercial_Collaboration_Level_Comments__c,
            Remarketing_Fee__c,Anticipated_Closing_Date__c,Budget_Amount__c,EVAL__c,Early_Termination_Income_Projection__c,
            FMV_Amount__c,Full_Partial__c,Income_Amount__c,Income_Projection_Reason__c,Portfolio_Notes__c,Probability__c,
            Sale_Renewal__c,Seller__c,Source__c,Federal_Local_Plates__c FROM EOLToGo__r) 
            FROM Takedowns_Contingency_plan__c WHERE id =: idTakedown LIMIT 1];

        allAsset = [SELECT id, Description, SerialNumber, CurrencyIsoCode, TKD_ls_asset_type__c, TKD_dv_total_cost__c, TKD_rb_Takedown_CP__c, TKD_fm_collateral_type__c FROM Asset WHERE TKD_rb_Takedown_CP__c  =: idTakedown];
        Takedowns_Contingency_plan__c InfoJson = [SELECT Id,CreatedDate, Name, RecordType.Name, CreatedBy.Name, CreatedBy.EmployeeNumber, CPL_rb_Opp__c, TKD_ls_takedown_stage__c, CPL_ls_Product__c, Financing_Needs__c, CPL_ls_Deal_Category__c  FROM Takedowns_Contingency_plan__c WHERE id =: idTakedown LIMIT 1];
        allCotizacionSeguro = [SELECT id, Opportunity__c, Opportunity__r.Account.Name, Name, QS_Razon_social__c, Producto__c, QS_descripcion__c, QS_Periodo_Cotizacion__c,  CurrencyIsoCode, QS_Suma_Asegurada__c, QS_Prima_Neta__c, QS_Prima_Neta_Label__c, QS_IVA__c, QS_IVA_Label__c, QS_Prima_Neta_Total__c, QS_Prima_Neta_Total_Label__c, QS_Prima_Total__c, QS_Prima_Total_Label__c, QS_Gastos__c, QS_Gastos_Label__c FROM Cotizacion_seguro__c];
        cotizacionSeguro = Wrapper_seguro_details.cotizacionSeguro(allCotizacionSeguro);

        if(InfoJson.RecordType.Name == 'Takedown LMM') {
            TakedownContent contentTakedown = new TakedownContent();
            contentTakedown.userId = InfoJson.CreatedBy.EmployeeNumber;
            contentTakedown.userName = InfoJson.CreatedBy.Name;
            contentTakedown.typeProcessCode = (InfoJson.TKD_ls_takedown_stage__c).replace(' ','_')+'_'+InfoJson.CPL_ls_Product__c+'_'+(InfoJson.Financing_Needs__c).replace(' ','_')+'_'+(InfoJson.CPL_ls_Deal_Category__c).replace(' ','_');
            contentTakedown.processFKId = InfoJson.Id;
            
            for(LMM_Entidad_de_oportunidad__c indentifier : [Select LMM_tx_Entity_Name__c,LMM_tx_RFC__c,LMM_ls_Entity_Type__c FROM LMM_Entidad_de_oportunidad__c WHERE LMM_pd_Oportunidad__c =: InfoJson.CPL_rb_Opp__c]){
                TakedownContent.Identifiers identifi = new TakedownContent.Identifiers();
                identifi.name = indentifier.LMM_tx_Entity_Name__c;
                identifi.rfc = indentifier.LMM_tx_RFC__c;
                if(indentifier.LMM_ls_Entity_Type__c == 'ORGANIZATION') {
                    identifi.person = 1;
                }
                else if(indentifier.LMM_ls_Entity_Type__c == 'INDIVIDUAL') {
                    identifi.person = 0;
                }
                identifi.type = 2;
                identifiers.add(identifi);
            }
            contentTakedown.identifiers = identifiers;      
            detailTakedownCP.add(new Wrapper_seguro_details(takedownCP, allAsset, contentTakedown, cotizacionSeguro));
        }
        else {
            TakedownContentOld contentTakedown = new TakedownContentOld();
            Wrapper_seguro_details.WrapperProcessCategory wrapperInfo = Wrapper_seguro_details.processDeal(InfoJson.CPL_ls_Product__c, InfoJson.CPL_ls_Deal_Category__c, InfoJson.TKD_ls_takedown_stage__c, InfoJson.Financing_Needs__c, InfoJson.CreatedDate);
            if(InfoJson.CPL_ls_Deal_Category__c !='Workout Restructure' && InfoJson.CPL_ls_Deal_Category__c !='Not new origination' ||
               ((InfoJson.CPL_ls_Deal_Category__c =='Workout Restructure' || InfoJson.CPL_ls_Deal_Category__c=='Not new origination')&& Wrapper_seguro_details.forWOAlprocess(InfoJson.CreatedDate)==false)){
                   contentTakedown.userId = InfoJson.CreatedBy.EmployeeNumber;
                   contentTakedown.userName = InfoJson.CreatedBy.Name;
                   contentTakedown.typeProcessId = wrapperInfo.process;
                   contentTakedown.processName = wrapperInfo.processName;
                   contentTakedown.exclude = wrapperInfo.exclude;
                   contentTakedown.processFKId = InfoJson.Name;
                  
               }else{
                   contentTakedown.userId = InfoJson.CreatedBy.EmployeeNumber;
                   contentTakedown.userName = InfoJson.CreatedBy.Name;
                   contentTakedown.typeProcessCode = wrapperInfo.process;
                   contentTakedown.processName = wrapperInfo.processName;
                   contentTakedown.processFKId = InfoJson.Name;
               }
            
            
            
            for(ES2_Obj_EntityMasterInCreditApproval__c indentifier : [Select ES2_tx_Oracle_Account_Name__c, TKD_txt_RFC__c, ES2_tx_CostumerType__c FROM ES2_Obj_EntityMasterInCreditApproval__c where ES3_rb_Opportunity__c =: InfoJson.CPL_rb_Opp__c]){
                TakedownContentOld.Identifiers identifi = new TakedownContentOld.Identifiers();
                identifi.name = indentifier.ES2_tx_Oracle_Account_Name__c.replace('  ', ' ');
                identifi.rfc = indentifier.TKD_txt_RFC__c;
                if(indentifier.ES2_tx_CostumerType__c == 'ORGANIZATION') {
                    identifi.person = 1;
                }
                else if(indentifier.ES2_tx_CostumerType__c == 'INDIVIDUAL') {
                    identifi.person = 0;
                }
                identifi.type = 2;
                identifiersOLD.add(identifi);
            }
            contentTakedown.identifiers = identifiersOLD;      
            detailTakedownCP.add(new Wrapper_seguro_details(takedownCP, allAsset, contentTakedown, cotizacionSeguro));
        }
       restRes.addHeader('Content-Type', 'application/json;charset=UTF-8');
       restRes.responseBody = Blob.valueOf(JSON.serialize(detailTakedownCP, true));
    }
}