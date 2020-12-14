/**
 * @File Name          : Takedown_Wrapper_OpenLegacy_cls.cls
 * @Description        : 
 * @Author             : eduardo.amiens@outlook.com
 * @Group              : 
 * @Last Modified By   : eduardo.amiens@outlook.com
 * @Last Modified On   : 29/7/2019 15:46:04
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      		      Modification
 *==============================================================================
 * 1.0    29/7/2019 15:42:34   eduardo.amiens@outlook.com     Initial Version
**/
public with sharing class Takedown_Wrapper_Token_OL_cls {
    public class TokenResponse {
        public String access_token  {get;set;}
        public String token_type    {get;set;}
        public String scope         {get;set;}
    }
}