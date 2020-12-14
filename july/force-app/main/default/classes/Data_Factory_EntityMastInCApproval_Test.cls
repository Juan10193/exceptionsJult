/**
 * @File Name          : Data_Factory_EntityMasterInCreditApproval_Test.cls
 * @Description        : Clase Utility para crear Entities Master En credit Approval
 * @Author             : juandedios.hernandez@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : juandedios.hernandez@engeniumcapital.com
 * @Last Modified On   : 30/9/2019 20:01:12
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    30/9/2019   juandedios.hernandez@engeniumcapital.com     Initial Version
**/
@IsTest
public class Data_Factory_EntityMastInCApproval_Test {
   public static ES2_Obj_EntityMasterInCreditApproval__c createEntityInCA(Credit_approval_CP__c ca){
       ES2_Obj_EntityMasterInCreditApproval__c entity = new ES2_Obj_EntityMasterInCreditApproval__c();
       entity.Name='ABA';
       entity.ES2_rb_Credit_approval__c =ca.Id;
       entity.ES3_tx_Or_Rating__c ='0';
       entity.ES2_ms_Role__c ='Obligor';
       insert entity;
       return entity;
   }
}