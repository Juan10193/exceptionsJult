@Istest
public class TKD_ChecklistTolgate1ControllerTest {
    @testSetup static void setup(){
        //creation of EIV parameters
        list<EIV_Parameter__c> parameters = Test.loadData(EIV_Parameter__c.sobjectType, 'parametrosTest');
        System.assert(parameters.size()>0);
    }
    @Istest
    public static void fetchLasInTKDTest(){
        Takedowns_Contingency_plan__c  tkd = Data_Factory_Takedown_Test.createTakedown('OPERFIN-FIJA', 'Jaivos', 'RFCJaivi109');
        TKD_ChecklistTolgate1Controller.fetchLasInTKD(tkd.Id);
    }
    
    @Istest
    public static void getTakedownInvoicesTest(){
        Takedowns_Contingency_plan__c  tkd = Data_Factory_Takedown_Test.createTakedown('OPERFIN-FIJA', 'Jaivas', 'RFCJAIVAS10');
        TKD_ChecklistTolgate1Controller.getTakedownInvoices(tkd.Id);
    }
    
    @Istest
    public static void getMasterEntityTest(){
        Opportunity op = Data_Factory_Opportunity_Test.createNewOpportunityTypeSales();
        TKD_ChecklistTolgate1Controller.getMasterEntity(op.Id);
        Credit_approval_CP__c cp = Data_Factory_CreditApproval_Test.createNewCreditApprovalTypeCA('lelito');
        Data_Access_EntityMastInCApproval_cls.getEntitiesInCa(cp.Id);
        Data_Access_EntityMastInCApproval_cls.getEntitiesMasterByCAId(cp.Id);
    }
    
    @Istest
    public static void getSupplierInApprovalStatusTest(){
        Takedowns_Contingency_plan__c  tkd = Data_Factory_Takedown_Test.createTakedown('OPERFIN-FIJA', 'PECUARIO', 'RFCPECUAR10');
        TKD_ChecklistTolgate1Controller.getSupplierInApprovalStatus(tkd.Id);
    }
    
    @Istest
    public static void requestToContentTest(){
        string sandbox = GetSandboxType.getTypeOfSandbox();
        string namecred;
        
        if(sandbox == 'DEV'){
            namecred = 'ContentManagmentDev';
        }
        if(sandbox == 'QA'){
            namecred = 'ContentManagmentQA';
        }
        if(sandbox =='PROD'){
            namecred = 'ContentManagmentProd';
        }
        string testEndpoint = 'callout:'+ namecred + '/wcmecapp/files/tollgate' ;
         String getResponse ='Respuesta dumy';
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseHandler_cls(testEndpoint, getResponse, 'POST', 'application/json', 200));
        test.startTest();
        TKD_ChecklistTolgate1Controller.requestToContent('DatosEncriptadosDumy');
        test.stopTest();
    }
    
     @Istest
    public static void getTokenTest(){
        string sandbox = GetSandboxType.getTypeOfSandbox();
        string namecred;
        
       if(sandbox == 'DEV'){
            namecred = 'ContentManagmentDevToken';
        }
        if(sandbox == 'QA'){
            namecred = 'ContentManagmentQAToken';
        }
        if(sandbox =='PROD'){
            namecred = 'ContentManagmentProdToken';
        }
        string testEndpoint = 'callout:'+ namecred;
         String getResponse ='Respuesta dumy';
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseHandler_cls(testEndpoint, getResponse, 'POST', 'application/json', 200));
        test.startTest();
        Takedown_WS_Tollgate_cls.getToken();
        test.stopTest();
    }
    
    @Istest
    public static void getRequiredForPretollgate1Test(){
        TKD_ChecklistTolgate1Controller.getRequiredForPretollgate1('prodcutType');
    }
    
    @Istest
    public static void unlockForUpdateTest(){
		Takedowns_Contingency_plan__c  tkd = Data_Factory_Takedown_Test.createTakedown('OPERFIN-FIJA', 'CALCIO', 'RFCCALCIO10');
		TKD_ChecklistTolgate1Controller.unlockForUpdate(tkd.Id);
		TKD_ChecklistTolgate1Controller.lockForApproval(tkd.Id);        
    }
    
    @iSTEST
    static void opportunityValidDateTest(){
        TKD_ChecklistTolgate1Controller.opportunityValidDate(Date.today());
        Takedowns_Contingency_plan__c  tkd = Data_Factory_Takedown_Test.createTakedown('OPERFIN-FIJA', 'CALCIO', 'RFCCALCIO10');
        TKD_ChecklistTolgate1Controller.validateSuppDocs(tkd.Id, true);
    }
}