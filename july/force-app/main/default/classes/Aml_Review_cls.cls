/**
*---------------------------------------------------------------------------------------------------------------
*@Name  Aml_Review_cls
*@Author    Juan de Dios Hernández jhernández@anivia.mx
*@Date      Created: 2019-05-20 
*
*@Group     AML Review Components
*----------------------------------------------------------------------------------------------------------------
@Description Esta clase es el controlador para los componentes de AML Review .
*Contiene la logica de UI para mostrar la información.
*----------------------------------------------------------------------------------------------------------------
*@Changes
*----------------------------------------------------------------------------------------------------------------
**/

public class Aml_Review_cls {

/**
*------------------------------------------------------------------------------------------------------
*@Description   return a list of Credit Approvals with information of a record 'recordId' of an object 
*and the fields Originator, ISC, Sr.UW
*-------------------------------------------------------------------------------------------------------
*@Author    Juan de Dios Hernández jhernández@anivia.mx
*@Date      2019-05-20
*@param     recordId the record to be search
*@param     usIds the list of Ids Users
*@return    return a list of Credit Approvals that match with the criteria
*example    Aml_Review_cls.getUseruarios(list<id>usIds, string recordId of Credit Approval)
*------------------------------------------------------------------------------------------------------
**/

    @AuraEnabled(cacheable=true)
    public static list<Credit_approval_CP__c> getUseruarios (list<id>usIds, string recordId){

        list<Credit_approval_CP__c> cas = 
                [Select Inside_Sales__r.Name, Sr_Underwriter__r.Name,CreatedBy.name from 
                Credit_approval_CP__c where
                (Inside_Sales__c in :usIds or
                Sr_Underwriter__c in :usIds or 
                CreatedById in :usIds) AND Id =:recordId];

        return cas;

    }


    
/**
*------------------------------------------------------------------------------------------------------
*@Description   return a list of Entities Master In credit Approval with information of a record
*'caId' of an object and the fields ES3_tx_Entity_Name__c,ES2_ms_Role__c,ES2_fm_Entity__c
*ES2_Obj_EntityMasterInCreditApproval__c
*------------------------------------------------------------------------------------------------------
*@Author    Juan de Dios Hernández jhernández@anivia.mx
*@Date      2019-05-20
*@param     caId the record of Credit Approval to be search
*@return    return a list of Entities Master In credit Approval
*example    Aml_Review_cls.getUsegetEntitiesruarios(string recordId of Credit Approval)
*------------------------------------------------------------------------------------------------------
**/


    @AuraEnabled(cacheable=true) 
    public static list<ES2_Obj_EntityMasterInCreditApproval__c> getEntities(string caId){

        list<ES2_Obj_EntityMasterInCreditApproval__c> ents = 
                [Select id,ES2_chk_Adverse_Media__c,ES3_tx_Entity_Name__c,
                ES2_ms_Role__c,ES2_fm_Entity__c,ES2_tx_Party_Id__c,ES2_tx_CostumerType__c from 
                ES2_Obj_EntityMasterInCreditApproval__c where 
                ES2_rb_Credit_approval__c =:caId];

        return ents;
    }




/**
*------------------------------------------------------------------------------------------------------
*@Description   return a list of Credit AML Review Comments with information of a record 'recordId'
*and the fields AMLR_User_Name__c, AMLR_Comment__c, OwnerId, Related_Credit_approval_rb__c
*-------------------------------------------------------------------------------------------------------
*@Author    Juan de Dios Hernández jhernández@anivia.mx
*@Date      2019-05-20
*@param     recordId the record of Credit Approval
*@return    return a list of Comments that match with the criteria
*example    Aml_Review_cls.getComments(string recordId of Credit Approval)
*------------------------------------------------------------------------------------------------------
**/

    @AuraEnabled(cacheable=true)
    public static list<LWC_Comment__c> getComments(String recordId, string requestId, String commentType){
        system.debug('recordId comments ' + recordId);
        system.debug('requestId comments ' + requestId);
        system.debug('commentType comments ' + commentType);
        list<LWC_Comment__c> comments =null;
        if(requestId==''){
               system.debug('No tiene requestId');
               comments = [Select Id, LWC_User_Name__c, CreatedDate, LWC_Comment__c,
                 OwnerId, LWC_fm_Creation_Date__c from LWC_Comment__c where
                 LWC_Related_RecordId__c=:recordId and LWC_Comment_Type__c =:commentType order by CreatedDate asc];
        }else {
            comments = [Select Id, LWC_User_Name__c, CreatedDate, LWC_Comment__c,
                 OwnerId, LWC_fm_Creation_Date__c from LWC_Comment__c where
                 LWC_RequestId__c=:requestId and LWC_Comment_Type__c =:commentType order by CreatedDate asc];
        }


        return comments;            
    }




/**
*------------------------------------------------------------------------------------------------------
*@Description   return a list of users photo from specific user Id
*-------------------------------------------------------------------------------------------------------
*@Author    Juan de Dios Hernández jhernández@anivia.mx
*@Date      2019-05-20
*@param     userIds the user Ids list
*@return    return a user Photo that match with the criteria
*example    Aml_Review_cls.getCgetUserPhotos(list<id> recordIds of Credit Approval)
*------------------------------------------------------------------------------------------------------
**/

