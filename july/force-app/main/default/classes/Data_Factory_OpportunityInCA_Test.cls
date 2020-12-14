/**
 * @File Name          : Data_Factory_OpportunityInCA_Test.cls
 * @Description        : Clase Utility para crear Opportunities En credit Approval
 * @Author             : benedick.esquivel@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : benedick.esquivel@engeniumcapital.com
 * @Last Modified On   : 10/1/2019 11:11:11
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    10/1/2019   benedick.esquivel@engeniumcapital.com     Initial Version
**/
@IsTest
public class Data_Factory_OpportunityInCA_Test {
   public static Opportunity_in_Credit_approval_CP__c createOppInCA(Credit_approval_CP__c ca, Opportunity opp){
       Opportunity_in_Credit_approval_CP__c Opp_CA = new Opportunity_in_Credit_approval_CP__c();
       Opp_CA.CP_rb_Credit_approval_CP__c = ca.Id;
       Opp_CA.CP_rb_Oportunidad__c = opp.Id;
       insert Opp_CA;
       return Opp_CA;
   }
}