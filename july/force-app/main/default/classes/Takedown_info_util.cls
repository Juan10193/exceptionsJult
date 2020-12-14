@IsTest
public class Takedown_info_util {
    //Uso
	public static Catalogo_Colaterals__c createCollaterals(){
		Catalogo_Colaterals__c collateral = new Catalogo_Colaterals__c();
        collateral.COLATERAL_DESCRIPTION__c = 'TRAILER - DRY VAN';
        collateral.COLATERAL_TYPE__c = 'TRANSPORTATION - TRAILER';
        collateral.CURRENCYISOCODE = 'USD';
        collateral.MANUFACTURER__c = 'UTILITY';
        collateral.MODEL_YEAR__c = '2019';
        collateral.MODEL__c = 'Caja Seca - 53 Pies';
        collateral.NAME = 'a2w1R0000001fSy';
        collateral.ORACLE_FA_CATEGORY_ID__C = '336';
        insert collateral;
        
        return collateral;
    }
    
    //Uso
    public static Asset createAsset(Id idAccount, Id idColateral, Id idTakedown) {
        Asset asset = new Asset();
        asset.Name = 'CROMATOGRAFO DE LIQUIDO';
        asset.Description = 'Descipción de activo';
        asset.TKD_tx_Model__c = 'ALLIANCE E2695';
        asset.TKD_tx_model_year__c = '2020';
        asset.TKD_tx_brand__c = 'WATERS';
        asset.SerialNumber = 'G19SM4993A';
        asset.TKD_ck_active__c = true;
        
        asset.AccountId = idAccount;
        asset.TKD_rb_collateral__c = idColateral;
        asset.TKD_rb_Takedown_CP__c = idTakedown;
        
        asset.Quantity = 1;
        asset.TDK_dv_Unit_cost__c = 1000000;
        asset.TKD_dv_total_cost__c = 1000000;
        asset.CurrencyIsoCode = 'USD';
        insert asset;
        
        return asset;
    }
    
    //Uso
    public static TBO002_SIC_code__c createSICCode() {
		TBO002_SIC_code__c sic_code	 = new TBO002_SIC_code__c();
		sic_code.Name = '12345';
		sic_code.TBO002_tx_SIC_industry_description__c = 'Prueba SICCODE';
		sic_code.TBO002_ls_SIC_industry__c = 'Automotive';
        insert sic_code;
        
        return sic_code;
    }
    
    //Uso
    public static Account createAccount(Id sicCode) {
        Account account = new Account();
        account.Name = 'Prueba comercial';
        account.BillingStreet = 'Example';
        account.BillingCountry = 'México';
        account.BillingState = 'Puebla';
        account.BillingPostalCode = '80790';
        account.ACC_rb_SIC_Code__c = sicCode;
        insert account;
        
        return account;
    }
    