    @AuraEnabled(cacheable=true)
    public static list<user> getUserPhotos(list<id> userIds){
        system.debug('usersIds ' + userIds);
        list<User> u  = [Select Id, User.SmallPhotoUrl from User where User.id in :userIds];
        return u;
    }


/**
*------------------------------------------------------------------------------------------------------
*@Description   return a list of documments form Rest service
*-------------------------------------------------------------------------------------------------------
*@Author    Juan de Dios Hernández jhernández@anivia.mx
*@Date      2019-05-20
*@param     sServiceUrl the service endpoint
*@param     searchRequestId the Id of request in the service
*@param     sourceCAId the Id of Credit Approval Record
*@return    return a JSON of Documments
*example    Aml_Review_cls.getAMLDocts(string sServiceUrl, String searchRequestId, string sourceCAId)
*------------------------------------------------------------------------------------------------------
**/

    @AuraEnabled(cacheable=true)
    public static object getAMLDocts(string sServiceUrl, String searchRequestId, string sourceCAId ){
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        
        
        req.setTimeout(20000);
        req.setEndpoint(sServiceUrl + '/EcRequestSbDat/RequestRs/requests/documents?requestId=' + searchRequestId +'&sourceCAId=' + sourceCAId);
        req.setMethod('GET');
        
        HttpResponse res = h.send(req);
        system.debug('respuesta:--->' +  res.getBody());
        return res.getBody();
    }



/**
*------------------------------------------------------------------------------------------------------
*@Description   return a list of doctypes
*-------------------------------------------------------------------------------------------------------
*@Author    Juan de Dios Hernández jhernández@anivia.mx
*@Date      2019-05-20
*@param     recordId the Id of the record
*@param     recordTypeId the Id of of the recordType
*@return    return a string comma separated by doctypes
*example    Aml_Review_cls.getDoctypes(string recordId, string recordTypeId)
*------------------------------------------------------------------------------------------------------
**/ 

    @AuraEnabled(cacheable=true)
    public static string getDoctypes(string recordId, string recordTypeId){
        system.debug('holamundo');
        Id recordtypeCA = Schema.SObjectType.Credit_approval_CP__c.getRecordTypeInfosByName().get('Credit Approval').getRecordTypeId();
        Id recordtypeMAC = Schema.SObjectType.Credit_approval_CP__c.getRecordTypeInfosByName().get('MAC').getRecordTypeId();

        string doctypes;

        if(recordtypeCA == recordTypeId){
            doctypes = [Select DoctypesAML__c from 
                        Credit_approval_CP__c where 
                        Credit_approval_CP__c.Id =:recordId][0].DoctypesAML__c;
        }

        if(recordtypeMAC == recordTypeId){
            doctypes = [Select MC3_tx_DoctypesAMLMAC__c from 
                        Credit_approval_CP__c where 
                        Credit_approval_CP__c.Id =:recordId][0].MC3_tx_DoctypesAMLMAC__c;
        } 

        return doctypes;
    }

