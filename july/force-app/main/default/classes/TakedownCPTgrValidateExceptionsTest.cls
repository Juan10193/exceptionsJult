@Istest
public class TakedownCPTgrValidateExceptionsTest {
    @testSetup static void setup(){
        //creation of EIV parameters
        list<EIV_Parameter__c> parameters = Test.loadData(EIV_Parameter__c.sobjectType, 'parametrosTest');
        System.assert(parameters.size()>0);
        Takedowns_Contingency_plan__c  tkd = Data_Factory_Takedown_Test.createTakedownNowkopp('AFINAN-FIJA', 'Papus', 'RFC102990RB');
        Credit_approval_CP__c ca = Data_Factory_CreditApproval_Test.createNewCreditApprovalTypeCA('Frijoles');
        test.startTest();
        Opportunity opp = Data_Factory_Opportunity_Test.createNewOpportunityTypeLMM();
         tkd.CPL_rb_Opp__c = opp.Id;
        tkd.TKD_Suppilers_Documents__c = true;
        tkd.TKD_Approved_Suppliers__c = true;
        tkd.TKD_Tollgate_1_Val__c = true;
        tkd.TKD_Tollgate_2_Val__c = true;
        tkd.TKD_ls_takedown_stage__c ='In Signatures';
        update tkd;
        test.stopTest();
       
    }
    
   
    
    @Istest
    static void validateExceptionsForT2Test(){
        Takedowns_Contingency_plan__c tkd = [select Id from Takedowns_Contingency_plan__c][0];
        Credit_approval_CP__c ca = [select id from Credit_approval_CP__c][0];
        Opportunity opp =[Select id from Opportunity][0];
        test.startTest();
         IST__SuperTRUMP_Template__c template =  TestDataFactory_tst.createSTPricingTemplate();
        IST__SuperTRUMP_Pricing_Quote__c pq =TestDataFactory_tst.createSTPricingQuote(opp, template);
        TBO018_Pricing__c pricing = TestDataFactory_tst.createPricing(opp, pq);
        
          Opportunity_in_Credit_approval_CP__c oppca = Data_Factory_OpportunityInCA_Test.createOppInCA(ca, opp);
         pricing.TBO018_tx_Pricing_Status__c ='Approved';
        update pricing;
        ES3_obj_Pricing_in_Credit_Approval__c pca = TestDataFactory_tst.createPricingInCA(opp.Id, oppca.Id, pricing.Id, ca.Id);
        system.debug('pasamos aqui');
        Supplier_in_approval__c supplierInApproval = Data_Factory_SupplierInApproval_Test.createNewSupplierInApprovalNoTKD(tkd.Id);
        system.debug('pasamos 2');
        
        ID caid = ca.Id;
         WaiverToGo__c waiver = new WaiverToGo__c();
        waiver.Credit_Approval__c = caid;
        waiver.Document_Type__c ='Anti money laundry (AML)';
        waiver.Reason_for_Exception__c ='Incomplete AML revision (this only applies for document generation, never for funding)';
        waiver.Stage__c ='New';
        waiver.Commitment_Date__c = date.today();
        insert waiver;
             tkd.TKD_rb_Pricin_CA__c =pca.Id;
             tkd.TKD_ls_takedown_stage__c ='Tollgate 2';
        try{
            update tkd;
        }catch(Exception e){
            system.debug(e);
        }
       
        test.stopTest();
       
    }
}