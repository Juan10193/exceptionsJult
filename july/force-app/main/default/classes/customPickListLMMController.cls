/**
 * @File Name          : customPickListLMMController.cls
 * @Description        : 
 * @Author             : eduardo.amiens@outlook.com
 * @Group              : 
 * @Last Modified By   : eduardo.amiens@outlook.com
 * @Last Modified On   : 30/4/2020 14:41:42
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    30/4/2020   eduardo.amiens@outlook.com     Initial Version
**/
public with sharing class customPickListLMMController {

    public virtual class BaseException extends Exception {}
    public class fieldException extends BaseException {}
    
    @AuraEnabled(cacheable=false)
    public static string getRequestByPartyID(string partyID){
        //Si el party ID es 0 traerá todos los economic group, si se especifica el partyid traerá todos los entities asociados a un economic group
        string response  = EIV_EntityCallout.getRequestByPartyID(partyID).getBody();
        return response;      
    }
    @AuraEnabled(cacheable=false)
    public static string getRequestByRequestID(string requestId){
        string response;
        User u = [select id, EmployeeNumber from user where id=:userinfo.getuserid()];
        if(string.isNotEmpty(u.EmployeeNumber)){
            response  = EIV_EntityCallout.getRequestByRequestID(requestId,u.EmployeeNumber).getBody();
        } else {
            throw new fieldException('El usuario no tiene un SSO asignado, consulte con su administrador');
        }
        
        return response;      
    }
    
}