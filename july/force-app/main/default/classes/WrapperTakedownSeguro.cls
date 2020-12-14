global class WrapperTakedownSeguro {
    public class seguroInformacion {
        public String producto {get; set;}
        public String plazo {get; set;}
        public String moneda {get; set;}
        public String idOpportunity {get; set;}
        public String razonSocial {get; set;}
        public String nombre {get; set;}
        public List<activoDetail> activos {get; set;}
    }
    
    public class activoDetail {
        public String id {get; set;}
        public String Name {get; set;}
        public String cobertura {get; set;}
        public Decimal sumaAsegurada {get; set;}
        public Decimal primaNeta {get; set;}
        public String primaNetaLabel {get; set;}
        public Decimal iva {get; set;}
        public String ivaLabel {get; set;}
        public Decimal primaTotal {get; set;}
        public String primaTotalLabel {get; set;}
        public Decimal primaNetaTotal {get; set;}
        public String primaNetaTotalLabel {get; set;}
        public Decimal gastos {get; set;}
        public String gastosLabel {get; set;}
    }
}