    //credit and approval for takedown
    public static Credit_approval_CP__c createApproval(Id idAccount) {
        Id recordType = Schema.SObjectType.Credit_approval_CP__c.getRecordTypeInfosByName().get('Credit Approval').getRecordTypeId();
        
        Credit_approval_CP__c approval = new Credit_approval_CP__c();
        approval.Approval_Level__c = 'SUW+MDUW';
        approval.CPI_ck_FueAprobado__c = true;
        approval.CPI_ck_ItMayBeProvidedInAnotherCurrency__c = false;
		approval.CPI_nu_CA_Rate_c__c = 19.163;
        approval.CPI_tx_Customer_Since__c = '2019';
        approval.CPI_tx_Risk_Economic_Group__c = 'INTERDELI';
		approval.CPL_ls_StageName__c = 'Approved';
        approval.CPL_rb_account__c = idAccount;
        approval.CurrencyIsoCode = 'USD';
        approval.Decision_Date__c = date.parse('22/04/2019');
        approval.ES3_TX_MRA_ID__c = '737';
        approval.ES3_ls_AML_Review_Status__c = 'Approved';
        approval.ES3_ls_EBO__c = 'N/A';
        approval.ES3_ls_Low_High_High_Low__c = 'N/A';
        approval.ES3_ls_Nivel_1__c = 'Pricing (Pablo Zamora or Montserrat Ibarra)';
        approval.ES3_ls_Nivel_2__c = 'Sr. UW + MD UW';
        approval.ES3_ls_Nivel_3__c = 'N/A';
        approval.ES3_ls_Nivel_4__c = 'N/A';
        approval.ES3_ls_Nivel_5__c = 'N/A';
        approval.ES3_ls_RISK_REVIEW_STATUS__c = 'Approved';
        approval.ES3_ls_SL_B_YES_NO__c = 'NO';
        approval.ES3_ls_Type_of_Grace_Period__c = 'N/A';
        approval.ES3_ls_Used_New__c = 'N/A';
        approval.ES3_nu_Advance_Payment__c = 0;
        approval.ES3_nu_Grace_Period_in_Months__c = 0;
        approval.ES3_nu_Progress_Payments_M__c = 6;
        approval.ES3_nu_ROI_No_Insurance__c = 4.7;
        approval.ES3_num_SD__c = 0;
        approval.ES3_pc_RV__c = 0;
        approval.ES3_pc_Rate__c = 19.15;
        approval.ES3_pc_Remarketing_Fee__c = 0;
        approval.ES3_pc_Split_Trac__c = 0;
        approval.ES3_pc_Trac__c = 0;
        approval.ES3_tx_Account_Name__c = 'Interdeli';
        approval.ES3_tx_Boot_Collateral__c = 'Food Processing Equipment';
        approval.ES3_tx_Risk_Economic_Group_Id__c = '871448';
        approval.Exposure__c = 0;
        approval.Government__c = 'No';
        approval.MD_ca_AddOn__c = false;
        approval.MD_ca_Carveout__c = false;
        approval.MD_ca_Incremental__c = false;
        approval.MD_ca_MODMAC__c = false;
        approval.Override_Reason__c = 'N/A';
        approval.SP3_pl_Credit_Approval_Status__c = 'New';
        approval.Type_of_credit_approval__c = 'Fast Track';
        approval.RecordTypeId = recordType;
        insert approval; 
        
        return approval;
    }
    
    //Entity para credit approval master
    public static ES2_Obj_EntityMasterInCreditApproval__c createCreditAndApprove(Id idCreditApproval, Id idOpportunity) {
        ES2_Obj_EntityMasterInCreditApproval__c invoice = new ES2_Obj_EntityMasterInCreditApproval__c();
        invoice.Name = 'DELI DIPS & SNACKS, S.A.P.I. DE C.V.';
        invoice.CurrencyIsoCode = 'USD';
        invoice.TKD_txt_RFC__c = 'DEL160511D67';
        invoice.ES2_rb_Credit_approval__c = idCreditApproval;
        invoice.ES2_ms_Role__c = 'Guarantor';
        invoice.ES2_tx_CostumerType__c = 'ORGANIZATION';
        invoice.ES2_tx_Oracle_Account_Name__c = 'DELI DIPS & SNACKS, S.A.P.I. DE C.V.';
        invoice.ES2_tx_Party_Id__c = '948425';
        invoice.ES2_tx_TopParentID__c = '00136000017tIhK';
        invoice.ES2_tx_TopParetName__c = 'Interdeli';
        invoice.ES2_tx_pageVF__c = 'EIV_EntityReadPageOrganization';
        invoice.ES3_rb_Opportunity__c = idOpportunity;
        invoice.ES3_txt_CRR_Override__c = 'SELECTION';
        invoice.ES2_chk_Adverse_Media__c = False;
        insert invoice;
        
        return invoice;
    }
    
