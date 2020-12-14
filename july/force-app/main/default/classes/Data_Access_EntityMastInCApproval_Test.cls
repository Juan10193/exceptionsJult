@isTest
public class Data_Access_EntityMastInCApproval_Test {
    @isTest
    public static void entitiesInCaOp(){
        Opportunity opp = Data_Factory_Opportunity_Test.createNewOpportunityTypeWK();
        Credit_approval_CP__c CA = Data_Factory_CreditApproval_Test.createNewCreditApprovalTypeWK('Ejemplo Cuenta');
		ES2_Obj_EntityMasterInCreditApproval__c Entity = Data_Factory_EntityMastInCApproval_Test.createEntityInCA(CA);
        Data_Access_EntityMastInCApproval_cls.entitiesInCaOp(opp.id);        
    }
    @isTest
    public static void getEntitiesMasterByCAId(){
        Credit_approval_CP__c CA = Data_Factory_CreditApproval_Test.createNewCreditApprovalTypeWK('Ejemplo Cuenta');
		ES2_Obj_EntityMasterInCreditApproval__c Entity = Data_Factory_EntityMastInCApproval_Test.createEntityInCA(CA);
        Data_Access_EntityMastInCApproval_cls.getEntitiesMasterByCAId(CA.id);        
    }    
	@isTest
    public static void getEntitiesInCa(){
        Credit_approval_CP__c CA = Data_Factory_CreditApproval_Test.createNewCreditApprovalTypeWK('Ejemplo Cuenta');
		ES2_Obj_EntityMasterInCreditApproval__c Entity = Data_Factory_EntityMastInCApproval_Test.createEntityInCA(CA);
        Data_Access_EntityMastInCApproval_cls.getEntitiesInCa(Entity.id);        
    }
}