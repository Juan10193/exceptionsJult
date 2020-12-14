@isTest
public class ES2_Controller_KWYPMoralFillTest {
    @Istest
    static void ES2_Controller_KWYPersonaMoralfill(){
    ES2_Controller_KWYPMoralFill a = new ES2_Controller_KWYPMoralFill();
      a.request =  new ES2_WraperRequest();
      a.WraperReqList =  new List<ES2_WraperRequest>();
        a.pasnull(null);
        a.pasnullDate('a');
        
      Map<string,object>jsonResponse =(Map<string,object>)JSON.deserializeUntyped(ES2_jsonDummy.entitymasterToJson());
        Map<String, Object> mapRequests =(Map<String, Object>)jsonResponse.get('requests');
        a.rellenarHeader(mapRequests);
    }
    
    @istest
    static void ES2_Controller_KWYPersonaMoralAml(){
       
        
        ES2_Controller_KWYPMoralFill a = new ES2_Controller_KWYPMoralFill();
        
      a.request =  new ES2_WraperRequest();
      a.WraperReqList =  new List<ES2_WraperRequest>();
         Map<string,object>jsonResponse =(Map<string,object>)JSON.deserializeUntyped(ES2_jsonDummy.JsonnULO('AML HITS CRR'));
        Map<String, Object> mapRequests =(Map<String, Object>)jsonResponse.get('requests');
        
       
        a.rellenarHeader(mapRequests);
        
    }
    
     @istest
    static void ES2_Controller_KWYPersonaMoralCREDITBUREAU(){
       
        
        ES2_Controller_KWYPMoralFill a = new ES2_Controller_KWYPMoralFill();
        
      a.request =  new ES2_WraperRequest();
      a.WraperReqList =  new List<ES2_WraperRequest>();
         Map<string,object>jsonResponse =(Map<string,object>)JSON.deserializeUntyped(ES2_jsonDummy.entitymasterToJsonTes('CREDIT BUREAU'));
        Map<String, Object> mapRequests =(Map<String, Object>)jsonResponse.get('requests');
        
       
        a.rellenarHeader(mapRequests);
        
    }
    
     @istest
    static void ES2_Controller_KWYPersonaMoralcreditApproval(){
       
        
        ES2_Controller_KWYPMoralFill a = new ES2_Controller_KWYPMoralFill();
        
      a.request =  new ES2_WraperRequest();
      a.WraperReqList =  new List<ES2_WraperRequest>();
         Map<string,object>jsonResponse =(Map<string,object>)JSON.deserializeUntyped(ES2_jsonDummy.entitymasterToJsonTes('creditApproval'));
        Map<String, Object> mapRequests =(Map<String, Object>)jsonResponse.get('requests');
        
       
        a.rellenarHeader(mapRequests);
        
    }
    
     @istest
    static void ES2_Controller_KWYPersonaMoralKYCINDIVIDUAL(){
       
        
        ES2_Controller_KWYPMoralFill a = new ES2_Controller_KWYPMoralFill();
        
      a.request =  new ES2_WraperRequest();
      a.WraperReqList =  new List<ES2_WraperRequest>();
         Map<string,object>jsonResponse =(Map<string,object>)JSON.deserializeUntyped(ES2_jsonDummy.entitymasterToJsonTes('KYC INDIVIDUAL'));
        Map<String, Object> mapRequests =(Map<String, Object>)jsonResponse.get('requests');
        
       
        a.rellenarHeader(mapRequests);
        
    }
    @isTest
    static void ES2_Controller_KWYPersonaMoralKYCMORAL(){
       
        
        ES2_Controller_KWYPMoralFill a = new ES2_Controller_KWYPMoralFill();
        
      a.request =  new ES2_WraperRequest();
      a.WraperReqList =  new List<ES2_WraperRequest>();
         Map<string,object>jsonResponse =(Map<string,object>)JSON.deserializeUntyped(ES2_jsonDummy.entitymasterToJsonTes('KYC ORGANIZATION'));
        Map<String, Object> mapRequests =(Map<String, Object>)jsonResponse.get('requests');
        
       
        a.rellenarHeader(mapRequests);
        
    }
}