    //Entity para credit approval master
    public static ES2_Obj_EntityMasterInCreditApproval__c createCreditAndApproveInd(Id idCreditApproval, Id idOpportunity) {
        ES2_Obj_EntityMasterInCreditApproval__c invoice = new ES2_Obj_EntityMasterInCreditApproval__c();
        invoice.Name = 'DELI DIPS & SNACKS, S.A.P.I. DE C.V.';
        invoice.CurrencyIsoCode = 'USD';
        invoice.TKD_txt_RFC__c = 'DEL160511D67';
        invoice.ES2_rb_Credit_approval__c = idCreditApproval;
        invoice.ES2_ms_Role__c = 'Guarantor';
        invoice.ES2_tx_CostumerType__c = 'INDIVIDUAL';
        invoice.ES2_tx_Oracle_Account_Name__c = 'DELI DIPS & SNACKS, S.A.P.I. DE C.V.';
        invoice.ES2_tx_Party_Id__c = '948425';
        invoice.ES2_tx_TopParentID__c = '00136000017tIhK';
        invoice.ES2_tx_TopParetName__c = 'Interdeli';
        invoice.ES2_tx_pageVF__c = 'EIV_EntityReadPageOrganization';
        invoice.ES3_rb_Opportunity__c = idOpportunity;
        invoice.ES3_txt_CRR_Override__c = 'SELECTION';
        invoice.ES2_chk_Adverse_Media__c = False;
        insert invoice;
        
        return invoice;
    }
    
    public static Opportunity createOpportunityOld(){     
        
        Id recordTypeID = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Sales').getRecordTypeId();
        
		Date firstDate = Date.newInstance(2019, 09, 30);
		Opportunity opportunity = new Opportunity();
		opportunity.OwnerId=UserInfo.getUserId();
		opportunity.OPP_rb_Closer__c=UserInfo.getUserId();  
		opportunity.Name='Pruebas WK Test'; 
		opportunity.OPP_ls_Region__c='Mexico 1'; 
		opportunity.StageName='New';
		opportunity.CPL_dv_Approved_Amount__c = 100000;
        opportunity.CurrencyIsoCode = 'USD';
		//Deal Parameters
		opportunity.Amount=1000000.00; 
		opportunity.CloseDate=firstDate;
		opportunity.CPS2_da_Expected_1st_funding_date__c=firstDate;
		//Collateral Details
		opportunity.OPP_ls_Line_of_Business__c='Equipment';
		opportunity.OPP_ls_Collateral__c='Agricultural Equipment';            	
		//Vendor Parameters
		opportunity.OPP_ls_Opportunity_from_Vendor__c='No';
		//Broker Parameters
		opportunity.OPP_ls_Opportunity_from_Broker__c='No';
        opportunity.RecordTypeId = recordTypeID;
		insert opportunity;    
        
        return opportunity;        
    }
    
    //Uso
    public static Entity_CP__c createEntityCP(String name, String RFCTin){
        Entity_CP__c enttityCP = new Entity_CP__c();
        enttityCP.Name = name;
        enttityCP.CPI_tx_RFC_TIN__c =rfcTin;
        insert enttityCP;
        return enttityCP;
    }
    
    //Uso
    public static Opportunity createOpportunity(){     
        
        Id recordTypeID = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('LMM').getRecordTypeId();
        
		Date firstDate = Date.newInstance(2019, 09, 30);
		Opportunity opportunity = new Opportunity();
		opportunity.OwnerId=UserInfo.getUserId();
		opportunity.OPP_rb_Closer__c=UserInfo.getUserId();  
		opportunity.Name='Pruebas WK Test'; 
		opportunity.OPP_ls_Region__c='Mexico 1'; 
		opportunity.StageName='New';
		opportunity.CPL_dv_Approved_Amount__c = 100000;
        opportunity.CurrencyIsoCode = 'USD';
		//Deal Parameters
		opportunity.Amount=1000000.00; 
		opportunity.CloseDate=firstDate;
		opportunity.CPS2_da_Expected_1st_funding_date__c=firstDate;
		//Collateral Details
		opportunity.OPP_ls_Line_of_Business__c='Equipment';
		opportunity.OPP_ls_Collateral__c='Agricultural Equipment';            	
		//Vendor Parameters
		opportunity.OPP_ls_Opportunity_from_Vendor__c='No';
		//Broker Parameters
		opportunity.OPP_ls_Opportunity_from_Broker__c='No';
        opportunity.RecordTypeId = recordTypeID;
		insert opportunity;    
        
        return opportunity;        
    }
}