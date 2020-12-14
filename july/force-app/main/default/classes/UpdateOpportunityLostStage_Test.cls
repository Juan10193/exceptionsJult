@isTest
public class UpdateOpportunityLostStage_Test {
    @isTest 
    public static void UpdateOpportunityLostStage(){
        Opportunity opp = Data_Factory_Opportunity_Test.createNewOpportunityTypeSales(); 
    }
    @isTest 
    public static void fillLostStageData(){
        //Crear Oportunidad
        Opportunity opp = Data_Factory_Opportunity_Test.createNewOpportunityTypeSales();
        //Cambiar Stage a Opportunity Identified
        Opportunity oppor = [SELECT Id, OPP_ls_Product__c, OPP_ls_Financing_Need__c, OPP_ls_Deal_Category__c, StageName FROM Opportunity where id =:opp.id];
        oppor.OPP_ls_Product__c ='Term Loan';
        oppor.OPP_ls_Financing_Need__c ='CapEx Lines';
        oppor.OPP_ls_Deal_Category__c ='Re-book';
        oppor.StageName ='Opportunity Identified';
        
                System.debug('Oportunidad: '+ opp);
        //upsert oppor;
                System.debug('Oportunidad: '+ opp);
        /*Cambiar Stage a Lost Deal
        opp = [SELECT Id FROM Opportunity where id =:opp.id];
        opp.OPP_ls_Reason_Lost_Level_1__c='Customer Declined';
        opp.OPP_ls_Reason_Lost_Level_2__c='Cash'; 
        opp.OPP_ls_Reason_Lost_Level_3__c='Revolving Credit facility'; 
        opp.OPP_tx_Lost_Comments__c='Test chido XD';
        //Crear un Competitor
        TBO022_Competitor__c com = new  TBO022_Competitor__c();
        com.Name = 'Rico McPato';
        insert com;
		ID comID = com.id;
        opp = [SELECT Id FROM Opportunity where id =:opp.id];
        com = [SELECT Id FROM TBO022_Competitor__c where id =:com.id];
        opp.OPP_rb_Competitor__c = comID;
        opp.OPP_ls_Competitor_Is_the_main_lender__c ='Yes';
       	opp.OPP_ls_Competitor_Product__c='Term Loan';
        opp.OPP_ls_Competitor_Floating_Fixed__c='Floating';
        opp.OPP_ls_Competitor_Index__c='10 Yr. Swaps';
        opp.OPP_un_Competitor_Term_Months__c=12;
        opp.OPP_un_Competitor_Spread_bps__c=12;
        opp.OPP_un_Spread_Diff_vs_Competitor_in_bps__c=21;	
        opp.OPP_tl_Competitor_comments__c='Me gusta el dinero';
        //upsert opp;
        opp = [SELECT Id FROM Opportunity where id =:opp.id];
        opp.StageName='Lost Deal';
        //upsert opp;
        System.debug('Oportunidad: '+ opp);

        opp.StageName='Lost Deal';
        System.debug('Oportunidad: '+ opp.StageName); */
    }
}