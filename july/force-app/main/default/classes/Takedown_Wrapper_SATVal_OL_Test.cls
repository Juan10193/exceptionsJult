@isTest
public class Takedown_Wrapper_SATVal_OL_Test {
    @isTest static void SATValRequest_Test(){
        Takedown_Wrapper_SATVal_OL_cls.SATValRequest Test_1 = new Takedown_Wrapper_SATVal_OL_cls.SATValRequest();
        Test_1.assetType = 'Ejemplo' ;
        Test_1.channel = '1' ;
        Test_1.documentId = 'a40m0000000XcDEAA4' ;
        Test_1.mimeTypeXML = 'xml';
        Test_1.organizationId = '12';
        Test_1.ssoId = 'a40m0000000XcDEAA3' ;
        Test_1.takedownId = 'a40m0000000XcDEAB4' ;
        Test_1.xmlBase64 = '64' ;
    }
    @isTest static void SATValResponse_Test(){
        Takedown_Wrapper_SATVal_OL_cls.SATValResponse Test_2 = new Takedown_Wrapper_SATVal_OL_cls.SATValResponse();
        Takedown_Wrapper_SATVal_OL_cls.ResponseSatVO Test_3 = new Takedown_Wrapper_SATVal_OL_cls.ResponseSatVO();
        Takedown_Wrapper_SATVal_OL_cls.ResponseValidatorVO Test_4 = new Takedown_Wrapper_SATVal_OL_cls.ResponseValidatorVO();
        Takedown_Wrapper_SATVal_OL_cls.ComprobanteVO Test_5 = new Takedown_Wrapper_SATVal_OL_cls.ComprobanteVO();
        Test_2.responseSatVO = Test_3;
        Test_2.responseValidatorVO = Test_4;
        Test_2.comprobanteVO = Test_5;
    }
    @isTest static void ResponseSatVO_Test(){
    Takedown_Wrapper_SATVal_OL_cls.ResponseSatVO Test_3 = new Takedown_Wrapper_SATVal_OL_cls.ResponseSatVO();
        Test_3.statusCode = '32233';
        Test_3.statusDescription = 'Ejemplo Descripción' ;
        Test_3.statusFactura = 'listo' ;
        Test_3.messsage = 'Esto es un mensaje' ;
        Test_3.enableCancelation = 'Si'; 
    }
    @isTest static void ResponseValidatorVO_Test(){
    Takedown_Wrapper_SATVal_OL_cls.ResponseValidatorVO Test_4 = new Takedown_Wrapper_SATVal_OL_cls.ResponseValidatorVO();
        Test_4.code = '123r3442' ;
        Test_4.message = 'Ejemplo de mensaje';
        Test_4.success = 'listo';
    }
    @isTest static void ComprobanteVO_Test(){
        Takedown_Wrapper_SATVal_OL_cls.ComprobanteVO Test_5 = new Takedown_Wrapper_SATVal_OL_cls.ComprobanteVO();
        Takedown_Wrapper_SATVal_OL_cls.CfdiRelacionadosVO Test_6 = new Takedown_Wrapper_SATVal_OL_cls.CfdiRelacionadosVO();
        Takedown_Wrapper_SATVal_OL_cls.EmisorVO Test_8 = new Takedown_Wrapper_SATVal_OL_cls.EmisorVO();
        Takedown_Wrapper_SATVal_OL_cls.ReceptorVO Test_9 = new Takedown_Wrapper_SATVal_OL_cls.ReceptorVO();
        Takedown_Wrapper_SATVal_OL_cls.ConceptosVO Test_10= new Takedown_Wrapper_SATVal_OL_cls.ConceptosVO();
        Takedown_Wrapper_SATVal_OL_cls.ImpuestosVO Test_12 = new Takedown_Wrapper_SATVal_OL_cls.ImpuestosVO();
        Takedown_Wrapper_SATVal_OL_cls.ComplementoVO Test_16 = new Takedown_Wrapper_SATVal_OL_cls.ComplementoVO();
        Test_5.schemaLocation = 'Mex' ;
        Test_5.certificado = 'ewqe23' ;
        Test_5.fecha = '3/12/2019';
        Test_5.folio = '122ww1we3' ;
        Test_5.formaPago = 'Tarjeta';
        Test_5.lugarExpedicion = 'E.U.A';
        Test_5.metodoPago = 'Efectivo';
        Test_5.moneda = 'Dolar';
        Test_5.noCertificado = 'rerere34232';
        Test_5.sello = 'Si';
        Test_5.serie = '3';
        Test_5.subTotal = '123444444';
        Test_5.total = '1235635';
        Test_5.tipoCambio = 'Dolarp';
        Test_5.tipoDeComprobante = 'Comprobante Ejemplo';
        Test_5.version = '1.032311232223333333';
        Test_5.cfdiRelacionadosVO = Test_6 ;
        Test_5.emisorVO = Test_8;
        Test_5.receptorVO = Test_9;
        Test_5.conceptosVO = Test_10;
        Test_5.impuestosVO = Test_12;
        Test_5.complementoVO = Test_16;
    }
    @isTest static void CfdiRelacionadosVO_Test(){
    Takedown_Wrapper_SATVal_OL_cls.CfdiRelacionadosVO Test_6 = new Takedown_Wrapper_SATVal_OL_cls.CfdiRelacionadosVO();
        Test_6.tipoRelacion = 'Uno a Muchos';
        Test_6.listCfdiRelacionadoVO = new list <Takedown_Wrapper_SATVal_OL_cls.ListCfdiRelacionadoVO>();
    }
    @isTest static void ListCfdiRelacionadoVO_Test(){
        Takedown_Wrapper_SATVal_OL_cls.ListCfdiRelacionadoVO Test_7 = new Takedown_Wrapper_SATVal_OL_cls.ListCfdiRelacionadoVO();
        Test_7.uuid = 'a40m0000000XcDEAA8';
    }
    @isTest static void EmisorVO_Test(){
    Takedown_Wrapper_SATVal_OL_cls.EmisorVO Test_8 = new Takedown_Wrapper_SATVal_OL_cls.EmisorVO();
        Test_8.nombre = 'Ejemplo' ;
        Test_8.regimenFiscal = 'Otro Ejemplo' ;
        Test_8.rfc = 'fee3tfdffhnfdfewr';
    }
    @isTest static void ReceptorVO_Test(){
    Takedown_Wrapper_SATVal_OL_cls.ReceptorVO Test_9 = new Takedown_Wrapper_SATVal_OL_cls.ReceptorVO();
        Test_9.nombre = 'Otro Ejemplo' ;
        Test_9.rfc = 'advvbrrwqwd23dwdxa';
        Test_9.usoCFDI = 'a40m0000000XcDEAA9';
    }
    @isTest static void ConceptosVO_Test(){
    Takedown_Wrapper_SATVal_OL_cls.ConceptosVO Test_10= new Takedown_Wrapper_SATVal_OL_cls.ConceptosVO();
		Test_10.listConceptoVO = new list <Takedown_Wrapper_SATVal_OL_cls.ListConceptoVO>();
    }
    @isTest static void ListConceptoVO_Test(){
        Takedown_Wrapper_SATVal_OL_cls.ListConceptoVO Test_11 = new Takedown_Wrapper_SATVal_OL_cls.ListConceptoVO();
        Takedown_Wrapper_SATVal_OL_cls.ImpuestosVO Test_12 = new Takedown_Wrapper_SATVal_OL_cls.ImpuestosVO();
        Takedown_Wrapper_SATVal_OL_cls.InformacionAduaneraVO Test_15 = new Takedown_Wrapper_SATVal_OL_cls.InformacionAduaneraVO();
        Test_11.cantidad = '35';
        Test_11.claveProdServ = '23' ;
        Test_11.claveUnidad = '122';
        Test_11.descripcion = 'Prodcuto';
        Test_11.importe = '12';
        Test_11.noIdentificacion = 'nada' ;
        Test_11.unidad ='12';
        Test_11.valorUnitario = '14';
        Test_11.impuestosVO = Test_12 ;
        Test_11.informacionAduaneraVO = Test_15;
    }
    @isTest static void ImpuestosVO_Test(){
        Takedown_Wrapper_SATVal_OL_cls.ImpuestosVO Test_12 = new Takedown_Wrapper_SATVal_OL_cls.ImpuestosVO();
        Takedown_Wrapper_SATVal_OL_cls.TrasladosVO Test_13 = new Takedown_Wrapper_SATVal_OL_cls.TrasladosVO();
        Test_12.totalImpuestosTrasladados = '156' ;
        Test_12.trasladosVO = Test_13;
    }
    @isTest static void TrasladosVO_Test(){
        Takedown_Wrapper_SATVal_OL_cls.TrasladosVO Test_13 = new Takedown_Wrapper_SATVal_OL_cls.TrasladosVO();
        Test_13.listTrasladoVO = new list <Takedown_Wrapper_SATVal_OL_cls.ListTrasladoVO>();
    }
    @isTest static void ListTrasladoVO_Test(){
    	Takedown_Wrapper_SATVal_OL_cls.ListTrasladoVO Test_14 = new Takedown_Wrapper_SATVal_OL_cls.ListTrasladoVO();
        Test_14.base = 'mucho' ;
        Test_14.importe = '123' ;
        Test_14.impuesto = '12' ;
        Test_14.tasaOCuota = '340' ;
        Test_14.tipoFactor = 'Ninguno';
    }
    @isTest static void InformacionAduaneraVO_Test(){
    	Takedown_Wrapper_SATVal_OL_cls.InformacionAduaneraVO Test_15 = new Takedown_Wrapper_SATVal_OL_cls.InformacionAduaneraVO();
		Test_15.numeroPedimento = '1543434';
    }
    @isTest static void ComplementoVO_Test(){
    	Takedown_Wrapper_SATVal_OL_cls.ComplementoVO Test_16 = new Takedown_Wrapper_SATVal_OL_cls.ComplementoVO();
    	Takedown_Wrapper_SATVal_OL_cls.TimbreFiscalDigitalVO Test_17 = new Takedown_Wrapper_SATVal_OL_cls.TimbreFiscalDigitalVO();	
		Test_16.timbreFiscalDigitalVO = Test_17 ;
    }
    @isTest static void TimbreFiscalDigitalVO_Test(){
    	Takedown_Wrapper_SATVal_OL_cls.TimbreFiscalDigitalVO Test_17 = new Takedown_Wrapper_SATVal_OL_cls.TimbreFiscalDigitalVO();		
    	Test_17.schemaLocation ='mex';	
        Test_17.version = '10d44dfgfd';
        Test_17.uuid = 'a40m0000000XcDEAA6';
        Test_17.fechaTimbrado = '12/11/2019';
        Test_17.rfcProvCertif = 'efbbtb543355g6';
        Test_17.selloCFD = 'tby5gf4vb';
        Test_17.noCertificadoSAT = '4tgnyn5445';
        Test_17.selloSAT = '4r4b5g5';
    }
    @isTest static void SATValErrorResponse_Test(){
        Takedown_Wrapper_SATVal_OL_cls.SATValErrorResponse Test_18 = new Takedown_Wrapper_SATVal_OL_cls.SATValErrorResponse();			
        Test_18.timestamp = 2.000123;
        Test_18.status = 23;
        Test_18.error = 'Ejemplo_Error';
    }
}