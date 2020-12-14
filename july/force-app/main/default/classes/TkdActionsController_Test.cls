@isTest
public class TkdActionsController_Test {
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
        TkdActionsController.processApproval(takedown.Id, action, comment);
    }
    @isTest
    public static void handleVisibilityBtns(){
        string action = 'Actualiza';
        string comment = 'Tests';
        list<EIV_Parameter__c> parameters = Test.loadData(EIV_Parameter__c.sobjectType, 'parametrosTest');
        Takedowns_Contingency_plan__c takedown = Data_Factory_Takedown_Test.createTakedown('OPERFIN-FIJA','CDMX', 'CDMX123456');
        TkdActionsController.handleVisibilityBtns(takedown.Id);
    }
    @isTest
    public static void submitForApproval(){
        list<EIV_Parameter__c> parameters = Test.loadData(EIV_Parameter__c.sobjectType, 'parametrosTest');
        Takedowns_Contingency_plan__c takedown = Data_Factory_Takedown_Test.createTakedownNowkoppForApproval('OPERFIN-FIJA','CDMX', 'CDMX123456');
        TkdActionsController.submitForApproval(takedown.Id);
        TkdActionsController.handleVisibilityBtns(takedown.Id);
    }
    @isTest
    public static void getFieldsName(){
        list<EIV_Parameter__c> parameters = Test.loadData(EIV_Parameter__c.sobjectType, 'parametrosTest');
        Takedowns_Contingency_plan__c takedown = Data_Factory_Takedown_Test.createTakedown('OPERFIN-FIJA','CDMX', 'CDMX123456');
        string td = 'Takedowns_Contingency_plan__c';
        TkdActionsController.getFieldsName(td);
    }
    @isTest
    public static void processRequestRemoved(){
        string action = 'Removed';
        string comment = getComments();
        list<EIV_Parameter__c> parameters = Test.loadData(EIV_Parameter__c.sobjectType, 'parametrosTest');
        Takedowns_Contingency_plan__c takedown = Data_Factory_Takedown_Test.createTakedown('OPERFIN-FIJA','CDMX', 'CDMX123456');
		takedown.CPL_ls_Stage__c = 'Tollgate 1';
        update takedown;        
        TkdActionsController.processApproval(takedown.Id, action, comment);
    }
    @isTest
    public static void processRequestApprove(){
        string action = 'Approve';
        string comment = getComments();
        list<EIV_Parameter__c> parameters = Test.loadData(EIV_Parameter__c.sobjectType, 'parametrosTest');
        Takedowns_Contingency_plan__c takedown = Data_Factory_Takedown_Test.createTakedown('OPERFIN-FIJA','CDMX', 'CDMX123456');
		takedown.CPL_ls_Stage__c = 'Tollgate 1';
        update takedown;        
        TkdActionsController.processApproval(takedown.Id, action, comment);
    }
    @isTest
    public static void processRequestReject(){
        
                Opportunity opp = Data_Factory_Opportunity_Test.createNewOpportunityTypeWK();
       TBO021_Takedowns_forecast__c forecast = Data_Factory_EasyForecast_Test.createForecast(opp.Id);
       IST__SuperTRUMP_Template__c template = TestDataFactory_tst.createSTPricingTemplate();
       IST__SuperTRUMP_Pricing_Quote__c pq = TestDataFactory_tst.createSTPricingQuote(opp,template);
       Test.startTest();
       Entity_CP__c entitycp = Data_Factory_EntityCp.createEntityCP('CDMX', 'CDMX123456' );
       Takedowns_Contingency_plan__c takedown = new Takedowns_Contingency_plan__c();
       takedown.CPL_ls_Stage__c = 'New';
       takedown.CPL_rb_Entity_Name_CP__c =entitycp.Id;
       takedown.Takedowns_forecast__c = forecast.Id;
       takedown.Annex_Pricing_SuperTrump__c = pq.Id;
       takedown.TKD_ls_takedown_stage__c ='Converted';
       takedown.CPL_ls_Deal_Category__c ='Refi';
       takedown.Financing_Needs__c ='CapEx Lines';
       takedown.CPL_rb_Opp__c = opp.Id;
       takedown.TDAmount__c =1.00;
       takedown.Contract_Annex_Number__c= '13213124';
       takedown.Invoice_Exchange_Rate__c =19.147400;
       takedown.CPL_ls_Operation_Unit__c ='	UO_397 HOLDING';
       takedown.CLI_lsInvoice_Currency__c ='MXN';
       takedown.CPL_ls_Product__c ='OPERFIN-FIJA';
       insert takedown;
        
        string action = 'Reject';
        string comment = TkdActionsController_Test.getComments();
        list<EIV_Parameter__c> parameters = Test.loadData(EIV_Parameter__c.sobjectType, 'parametrosTest');
        Id devRecordTypeId = Schema.SObjectType.Takedowns_Contingency_plan__c.getRecordTypeInfosByName().get('Takedown').getRecordTypeId();


        //Takedowns_Contingency_plan__c takedown = Data_Factory_Takedown_Test.createTakedown('OPERFIN-FIJA','CDMX', 'CDMX123456');
		
        takedown.RecordTypeId = devRecordTypeId;
        update takedown; 
        takedown.CPL_ls_Stage__c = 'Tollgate 1';
        update takedown; 
		
        id userId = UserInfo.getUserId();

        // Create an approval request for the account
        Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
        req1.setComments('Submitting request for approval.');
        req1.setObjectId(takedown.id);

        // Submit on behalf of a specific submitter
        req1.setSubmitterId(userId); 

        // Submit the record to specific process and skip the criteria evaluation
        req1.setProcessDefinitionNameOrId('TKD_Tollgate_1');
        req1.setSkipEntryCriteria(true);

        // Submit the approval request for the account
        Approval.ProcessResult result = Approval.process(req1);
        test.stopTest();
        TkdActionsController.processApproval(takedown.Id, action, comment);
    }
    @isTest
    public static string getComments(){
        return  '==============Comments=============='
            + 'Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test'
            + '===================================='
            + 'Tipo: Documentos Faltantes Subtipo: Apéndice A (PP)'
            + 'Tipo: Documentos Faltantes Subtipo: Contrato de Prenda'
            + 'Tipo: Documentos Faltantes Subtipo: Pricing PRM'
            + 'Tipo: Documentos Faltantes Subtipo: Contrato Maestro original (Release)'
            + 'Tipo: Documentos Faltantes Subtipo: Contrato Maestro Firmado'
            + 'Tipo: Documentos Faltantes Subtipo: Acuse de File Room'
            + 'Tipo: Documentos Faltantes Subtipo: Convenio Modificatorio (Contrato, Prenda, Anexo, etc.)'
            + 'Tipo: Documentos Faltantes Subtipo: Solicitud de Fondos'
            + 'Tipo: Documentos Faltantes Subtipo: Pricing Aprobación'
            + 'Tipo: Documentos Faltantes Subtipo: Avalúo'
            + 'Tipo: Documentos Faltantes Subtipo: VoBo Rapid Tag / Gestorías'
            + 'Tipo: Documentos Faltantes Subtipo: Comprobante de Pago SD'
            + 'Tipo: Documentos Faltantes Subtipo: Apéndice B Firmado (PP)'
            + 'Tipo: Documentos Faltantes Subtipo: Contrato de Crédito'
            + 'Tipo: Documentos Faltantes Subtipo: RUG para Activos Mayores a 6 meses'
            + 'Tipo: Documentos Faltantes Subtipo: Cálculo TV'
            + 'Tipo: Documentos Faltantes Subtipo: WUP / Closing Memo'
            + 'Tipo: Documentos Faltantes Subtipo: Anexo Firmado'
            + 'Tipo: Documentos Faltantes Subtipo: Legal Assessment'
            + 'Tipo: Documentos Faltantes Subtipo: VoBo Importaciones'
            + 'Tipo: Documentos Faltantes Subtipo: Prebook'
            + 'Tipo: Documentos Faltantes Subtipo: Pagaré Firmado'
            + 'Tipo: Documentos Faltantes Subtipo: Identificación Representante Legal'
            + 'Tipo: Documentos Faltantes Subtipo: Pagaré'
            + 'Tipo: Documentos Faltantes Subtipo: Estado de Cuenta de Proveedor'
            + 'Tipo: Documentos Faltantes Subtipo: VoBo Collections'
            + 'Tipo: Documentos Faltantes Subtipo: Contrato de Crédito Firmado'
            + 'Tipo: Documentos Faltantes Subtipo: Pedimento'
            + 'Tipo: Documentos Faltantes Subtipo: Apendice 1 Anexo A (Fleet)'
            + 'Tipo: Documentos Faltantes Subtipo: Solicitud de Disposición Firmada'
            + 'Tipo: Documentos Faltantes Subtipo: VoBo Referral Fee'
            + 'Tipo: Documentos Faltantes Subtipo: Carta de Instrucción Firmada'
            + 'Tipo: Documentos Faltantes Subtipo: Orden de Requisición del Vehículo, Anexo A (Fleet)'
            + 'Tipo: Documentos Faltantes Subtipo: Facturas Originales (Release)'
            + 'Tipo: Documentos Faltantes Subtipo: RUG S&LB'
            + 'Tipo: Documentos Faltantes Subtipo: Eval'
            + 'Tipo: Documentos Faltantes Subtipo: Contrato Maestro'
            + 'Tipo: Documentos Faltantes Subtipo: EFA'
            + 'Tipo: Documentos Faltantes Subtipo: Carta de Instrucción'
            + 'Tipo: Documentos Faltantes Subtipo: Notas de Crédito'
            + 'Tipo: Documentos Faltantes Subtipo: Land Lord Waiver / Hipoteca'
            + 'Tipo: Documentos Faltantes Subtipo: Proveedor (SITE)'
            + 'Tipo: Documentos Faltantes Subtipo: Facturas'
            + 'Tipo: Documentos Faltantes Subtipo: Apéndice B (PP)'
            + 'Tipo: Documentos Faltantes Subtipo: Pricing Histórico (PP)'
            + 'Tipo: Documentos Faltantes Subtipo: Comprobante de Pago Advanced Payment'
            + 'Tipo: Documentos Faltantes Subtipo: Anexo'
            + 'Tipo: Documentos Faltantes Subtipo: Pricing Summary'
            + 'Tipo: Documentos Faltantes Subtipo: VoBo Riesgo Contrato Maestro'
            + 'Tipo: Documentos Faltantes Subtipo: Cotización EOL (Release)'
            + 'Tipo: Documentos Faltantes Subtipo: Solicitud de Disposición'
            + 'Tipo: Documentos Faltantes Subtipo: Pagaré Original (Release)'
            + 'Tipo: Documentos Faltantes Subtipo: Facturas Origen (S&LB)'
            + 'Tipo: Documentos Faltantes Subtipo: Contrato de Prenda Firmado'
            + 'Tipo: Documentos Faltantes Subtipo: Formato de Entrega Anexo B (Fleet)'
            + 'Tipo: Documentos Faltantes Subtipo: QesQ'
            + 'Tipo: Documentos Faltantes Subtipo: Carta Domicialización'
            + 'Tipo: Documentos Faltantes Subtipo: Otro'
            + 'Tipo: Documentos Faltantes Subtipo: Put / Call'
            + 'Tipo: Documentos Faltantes Subtipo: Convenio Modificatorio Firmado'
            + 'Tipo: Documentos Faltantes Subtipo: Condiciones Comerciales del Arrendamiento Anexo C (Fleet)'
            + 'Tipo: Documentos Faltantes Subtipo: Anexo Original (Release)'
            + 'Tipo: Pricing Subtipo: EBO'
            + 'Tipo: Pricing Subtipo: Split Trac'
            + 'Tipo: Pricing Subtipo: Seguro - Fecha Rebate'
            + 'Tipo: Pricing Subtipo: Rentas'
            + 'Tipo: Pricing Subtipo: Monto'
            + 'Tipo: Pricing Subtipo: Evergreen'
            + 'Tipo: Pricing Subtipo: Blind Descount'
            + 'Tipo: Pricing Subtipo: Expense Fee'
            + 'Tipo: Pricing Subtipo: Valor Residual'
            + 'Tipo: Pricing Subtipo: Book Yield'
            + 'Tipo: Pricing Subtipo: Frecuency'
            + 'Tipo: Pricing Subtipo: Seguro - Monto Rebate'
            + 'Tipo: Pricing Subtipo: Activos - Fecha (Delivery, Funding, Depreciation)'
            + 'Tipo: Pricing Subtipo: Advance Payment'
            + 'Tipo: Pricing Subtipo: Seguro - Otro'
            + 'Tipo: Pricing Subtipo: Seguro - Anualidad Expense'
            + 'Tipo: Pricing Subtipo: Income Fee'
            + 'Tipo: Pricing Subtipo: Renta Interina'
            + 'Tipo: Pricing Subtipo: Seguro - Anualidad Income'
            + 'Tipo: Pricing Subtipo: Arrear / Advance'
            + 'Tipo: Pricing Subtipo: Term in Months'
            + 'Tipo: Pricing Subtipo: Depósito de Seguridad'
            + 'Tipo: Pricing Subtipo: Seguro - Gastos Relacionados a la Emisión'
            + 'Tipo: Pricing Subtipo: Money Cost'
            + 'Tipo: Pricing Subtipo: Tasa'
            + 'Tipo: Pricing Subtipo: Moneda'
            + 'Tipo: Pricing Subtipo: Template Vigente'
            + 'Tipo: Pricing Subtipo: Seguro - Interina'
            + 'Tipo: Pricing Subtipo: Seguro - Issue Cost'
            + 'Tipo: Pricing Subtipo: Otro'
            + 'Tipo: Pricing Subtipo: Opening Fee'
            + 'Tipo: Pricing Subtipo: Seguro - Tasa'
            + 'Tipo: Pricing Subtipo: Purchase Option'
            + 'Tipo: Pricing Subtipo: Producto'
            + 'Tipo: Pricing Subtipo: Seguro - Fechas y Periodicidad a la renta'
            + 'Tipo: Pricing Subtipo: Balloon Payment'
            + 'Tipo: Pricing Subtipo: Seguro - Fechas y Periodicidad a la renta'
            + 'Tipo: Contrato de Crédito Subtipo: Firmantes'
            + 'Tipo: Contrato de Crédito Subtipo: Monto'
            + 'Tipo: Contrato de Crédito Subtipo: Proemio'
            + 'Tipo: Contrato de Crédito Subtipo: Otro'
            + 'Tipo: Contrato de Crédito Subtipo: Términos Económicos'
            + 'Tipo: Contrato de Crédito Subtipo: Covenants / Condiciones Especiales'
            + 'Tipo: Contrato de Crédito Subtipo: Fecha'
            + 'Tipo: Anexo Subtipo: Tabla de valores de Terminación'
            + 'Tipo: Anexo Subtipo: Condiciones de Retorno'
            + 'Tipo: Anexo Subtipo: Fleet'
            + 'Tipo: Anexo Subtipo: Claúsulas'
            + 'Tipo: Anexo Subtipo: Descripción del Equipo / Facturas'
            + 'Tipo: Anexo Subtipo: Proemio'
            + 'Tipo: Anexo Subtipo: Otro'
            + 'Tipo: Anexo Subtipo: Tipo de Cambio'
            + 'Tipo: Anexo Subtipo: Términos y Condiciones Financieros'
            + 'Tipo: Anexo Subtipo: Pago Progresivo'
            + 'Tipo: Anexo Subtipo: Firmas'
            + 'Tipo: Closing Memo / WUP Subtipo: Otro'
            + 'Tipo: Carta de Instrucción / Solicitud de Disposición Subtipo: Número de Anexo'
            + 'Tipo: Carta de Instrucción / Solicitud de Disposición Subtipo: Fecha de Firma'
            + 'Tipo: Carta de Instrucción / Solicitud de Disposición Subtipo: Monto Fondeo Número'
            + 'Tipo: Carta de Instrucción / Solicitud de Disposición Subtipo: Firmante'
            + 'Tipo: Carta de Instrucción / Solicitud de Disposición Subtipo: Número de Contrato Maestro'
            + 'Tipo: Carta de Instrucción / Solicitud de Disposición Subtipo: Fecha de contrato Maestro'
            + 'Tipo: Carta de Instrucción / Solicitud de Disposición Subtipo: Banco'
            + 'Tipo: Carta de Instrucción / Solicitud de Disposición Subtipo: Fecha de Anexo';
    }
}