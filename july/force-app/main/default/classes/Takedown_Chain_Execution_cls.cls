public class Takedown_Chain_Execution_cls { 
     
    public Takedown_Wrapper_SATVal_OL_cls.SATValRequest SATValRequest;
    public Takedown_Wrapper_SATVal_OL_cls.SATValResponse SATValResponse;
    public Takedown_Wrapper_FindAssets_OL_cls.FindAssetsResponse findAssetsResponse;
    public String jsonRequest {get;set;}
    public id AccountID; 
    public id takedownID;
    
    public Takedown_Chain_Execution_cls(Takedown_Wrapper_SATVal_OL_cls.SATValRequest SATValRequest, id AccountID){
        this.AccountID = AccountID;
        this.SATValRequest = SATValRequest;
        this.takedownID = SATValRequest.takedownId;
        this.jsonRequest = '';        
    }
    public void procesing_Chain(){
        System.debug(LoggingLevel.INFO, 'Inicia procesing_Chain con el document id ' + this.SATValRequest.documentId);
        list<Supplier__c> listSupplier = new list<Supplier__c>();
        //Realiza la consulta del token el cual será necesario para las operaciones de consulta de:
        //1.- sat y engen validation 
        //2.- desglose de activos
        String token = execute_Token();

        if(String.isNotEmpty(token)){
            //utiliza el token para consultar las dos operaciones antes mencionadas 
            //Si la validación del sat manda error, no se podrá consultar la operación de desglose de activos
            execute_SATVal(token);              
            if(this.SATValResponse != null){
                //si la validación del sat y engen capital fue exitosa, se generarán objetos de invocies con el detalle del xml que se envió durante la validación
                //Este detalle servirá para realizar la tercera operación de consulta, la cual consiste en obtener información de los suppliers en base 
                //a la información del emisor (RFC y Nombre del emisor)
                String rfc = this.SATValResponse.comprobanteVO == null ? '' : this.SATValResponse.comprobanteVO.emisorVO == null ? '' : this.SATValResponse.comprobanteVO.emisorVO.rfc;
                String name = this.SATValResponse.comprobanteVO == null ? '' : this.SATValResponse.comprobanteVO.emisorVO == null ? '' : this.SATValResponse.comprobanteVO.emisorVO.nombre;
                if(String.isNotEmpty(rfc) || String.isNotEmpty(name)){
                	Takedown_Wrapper_DetSearchKnownSuppliers.responseDetSearchKnownSupplier responseDetSearchKnownSupplier = Takedown_Callout_SupplierInCA.detKnownSupplierSearch(rfc, name);    
                    if(responseDetSearchKnownSupplier.suppliers != null){
                    	listSupplier = Takedown_Response_Op_Supplier.upsertSupplier(responseDetSearchKnownSupplier, this.SATValRequest.takedownId);        
                    } else {
                        Supplier__c newSupplier = Takedown_Response_Op_Supplier.insertNonOracleSuppleir(name, rfc, this.SATValRequest.takedownId);
                        if(newSupplier != null){
                            listSupplier.add(newSupplier);   
                        }
                    }
                }            	
            }
        } 
        // la operación de ejecución realizará todas las insersiones necesarias de las 3 operaciones antes descritas
        execute_Response_Operation(listSupplier);
        System.debug(LoggingLevel.INFO, 'Termina procesing_Chain con el document id ' + this.SATValRequest.documentId);        
    }
    public String execute_Token(){
        System.debug(LoggingLevel.INFO, 'Inicia execute_Token');  
        HttpResponse httpResponse;// = new HttpResponse;
        Takedown_Wrapper_Token_OL_cls.TokenResponse TokenResponse = new Takedown_Wrapper_Token_OL_cls.TokenResponse();
        String token;
        	httpResponse = Takedown_WS_OpenLegacy_cls.getToken();    
        
        if (httpResponse.getStatusCode() == 200) {             
            TokenResponse = (Takedown_Wrapper_Token_OL_cls.TokenResponse)JSON.deserialize(httpResponse.getBody(), Takedown_Wrapper_Token_OL_cls.TokenResponse.class); // Jsonstring is the above JSON
			token = TokenResponse.access_token;
        } else{
            System.debug(LoggingLevel.ERROR,'StatusCode: ' + httpResponse.getStatusCode());
            System.debug(LoggingLevel.ERROR,'Body: ' + httpResponse.getBody());
            this.SATValResponse = setErrorResponse(httpResponse);
            token = null;
        }
        System.debug(LoggingLevel.INFO, 'Termina execute_Token');
        return token;
    } 
    public void execute_SATVal(String token){ 
        System.debug(LoggingLevel.INFO, 'Inicia execute_SATVal');
        this.jsonRequest = System.JSON.serialize(SATValRequest);
		HttpResponse httpResponse = Takedown_WS_OpenLegacy_cls.SATValidationOpenLegacy(token, this.jsonRequest, this.SATValRequest.documentId);
        if (httpResponse.getStatusCode() == 200) {
            this.SATValResponse = (Takedown_Wrapper_SATVal_OL_cls.SATValResponse)JSON.deserialize(httpResponse.getBody(), Takedown_Wrapper_SATVal_OL_cls.SATValResponse.class); // Jsonstring is the above JSON
        	System.debug('this.SATValResponse response.getBody() ' + httpResponse.getBody());
            execute_Find_Assets(token);
        } else{            
            this.SATValResponse = setErrorResponse(httpResponse);
            System.debug(LoggingLevel.ERROR,'StatusCode: ' + httpResponse.getStatusCode());
            System.debug(LoggingLevel.ERROR,'Body: ' + httpResponse.getBody());
        }
        System.debug(LoggingLevel.INFO, 'Termina execute_SATVal');
    }
    public void execute_Find_Assets(string token){
        System.debug(LoggingLevel.INFO, 'Inicia execute_Find_Assets');
        Takedown_Wrapper_FindAssets_OL_cls.FindAssetsRequestByDocument findAssetsRequestByDocument = new Takedown_Wrapper_FindAssets_OL_cls.FindAssetsRequestByDocument();
        findAssetsRequestByDocument.documentId = SATValRequest.documentId;
        jsonRequest = System.JSON.serialize(findAssetsRequestByDocument);
        
        HttpResponse httpResponse = Takedown_WS_OpenLegacy_cls.FindAssetsByDocument(token, jsonRequest);
        system.debug('httpResponse.getStatusCode() ');
        if (httpResponse.getStatusCode() == 200) {
            this.findAssetsResponse = (Takedown_Wrapper_FindAssets_OL_cls.FindAssetsResponse)JSON.deserialize(httpResponse.getBody(), Takedown_Wrapper_FindAssets_OL_cls.FindAssetsResponse.class); // Jsonstring is the above JSON
        	System.debug('response.getBody() ' + httpResponse.getBody());
        } else{
            System.debug(LoggingLevel.ERROR,'StatusCode: ' + httpResponse.getStatusCode());
            System.debug(LoggingLevel.ERROR,'Body: ' + httpResponse.getBody());
        }
		System.debug(LoggingLevel.INFO, 'Termina execute_Find_Assets');        
    }
    public void execute_Response_Operation(list<Supplier__c> listSupplier){
        System.debug(LoggingLevel.INFO, 'Inicia execute_Response_Operation');
    	/**Inicia operaciones de inserción y actualización*/
        Takedown_Response_Operation_cls response_Operation = new Takedown_Response_Operation_cls(this.AccountID); 
        if(this.SATValResponse != null){
            System.debug('Inicia Work_Response_ValidateData ' + this.SATValResponse);
            response_Operation.Work_Response_ValidateData(this.SATValResponse,this.SATValRequest.documentId,listSupplier,this.takedownID);
        }
        if(this.findAssetsResponse != null){
            System.debug('Inicia findAssetsResponse ' + this.findAssetsResponse);
            string Takedown_Invoice_CurrencyIsoCode = SATValResponse.comprobanteVO == null ? '' : SATValResponse.comprobanteVO.moneda;
            response_Operation.Work_Response_FindAssets(this.findAssetsResponse, Takedown_Invoice_CurrencyIsoCode);
        }    
        System.debug(LoggingLevel.INFO, 'Termina execute_Response_Operation');
    }
    public static Takedown_Wrapper_SATVal_OL_cls.SATValResponse setErrorResponse(HttpResponse httpResponse){
        System.debug(LoggingLevel.INFO, 'Inicia setErrorResponse');
        Takedown_Wrapper_SATVal_OL_cls.SATValResponse SATValResponse = new Takedown_Wrapper_SATVal_OL_cls.SATValResponse();
        Takedown_Wrapper_SATVal_OL_cls.ResponseSatVO responseSATVO = new Takedown_Wrapper_SATVal_OL_cls.ResponseSatVO();
        responseSATVO.statusDescription = String.valueof(httpResponse.getStatusCode());
        responseSATVO.messsage = 'Status code: ' + String.valueof(httpResponse.getStatusCode()) + '\nStatus message: '+ httpResponse.getStatus();
        Takedown_Wrapper_SATVal_OL_cls.ResponseValidatorVO responseValidatorVO = new Takedown_Wrapper_SATVal_OL_cls.ResponseValidatorVO();
        responseValidatorVO.success = String.valueof(httpResponse.getStatusCode());
        responseValidatorVO.message = 'Status code: ' + String.valueof(httpResponse.getStatusCode()) + '\nStatus message: '+ httpResponse.getStatus();
        SATValResponse.responseSatVO = responseSATVO;
        SATValResponse.responseValidatorVO = responseValidatorVO;
        system.debug('SATValResponse ' + SATValResponse);
        System.debug(LoggingLevel.INFO, 'Termina setErrorResponse');
        return SATValResponse;
    }

}