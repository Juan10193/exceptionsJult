public class WrapperQuoteSeguros_cls {
	public class QuoteJson {
		public List<Data> data;
	}

	public class Status {
		public String code;
		public String message;
		public String detail;
	}

	public QuoteJson quote;
	public Status status;

	public class Data {
        @AuraEnabled public Integer id;
		//public Object idCotizacion;
		@AuraEnabled public Integer idBienRiesgo;
		@AuraEnabled public String descripcion;
		@AuraEnabled public String sumaAsegurada;
		@AuraEnabled public Integer periodoCotizacion;
		@AuraEnabled public String primaNeta;
		@AuraEnabled public String primaNetaTotal;
		@AuraEnabled public String gastos;
		@AuraEnabled public String subtotal;
		@AuraEnabled public String iva;
		@AuraEnabled public String primaTotal;
		@AuraEnabled public String primaNetaLabel;
		@AuraEnabled public String primaNetaTotalLabel;
		@AuraEnabled public String gastosLabel;
		@AuraEnabled public String subtotalLabel;
		@AuraEnabled public String ivaLabel;
		@AuraEnabled public String primaTotalLabel;
	}
    
    public static WrapperQuoteSeguros_cls parse(String json) {
        return (WrapperQuoteSeguros_cls) System.JSON.deserialize(json, WrapperQuoteSeguros_cls.class);
    }
}