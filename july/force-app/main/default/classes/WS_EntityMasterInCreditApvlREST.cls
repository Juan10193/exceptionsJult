@RestResource (urlMapping='/EntityMasterInCreditApproval/v1/*')
global class WS_EntityMasterInCreditApvlREST {
    
  @HttpGet
  global static void getEntityMasterInCaByCreditApprovalById(){
    RestRequest req = RestContext.request;
    RestResponse res = RestContext.response;
    res.addHeader('Content-Type', 'application/json;charset=UTF-8');

    try {
      id caId = req.params.get('caId');

      ES2_Obj_EntityMasterInCreditApproval__c entitisca = [SELECT Id,IsDeleted,Name,CurrencyIsoCode,LastActivityDate,ES2_rb_Credit_approval__c,
      ES2_fm_Desicion_Entity__c,ES2_fm_Entity__c,ES2_fm_Garantor__c,ES2_fm_Obligor__c,ES2_ms_Role__c,ES2_tx_CostumerType__c,ES2_tx_Oracle_Account_Name__c,
      ES2_tx_Party_Id__c,ES2_tx_TopParentID__c,ES2_tx_TopParetName__c,ES2_tx_pageVF__c,ES2_url_Entity_Master__c,ES3_rb_Opportunity__c,
      ES3_rb_Opportunity_in_Credit_approval_CP__c,ES3_tx_BloombergID__c,ES3_tx_Entity_Name__c,ES3_tx_HNWI_ID__c,ES3_tx_MRAID__c,ES3_tx_Or_Rating__c,
      ES3_tx_Risk_Classification__c,ES3_tx_Transaction_Date__c,ES3_txt_CRR_Override__c,ES3_txt_CRR__c,ES3_txt_SIC_Code__c,ES3_txt_SIC_Description__c,
      ES2_Resolve_Comment__c,ES2_Unresolved_Items__c,ES2_chk_Adverse_Media__c,ES2_txt_Hit_Description__c,Status_Color__c,ES3_rb_Carveout_in_CA_inCredit__c,JR_Txt_Top_Parent_Name__c,
      TKD_txt_RFC__c from ES2_Obj_EntityMasterInCreditApproval__c where  ES2_rb_Credit_approval__c =:caId LIMIT 1];
      ApexPages.StandardController sc = new ApexPages.StandardController(entitisca);
      WS_EntityMasterInCreditApvlREST_Helper entityInCA= new WS_EntityMasterInCreditApvlREST_Helper(sc);
      res.responseBody = Blob.valueOf(JSON.serializePretty(entityInCA, true));
    }catch (System.StringException e) {
      SalesforceError[] errs = new SalesforceError[]{ 
          new SalesforceError('BAD_REQUEST',string.valueOf(e.getMessage()))
      };
      res.statusCode =400;
      res.responseBody = Blob.valueOf(JSON.serialize(errs));
    }catch (System.QueryException e){
      res.statusCode = 404;
      SalesforceError[] errs = new SalesforceError[]{ 
          new SalesforceError('NOT_FOUND', string.valueOf(e.getMessage()))
      };
      res.responseBody = Blob.valueOf(JSON.serialize(errs));
    }catch(Exception e){
      res.statusCode = 500;
      SalesforceError[] errs = new SalesforceError[]{ 
          new SalesforceError('BAD_REQUEST', string.valueOf(e.getCause()))
      };
      res.responseBody = Blob.valueOf(JSON.serialize(errs));
    }
  }
}