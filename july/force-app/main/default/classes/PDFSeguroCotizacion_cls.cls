public class PDFSeguroCotizacion_cls {
    public List<Cotizacion_seguro__c> getSeguroCotizacion {set; get;}
    public list<Cotizacion_seguro__c> getInfoSeguro {set; get;}
    public WrapperTotal getInfoTotal {get; set;}
    
    public PDFSeguroCotizacion_cls(ApexPages.StandardController controller) {
        String idCotizacion = controller.getId();
        getSeguroCotizacion(idCotizacion);
        getInfoSeguro(idCotizacion);
        getSeguroCotizacionTotal(idCotizacion);
    }
    
    public void getSeguroCotizacion(String idOpportunity) {
        List<Cotizacion_seguro__c> allSeguroCotizacion = new List<Cotizacion_seguro__c>();
		for(Cotizacion_seguro__c flag : [SELECT QS_descripcion__c, QS_Suma_Asegurada__c, QS_Prima_Neta_Label__c, QS_Gastos_Label__c, QS_IVA_Label__c, QS_Prima_Neta_Total_Label__c, QS_Prima_Total_Label__c, CreatedDate, QS_Prima_Neta__c, QS_Gastos__c, QS_IVA__c, QS_Prima_Total__c FROM Cotizacion_seguro__c WHERE Opportunity__c =: idOpportunity ORDER BY CreatedDate DESC]) {
        	allSeguroCotizacion.add(flag);
        }
        getSeguroCotizacion = allSeguroCotizacion;
    }
    
    public void getInfoSeguro(String idOpportunity) {
        List<Cotizacion_seguro__c> infoSeguro = new List<Cotizacion_seguro__c>();
		for(Cotizacion_seguro__c flag : [SELECT createdDate, QS_Periodo_Cotizacion__c, owner.Name, QS_Razon_social__c FROM Cotizacion_seguro__c WHERE Opportunity__c =: idOpportunity ORDER BY CreatedDate DESC LIMIT 1]) {
        	infoSeguro.add(flag);
        }
        getInfoSeguro = infoSeguro;
    }
    
    public void getSeguroCotizacionTotal (String idOpportunity) {
        Decimal primaNeta = 0;
        Decimal gastosExp = 0;
        Decimal iva = 0;
        Decimal total = 0;
		for(Cotizacion_seguro__c flag : [SELECT QS_descripcion__c, QS_Suma_Asegurada__c, CurrencyIsoCode, QS_Prima_Neta_Label__c, QS_Gastos_Label__c, QS_IVA_Label__c, QS_Prima_Neta_Total_Label__c, QS_Prima_Total_Label__c, CreatedDate, QS_Prima_Neta__c, QS_Gastos__c, QS_IVA__c, QS_Prima_Total__c, QS_Periodo_Cotizacion__c, QS_Razon_social__c FROM Cotizacion_seguro__c WHERE Opportunity__c =: idOpportunity ORDER BY CreatedDate DESC]) {
        	primaNeta += flag.QS_Prima_Neta__c;
            gastosExp += flag.QS_Gastos__c;
            iva += flag.QS_IVA__c; 
            total += flag.QS_Prima_Total__c;
        }
        getInfoTotal = new WrapperTotal(primaNeta, gastosExp, iva, total);
    }
    
    public class WrapperTotal {
        public Decimal primaNeta {get; set;}
        public Decimal gastosExp {get; set;}
        public Decimal iva {get; set;}
        public Decimal total {get; set;}
        
        public WrapperTotal(Decimal primaNeta, Decimal gastosExp, Decimal iva, Decimal total) {
            this.primaNeta = primaNeta;
        	this.gastosExp = gastosExp;
            this.iva = iva;
            this.total = total;
        }
    }
}