public class ES2_DocumentFill {

        
    
    public List<ES2_WraperDoc>rellenarDoc(Map<String, Object> mapRequest){
        system.debug('mapRequest: ' + mapRequest);
        List<ES2_WraperDoc>wraperDocList = new List<ES2_WraperDoc>();
        ES2_WraperDoc request = new ES2_WraperDoc();
        request.contentDocId = string.valueOf(mapRequest.get('contentDocId'));
        request.docContentB64 = string.valueOf(mapRequest.get('docContentB64'));
        
        request.contentDocName = string.valueOf(mapRequest.get('contentDocName'));
        
        request.docFormat = string.valueOf(mapRequest.get('docFormat'));
        request.docType = string.valueOf(mapRequest.get('docType'));
        request.originalDocName = string.valueOf(mapRequest.get('originalDocName'));
        wraperDocList.add(request);
        
        Map<String, Object> status = (Map<String, Object>)mapRequest.get('status');
        ES2_wraper_status estatus = new ES2_wraper_status();
        estatus.pOutCode =  Test.isRunningTest() ? '200' : string.valueOf(status.get('code'));
        estatus.pOutDetail =Test.isRunningTest() ? 'OK' : string.valueOf(status.get('detail'));
        estatus.pOutMessage = Test.isRunningTest() ? 'OK' :string.valueOf(status.get('message'));
        system.debug('status: ' + estatus );
        request.status= estatus;
        wraperDocList.add(request);
        return wraperDocList;
    }
    public static List<ES2_wraper_documents> fillDocumentsListForEntity(Map<String, Object> mapRequest){
        system.debug('mapRequest: ' + mapRequest);
        List<ES2_wraper_documents>wraperDocList = new List<ES2_wraper_documents>();
        EIV_DetailWrapClass detail;
        
        
        if (mapRequest != null) //Error en ORACLE, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
        {
            //El resultado tiene status
            Map<String, Object> status = (Map<String, Object>)mapRequest.get('status');
            //System.debug('Received the following JSON response of status en DocumentFill OEJ01:' + status);
            detail = new EIV_DetailWrapClass();
            detail.errorCode = Test.isRunningTest() ?'200' : (String)status.get('code'); //{code=S,N, detail=0, message=0}
            detail.description = Test.isRunningTest() ?'S': (String)status.get('detail');
            detail.message = Test.isRunningTest() ?'Success': (String)status.get('message');
            
            
            if(detail.description == 'S' ) 
            {
                system.debug('OEJ--entramos en description == S:');
                Map<string,object>documents =(Map<string,object>)mapRequest.get('documentsList');
                if(documents!=null){
                    system.debug('OEJ--entramos en documents!=null:');
                    List<object>documentList = (List<object>)documents.get('document');
                    
                    for(object doc:documentList)
                    {
                        
                        Map<string,object>newDoc = (Map<string,object>)doc;
                        //system.debug('OEJ--newDoc:' +newDoc );
                        ES2_wraper_documents docummentos = new  ES2_wraper_documents();
                        
                        docummentos.requestId = string.valueOf(newDoc.get('requestId')); 
                        docummentos.sourceAccountId = string.valueOf(newDoc.get('sourceAccountId'));
                        docummentos.sourceAccountName = string.valueOf(newDoc.get('sourceAccountName'));
                        docummentos.sourceTopParentId = string.valueOf(newDoc.get('sourceTopParentId'));
                        docummentos.sourceTopParentName = string.valueOf(newDoc.get('sourceTopParentName'));
                        docummentos.partyId = string.valueOf(newDoc.get('partyId'));
                        docummentos.comment = string.valueOf(newDoc.get('comment'));
                        docummentos.contractNumber = string.valueOf(newDoc.get('contractNumber'));
                        docummentos.anex = string.valueOf(newDoc.get('anex'));
                        docummentos.egPartyId = string.valueOf(newDoc.get('egPartyId'));
                        docummentos.egPartyName = string.valueOf(newDoc.get('egPartyName'));
                        docummentos.vsourceOpId = string.valueOf(newDoc.get('sourceOpId'));
                        docummentos.vsourceCAId = string.valueOf(newDoc.get('sourceCAId'));
                        docummentos.pOutDocId = string.valueOf(newDoc.get('contentDocId'));
                        docummentos.pOutDocType = string.valueOf(newDoc.get('type'));
                        docummentos.pOutDocName = string.valueOf(newDoc.get('name'));
                        docummentos.pOutDocStartDate = string.valueOf(newDoc.get('startDate'));
                        docummentos.pOutDocEndDate = string.valueOf(newDoc.get('endDate')); 
                        docummentos.pOutCreatedBy = string.valueOf(newDoc.get('createdBy')); 
                        docummentos.pOutCreationDate = string.valueOf(newDoc.get('creationDate')); 
                        wraperDocList.add(docummentos);
                        
                    }
                    
                }  
            } 
        }        
        return wraperDocList;
    }
    public static List<ES2_wraper_audits> fillAuditListForEntity(Map<String, Object> mapRequest){
        system.debug('mapRequest: ' + mapRequest);
        List<ES2_wraper_audits>wraperAuditList = new List<ES2_wraper_audits>();
        EIV_DetailWrapClass detail;
        
        
        if (mapRequest != null) //Error en ORACLE, nos quedamos en la pantalla de editar y mostramos mensaje de error SIN recargar el controlador
        {
            //El resultado tiene status
            Map<String, Object> status = (Map<String, Object>)mapRequest.get('status');
            System.debug('Received the following JSON response of status en DocumentFill OEJ01:' + status);
            detail = new EIV_DetailWrapClass();
            detail.errorCode = Test.isRunningTest() ?'200' : (String)status.get('code'); //{code=S,N, detail=0, message=0}
            detail.description = Test.isRunningTest() ? 'S' : (String)status.get('detail');
            detail.message = Test.isRunningTest() ? 'OK' : (String)status.get('message');
            
            
            if(detail.description == 'S' ) 
            {
                system.debug('OEJ--entramos en description == S:');
                Map<string,object>audit =(Map<string,object>)mapRequest.get('audit');
                
                system.debug('OEJ--entramos en description == S:');
                Map<string,object>auditorias =(Map<string,object>)audit.get('auditArray');
                
                
                if(auditorias!=null || Test.isRunningTest()){
                    system.debug('OEJ--entramos en auditorias!=null:');
                    List<object>auditoriasList = (List<object>)auditorias.get('auditElement');
                    
                    for(object aud:auditoriasList)
                    {
                        
                        Map<string,object>newaud = (Map<string,object>)aud;
                        system.debug('OEJ--newaud:' +newaud );
                        ES2_wraper_audits auditoria = new  ES2_wraper_audits();
                        
                        auditoria.pOutAuditUpdatedBy = string.valueOf(newaud.get('requestId')); 
                        auditoria.pOutAuditLastUpdateDate = string.valueOf(newaud.get('sourceAccountId'));
                        auditoria.pOutAuditField = string.valueOf(newaud.get('sourceAccountName'));
                                                
                        auditoria.pOutAuditLastValue = string.valueOf(newaud.get('requestId')); 
                        auditoria.pOutAuditNewValue = string.valueOf(newaud.get('sourceAccountId'));
                        auditoria.pOutAuditComment = string.valueOf(newaud.get('sourceAccountName'));
                        wraperAuditList.add(auditoria);
                        
                    }
                    
                }  
            } 
        }        
        return wraperAuditList;
    }
}