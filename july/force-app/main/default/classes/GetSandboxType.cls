public class GetSandboxType {
    @AuraEnabled(cacheable=false)
    public static string getTypeOfSandbox (){
        
        Organization  org = [SELECT Id, Name, IsSandbox, InstanceName, OrganizationType FROM Organization];
        boolean IsSandbox = org.IsSandbox;
        string OrganizationType = org.OrganizationType;
        string typeOfsandbox ='';
        string quality = '--qa';
        string sandboxurl = URL.getSalesforceBaseUrl().getHost();
        
        if(sandboxurl.contains(quality) && IsSandbox == true){
            typeOfsandbox ='QA';
        }
        
        
        if(IsSandbox ==false){
            typeOfsandbox ='PROD';
        }
        
        
        if(typeOfsandbox =='' && typeOfsandbox !='QA' && typeOfsandbox != 'PROD'  && IsSandbox == true && OrganizationType !='Developer Edition'){
            typeOfsandbox ='DEV';
        }
        
        if(IsSandbox == true  && OrganizationType =='Developer Edition'){
            typeOfsandbox ='Developer Edition';
        }
        
        return typeOfsandbox;
    }

    @AuraEnabled(cacheable=false)
    public static string getNamedCredential(string sandboxtype){
        string endpoint;
        switch on sandboxtype {
            when 'QA' {
                endpoint = [Select Endpoint FROM NamedCredential WHERE DeveloperName = 'getsServiceUrlQa' ][0].Endpoint;
            }
            when 'PROD'{
                endpoint = [Select Endpoint FROM NamedCredential WHERE DeveloperName = 'getsServiceUrlProd' ][0].Endpoint;
            }
            when 'DEV'{
                endpoint = [Select Endpoint FROM NamedCredential WHERE DeveloperName = 'getsServiceUrl' ][0].Endpoint;
            }
            
            when 'Developer Edition'{
                 endpoint = [Select Endpoint FROM NamedCredential WHERE DeveloperName = 'getsServiceUrl' ][0].Endpoint;
            }
        }

        return endpoint;
    }
}