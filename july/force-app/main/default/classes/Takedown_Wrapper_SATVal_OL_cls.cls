public class Takedown_Wrapper_SATVal_OL_cls {    
    /**Request**/
    public class SATValRequest {
        public string assetType			{get;set;}
        public String channel  			{get;set;} //Posibles valores: 1;2;3  
        public String documentId    	{get;set;} //Posibles valores: idSalesforce
        public String mimeTypeXML  		{get;set;} //Posibles valores: text/xml
        public String organizationId    {get;set;} //Posibles valores: 13
        public String ssoId    			{get;set;} //Posibles valores: 100000001
        public String takedownId        {get;set;} //Posibles valores: idSalesforce
        public String xmlBase64			{get;set;} //Posibles valores: XMLEnBase64
    }
    //public
    /**Response**/
    public class SATValResponse {
        public ResponseSatVO responseSatVO				{get;set;}
        public ResponseValidatorVO responseValidatorVO	{get;set;}
        public ComprobanteVO comprobanteVO				{get;set;}
    }
    public class ResponseSatVO {        
        public String statusCode  			{get;set;} //Posibles valores:
        public String statusDescription    	{get;set;} //Posibles valores: 
        public String statusFactura      	{get;set;} //Posibles valores: //
        public String messsage  			{get;set;} //Posibles valores: //Mostrar
        public String enableCancelation    	{get;set;} //Posibles valores: 
    }
    public class ResponseValidatorVO {        
        public String code  		{get;set;} //Posibles valores:
        public String message    	{get;set;} //Posibles valores: 
        public String success      	{get;set;} //Posibles valores:
    }
    public class ComprobanteVO {        
        public String schemaLocation  					{get;set;} //Posibles valores:
        public String certificado    					{get;set;} //Posibles valores: 
        public String fecha      						{get;set;} //Posibles valores:
        public String folio  							{get;set;} //Posibles valores:
        public String formaPago    						{get;set;} //Posibles valores: 
        public String lugarExpedicion      				{get;set;} //Posibles valores:
        public String metodoPago  						{get;set;} //Posibles valores:
        public String moneda    						{get;set;} //Posibles valores: 
        public String noCertificado      				{get;set;} //Posibles valores:
        public String sello      						{get;set;} //Posibles valores:
        public String serie      						{get;set;} //Posibles valores:
        public String subTotal      					{get;set;} //Posibles valores:
        public String tipoCambio      					{get;set;} //Posibles valores:
        public String tipoDeComprobante     			{get;set;} //Posibles valores:
        public String total      						{get;set;} //Posibles valores:
        public String version      						{get;set;} //Posibles valores:
        public CfdiRelacionadosVO cfdiRelacionadosVO	{get;set;} //Posibles valores:
        public EmisorVO emisorVO						{get;set;} //Posibles valores:
        public ReceptorVO receptorVO					{get;set;} //Posibles valores:
        public ConceptosVO conceptosVO					{get;set;} //Posibles valores:
        public ImpuestosVO impuestosVO					{get;set;} //Posibles valores:
        public ComplementoVO complementoVO				{get;set;} //Posibles valores:
    }
    public class CfdiRelacionadosVO {        
        public String tipoRelacion  								{get;set;} //Posibles valores:
        public List<ListCfdiRelacionadoVO> listCfdiRelacionadoVO    {get;set;} //Posibles valores:
    }
    public class ListCfdiRelacionadoVO {        
        public String uuid		{get;set;} //Posibles valores:
    }    
    public class EmisorVO {        
        public String nombre			{get;set;} //Posibles valores:
        public String regimenFiscal		{get;set;} //Posibles valores:
        public String rfc				{get;set;} //Posibles valores:
    }
    public class ReceptorVO {        
        public String nombre			{get;set;} //Posibles valores:
        public String rfc				{get;set;} //Posibles valores:
        public String usoCFDI			{get;set;} //Posibles valores:
    }
    public class ConceptosVO {        
        public List<ListConceptoVO> listConceptoVO	{get;set;} //Posibles valores:
    }
    public class ListConceptoVO {        
        public String cantidad			{get;set;} //Posibles valores:
        public String claveProdServ		{get;set;} //Posibles valores:
        public String claveUnidad		{get;set;} //Posibles valores:
        public String descripcion		{get;set;} //Posibles valores:
        public String importe			{get;set;} //Posibles valores:
        public String noIdentificacion	{get;set;} //Posibles valores:
        public String unidad			{get;set;} //Posibles valores:
        public String valorUnitario		{get;set;} //Posibles valores:
        public ImpuestosVO impuestosVO	{get;set;} //Posibles valores:
        public InformacionAduaneraVO informacionAduaneraVO	{get;set;} //Posibles valores:
    }
    public class ImpuestosVO {        
        public String totalImpuestosTrasladados		{get;set;} //Posibles valores:
        public TrasladosVO trasladosVO				{get;set;} //Posibles valores:
    }
    public class TrasladosVO {        
        public List<ListTrasladoVO> listTrasladoVO	{get;set;} //Posibles valores:
    }
    public class ListTrasladoVO {        
        public String base			{get;set;} //Posibles valores:
        public String importe		{get;set;} //Posibles valores:
        public String impuesto		{get;set;} //Posibles valores:
        public String tasaOCuota	{get;set;} //Posibles valores:
        public String tipoFactor	{get;set;} //Posibles valores:
    }
    public class InformacionAduaneraVO {        
        public String numeroPedimento	{get;set;} //Posibles valores:
    }
    public class ComplementoVO {        
        public TimbreFiscalDigitalVO timbreFiscalDigitalVO	{get;set;} //Posibles valores:
    }
    public class TimbreFiscalDigitalVO {        
        public String schemaLocation	{get;set;} //Posibles valores:
        public String version			{get;set;} //Posibles valores:
        public String uuid				{get;set;} //Posibles valores:
        public String fechaTimbrado		{get;set;} //Posibles valores:
        public String rfcProvCertif		{get;set;} //Posibles valores:
        public String selloCFD			{get;set;} //Posibles valores:
        public String noCertificadoSAT	{get;set;} //Posibles valores:
        public String selloSAT			{get;set;} //Posibles valores:
    }
    /**Response**/
    public class SATValErrorResponse {
        public double timestamp			{get;set;}
        public Integer status			{get;set;}
        public String error				{get;set;} 
    }
    
    
    

}