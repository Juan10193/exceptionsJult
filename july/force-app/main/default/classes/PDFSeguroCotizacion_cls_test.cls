@IsTest
public class PDFSeguroCotizacion_cls_test {
    
    static testMethod void createdPDF() {    
        Account testAcct = new Account (Name= 'My Test Account', BillingState= 'Puebla', BillingStreet= 'Example', BillingCountry = 'México', BillingPostalCode = '98760');
     	insert testAcct;

    	Opportunity oppt = new Opportunity(Name ='New mAWS Deal',
                            				AccountID = testAcct.ID,
                            				StageName = 'New',
                            				Amount = 3000,
                            				CloseDate = System.today());

   		insert oppt;
        
        Cotizacion_seguro__c example = new Cotizacion_seguro__c(QS_Id_Quote__c = 1,
			QS_Clave_Bien_Riesgo__c = String.valueOf('11'),
			QS_descripcion__c = 'Equipo Electrónico Móvil',
			QS_Suma_Asegurada__c = 500000,
			QS_Periodo_Cotizacion__c = 12,
			QS_Prima_Neta__c = 23,
			QS_Prima_Neta_Total__c = 0,
			QS_Gastos__c = 0,
			QS_Subtotal__c = 0,
			QS_IVA__c = 0,
			QS_Prima_Total__c = 0,
			QS_Prima_Neta_Label__c = '0',
			QS_Prima_Neta_Total_Label__c = '0',
			QS_Gastos_Label__c = '0',
			QS_Subtotal_Label__c = '0',
			QS_IVA_Label__c = '0',
			QS_Prima_Total_Label__c = '0',
            Opportunity__c = oppt.Id);
        
        insert example;
        
        PageReference pageRef = Page.PDFSeguroCotizacion;
		Test.setCurrentPage(pageRef);
        
        pageRef.getParameters().put('Id', oppt.Id);
        ApexPages.StandardController sc = new ApexPages.StandardController(oppt);
        PDFSeguroCotizacion_cls testPDF = new PDFSeguroCotizacion_cls(sc);
    }
}