@istest
public class Takedown_Chain_Execution_test {
     @testSetup static void testSetUp() {
		EIV_Parameter__c parameters = new EIV_Parameter__c();
        parameters.name = 'fecha limite';
        parameters.EIV_tx_parameter__c = '01/12/2018';
        insert parameters;
        Takedown_Invoice__c tkd_invoice = Data_Factory_TakedownInvoice_Test.createTakedownInvoice('xml');
	}
    @istest
    static void Takedown_Chain_Execution_cls(){        
        Takedown_Invoice__c Takedown_Invoice = [select id, name, TKD_txt_Document_ID__c, TKD_pd_Takedown_CP__c,
                                                TKD_pd_Takedown_CP__r.CPL_rb_Opp__r.AccountId from  Takedown_Invoice__c];
        list<Takedown_Wrapper_SATVal_OL_cls.SATValRequest> listTakedown_Wrapper_SATVal = new list<Takedown_Wrapper_SATVal_OL_cls.SATValRequest>();
        Takedown_Wrapper_SATVal_OL_cls.SATValRequest SATValRequest = new Takedown_Wrapper_SATVal_OL_cls.SATValRequest();
        SATValRequest.assetType = 'Transporte (Tractocamiones)';
        SATValRequest.channel = '3';
        SATValRequest.documentId = Takedown_Invoice.TKD_txt_Document_ID__c;
        SATValRequest.mimeTypeXML = 'xml';
        SATValRequest.organizationId = UserInfo.getOrganizationId();
        SATValRequest.ssoId = '100000001';
        SATValRequest.takedownId = Takedown_Invoice.TKD_pd_Takedown_CP__c;
        MultiStaticResourceCalloutMock multimock = new MultiStaticResourceCalloutMock();
        multimock.setStaticResource('https://apps.engeniumcapital.com/getToken','Mock_Data_WS_OL_getToken');
        multimock.setStaticResource('https://apps.engeniumcapital.com/SATValidationOpenLegacy','Mock_Data_WS_OL_SATValidationOpenLegacy');
        multimock.setStaticResource('https://apps.engeniumcapital.com/FindAssetsByDocument','Mock_Data_WS_OL_FindAssetsByTakedown');
        multimock.setStaticResource('https://apps.engeniumcapital.com/FindAssetsByTakedown','Mock_Data_WS_OL_FindAssetsByTakedown');
        multimock.setStaticResource('https://apps.engeniumcapital.com/knowSuppliers','Mock_Data_WS_KnowSuppliers');
        //multimock.setStaticResource('http://api.example.com/contacts', 'jsonContacts');
        multimock.setStatusCode(200);
        multimock.setHeader('Content-Type', 'application/json');
    
        // Set the mock callout mode
        Test.setMock(HttpCalloutMock.class, multimock);
    

        Test.startTest();
        listTakedown_Wrapper_SATVal.add(SATValRequest);
        Takedown_Chain_Execution_cls Takedown_Chain_Execution = new Takedown_Chain_Execution_cls(SATValRequest, Takedown_Invoice.TKD_pd_Takedown_CP__r.CPL_rb_Opp__r.AccountId);
        try{
        	Takedown_Chain_Execution.procesing_Chain();   
            Takedown_Chain_Execution.procesing_Chain();   
        } catch(exception e){
            System.debug(LoggingLevel.ERROR,'e ' + e);
        }
        Test.stopTest();  
    }
    @istest
    static void Takedown_Chain_Execution_NoOracleSupplier(){        
        Takedown_Invoice__c Takedown_Invoice = [select id, name, TKD_txt_Document_ID__c, TKD_pd_Takedown_CP__c,
                                                TKD_pd_Takedown_CP__r.CPL_rb_Opp__r.AccountId from  Takedown_Invoice__c];
        list<Takedown_Wrapper_SATVal_OL_cls.SATValRequest> listTakedown_Wrapper_SATVal = new list<Takedown_Wrapper_SATVal_OL_cls.SATValRequest>();
        Takedown_Wrapper_SATVal_OL_cls.SATValRequest SATValRequest = new Takedown_Wrapper_SATVal_OL_cls.SATValRequest();
        SATValRequest.assetType = 'Transporte (Tractocamiones)';
        SATValRequest.channel = '3';
        SATValRequest.documentId = Takedown_Invoice.TKD_txt_Document_ID__c;
        SATValRequest.mimeTypeXML = 'xml';
        SATValRequest.organizationId = UserInfo.getOrganizationId();
        SATValRequest.ssoId = '100000001';
        SATValRequest.takedownId = Takedown_Invoice.TKD_pd_Takedown_CP__c;
        MultiStaticResourceCalloutMock multimock = new MultiStaticResourceCalloutMock();
        multimock.setStaticResource('https://apps.engeniumcapital.com/getToken','Mock_Data_WS_OL_getToken');
        multimock.setStaticResource('https://apps.engeniumcapital.com/SATValidationOpenLegacy','Mock_Data_WS_OL_SATValidationOpenLegacy');
        multimock.setStaticResource('https://apps.engeniumcapital.com/FindAssetsByDocument','Mock_Data_WS_OL_FindAssetsByTakedown');
        multimock.setStaticResource('https://apps.engeniumcapital.com/FindAssetsByTakedown','Mock_Data_WS_OL_FindAssetsByTakedown');
        multimock.setStaticResource('https://apps.engeniumcapital.com/knowSuppliers','Mock_Data_WS_KnowSuppliersNoOracleSupplier');
        
        //multimock.setStaticResource('http://api.example.com/contacts', 'jsonContacts');
        multimock.setStatusCode(200);
        multimock.setHeader('Content-Type', 'application/json');
    
        // Set the mock callout mode
        Test.setMock(HttpCalloutMock.class, multimock);
    

        Test.startTest();
        listTakedown_Wrapper_SATVal.add(SATValRequest);
        Takedown_Chain_Execution_cls Takedown_Chain_Execution = new Takedown_Chain_Execution_cls(SATValRequest, Takedown_Invoice.TKD_pd_Takedown_CP__r.CPL_rb_Opp__r.AccountId);
        try{
        	Takedown_Chain_Execution.procesing_Chain();   
            Takedown_Chain_Execution.procesing_Chain();   
        } catch(exception e){
            System.debug(LoggingLevel.ERROR,'e ' + e);
        }
        Test.stopTest();  
    }
    @istest
    static void Takedown_Chain_Execution_BadResponse(){        
        Takedown_Invoice__c Takedown_Invoice = [select id, name, TKD_txt_Document_ID__c, TKD_pd_Takedown_CP__c,
                                                TKD_pd_Takedown_CP__r.CPL_rb_Opp__r.AccountId from  Takedown_Invoice__c];
        list<Takedown_Wrapper_SATVal_OL_cls.SATValRequest> listTakedown_Wrapper_SATVal = new list<Takedown_Wrapper_SATVal_OL_cls.SATValRequest>();
        Takedown_Wrapper_SATVal_OL_cls.SATValRequest SATValRequest = new Takedown_Wrapper_SATVal_OL_cls.SATValRequest();
        SATValRequest.assetType = 'Transporte (Tractocamiones)';
        SATValRequest.channel = '3';
        SATValRequest.documentId = Takedown_Invoice.TKD_txt_Document_ID__c;
        SATValRequest.mimeTypeXML = 'xml';
        SATValRequest.organizationId = UserInfo.getOrganizationId();
        SATValRequest.ssoId = '100000001';
        SATValRequest.takedownId = Takedown_Invoice.TKD_pd_Takedown_CP__c;
        MultiStaticResourceCalloutMock multimock = new MultiStaticResourceCalloutMock();
        multimock.setStaticResource('https://apps.engeniumcapital.com/getToken','Mock_Data_WS_OL_getToken');
        multimock.setStaticResource('https://apps.engeniumcapital.com/SATValidationOpenLegacy','Mock_Data_WS_OL_SATValidationOpenLegacy');
        multimock.setStaticResource('https://apps.engeniumcapital.com/FindAssetsByDocument','Mock_Data_WS_OL_FindAssetsByTakedown');
        multimock.setStaticResource('https://apps.engeniumcapital.com/FindAssetsByTakedown','Mock_Data_WS_OL_FindAssetsByTakedown');
        multimock.setStaticResource('https://apps.engeniumcapital.com/knowSuppliers','Mock_Data_WS_KnowSuppliers');
        //multimock.setStaticResource('http://api.example.com/contacts', 'jsonContacts');
        multimock.setStatusCode(404);
        multimock.setHeader('Content-Type', 'application/json');
    
        // Set the mock callout mode
        Test.setMock(HttpCalloutMock.class, multimock);
    

        Test.startTest();
        listTakedown_Wrapper_SATVal.add(SATValRequest);
        Takedown_Chain_Execution_cls Takedown_Chain_Execution = new Takedown_Chain_Execution_cls(SATValRequest, Takedown_Invoice.TKD_pd_Takedown_CP__r.CPL_rb_Opp__r.AccountId);
        try{
        	Takedown_Chain_Execution.procesing_Chain();           
        } catch(exception e){
            System.debug(LoggingLevel.ERROR,'e ' + e);
        }
        Test.stopTest();  
    }

}