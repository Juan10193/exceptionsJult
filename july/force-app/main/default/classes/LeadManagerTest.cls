@istest(seealldata=true)
private class LeadManagerTest {
	static testMethod void testPost() {
        String nombre ='PRM';
    	String noCliente = '123456789';
    	String rfc = '1234567891234';
    	String tipoSociedad = '1';
    	String pais = 'MEX';
    	String codigoPostal = '78563';
    	String estado = 'AG';
    	String ciudad = 'México';
    	String municipio = 'Colima';
    	String colonia = 'Av Rosales';
    	String calle = 'Rosales';
    	String numeroExterior = '23';
    	String numeroInterior = '';
    	String datosIndustria = '';
    	Boolean relacionComercialGobierno = true;
    	Boolean bolsaExtranjeraReconocida = false;
    	String oficinasReconocidad = 'Definir';
    	String actividadesComercionales = 'Definir';
    	String moneda = 'USD';
    	Integer broken = 1;
    	Integer programa = 1;
    	Decimal monto = 123456.00;
    	String idContent = '123456789';
    	String link = 'https://example.com';
    	String idOportunidad = '123456789';
    	ID ids = LeadManager.createLead(nombre, noCliente, rfc, tipoSociedad, pais, codigoPostal, estado, ciudad, municipio, colonia, calle, numeroExterior, numeroInterior,
                                           datosIndustria, relacionComercialGobierno, bolsaExtranjeraReconocida, oficinasReconocidad, actividadesComercionales,
                                           moneda, broken, programa, monto, idContent, link, idOportunidad);
        
        System.debug(LoggingLevel.INFO, 'THERE: '+ ids);
        //Database.LeadConvert lc = new database.LeadConvert();
		//lc.setLeadId(ids);
        Lead convertStatus = [SELECT id, Status FROM Lead WHERE Status = 'Converted' LIMIT 1];
	    //lc.setConvertedStatus(convertStatus.MasterLabel);

        //Database.LeadConvertResult lcr = Database.convertLead(lc);
        
        //Request status lead and opportunity
		RestResponse res = new RestResponse();
		RestRequest req = new RestRequest(); 
        req.params.put('id', convertStatus.Id);
        
		req.httpMethod = 'Get';
		req.addHeader('Content-Type', 'application/json');
		req.requestURI = '/services/apexrest/Lead/' ; 
		RestContext.request = req;
		RestContext.response = res;
        List<PrmWrapperLead> results = LeadManager.getLead();

	}
}