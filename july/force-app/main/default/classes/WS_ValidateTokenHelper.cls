public with sharing class WS_ValidateTokenHelper {
    public virtual class BaseException extends Exception {}
    public class WsException extends BaseException {}

    public static string orgtype {
        get {
            if (orgtype == null) {
               Boolean isSandbox = [SELECT IsSandbox FROM Organization LIMIT 1].IsSandbox;
               orgtype= isSandbox == true?'Sandbox':'Prod';
            }
            return orgtype ;
        }
        set;
    }
   
    public static WSExposedCredential__mdt validateParametersHeader(string parameters){
        String developerName = Test.isRunningTest() ? 'TokenTest' : 'ServicioToken';
        Blob creds = EncodingUtil.base64Decode(parameters);
        EncriptationKeys__mdt decryption = [SELECT EncriptationKey__c, EncriptationType__c, IV__c FROM EncriptationKeys__mdt WHERE DeveloperName =: developerName LIMIT 1];
        Blob ivs = Blob.valueOf(decryption.IV__c);
        Blob key = Blob.valueOf(decryption.EncriptationKey__c);
        string decryptedCreds;
        try {
            decryptedCreds = Crypto.decrypt('AES128', key,ivs, creds).toString();
        } catch (Exception e) {
            system.debug(e.getMessage());
            throw new WsException('Credenciales No validas');
        }
        system.debug('decripted');
        system.debug(decryptedCreds);
        
        WSExposedCredentialWrapper credObject = (WSExposedCredentialWrapper)JSON.deserialize(decryptedCreds, WSExposedCredentialWrapper.class);
        if (credObject!=null) {
            String typeOrg = Test.isRunningTest() ? 'Sandbox' : WS_ValidateTokenHelper.orgtype;
            list<WSExposedCredential__mdt> metadataCreds = [
                SELECT Id, DeveloperName, MasterLabel, Language, NamespacePrefix, 
                Label, QualifiedApiName, Org_Type__c, User__c, 
                Password__c, SF_User__c,SF_Password__c, Client_ID__c, Client_Secret__c 
                FROM WSExposedCredential__mdt where User__c =:credObject.user AND Password__c =:credObject.password AND Org_Type__c =:typeOrg
            ]; 

            if(metadataCreds.size()>0){
                return metadataCreds[0];
            }
        }
        return null;
    }
}