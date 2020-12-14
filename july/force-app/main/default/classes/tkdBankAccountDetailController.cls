/**
 * @description       : 
 * @author            : eduardo.amiens@outlook.com
 * @group             : 
 * @last modified on  : 09-11-2020
 * @last modified by  : eduardo.amiens@outlook.com
 * Modifications Log 
 * Ver   Date         Author                       Modification
 * 1.0   08-14-2020   eduardo.amiens@outlook.com   Initial Version
**/
public with sharing class tkdBankAccountDetailController {
    
    @AuraEnabled(cacheable=true)
    public static string getTKD_Bank_Account(){
        string response;
        Takedown_Wrapper_Token_OL_cls.TokenResponse TokenResponse = new Takedown_Wrapper_Token_OL_cls.TokenResponse();
        HttpResponse httpResponse = Takedown_WS_OpenLegacy_cls.getToken();    
        TokenResponse = (Takedown_Wrapper_Token_OL_cls.TokenResponse)JSON.deserialize(httpResponse.getBody(), Takedown_Wrapper_Token_OL_cls.TokenResponse.class);
        string token = TokenResponse.access_token;

        response = Takedown_WS_OpenLegacy_cls.getBankAccount(token).getBody();
        return response;

    }  
}