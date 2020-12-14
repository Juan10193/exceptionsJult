@isTest
public class ES2_Controller_EntityMasterInCreditTest {
    @isTest
    static void ES2_Controller_EntityMasterInCreditApvl()
    {
        
        User currentUser = TestDataFactory_tst.createUser('test@engenium.com', 'Administrator', 'Sales Director - All Regions');
        System.runAs(currentUser) 
        {
            Account accnt = TestDataFactory_tst.createAccount();            
            accnt.ACC_dv_Sales_Annual_Revenue__c = 200000000;            
            update accnt;            

            
            Credit_approval_CP__c ca = new Credit_approval_CP__c();
            ca.CPL_rb_account__c= accnt.id;
            ca.Risk_Analyst__c= currentUser.id;
            ca.Sr_Underwriter__c=currentUser.id;
            ca.Type_of_credit_approval__c='Workout';
            ca.Inside_Sales__c=currentUser.id;
            insert ca;
            
            ES2_Obj_EntityMasterInCreditApproval__c EMinCA = new ES2_Obj_EntityMasterInCreditApproval__c();
            EMinCA.ES2_ms_Role__c = 'Obligor';
            EMinCA.ES2_rb_Credit_approval__c = ca.id;
            EMinCA.ES2_tx_Party_Id__c = '897687';
            //insert EMinCA;
            EIV_Parameter__c param = new EIV_Parameter__c();
            param.EIV_tx_parameter__c = 'ee';
            param.Name = 'URL_Servicio';
            insert param;
            
            ApexPages.StandardController stdController = new ApexPages.StandardController(EMinCA);
            ES2_Controller_EntityMasterInCreditApvl p = new ES2_Controller_EntityMasterInCreditApvl(stdController);
            
            //Cargar variables
            p.entity = new EIV_EntityWrapClass();
            p.entity.Customer_Type = 'Individual';
            
            p.sTopParentId = 'oiudoiusadio';
            p.sTopParentName = '928473892';
            p.entity.Oracle_Account_Name = 'ssdfsdf';
            p.entity.Party_Id = '2222';
            p.SaveData();   
            //p.entities.add(p.entity);
            
            P.getEMOptions();
            
            p.responseToEntityObj(  (Map<string,object>)JSON.deserializeUntyped( EIV_EntityJsonCreateTest.entitymasterToJsonBis()) );
            
        }
        
    }

}