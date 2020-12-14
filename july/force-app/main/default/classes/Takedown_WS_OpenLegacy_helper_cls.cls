/**
 * @File Name          : Takedown_WS_OpenLegacy_helper_cls.cls
 * @Description        : 
 * @Author             : eduardo.villegas@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : eduardo.amiens@outlook.com
 * @Last Modified On   : 10-15-2020
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    28/1/2020   eduardo.villegas@engeniumcapital.com     Initial Version
**/
public with sharing class Takedown_WS_OpenLegacy_helper_cls {
    
    /**
    * @description 
    * @author eduardo.villegas@engeniumcapital.com | 28/1/2020 
    * @param statusCode 
    * @param statusMessage 
    * @return Takedown_Wrapper_SATVal_OL_cls.SATValResponse 
    **/
    public static Takedown_Wrapper_SATVal_OL_cls.SATValResponse setErrorResponse(String statusCode, String statusMessage){
        Takedown_Wrapper_SATVal_OL_cls.SATValResponse SATValResponse = new Takedown_Wrapper_SATVal_OL_cls.SATValResponse();
        Takedown_Wrapper_SATVal_OL_cls.ResponseSatVO responseSATVO = new Takedown_Wrapper_SATVal_OL_cls.ResponseSatVO();
        responseSATVO.statusDescription = String.valueof(statusCode);
        responseSATVO.messsage = statusMessage;
        Takedown_Wrapper_SATVal_OL_cls.ResponseValidatorVO responseValidatorVO = new Takedown_Wrapper_SATVal_OL_cls.ResponseValidatorVO();
        responseValidatorVO.success = String.valueof(statusCode);
        responseValidatorVO.message = statusMessage;
        SATValResponse.responseSatVO = responseSATVO;
        SATValResponse.responseValidatorVO = responseValidatorVO;
        system.debug('SATValResponse ' + SATValResponse);
        return SATValResponse;
    }

    public static String execute_Token(){
        System.debug(LoggingLevel.INFO, 'Inicia execute_Token');  
        HttpResponse httpResponse;
        Takedown_Wrapper_Token_OL_cls.TokenResponse TokenResponse = new Takedown_Wrapper_Token_OL_cls.TokenResponse();
        String token;
        	httpResponse = Takedown_WS_OpenLegacy_cls.getToken();    
        
        if (httpResponse.getStatusCode() == 200) {             
            TokenResponse = (Takedown_Wrapper_Token_OL_cls.TokenResponse)JSON.deserialize(httpResponse.getBody(), Takedown_Wrapper_Token_OL_cls.TokenResponse.class); // Jsonstring is the above JSON
			token = TokenResponse.access_token;
        } else{
            System.debug(LoggingLevel.ERROR,'StatusCode: ' + httpResponse.getStatusCode());
            System.debug(LoggingLevel.ERROR,'Body: ' + httpResponse.getBody());
            token = null;
        }
        System.debug(LoggingLevel.INFO, 'Termina execute_Token');
        return token;
    } 
}