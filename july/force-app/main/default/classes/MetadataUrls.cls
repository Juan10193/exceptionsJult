/**
 * @File Name          : MetadataUrls.cls
 * @Description        : 
 * @Author             : jhernandez@anivia.mx
 * @Group              : 
 * @Last Modified By   : juandedios.hernandez@engeniumcapital.com
 * @Last Modified On   : 29/8/2019 13:22:54
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      		      Modification
 *==============================================================================
 * 1.0    16/8/2019 9:30:19   jhernandez@anivia.mx     Initial Version
**/
public without sharing class MetadataUrls {
    public static string url;
    public static string sandbox = GetSandboxType.getTypeOfSandbox();
     
	@AuraEnabled(cacheable = true)
    /**
    * @description trae la url para invocar la app de documentos dependiendo la Org
    * @author jhernandez@anivia.mx | 20/8/2019
    * @param string data
    * @return string
    */
    public static string getUrlDocs(){

        if(sandbox =='QA'){
        	url  = [SELECT Url__c FROM Urls__mdt where Sanbox__c ='Quality' and Application__c  ='Componente DocumentosV2'][0].Url__c;
        }
        
        if(sandbox =='DEV' || sandbox== 'Developer Edition'){
            url  = [SELECT Url__c FROM Urls__mdt where Sanbox__c ='Development' and Application__c  ='Componente DocumentosV2'][0].Url__c;
        }
        
        if(sandbox =='PROD'){
            url  = [SELECT Url__c FROM Urls__mdt where Sanbox__c ='Production' and Application__c  ='Componente DocumentosV2'][0].Url__c;
        }
        
        return url;
    }



    /**
    * @description Trae la el credential name dependiendo la Org
    * @author juandedios.hernandez@engeniumcapital.com | 29/8/2019
    * @return string
    */
    public static string getUrlDocsDetail(){
        
        switch on sandbox {
            when 'QA' {
                url = 'callout:EndpointDocsV2_qa';
            }
            when 'PROD' {
                url = 'callout:EndpointDocsV2_prod';
            }
            when 'DEV' {
                url = 'callout:EndpointDocsV2_dev';
            }
            
            when 'Developer Edition' {
                url = 'callout:EndpointDocsV2_dev';
            }
            when else {
                system.debug(LoggingLevel.ERROR,'No se pudo identificar el sandbox');
            }
        }


        return url;
    }

}