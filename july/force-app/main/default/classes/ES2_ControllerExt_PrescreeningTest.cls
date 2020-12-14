@isTest
public class ES2_ControllerExt_PrescreeningTest {
    @isTest
    static void ES2_ControllerExt_Prescreening()
    {
        User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Administrator', 'Sales Director - All Regions');
        System.runAs(currentUser) {
            Account accnt = TestDataFactory_tst.createAccount();            
            accnt.ACC_dv_Sales_Annual_Revenue__c = 200000000;            
            update accnt;            
            TBO022_Competitor__c competitor = TestDataFactory_tst.createCompetitor();            
            //Opportunity opp = TestDataFactory_tst.createOpportunity(accnt, currentUser, competitor);
            
            Opportunity opp = new Opportunity();
            opp.Name = 'Opp with attachment';
            opp.Amount = 300000000.50;
            opp.StageName = 'Lead';
            
            Date firstFundingExpectedDate = Date.today();
            firstFundingExpectedDate = firstFundingExpectedDate.addMonths(2);
            opp.CloseDate = firstFundingExpectedDate;
            
            if (accnt != null) {
                opp.AccountId = accnt.Id;
            }
            
            opp.OPP_ls_Product__c = 'Term Loan';
            opp.OPP_ls_Financing_Need__c = 'CapEx Lines';
            opp.OPP_ls_Collateral__c = 'Agricultural Equipment';
            opp.OPP_ls_Deal_Category__c = 'New Origination';
            opp.StageName = 'Opportunity Identified';
            opp.OPP_ls_Line_of_Business__c = 'Equipment';
            opp.OPP_ls_Region__c = currentUser.USU_ls_Region__c;
            opp.OPP_ls_Origin_of_equipment__c = 'Austria';
            opp.OPP_ls_Insurance_Type__c = 'Customer Self Insurance';
            opp.OPP_ls_Equipment_Import_Required__c = 'No';
            opp.OPP_ls_Reason_Won_Level_1__c = 'Ability to Execute';
            opp.OPP_ls_Reason_Won_Level_2__c = 'Ability to Deliver';
            opp.OPP_fh_Date_Customer_Expects_Credit_App__c = Date.today();
            opp.OPP_tl_Won_Comments__c = 'Won Comments.';
            opp.OPP_rb_Competitor__c = competitor.Id;
            opp.OPP_ca_No_document__c = true;
            opp.OPP_tl_Not_Signed_Proposal_Reason__c = 'Not Signed Reason.';
            opp.OPP_ls_Equipment_Condition__c = 'New';
            opp.OPP_ls_Insurance_Type__c = 'Engenium Capital Financed';  
            insert opp;    
            opp.StageName = 'Opportunity Identified';            
            update opp;      
            
            ES2_Obj_Prescreening__c pres = new ES2_Obj_Prescreening__c();
            pres.ES2_rb_Opportunity__c = opp.id;
            pres.OwnerId = currentUser.id;
            pres.Name='Prueba';
            pres.ES2_lst_Payment_Trend__c='N/A';
            pres.ES2_lst_Special_Payment_Terms__c='Yes';
            pres.ES2_tx_Why_is_customer__c='Hola que tal';
            pres.ES2_lts_Financial_Information_Source__c='Customer';
            pres.ES2_nu_OLV_Day_1__c=123;
            pres.ES2_lst_USD_Sales_50__c='No';
            pres.ES2_date_Customer_Expected_Date__c= date.today();
            pres.Personal_Guarantee__c='Yes';
            pres.ES2_lst_Companies_in_the_Group__c='1';
            pres.ES2_lst_Visibility_of_all_Companies__c='Yes';
            pres.ES2_lst_10_Years_in_Business__c='Yes';
            pres.ES2_lts_Single_Customer_Concentration__c='Yes';
            pres.ES2_lts_Industry_Concem__c='Yes';
            pres.ES2_lst_Commodity_Driven__c='Yes';
            pres.ES2_lts_Highly_Cyclical__c='Yes';
            pres.ES2_lts_Government_Cust_Concentration__c='Yes';
            INSERT pres;
            pres = [Select CreatedById,ES2_rb_Opportunity__c,OwnerId,Name,ES2_lst_Payment_Trend__c,ES2_lst_Special_Payment_Terms__c,ES2_tx_Why_is_customer__c,
                    ES2_lts_Financial_Information_Source__c,ES2_nu_OLV_Day_1__c,ES2_lst_USD_Sales_50__c,ES2_date_Customer_Expected_Date__c,
                    Personal_Guarantee__c,ES2_lst_Companies_in_the_Group__c,ES2_lst_Visibility_of_all_Companies__c,ES2_lst_10_Years_in_Business__c,
                    ES2_lts_Single_Customer_Concentration__c,ES2_lts_Industry_Concem__c,ES2_lst_Commodity_Driven__c,ES2_lts_Highly_Cyclical__c,
                    ES2_lts_Government_Cust_Concentration__c from ES2_Obj_Prescreening__c where id =: pres.id];
            
            ApexPages.StandardController stdController = new ApexPages.StandardController(pres);
            ES2_ControllerExt_Prescreening p = new ES2_ControllerExt_Prescreening(stdController);
            p.getQueueUWSr();
            p.approval();
            p.inProcess();
            p.picRequired();
            p.declined();
            p.approved(); 
            
            
            pres = [Select CreatedById,ES2_rb_Opportunity__c,OwnerId,Name,ES2_lst_Payment_Trend__c,ES2_lst_Special_Payment_Terms__c,ES2_tx_Why_is_customer__c,
                    ES2_lts_Financial_Information_Source__c,ES2_nu_OLV_Day_1__c,ES2_lst_USD_Sales_50__c,ES2_date_Customer_Expected_Date__c,
                    Personal_Guarantee__c,ES2_lst_Companies_in_the_Group__c,ES2_lst_Visibility_of_all_Companies__c,ES2_lst_10_Years_in_Business__c,
                    ES2_lts_Single_Customer_Concentration__c,ES2_lts_Industry_Concem__c,ES2_lst_Commodity_Driven__c,ES2_lts_Highly_Cyclical__c,
                    ES2_lts_Government_Cust_Concentration__c from ES2_Obj_Prescreening__c where id =: pres.id];
            
            
        }
    }
    
    
    
