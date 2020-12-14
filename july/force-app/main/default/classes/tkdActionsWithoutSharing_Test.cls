@isTest
public class tkdActionsWithoutSharing_Test {
    @testSetup static void setup(){
        //creation of EIV parameters
        list<EIV_Parameter__c> parameters = Test.loadData(EIV_Parameter__c.sobjectType, 'parametrosTest');
        System.assert(parameters.size()>0);
    }
    @isTest
    public static void processApproval(){
        string action = 'Actualiza';
        string comment = 'Tests';
        list<EIV_Parameter__c> parameters = Test.loadData(EIV_Parameter__c.sobjectType, 'parametrosTest');
        Takedowns_Contingency_plan__c takedown = Data_Factory_Takedown_Test.createTakedown('OPERFIN-FIJA','CDMX', 'CDMX123456');
        takedown.TKD_ls_takedown_stage__c = 'Registry';
        TkdActionsController.processApproval(takedown.Id, action, comment);
        takedown.TKD_ls_Visto_bueno_finanzas__c = 'No';
        tkdActionsWithoutSharing.updateTakedown(takedown);
        tkdActionsWithoutSharing.recallApprovalProcess(takedown.id);
        
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();
        
        email.subject = 'test';
        email.fromName = 'test test';
        email.plainTextBody = takedown.id;
        envelope.fromAddress = 'user@acme.com';
       


        // setup controller object
        recallEmail rEmail = new recallEmail();
        Messaging.InboundEmailResult result = rEmail.handleInboundEmail(email, envelope);
    }
    @isTest
    public static void processApprovalError(){
        string action = 'Actualiza';
        string comment = 'Tests';
        list<EIV_Parameter__c> parameters = Test.loadData(EIV_Parameter__c.sobjectType, 'parametrosTest');
        Takedowns_Contingency_plan__c takedown = Data_Factory_Takedown_Test.createTakedown('OPERFIN-FIJA','CDMX', 'CDMX123456');
        TkdActionsController.processApproval(takedown.Id, action, comment);
        takedown.TKD_ls_Visto_bueno_finanzas__c = 'No';
        tkdActionsWithoutSharing.updateTakedown(takedown);
        tkdActionsWithoutSharing.recallApprovalProcess(takedown.id);
        
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();
        
        email.subject = 'test';
        email.fromName = 'test test';
        email.plainTextBody = takedown.id;
        envelope.fromAddress = 'user@acme.com';
       


        // setup controller object
        recallEmail rEmail = new recallEmail();
        Messaging.InboundEmailResult result = rEmail.handleInboundEmail(email, envelope);
    }
    

}