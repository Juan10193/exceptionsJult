@Istest
public class Data_Factory_TesoreryTest_Test {    
    public static wk_TesoreryTest__c createNewTesoreryTest(){
            Credit_approval_CP__c cA =  Data_Factory_CreditApproval_Test.createNewCreditApprovalTypeWK('Pruebas');
            wk_TesoreryTest__c  tesorery = new  wk_TesoreryTest__c();       
            tesorery.wk_ta_Response1__c = 'Not Compliant' ;
            tesorery.wk_ta_Response2__c = 'Not Compliant' ;
            tesorery.wk_ta_Response3__c = 'Not Compliant' ;
            tesorery.wk_ta_Response4__c = 'Not Compliant' ;
            tesorery.wk_ta_Response5__c = 'Not Compliant' ;
            tesorery.wk_ta_Response6__c = 'Not Compliant' ;
            tesorery.wk_ta_Response7__c = 'Not Compliant' ;
            tesorery.wk_ta_Response8__c = 'Not Compliant' ;
            tesorery.wk_pd_creditApproval__c = cA.Id ;
            insert tesorery;
            System.debug('tesorery creada: '+ tesorery);
            return tesorery;
        }

}