    @isTest
    static void ES2_ControllerExt_Prescreening2()
    {
        User currentUser = TestDataFactory_tst.createUser('scastro@engenium.com', 'Administrator', 'Sales Director - All Regions');
        System.runAs(currentUser) {
            Account accnt = TestDataFactory_tst.createAccount();            
            accnt.ACC_dv_Sales_Annual_Revenue__c = 200000000;            
            update accnt;            
            TBO022_Competitor__c competitor = TestDataFactory_tst.createCompetitor();            
Opportunity opp = new Opportunity();
            opp.Name = 'Opp with attachment';
            opp.Amount = 300000000.50;
            opp.StageName = 'Lead';
            
            Date firstFundingExpectedDate = Date.today();
            firstFundingExpectedDate = firstFundingExpectedDate.addMonths(2);
            opp.CloseDate = firstFundingExpectedDate;
            
            if (accnt != null) {
                opp.AccountId = accnt.Id;
            }
            
            opp.OPP_ls_Product__c = 'Term Loan';
            opp.OPP_ls_Financing_Need__c = 'CapEx Lines';
            opp.OPP_ls_Collateral__c = 'Agricultural Equipment';
            opp.OPP_ls_Deal_Category__c = 'New Origination';
            opp.StageName = 'Opportunity Identified';
            opp.OPP_ls_Line_of_Business__c = 'Equipment';
            opp.OPP_ls_Region__c = currentUser.USU_ls_Region__c;
            opp.OPP_ls_Origin_of_equipment__c = 'Austria';
            opp.OPP_ls_Insurance_Type__c = 'Customer Self Insurance';
            opp.OPP_ls_Equipment_Import_Required__c = 'No';
            opp.OPP_ls_Reason_Won_Level_1__c = 'Ability to Execute';
            opp.OPP_ls_Reason_Won_Level_2__c = 'Ability to Deliver';
            opp.OPP_fh_Date_Customer_Expects_Credit_App__c = Date.today();
            opp.OPP_tl_Won_Comments__c = 'Won Comments.';
            opp.OPP_rb_Competitor__c = competitor.Id;
            opp.OPP_ca_No_document__c = true;
            opp.OPP_tl_Not_Signed_Proposal_Reason__c = 'Not Signed Reason.';
            opp.OPP_ls_Equipment_Condition__c = 'New';
            opp.OPP_ls_Insurance_Type__c = 'Engenium Capital Financed';  
            insert opp;    
            opp.StageName = 'Opportunity Identified';            
            update opp;           
            
            ES2_Obj_Prescreening__c pres = new ES2_Obj_Prescreening__c();
            pres.ES2_rb_Opportunity__c = opp.id;
            pres.OwnerId = currentUser.id;
            pres.Name='Prueba';
            pres.ES2_lst_Payment_Trend__c='N/A';
            pres.ES2_lst_Special_Payment_Terms__c='Yes';
            pres.ES2_tx_Why_is_customer__c='Hola que tal';
            pres.ES2_lts_Financial_Information_Source__c='Customer';
            pres.ES2_nu_OLV_Day_1__c=123;
            pres.ES2_lst_USD_Sales_50__c='No';
            pres.ES2_date_Customer_Expected_Date__c= date.today();
            pres.Personal_Guarantee__c='Yes';
            pres.ES2_lst_Companies_in_the_Group__c='1';
            pres.ES2_lst_Visibility_of_all_Companies__c='Yes';
            pres.ES2_lst_10_Years_in_Business__c='Yes';
            pres.ES2_lts_Single_Customer_Concentration__c='Yes';
            pres.ES2_lts_Industry_Concem__c='Yes';
            pres.ES2_lst_Commodity_Driven__c='Yes';
            pres.ES2_lts_Highly_Cyclical__c='Yes';
            pres.ES2_lts_Government_Cust_Concentration__c='Yes';
            pres.ES2_rb_Sr_UnderWriter__c=pres.OwnerId;
            pres.ES2_tx_Comments_UW__c='HOLA';
            INSERT pres;
            pres = [Select CreatedById,ES2_rb_Opportunity__c,OwnerId,Name,ES2_lst_Payment_Trend__c,ES2_lst_Special_Payment_Terms__c,ES2_tx_Why_is_customer__c,
                    ES2_lts_Financial_Information_Source__c,ES2_nu_OLV_Day_1__c,ES2_lst_USD_Sales_50__c,ES2_date_Customer_Expected_Date__c,
                    Personal_Guarantee__c,ES2_lst_Companies_in_the_Group__c,ES2_lst_Visibility_of_all_Companies__c,ES2_lst_10_Years_in_Business__c,
                    ES2_lts_Single_Customer_Concentration__c,ES2_lts_Industry_Concem__c,ES2_lst_Commodity_Driven__c,ES2_lts_Highly_Cyclical__c,
                    ES2_lts_Government_Cust_Concentration__c,ES2_tx_Comments_UW__c,ES2_rb_Sr_UnderWriter__c from ES2_Obj_Prescreening__c where id =: pres.id];
            
            ApexPages.StandardController stdController = new ApexPages.StandardController(pres);
            ES2_ControllerExt_Prescreening p = new ES2_ControllerExt_Prescreening(stdController);
            p.getQueueUWSr();
            p.approval();
            p.inProcess();
            p.picRequired();
            p.declined();
            p.approved(); 
            
            
            pres = [Select CreatedById,ES2_rb_Opportunity__c,OwnerId,Name,ES2_lst_Payment_Trend__c,ES2_lst_Special_Payment_Terms__c,ES2_tx_Why_is_customer__c,
                    ES2_lts_Financial_Information_Source__c,ES2_nu_OLV_Day_1__c,ES2_lst_USD_Sales_50__c,ES2_date_Customer_Expected_Date__c,
                    Personal_Guarantee__c,ES2_lst_Companies_in_the_Group__c,ES2_lst_Visibility_of_all_Companies__c,ES2_lst_10_Years_in_Business__c,
                    ES2_lts_Single_Customer_Concentration__c,ES2_lts_Industry_Concem__c,ES2_lst_Commodity_Driven__c,ES2_lts_Highly_Cyclical__c,
                    ES2_lts_Government_Cust_Concentration__c, ES2_tx_Comments_UW__c,ES2_rb_Sr_UnderWriter__c from ES2_Obj_Prescreening__c where id =: pres.id];
            
            
        }
    }
}