    @AuraEnabled(cacheable=false)
    public static void unresolvedEntities(list<string> Ids, string unresolvedEnts){
        List<ES2_Obj_EntityMasterInCreditApproval__c> entsWithHits =[Select Id,ES2_tx_Party_Id__c, ES3_tx_Entity_Name__c, ES2_Unresolved_Items__c from ES2_Obj_EntityMasterInCreditApproval__c  where Id in:Ids ];
        list<ES2_Obj_EntityMasterInCreditApproval__c> entsUnresolved = new list<ES2_Obj_EntityMasterInCreditApproval__c>();
        Aml_Reciew_UnresolvedWrapper_cls.Unresolveds unresEnts = (Aml_Reciew_UnresolvedWrapper_cls.Unresolveds)JSON.deserializeStrict(unresolvedEnts,Aml_Reciew_UnresolvedWrapper_cls.Unresolveds.class);
    	list<Aml_Reciew_UnresolvedWrapper_cls.content> unresL =unresEnts.unresolveds;
        for(Aml_Reciew_UnresolvedWrapper_cls.content unr:unresL){
            for(ES2_Obj_EntityMasterInCreditApproval__c ent: entsWithHits){
                if(unr.id == ent.Id && (ent.ES2_Unresolved_Items__c=='No Hits' || ent.ES2_Unresolved_Items__c==null)){
                    ES2_Obj_EntityMasterInCreditApproval__c entidad = new ES2_Obj_EntityMasterInCreditApproval__c();
                    entidad.Id =unr.id;
                    entidad.ES2_Unresolved_Items__c='Unresolved';
                    entidad.ES2_txt_Hit_Description__c = unr.hitDescription;
                    entsUnresolved.add(entidad);
                }
            }
        }
          try{
            update entsUnresolved;
        }catch(DmlException e) {
            system.debug('error al actualizar hits' + e);
        }
    }

    @AuraEnabled(cacheable=false)
    public static Map<String, Object> showHits(list<integer> partyIds, string sServiceURL){
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
        gen.writeFieldName('ids');
        gen.writeStartObject();
        gen.writeFieldName('id');
        gen.writeStartArray();
        for (integer party : partyIds) {
            gen.writeNumber(party);
        }
        gen.writeEndArray();
        gen.writeEndObject();
        gen.writeEndObject();
        string json = gen.getAsString();
        system.debug('sendjson:'  +json);
        Map<String, Object> jsonResponse = null;  
        jsonResponse = Test.isRunningTest() ? new Map<String, Object>() : EIV_EntityExtencionCalloutClass.postHitsEntitys(sServiceURL, json);
        System.debug('jsonResponse OEJ:' + jsonResponse);
         Map<String, Object> result =null;
        if (jsonResponse == null) //Error en ORACLE, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
        {
            system.debug('OEJ: ERROR, Oracle Server Missing');
        }
        else
        {
            //El resultado tiene status
            Map<String, Object> statusCreate = (Map<String, Object>)jsonResponse.get('status');
            System.debug('Received the following JSON response of status OEJ01:' + statusCreate);
            if(statusCreate != null)
            {
                System.debug('Received the following JSON response of status.code OEJ01:' + (String)statusCreate.get('code'));
                System.debug('Received the following JSON response of status.message OEJ01:' + (String)statusCreate.get('message'));
                System.debug('Received the following JSON response of status.detail OEJ01:' + (String)statusCreate.get('detail')); 
                
                
                if((String)statusCreate.get('detail') == 'S' ) //Exito en el salvado, pasamos a la pagina de lectura y recargamos el controlador
                {
                    system.debug('OEJ: EXITO, El servicio se ejecuto correctamente');
                    result = (Map<String, Object>)jsonResponse.get('result');
                    system.debug('el resultado es: ' + result);
                }
                else //Error en el salvado, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
                {
                    system.debug('OEJ: Error, El servicio NO se ejecuto correctamente' + (String)statusCreate.get('code'));
                    system.debug('ERROR, El servicio NO se ejecuto correctamente' + (String)statusCreate.get('code')); 
                }          
            }
            
        }

        return result;
    }
 
    @AuraEnabled(cacheable=true)
    public static list<ES2_Obj_EntityMasterInCreditApproval__c> getUnresolvedItems(list<string> Ids){
        list<ES2_Obj_EntityMasterInCreditApproval__c> unresolvedItems = [Select Id, Status_Color__c, ES3_tx_Entity_Name__c, ES2_txt_Hit_Description__c, ES2_Unresolved_Items__c,
                                       ES2_Resolve_Comment__c from ES2_Obj_EntityMasterInCreditApproval__c where Id in:Ids];
                                       system.debug('hola');
        return unresolvedItems;
    
    }

    @AuraEnabled(cacheable=false)
    public static void adverseMedia(string entId){
        
        ES2_Obj_EntityMasterInCreditApproval__c ent =Test.isRunningTest()?new ES2_Obj_EntityMasterInCreditApproval__c(ES2_chk_Adverse_Media__c=false):[Select Id, ES2_chk_Adverse_Media__c from ES2_Obj_EntityMasterInCreditApproval__c where Id=:entId];
        if(ent.ES2_chk_Adverse_Media__c==false){
            ent.ES2_chk_Adverse_Media__c =true;
        }else{
             ent.ES2_chk_Adverse_Media__c =false;
        }
        
        if(Test.isRunningTest()){
            
        }else{
             update ent;
        }
       
    }
}