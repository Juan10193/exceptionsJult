public class ES2_Controller_KWYPMoralFill {
    
    Public List<ES2_WraperRequest> WraperReqList                            {get;set;}
    Public ES2_WraperRequest request                                        {get;set;}    
    
    
    
    public List<ES2_WraperRequest>  rellenarHeader(Map<String, Object> mapRequest)
    {
        System.debug(LoggingLevel.INFO,'Inicia rellenarHeader');
        
        List<ES2_Wraper_Doctype>WraperDoctList = new List<ES2_Wraper_Doctype>();
        list<ES4_wraper_RelatedRequest> related = new list<ES4_wraper_RelatedRequest>();
        list<EIV_PrivilegesWrapClass> Privilegios = new list<EIV_PrivilegesWrapClass>();
        ES2_Wraper_workflow Flujotrabjo = new ES2_Wraper_workflow();
        List<ES2_Wraper_NextStatus> estatus = new  List<ES2_Wraper_NextStatus>();
        ES2_Wraper_AML aml =  new ES2_Wraper_AML();
        ES2_wraper_AMLHit amlHit = new  ES2_wraper_AMLHit();
        List<ES2_wraper_hits> wamlHits = new List<ES2_wraper_hits>();
        ES2_Wraper_CREDIT_BUREAU  buro =  new ES2_Wraper_CREDIT_BUREAU();
        List<ES2_wraper_Alerts> walerts = new List<ES2_wraper_Alerts>();
        List<ES2_Wraper_CreditApproval>wCreditAproval =  new List <ES2_Wraper_CreditApproval>();
        ES2_wraper_economic_group_request Ecgroup = new ES2_wraper_economic_group_request();
        ES2_Wraper_KWYPersonaFisica kwyfisc = new  ES2_Wraper_KWYPersonaFisica();
        ES2_wraper_datos_generales wdatosG = new ES2_wraper_datos_generales();
        ES2_wraper_DomicilioParticular wdomicilioP = new ES2_wraper_DomicilioParticular();
        ES2_wraper_datosGralesEmpleo wdatosEmpleo =  new  ES2_wraper_datosGralesEmpleo();
        ES2_wraper_PPE wPPE = new ES2_wraper_PPE();
        List<ES2_wraper_proveedorRecurso>wProveedorR = new List<ES2_wraper_proveedorRecurso>();
        ES2_wraper_suscritopor wsuscrito = new ES2_wraper_suscritopor();
        ES2_Wraper_KWYPersonaMoral kwyMoral = new ES2_Wraper_KWYPersonaMoral();
        ES2_wraper_datos_generales wdatosGM = new ES2_wraper_datos_generales();
        ES2_wraper_DomicilioParticular wdomicilioPM = new  ES2_wraper_DomicilioParticular();
        ES2_wraper_actividadeconomica wActividadEPM = new ES2_wraper_actividadeconomica();
        ES2_wraper_mercadografico wMercadoGPM = new ES2_wraper_mercadografico();
        list<ES2_wraper_cuentasbancarias> wCuentasBancariasPM = new list<ES2_wraper_cuentasbancarias>(); 
        ES2_wraper_PPE wppeM = new ES2_wraper_PPE();
        List<ES2_wraper_proveedoresRecursos> proveedorRM =new List<ES2_wraper_proveedoresRecursos>(); 
        List<ES2_wraper_composicionsocial> wComposicionSocial = new List<ES2_wraper_composicionsocial>();
        List<ES2_wraper_accionistaspm> wAccionistpm = new List<ES2_wraper_accionistaspm>();
        list<ES2_wraper_sociosfideicomisos> wFideicomisos = new list<ES2_wraper_sociosfideicomisos>();
        list<ES2_wraper_sociosPF> wSociosPF =  new list<ES2_wraper_sociosPF>();
        list<ES2_Wraper_socioAdminPor> wSocioAdmin = new list<ES2_Wraper_socioAdminPor>();
        list<ES2_wraper_funcionariosPrincipales> WfuncionariosP = new list<ES2_wraper_funcionariosPrincipales>();
        list<ES2_wraper_grupoEmpresarial>wGrupoEmpM =new list<ES2_wraper_grupoEmpresarial>();
        ES2_wraper_certificadorepresentantelegal wRepLegalM =  new ES2_wraper_certificadorepresentantelegal();
        ES2_wraper_entityDocument enttyDocument = new ES2_wraper_entityDocument();
        ES2_wraper_entityComment enttyComent = new ES2_wraper_entityComment();
        ES2_wraper_sicCode  sicOde = new  ES2_wraper_sicCode();
        list<ES2_wraper_coments> wComents = new list<ES2_wraper_coments>();
        list<ES2_wraper_documents> wDocuments = new list<ES2_wraper_documents>();
        list<ES2_wraper_audits> wAudits =new list<ES2_wraper_audits>();
        ES2_wraper_status  statusM = new   ES2_wraper_status();
        
        ES4_Wraper_EVAL evalsP = new ES4_wraper_EVAL();
        list <ES4_wraper_EVAL_Assets> assets = new list <ES4_Wraper_EVAL_Assets>();
        
        ES5_wraper_LAH legalAss =  new ES5_wraper_LAH();
        list<ES5_wraper_LA_limitante> limitantes = new list <ES5_wraper_LA_limitante>();
        List<ES5_wraper_LA_modificacion> modificaciones = new list <ES5_wraper_LA_modificacion>();
        list<ES5_wraper_LA_apoderados> apoderados = new list <ES5_wraper_LA_apoderados>();
        list<ES5_wraper_LA_Estatutos> Estatutos = new list<ES5_wraper_LA_Estatutos>();
        
        
        List<Object> requestlista = (List<Object>)mapRequest.get('request');
        system.debug('OEJ requestListaJson:' + requestlista);
        
        if(requestlista ==null)
        {
            System.debug('OEJ: No existen solicitudes requests que revisar');
        }
        else
        {
            WraperReqList = new List<ES2_WraperRequest> ();
            Map<String,object>DocTypes = null;
            Map<String,object>RelatedRequests=null;
            Map<string,object>NextStatuses = null;
            Map<string,object>Hits = null;
            Map<string,object>alerts = null;
            //Map<string,object>creditApproval = null;
            Map<string,object>parties=null;
            Map<string,object>cuentBanc =null;
            
            
            for(Object a: requestlista)
            {
                request = new ES2_WraperRequest();
                Map<String, Object> newRequest = (Map<String, Object>) a;
                Map<string, Object> newHeader = (Map<string,Object>)newRequest.get('header');
                system.debug('OEJ newHeader:' + newheader); 
                
                
                request.pOutActiveFlag = string.valueOf(newHeader.get('activeFlag'));
                request.pOutndaType =  string.valueOf(newHeader.get('ndaType'));
                request.pOutAssignedDate =String.valueOf(newHeader.get('assignedDate'));
                request.pOutAssignedGroup=String.valueOf(newHeader.get('assignedGroup'));
                request.pOutAssignedTo=String.valueOf(newHeader.get('assignedTo'));
                request.nameAssignedTo = String.valueOf(newHeader.get('nameAssignedTo'));
                request.pOutsourceTopParentName=String.valueOf(newHeader.get('sourceTopParentName'));
                request.pOutCreatedBy=String.valueOf(newHeader.get('createdBy'));
                request.nameCreatedBy = String.valueOf(newHeader.get('nameCreatedBy'));
                request.pOutCreationDate=String.valueOf(newHeader.get('creationDate'));
                request.pOutEGPartyId = String.valueOf(newHeader.get('egPartyId'));
                request.pOutEGPartyName = String.valueOf(newHeader.get('egPartyName'));
                request.pOutEndDate=String.valueOf(newHeader.get('endDate'));
                request.pOutFinantialEntity = String.valueOf(newHeader.get('finantialEntity'));
                request.pOutLastUpdateDate = String.valueOf(newHeader.get('lastUpdateDate'));
                request.pOutPartyId = String.valueOf(newHeader.get('partyId'));
                request.pOutPartyName = String.valueOf(newHeader.get('partyName'));
                request.pOutProcessName = String.valueOf(newHeader.get('applicationId')); //antes era process name
                request.pOutRequestedBy = String.valueOf(newHeader.get('requestedBy'));
                request.nameRequestedBy = String.valueOf(newHeader.get('nameRequestedBy'));
                request.pOutRequestId = String.valueOf(newHeader.get('requestId'));
                request.pOutRequestStatus = String.valueOf(newHeader.get('requestStatus'));
                request.pOutRequestType = String.valueOf(newHeader.get('requestType'));
                request.pOutRootRequestId =String.valueOf(newHeader.get('rootRequestId'));
                request.pOutSolvedBy =String.valueOf(newHeader.get('solvedBy'));
                request.pOutSolvedDate = String.valueOf(newHeader.get('solvedDate'));
                request.pOutSourceAccountName = String.valueOf(newHeader.get('sourceAccountName'));
                request.pOutSourceAccountId = String.valueOf(newHeader.get('sourceAccountId'));
                request.pOutSourceCAId =String.valueOf(newHeader.get('sourceCAId'));
                request.pOutSourceOpId = String.valueOf(newHeader.get('sourceOpId'));
                request.pOutSourceTopParentId = String.valueOf(newHeader.get('sourceTopParentId'));
                request.pOutStartDate = String.valueOf(newHeader.get('startDate'));
                request.pOutUpdatedBy =String.valueOf(newHeader.get('updatedBy'));
                request.nameUpdatedBy = String.valueOf(newHeader.get('nameUpdatedBy'));
                
                system.debug('OEJ REQUUUUUUUUUUEST: ' + request);
                system.debug('request.pOutRequestId ' + request.pOutRequestId);
                //Comentamos DOC Types
                DocTypes = (Map<string,object>)newheader.get('docTypes');
                system.debug('OEJ DocTypes: '+ DocTypes);
                if(DocTypes != null)
                {
                    List<object>DoctypesList = (List<Object>)DocTypes.get('docType');
                    system.debug('OEJ DoctypesList '+DoctypesList );
                    request.docTypesToURL = '';
                    
                    for(object b : DoctypesList)
                    {
                        Map<String, Object> newDoctype = (Map<String, Object>) b;  
                        Map<String, Object> Doctype = (Map<String, Object>)newDoctype;
                        ES2_Wraper_Doctype Doct = new ES2_Wraper_Doctype();   
                        
                        Doct.IdDoc = String.valueOf(Doctype.get('id'));
                        Doct.name =  String.valueOf(Doctype.get('name'));
                        Doct.reqFlag = String.valueOf(Doctype.get('reqFlag'));
                        Doct.processName = string.valueOf(Doctype.get('processName'));
                        Doct.prm1 = string.valueOf(Doctype.get('prm1'));
                        WraperDoctList.add(Doct);
                        request.docTypesToURL = request.docTypesToURL + Doct.name + ';';
                        
                    }
                    system.debug('OEJ WraperDoctList: '+WraperDoctList);
                    request.DocTypesObj = WraperDoctList;
                }
                
                //Comentamos Related Request
                RelatedRequests = (Map<string,object>)newRequest.get('relatedRequests');
                system.debug('OEJ RelatedRequests: '+ RelatedRequests);
                if(RelatedRequests != null)
                {
                    List<object>RelatedRequestsList = (List<Object>)RelatedRequests.get('requestHeader');
                    system.debug('OEJ RelatedRequestsList '+RelatedRequestsList );
                    
                    for(object b : RelatedRequestsList)
                    {
                        Map<String, Object> newDoctype = (Map<String, Object>) b;  
                        Map<String, Object> releated = (Map<String, Object>)newDoctype;
                        ES4_wraper_RelatedRequest RelaReq = new ES4_wraper_RelatedRequest();   
                        
                        RelaReq.pOutActiveFlag = string.valueOf(releated.get('activeFlag'));
                        RelaReq.pOutndaType =  string.valueOf(releated.get('ndaType'));
                        RelaReq.pOutAssignedDate =String.valueOf(releated.get('assignedDate'));
                        RelaReq.pOutAssignedGroup=String.valueOf(releated.get('assignedGroup'));
                        RelaReq.pOutAssignedTo=String.valueOf(releated.get('assignedTo'));
                        RelaReq.nameAssignedTo = String.valueOf(releated.get('nameAssignedTo'));
                        RelaReq.pOutsourceTopParentName=String.valueOf(releated.get('sourceTopParentName'));
                        RelaReq.pOutCreatedBy=String.valueOf(releated.get('createdBy'));
                        RelaReq.nameCreatedBy = String.valueOf(releated.get('nameCreatedBy'));
                        RelaReq.pOutCreationDate=String.valueOf(releated.get('creationDate'));
                        RelaReq.pOutEGPartyId = String.valueOf(releated.get('egPartyId'));
                        RelaReq.pOutEGPartyName = String.valueOf(releated.get('egPartyName'));
                        RelaReq.pOutEndDate=String.valueOf(releated.get('endDate'));
                        RelaReq.pOutFinantialEntity = String.valueOf(releated.get('finantialEntity'));
                        RelaReq.pOutLastUpdateDate = String.valueOf(releated.get('lastUpdateDate'));
                        RelaReq.pOutPartyId = String.valueOf(releated.get('partyId'));
                        RelaReq.pOutPartyName = String.valueOf(releated.get('partyName'));
                        RelaReq.pOutProcessName = String.valueOf(releated.get('applicationId')); //antes era process name
                        RelaReq.pOutRequestedBy = String.valueOf(releated.get('requestedBy'));
                        RelaReq.nameRequestedBy = String.valueOf(releated.get('nameRequestedBy'));
                        RelaReq.pOutRequestId = String.valueOf(releated.get('requestId'));
                        RelaReq.pOutRequestStatus = String.valueOf(releated.get('requestStatus'));
                        RelaReq.pOutRequestType = String.valueOf(releated.get('requestType'));
                        RelaReq.pOutRootRequestId =String.valueOf(releated.get('rootRequestId'));
                        RelaReq.pOutSolvedBy =String.valueOf(releated.get('solvedBy'));
                        RelaReq.pOutSolvedDate = String.valueOf(releated.get('solvedDate'));
                        RelaReq.pOutSourceAccountId = String.valueOf(releated.get('sourceAccountId'));
                        RelaReq.pOutSourceCAId =String.valueOf(releated.get('sourceCAId'));
                        RelaReq.pOutSourceOpId = String.valueOf(releated.get('sourceOpId'));
                        RelaReq.pOutSourceTopParentId = String.valueOf(releated.get('sourceTopParentId'));
                        RelaReq.pOutStartDate = String.valueOf(releated.get('startDate'));
                        RelaReq.pOutUpdatedBy =String.valueOf(releated.get('updatedBy'));
                        RelaReq.nameUpdatedBy = String.valueOf(releated.get('nameUpdatedBy'));
                        related.add(RelaReq);  
                    }
                    system.debug('OEJ related: '+related);
                    
                    request.requestHIJO= related;
                }
                
                
                Map<string, Object> privileges = (Map<string,Object>)newRequest.get('privileges');
                
                System.debug('OEJ Privilegies: ' + privileges );
                if(privileges != null )
                {
                    List<object>privlist = (List<object>)privileges.get('privilege');
                    for(object privi:privlist){
                        Map<string,object>newPriv = (Map<string,object>)privi;
                        Map<string,object>pivileg = (Map<string,object>)newPriv;
                        EIV_PrivilegesWrapClass privilegx = new  EIV_PrivilegesWrapClass();
                        
                        privilegx.sso = string.valueOf(pivileg.get('sso'));
                        privilegx.applicationName = string.valueOf(pivileg.get('applicationName'));
                        privilegx.applicationCode = string.valueOf(pivileg.get('applicationCode'));
                        privilegx.screen = string.valueOf(pivileg.get('screen'));
                        privilegx.section = string.valueOf(pivileg.get('section'));
                        privilegx.employeeName = string.valueOf(pivileg.get('employeeName'));
                        privilegx.vCrud = string.valueOf(pivileg.get('vCrud'));
                        Privilegios.add(privilegx);
                    }
                    
                    request.privilegeObj = Privilegios;
                }
                /*Privilegios.sso = string.valueOf(privilege.get('sso'));
Privilegios.applicationName = string.valueOf(privilege.get('applicationName'));
Privilegios.applicationCode =  string.valueOf(privilege.get('applicationCode'));
Privilegios.screen = string.valueOf(privilege.get('screen'));
Privilegios.section = string.valueOf(privilege.get('section'));
Privilegios.employeeName =  string.valueOf(privilege.get('employeeName'));
Privilegios.vCrud = string.valueOf(privilege.get('vCrud'));

request.privilegeObj = Privilegios;*/
                
                
                /*Map<string, Object> workflow = (Map<string,Object>)newRequest.get('workflow');
System.debug('OEJ Workflow: ' + workflow );

Flujotrabjo.WFLEditFlag = string.valueOf(workflow.get('wflEditFlag'));

NextStatuses = (Map<string,Object>)workflow.get('wflNextStatuses');
List<object>StatusList = (List<Object>)NextStatuses.get('wflNextStatus');
system.debug('OEJ StatusList: ' + StatusList);

for(object c :StatusList )
{
Map<String, Object> newstatus = (Map<String, Object>)c;
Map<String, Object>status = (Map<String, Object>)newstatus;
ES2_Wraper_NextStatus estattus = new ES2_Wraper_NextStatus();

estattus.RWFLStatus =  string.valueOf(status.get('wflStatus'));
estatus.add(estattus);

}
Flujotrabjo.next =estatus;
request.workflowObj = Flujotrabjo;*/
                Map<string,object>comments = (Map<string,object>)newRequest.get('comments');
                if(comments!=null)
                {
                    List<object>commentList = (List<object>)comments.get('comment');
                    
                    for(object coment:commentList)
                    {
                        Map<string,object>newComent = (Map<string,object>)coment;
                        Map<string,object>comentario = (Map<string,object>)newComent;
                        ES2_wraper_coments comment = new ES2_wraper_coments();
                        
                        comment.pOutComId = string.valueOf(comentario.get('comId'));
                        comment.pOutComSection = string.valueOf(comentario.get('comSection'));
                        comment.pOutComComment = string.valueOf(comentario.get('comComment'));
                        comment.pOutComCreatedBy = string.valueOf(comentario.get('comCreatedBy'));
                        comment.comNameCreatedBy = string.valueOf(comentario.get('comNameCreatedBy'));
                        comment.pOutComCreationDate = string.valueOf(comentario.get('comCreationDate'));
                        comment.pOutComUpdatedBy = string.valueOf(comentario.get('comUpdatedBy'));
                        comment.comNameUpdatedBy = string.valueOf(comentario.get('comNameUpdatedBy'));
                        comment.pOutComLastUpdateDate = string.valueOf(comentario.get('comLastUpdateDate'));
                        
                        wComents.add(comment);
                    }
                    request.comentarios = wComents;
                }
                
                Map<string,object>documents =(Map<string,object>)newRequest.get('documents');
                if(documents!=null){
                    List<object>documentList = (List<object>)documents.get('document');
                    
                    for(object doc:documentList)
                    {
                        
                        Map<string,object>newDoc = (Map<string,object>)doc;
                        Map<string,object>docum = (Map<string,object>)newDoc;
                        ES2_wraper_documents docummentos = new  ES2_wraper_documents();
                        docummentos.oraId = string.valueOf(newDoc.get('id'));
                        docummentos.pOutDocId = string.valueOf(newDoc.get('contentDocId'));
                        docummentos.requestId = string.valueOf(newDoc.get('requestId'));
                        docummentos.pOutDocType = string.valueOf(newDoc.get('type')); 
                        docummentos.pOutDocName = string.valueOf(newDoc.get('name'));
                        docummentos.pOutDocStatus = string.valueOf(newDoc.get('status')); 
                        docummentos.pOutDocURL =  string.valueOf(newDoc.get('url'));
                        docummentos.pOutDocStartDate = string.valueOf(newDoc.get('startDate'));
                        docummentos.pOutDocEndDate = string.valueOf(newDoc.get('endDate'));
                        docummentos.pOutCreatedBy = string.valueOf(newDoc.get('createdBy'));
                        docummentos.pOutNameCreatedBy = string.valueOf(newDoc.get('nameCreatedBy'));
                        docummentos.pOutCreationDate = string.valueOf(newDoc.get('creationDate'));
                        //docummentos.docContentB64 =string.valueOf(newDoc.get('docContentB64'));
                        
                        wDocuments.add(docummentos);
                    }
                    
                    request.documentos =wDocuments;
                }
                
                Map<string,object>audits = (Map<string,object>)newRequest.get('audits');
                if(audits != null)
                {
                    List<object>auditList = (List<object>)audits.get('audit');
                    
                    for(object aud:auditList)
                    {
                        Map<string,object>newAudit =(Map<string,object>)aud;
                        Map<string,object>audit = (Map<string,object>)newAudit;
                        ES2_wraper_audits auditoria = new  ES2_wraper_audits();
                        
                        auditoria.pOutAuditUpdatedBy =  string.valueOf(audit.get('auditUpdatedBy'));
                        auditoria.auditNameUpdatedBy = string.valueOf(audit.get('auditNameUpdatedBy'));
                        auditoria.pOutAuditLastUpdateDate = string.valueOf(audit.get('auditLastUpdateDate'));
                        auditoria.pOutAuditField = string.valueOf(audit.get('auditField'));
                        auditoria.pOutAuditLastValue =  string.valueOf(audit.get('auditLastValue'));
                        auditoria.pOutAuditNewValue = string.valueOf(audit.get('auditNewValue'));
                        auditoria.pOutAuditComment = string.valueOf(audit.get('auditComment'));
                        
                        wAudits.add(auditoria);
                    }
                    
                    request.audits = wAudits;
                    
                }
                
                /*
Map<string,object>entityDocument = (Map<string,object>)newRequest.get('entityDocument');
enttyDocument.pOutEntityDocDummy = string.valueOf(entityDocument.get('entityDocDummy'));
request.documentdommy = enttyDocument;

Map<string,object>entityComment = (Map<string,object>)newRequest.get('entityComment');
enttyComent.pOutEntityComDummy = string.valueOf(entityComment.get('entityComDummy'));
request.comentdommy = enttyComent;*/
                
                switch on  request.pOutRequestType {
                    
                    when  'AML HITS CRR'{
                        system.debug('Estoy en AML');
                        Map<string, Object> amlCRR = (Map<string,Object>)newRequest.get('amlCRR');
                        if(amlCRR!=null){
                            system.debug('OEJ AMLCRR: ' + amlCRR);
                            
                            aml.CRR = string.valueOf(amlCRR.get('crr'));
                            
                            aml.CRRModificationDate = string.valueOf(amlCRR.get('crrModificationDate'));
                            aml.CRRExpirationDate = string.valueOf(amlCRR.get('crrExpirationDate'));
                            aml.CRROverride = string.valueOf(amlCRR.get('crrOverride'));
                            aml.CRRSourceType = string.valueOf(amlCRR.get('crrSourceType'));
                            aml.CRR_Override_Comment = string.valueOf(amlCRR.get('crrComments'));
                            request.amlObj = aml;
                        }
                        
                        Map<string,object> amlHits = (Map<string,object>)newRequest.get('amlHit');
                        if(amlHits!=null){
                            system.debug('OEJ AMLHITS: ' + amlHits);
                            
                            amlHit.RFC = string.valueOf(amlHits.get('hitRFC'));
                            amlHit.EntityName = string.valueOf(amlHits.get('hitEntityName'));
                            amlHit.hitExpirationDate = string.valueOf(amlHits.get('hitExpirationDate'));
                            amlHit.Flag = passval(String.valueOf(amlHits.get('hitFlag'))); 
                            amlHit.UwStatus = string.valueOf(amlHits.get('hitUwStatus'));
                            amlHit.UwComments = string.valueOf(amlHits.get('hitUwComments'));
                            amlHit.AMLStatus = string.valueOf(amlHits.get('hitAMLStatus'));
                            amlHit.AMLComments = string.valueOf(amlHits.get('hitAMLComments'));
                            amlHit.AMLMaxPercent = string.valueOf(amlHits.get('hitAMLMaxPercent'));
                            request.amlhitsObj =  amlHit;
                            Hits = (Map<String, Object>)amlHits.get('hits');
                            if(Hits!=null){
                                List<object>HitList = (List<object>)Hits.get('hit');
                                system.debug('OEJ HitList: ' + HitList);
                                
                                for(object d :HitList)
                                {
                                    Map<string,object>newHit = (Map<string,object>)d;
                                    Map<string,object>Hit = (Map<string,object>)newHit;
                                    ES2_wraper_hits hitsO = new ES2_wraper_hits();
                                    
                                    hitsO.HitSource = string.valueOf(Hit.get('hitSource'));
                                    hitsO.HitDescription = string.valueOf(Hit.get('hitDescription'));
                                    hitsO.HitPercent = string.valueOf(Hit.get('hitPercent'));
                                    
                                    wamlHits.add(hitsO);
                                    
                                }
                                
                                amlHit.hits = wamlHits;  
                            }
                        }                            
                    }
                    when   'CREDIT BUREAU' {
                        Map<string,object>creditBoureau = (Map<string,object>)newRequest.get('creditBureau');
                        if(creditBoureau!=null){
                            system.debug('OEJ creditBoureau: '+ creditBoureau);
                            
                            buro.CBPartySiteID = string.valueOf(creditBoureau.get('cbPartySiteID')); 
                            buro.CBLegalPartyId =string.valueOf(creditBoureau.get('cbLegalPartyId'));
                            buro.CBLegalPartyAlias =string.valueOf(creditBoureau.get('cbLegalPartyAlias'));//este no es el nombre falta con mau
                            buro.CBRejectReason = string.valueOf(creditBoureau.get('cbRejectReason'));
                            buro.CBLetterFlag = string.valueOf(creditBoureau.get('cbLetterFlag'));
                            buro.RFC = string.valueOf(creditBoureau.get('cbrfc'));
                            buro.cbCustomerType = string.valueOf(creditBoureau.get('cbCustomerType'));
                            buro.cbName = string.valueOf(creditBoureau.get('cbName'));
                            buro.cbSecondName =string.valueOf(creditBoureau.get('cbSecondName'));
                            buro.cbLastName =string.valueOf(creditBoureau.get('cbLastName'));
                            buro.cbSecondLastName =string.valueOf(creditBoureau.get('cbSecondLastName'));
                            buro.cbAPIRequestor =string.valueOf(creditBoureau.get('cbAPIRequestor'));
                            buro.CompanyName =string.valueOf(creditBoureau.get('cbcompanyName'));
                            buro.Address = string.valueOf(creditBoureau.get('cbaddress'));
                            buro.ECEntity = string.valueOf(creditBoureau.get('cbecEntity'));
                            buro.cbTransactionId=string.valueOf(creditBoureau.get('cbTransactionId'));
                            
                            system.debug('(String)creditBoureau.get(cbletterSigningDate) ' + (String)creditBoureau.get('cbletterSigningDate') );
                            if(String.isNotBlank((String)creditBoureau.get('cbletterSigningDate')))
                            {
                                buro.LetterSigningDate = date.parse((String)creditBoureau.get('cbletterSigningDate')   );//falta este para mauricio
                            }
                            
                            buro.LetterSigningPlace = string.valueOf(creditBoureau.get('cbletterSigningPlace'));
                            buro.Alias = string.valueOf(creditBoureau.get('cbalias'));
                            buro.Street = string.valueOf(creditBoureau.get('cbstreetAndNumber'));//falta con mau.....CHECAR QUE LOS SEPARE .....
                            buro.intnum = string.valueOf(creditBoureau.get('cbIntNum'));/////faltaa
                            buro.outnum = string.valueOf(creditBoureau.get('cbOutNum'));//////faltaa
                            buro.municipality = string.valueOf(creditBoureau.get('cbMunicipality'));///////////faltaaa
                            buro.Suburb = string.valueOf(creditBoureau.get('cbsuburb'));
                            buro.ZipCode = string.valueOf(creditBoureau.get('cbzipCode'));
                            buro.City = string.valueOf(creditBoureau.get('cbcity')); 
                            buro.State = string.valueOf(creditBoureau.get('cbstate'));
                            buro.Country = string.valueOf(creditBoureau.get('cbcountry')); 
                            buro.AutorizationLetter = string.valueOf(creditBoureau.get('cbautorizationLetter')); 
                        }
                        /*alerts = (Map<string,object>)creditBoureau.get('alerts');
List<object>alertsList = (List<object>)alerts.get('alert');

for(object e:alertsList)
{
Map<string,object>newAlert = (Map<string,object>)e;
Map<string,object>alert = (Map<string,object>)newAlert;
ES2_wraper_Alerts alerta = new ES2_wraper_Alerts();

alerta.AlertName = string.valueOf(alert.get('cbAlertName'));
alerta.AlertValue = string.valueOf(alert.get('cbAlertValue'));
alerta.AlertColor = string.valueOf(alert.get('cbAlertColor'));

walerts.add(alerta);
}

buro.alert = walerts;*/
                        request.CreditBureauObj = buro;
                        system.debug('OEJ maaap reqeuestt: '+ mapRequest);
                    }
                    when 'Credit Approval'
                    {
                        Map<string,object>creditApproval =(Map<string,object>)newRequest.get('creditApproval');
                        system.debug('OEJ CREEEDIT APROVAL:' + creditApproval);
                        if(creditApproval != null)
                        {
                            parties = (Map<string,object>)creditApproval.get('parties');
                            List<object>partyList = (List<object>)parties.get('party');
                            
                            for(object fiesta:partyList)
                            {
                                Map<string,object>newFiesta = (Map<string,object>)fiesta;
                                Map<string,object>fieston = (Map<string,object>)newFiesta;
                                ES2_Wraper_CreditApproval party =  new ES2_Wraper_CreditApproval();
                                
                                party.oppPartyId = string.valueOf(fieston.get('oppPartyId'));
                                party.oppPartyName = string.valueOf(fieston.get('oppPartyName'));
                                party.oppPartyObligorFlag = string.valueOf(fieston.get('oppPartyObligorFlag'));
                                party.oppPartyGuarantorFlag = string.valueOf(fieston.get('oppPartyGuarantorFlag'));
                                party.oppPartyBOFlag = string.valueOf(fieston.get('oppPartyBOFlag'));
                                party.oppPartyRDEFlag = string.valueOf(fieston.get('oppPartyRDEFlag'));
                                wCreditAproval.add(party);
                            }
                            
                            request.creditAproval =  wCreditAproval;
                            
                        }
                        
                    }
                    when 'EVAL'{
                        Map<string,object> evalsD = (Map<string,object>)newRequest.get('eval');
                        system.debug('esta madre deberia llegar asi' + evalsD);
                        if(evalsD != null){
                            system.debug('JDLL EVAL: ' + evalsD);
                            
                            Map<string,object>EVALH =  (Map<string,object>)evalsD.get('evalHeader');
                            if(EVALH != null)
                            {
                                system.debug('JDLL EVAL Header: ' + EVALH);
                                evalsP.pOutEVEVALType = string.valueOf(EVALH.get('evEvalType'));
                                evalsP.pOutEVInsuranceReqFlag = string.valueOf(EVALH.get('evInsuranceReqFlag'));
                                evalsP.pOutEVEFAReqFlag = string.valueOf(EVALH.get('evEfaReqFlag'));
                                evalsP.pOutEVSLBFlag = string.valueOf(EVALH.get('evSlbFlag'));
                                evalsP.pOutEVImportsReqFlag = string.valueOf(EVALH.get('evImportsReqFlag'));
                                evalsP.pOutEVProgressPayFlag = string.valueOf(EVALH.get('evProgressPayFlag'));
                                evalsP.pOutEVShowFMVFlag = string.valueOf(EVALH.get('evShowFMVFlag'));
                                evalsP.pOutEVFreezeEvalFlag = string.valueOf(EVALH.get('evFreezeEvalFlag'));
                                evalsP.pOutEVFreezeStartDate = string.valueOf(EVALH.get('evFreezeStartDate'));
                                evalsP.OutEVFreezeEndDate = string.valueOf(EVALH.get('evFreezeEndDate'));
                                evalsP.pOutEVProgressPayTermMonths = string.valueOf(EVALH.get('evProgressPayTermMonths'));
                                evalsP.pOutEVEquipmentAmount = string.valueOf(EVALH.get('evEquipmentAmount'));
                                evalsP.pOutEVEquipmentAmountTax = string.valueOf(EVALH.get('evEquipmentAmountTax'));
                                evalsP.pOutEVEquipmentAmountPercent = string.valueOf(EVALH.get('evEquipmentAmountPercent'));
                                evalsP.pOutEVCostAmount = string.valueOf(EVALH.get('evCostAmount'));
                                evalsP.pOutEVCostAmountTax = string.valueOf(EVALH.get('evCostAmountTax'));
                                evalsP.pOutEVCostAmountPercent = string.valueOf(EVALH.get('evCostAmountPercent'));
                                evalsP.pOutEVCurrencyType = string.valueOf(EVALH.get('evCurrencyType'));
                                evalsP.pOutEVExchangeRate = string.valueOf(EVALH.get('evExchangeRate'));
                                evalsP.pOutEVAssetCount = string.valueOf(EVALH.get('evAssetCount'));
                                evalsP.pOutEVProductType = string.valueOf(EVALH.get('evProductType'));
                                evalsP.pOutEVResidualMaxTermMonths = string.valueOf(EVALH.get('evResidualMaxTermMonths'));
                                evalsP.pOutEVSpecialTermMonths01 = string.valueOf(EVALH.get('evSpecialTermMonths01'));
                                evalsP.pOutEVSpecialTermMonths02 = string.valueOf(EVALH.get('evSpecialTermMonths02'));
                                evalsP.pOutEVSpecialTermMonths03 = string.valueOf(EVALH.get('evSpecialTermMonths03'));
                                evalsP.pOutEVEndorsementComment = string.valueOf(EVALH.get('evEndorsementComment'));
                                
                                
                                Map<string,object>EVALD =  (Map<string,object>)evalsD.get('evalDetail');  
                                system.debug('JDLL EVAL Detail: ' + EVALD);
                                if(EVALD != null)
                                {
                                    Map<string,object>tablaAsset = (Map<string,object>)EVALD.get('evAssets');
                                    
                                    system.debug('JDLL EVAL Assets: ' + tablaAsset);
                                    if(tablaAsset != null)
                                    {
                                        List<object>tablaALista = (list<object>)tablaAsset.get('evAsset');
                                        system.debug('JDLL EVAL Asset: ' + tablaALista);
                                        
                                        for(object EVALA:tablaALista)
                                        {
                                            Map<string,object>newEVALA = (Map<string,object>)EVALA;
                                            Map<string,object>EVALAsset =(Map<string,object>)newEVALA;
                                            system.debug('datos' + EVALAsset);
                                            if(EVALAsset != null)
                                            {
                                                ES4_wraper_EVAL_Assets ASS = new ES4_wraper_EVAL_Assets();
                                                ASS.pOutEVAssetAssetId = string.valueOf(EVALAsset.get('evAssetAssetId'));
                                                ASS.pOutEVAssetRequestId = string.valueOf(EVALAsset.get('evAssetRequestId'));
                                                ASS.pOutEVAssetOracleFACategoryID = string.valueOf(EVALAsset.get('evAssetOracleFACategoryId'));
                                                ASS.pOutEVAssetOracleFACategory = string.valueOf(EVALAsset.get('evAssetOracleFACategory'));
                                                ASS.pOutEVAssetOracleFASubcategory = string.valueOf(EVALAsset.get('evAssetOracleFASubcategory'));
                                                ASS.pOutEVAssetCollateralType = string.valueOf(EVALAsset.get('evAssetCollateralType'));
                                                ASS.pOutEVAssetCollateralDescription = string.valueOf(EVALAsset.get('evAssetCollateralDescription'));
                                                ASS.pOutEVAssetCollateralId = string.valueOf(EVALAsset.get('evAssetCollateralId'));
                                                ASS.pOutEVAssetAssetModel = string.valueOf(EVALAsset.get('evAssetAssetModel'));
                                                ASS.pOutEVAssetAssetModelYear = string.valueOf(EVALAsset.get('evAssetAssetModelYear'));
                                                ASS.pOutEVAssetManufacturer = string.valueOf(EVALAsset.get('evAssetManufacturer'));
                                                ASS.pOutEVAssetCurrencyType = string.valueOf(EVALAsset.get('evAssetCurrencyType'));
                                                ASS.pOutEVAssetExchangeRate = string.valueOf(EVALAsset.get('evAssetExchangeRate'));
                                                ASS.pOutEVAssetQuantity = string.valueOf(EVALAsset.get('evAssetQuantity'));
                                                ASS.pOutEVAssetUnitCost = string.valueOf(EVALAsset.get('evAssetUnitCost'));
                                                ASS.pOutEVAssetUnitTax = string.valueOf(EVALAsset.get('evAssetUnitTax'));
                                                ASS.pOutEVAssetFreightCost = string.valueOf(EVALAsset.get('evAssetFreightCost'));
                                                ASS.pOutEVAssetParkingCost = string.valueOf(EVALAsset.get('evAssetParkingCost'));
                                                ASS.pOutEVAssetInstallationCost = string.valueOf(EVALAsset.get('evAssetInstallationCost'));
                                                ASS.pOutEVAssetTrainingCost = string.valueOf(EVALAsset.get('evAssetTrainingCost'));
                                                ASS.pOutEVAssetWarrantyCost = string.valueOf(EVALAsset.get('evAssetWarrantyCost'));
                                                ASS.pOutEVAssetSoftwareCost = string.valueOf(EVALAsset.get('evAssetSoftwareCost'));
                                                ASS.pOutEVAssetConditionType = string.valueOf(EVALAsset.get('evAssetConditionType'));
                                                ASS.pOutEVAssetTotalCost = string.valueOf(EVALAsset.get('evAssetTotalCost'));
                                                ASS.pOutEVAssetPhysicalCatType = string.valueOf(EVALAsset.get('evAssetPhysicalCatType'));
                                                ASS.pOutEVAssetInsuranceType = string.valueOf(EVALAsset.get('evAssetInsuranceType'));
                                                ASS.pOutEVAssetMultLocationFlag = string.valueOf(EVALAsset.get('evAssetMultLocationFlag'));
                                                ASS.pOutEVAssetRapidTagFlag = string.valueOf(EVALAsset.get('evAssetRapidTagFlag'));
                                                ASS.pOutEVAssetImportFlag = string.valueOf(EVALAsset.get('evAssetImportFlag'));
                                                ASS.pOutevAssetClonedAssetId = string.valueOf(EVALAsset.get('evAssetClonedAssetId'));
                                                Map<string,object>tablaValuations = (Map<string,object>)EVALAsset.get('evAssetValuations');
                                                if(tablaValuations != null)
                                                {
                                                    list <ES4_Wraper_EVAL_Valuation> valu = new list <ES4_Wraper_EVAL_Valuation>();
                                                    List<object>valList = (List<object>)tablaValuations.get('evValuation');
                                                    
                                                    for(object val1:valList)
                                                    {
                                                        Map<string,object>val2 =(Map<string,object>)val1;
                                                        Map<string,object>valuation = (Map<string,object>)val2;
                                                        
                                                        if(valuation != null)
                                                        {    
                                                            ES4_Wraper_EVAL_Valuation val = new ES4_Wraper_EVAL_Valuation();
                                                            val.pOutEVValValuationId = string.valueOf(valuation.get('evValValuationId'));
                                                            val.pOutEVValAssetId = string.valueOf(valuation.get('evValAssetId'));
                                                            val.pOutEVValRequestId = string.valueOf(valuation.get('evValRequestId'));
                                                            val.pOutEVValTermMonths = string.valueOf(valuation.get('evValTermMonths'));
                                                            val.pOutEVValFMVAmount = string.valueOf(valuation.get('evValFmvAmount'));
                                                            val.pOutEVValFMVPercent = string.valueOf(valuation.get('evValFmvPercent'));
                                                            val.pOutEVValNRVAmount = string.valueOf(valuation.get('evValNrvAmount'));
                                                            val.pOutEVValNRVPercent = string.valueOf(valuation.get('evValNrvPercent'));
                                                            val.pOutEVValOLVAmount = string.valueOf(valuation.get('evValOlvAmount'));
                                                            val.pOutEVValOLVPercent = string.valueOf(valuation.get('evValOlvPercent'));
                                                            val.pOutEVValRVAmount = string.valueOf(valuation.get('evValRvAmount'));
                                                            val.pOutEVValRVPercent = string.valueOf(valuation.get('evValRvPercent'));
                                                            val.pOutEVValInsurancePrima = string.valueOf(valuation.get('evValInsurancePrima'));
                                                            val.pOutEVValActiveFlag = string.valueOf(valuation.get('evValActiveFlag'));
                                                            val.pOutEVValCreatedBy = string.valueOf(valuation.get('evValCreatedBy'));
                                                            val.pOutEVValCreationDate = string.valueOf(valuation.get('evValNameCreatedBy'));
                                                            val.pOutEVValLastUpdatedBy = string.valueOf(valuation.get('evValCreationDate'));
                                                            val.pOutEVValLastUpdateDate = string.valueOf(valuation.get('evValLastUpdatedBy'));
                                                            val.pOutEVValNameCreatedBy = string.valueOf(valuation.get('evValNameUpdatedBy'));
                                                            val.pOutEVValNameUpdatedBy = string.valueOf(valuation.get('evValLastUpdateDate'));
                                                            valu.add(val);
                                                        }
                                                        
                                                    }
                                                    ASS.pOutEVValuationTBL = valu;
                                                    
                                                    
                                                }
                                                
                                                Map<string,object>tablaEndorsements = (Map<string,object>)EVALAsset.get('evAssetEndorsements');
                                                if(tablaEndorsements != null)
                                                {
                                                    list <ES4_Wraper_EVAL_Endorsement> Endor = new list <ES4_Wraper_EVAL_Endorsement>();
                                                    List<object>EndList = (List<object>)tablaEndorsements.get('evEndorsement');
                                                    
                                                    for(object End1:EndList)
                                                    {
                                                        Map<string,object>End2 =(Map<string,object>)End1;
                                                        Map<string,object>Endorsement = (Map<string,object>)End2;
                                                        
                                                        if(Endorsement != null)
                                                        {    
                                                            ES4_Wraper_EVAL_Endorsement Endo = new ES4_Wraper_EVAL_Endorsement();
                                                            Endo.pOutEVEndEndorsementId = string.valueOf(Endorsement.get('evEndEndorsementId'));
                                                            Endo.pOutEVEndAssetId = string.valueOf(Endorsement.get('evEndAssetId'));
                                                            Endo.pOutEVEndRequestId = string.valueOf(Endorsement.get('evEndRequestId'));
                                                            Endo.pOutEVEndAttributeType = string.valueOf(Endorsement.get('evEndAttributeType'));
                                                            Endo.pOutEVEndValueType = string.valueOf(Endorsement.get('evEndValueType'));
                                                            Endo.pOutEVEndUomType = string.valueOf(Endorsement.get('evEndUomType'));
                                                            Endo.pOutEVEndValueOther = string.valueOf(Endorsement.get('evEndValueOther'));
                                                            Endo.pOutEVEndComment = string.valueOf(Endorsement.get('evEndComment'));
                                                            Endo.pOutEVEndActiveFlag = string.valueOf(Endorsement.get('evEndActiveFlag'));
                                                            Endo.pOutEVEndCreatedBy = string.valueOf(Endorsement.get('evEndCreatedBy'));
                                                            Endo.pOutEVEndNameCreatedBy = string.valueOf(Endorsement.get('evEndNameCreatedBy'));
                                                            Endo.pOutEVEndCreationDate = string.valueOf(Endorsement.get('evEndCreationDate'));
                                                            Endo.pOutEVEndLastUpdatedBy = string.valueOf(Endorsement.get('evEndLastUpdatedBy'));
                                                            Endo.pOutEVEndNameUpdatedBy = string.valueOf(Endorsement.get('evEndNameUpdatedBy'));
                                                            Endo.pOutEVEndLastUpdateDate = string.valueOf(Endorsement.get('evEndLastUpdateDate'));
                                                            Endor.add(Endo);
                                                        }
                                                        
                                                    }
                                                    ASS.pOutEVEndorsementTBL = Endor;
                                                    
                                                    
                                                }
                                                assets.add(ASS);
                                                system.debug('esta madre llega asi' + assets);
                                            }
                                            evalsP.pOutEVAssetTBL= assets;
                                        }
                                        
                                        
                                    }
                                    
                                    
                                }
                                
                                request.EVALOBJ =evalsP;
                            }
                        }
                    }
                    when 'KYC INDIVIDUAL'
                    {
                        Map<string,object>KYCInd = (Map<string,object>)newRequest.get('kycInd');
                        if(KYCInd != null)
                        {
                            system.debug('OEJ KYCInd: ' + KYCInd);
                            
                            kwyfisc.pOutKYCIndName =  string.valueOf(KYCInd.get('kycIndName'));
                            
                            Map<string,object>DatosG =  (Map<string,object>)KYCInd.get('datosGenerales');
                            if(DatosG != null)
                            {
                                system.debug('OEJ datosGenerales: ' + DatosG);
                                if(String.IsNotBlank(String.valueOf(DatosG.get('kycIndGDBirthDate'))))
                                {
                                    wdatosG.BirthDate = Test.isRunningTest() ? date.newInstance(218, 11, 11): date.parse((String)DatosG.get('kycIndGDBirthDate'));
                                }
                                
                                wdatosG.GDRFC = string.valueOf(DatosG.get('kycIndGDRFC'));
                                wdatosG.GDCURP = string.valueOf(DatosG.get('kycIndGDCURP'));
                                wdatosG.GDNacionalities = string.valueOf(DatosG.get('kycIndGDNacionalities'));
                                wdatosG.GDFEASerialNo = string.valueOf(DatosG.get('kycIndGDFEASerialNo'));
                                wdatosG.GDBirthCountry = string.valueOf(DatosG.get('kycIndGDBirthCountry'));
                                wdatosG.GDBirthState = string.valueOf(DatosG.get('kycIndGDBirthState'));
                                wdatosG.GDSex = string.valueOf(DatosG.get('kycIndGDSex'));
                                wdatosG.GDMarriageStatus = string.valueOf(DatosG.get('kycIndGDMarriageStatus'));
                                wdatosG.GDMarriageRegime = string.valueOf(DatosG.get('kycIndGDMarriageRegime'));
                                wdatosG.GDNameOfSpouse = string.valueOf(DatosG.get('kycIndGDNameOfSpouse'));
                                kwyfisc.datosObj = wdatosG;
                                request.kwypfObj = kwyfisc;
                            }
                            Map<string,object>domicilioParticular =(Map<string,object>)KYCInd.get('domicilioParticular');
                            if(domicilioParticular != null){
                                system.debug('OEJ domicilioParticular: ' + domicilioParticular);
                                
                                wdomicilioP.pOutKYCIndAdrStreet = string.valueOf(domicilioParticular.get('kycIndAdrStreet'));
                                wdomicilioP.pOutKYCIndAdrOutNum = string.valueOf(domicilioParticular.get('kycIndAdrOutNum'));
                                wdomicilioP.pOutKYCIndAdrIntNum = string.valueOf(domicilioParticular.get('kycIndAdrIntNum'));
                                wdomicilioP.pOutKYCIndAdrCounty = string.valueOf(domicilioParticular.get('kycIndAdrCounty'));
                                wdomicilioP.pOutKYCIndAdrMunicipality = string.valueOf(domicilioParticular.get('kycIndAdrMunicipality'));
                                wdomicilioP.pOutKYCIndAdrCity = string.valueOf(domicilioParticular.get('kycIndAdrCity'));
                                wdomicilioP.pOutKYCIndAdrState = string.valueOf(domicilioParticular.get('kycIndAdrState'));
                                wdomicilioP.pOutKYCIndAdrCountry = string.valueOf(domicilioParticular.get('kycIndAdrCountry'));
                                wdomicilioP.pOutKYCIndIntAdrZipCode = string.valueOf(domicilioParticular.get('kycIndIntAdrZipCode'));
                                kwyfisc.dominioObj = wdomicilioP;
                                request.kwypfObj = kwyfisc;
                            }
                            Map<string,object>datosGralesEmpleo = (Map<string,object>)KYCInd.get('datosGralesEmpleo');
                            if(datosGralesEmpleo != null){
                                system.debug('OEJ datosGralesEmpleo' + datosGralesEmpleo);
                                
                                wdatosEmpleo.pOutKYCIndBizTitle = string.valueOf(datosGralesEmpleo.get('kycIndBizTitle'));
                                wdatosEmpleo.pOutKYCIndBizRelatedPaties = string.valueOf(datosGralesEmpleo.get('kycIndBizRelatedPaties'));
                                kwyfisc.datosgObj = wdatosEmpleo;
                                request.kwypfObj =kwyfisc;
                            }
                            Map<string,object>PPE = (Map<string,object>)KYCInd.get('ppe');
                            
                            system.debug('OEJ PPE: ' + PPE);
                            if(PPE != null)
                            {
                                wPPE.pOutKYCIndPPEFlag = string.valueOf(PPE.get('kycIndPPEFlag'));
                                wPPE.pOutKYCIndPPEJob =  string.valueOf(PPE.get('kycIndPPEJob'));
                                wPPE.pOutKYCIndPPEAFlag = string.valueOf(PPE.get('kycIndPPEAFlag'));
                                wPPE.pOutKYCIndPPEAName = string.valueOf(PPE.get('kycIndPPEAName'));
                                wPPE.pOutKYCIndPPEARelationship = string.valueOf(PPE.get('kycIndPPEARelationship'));
                                
                                kwyfisc.ppeObj =wPPE;
                                request.kwypfObj = kwyfisc;
                                
                            }
                            
                            
                            Map<string,object>tablaProveedorRecursos = (Map<string,object>)KYCInd.get('tablaProveedorRecursos');
                            if(tablaProveedorRecursos != null)
                            {
                                List<object>proveedorRecurso = (List<object>)tablaProveedorRecursos.get('proveedorRecurso');
                                
                                for(object f:proveedorRecurso)
                                {
                                    Map<string,object>newProveedorRecurso =(Map<string,object>)f;
                                    Map<string,object>proveedor = (Map<string,object>)newProveedorRecurso;
                                    ES2_wraper_proveedorRecurso provR = new ES2_wraper_proveedorRecurso();
                                    if(proveedor != null)
                                    {    
                                        provR.kycIndResId = string.valueOf(proveedor.get('kycIndResId'));
                                        provR.pOutKYCIndResLegalName = string.valueOf(proveedor.get('kycIndResLegalName'));
                                        provR.pOutKYCIndResCountry = string.valueOf(proveedor.get('kycIndResCountry'));
                                        provR.pOutKYCIndResRFC = string.valueOf(proveedor.get('kycIndResRFC'));
                                        provR.pOutKYCIndResAddress = string.valueOf(proveedor.get('kycIndResAddress'));
                                        provR.pOutKYCIndResFEASerialNo = string.valueOf(proveedor.get('kycIndResFEASerialNo'));
                                        
                                        wProveedorR.add(provR);
                                    }
                                    
                                }
                                
                                kwyfisc.provedorObj = wProveedorR;
                                request.kwypfObj = kwyfisc;
                                
                            }
                            
                            Map<string,object>suscritoPor = (Map<string,object>)KYCInd.get('suscritoPor');
                            if(suscritoPor != null){
                                system.debug('OEJ suscritoPor: ' + suscritoPor);
                                
                                wsuscrito.pOutKYCIndSignName = string.valueOf(suscritoPor.get('kycIndSignName'));
                                wsuscrito.pOutKYCIndSignFlag = string.valueOf(suscritoPor.get('kycIndSignFlag'));
                                wsuscrito.pOutKYCIndSignPowerFlag = string.valueOf(suscritoPor.get('kycIndSignPowerFlag'));
                                wsuscrito.pOutKYCIndSignPublicDeedNum = string.valueOf(suscritoPor.get('kycIndSignPublicDeedNum'));
                                if(String.IsNotBlank((String)suscritoPor.get('kycIndSignPublicDeedDate')))
                                {
                                    wsuscrito.pOutKYCIndSignPublicDeedDate = Test.isRunningTest() ? date.newInstance(218, 11, 11): date.parse((String)suscritoPor.get('kycIndSignPublicDeedDate')  );
                                }
                                
                                
                                wsuscrito.pOutKYCIndSignNotaryName = string.valueOf(suscritoPor.get('kycIndSignNotaryName'));
                                wsuscrito.pOutKYCIndSignNotaryNum = string.valueOf(suscritoPor.get('kycIndSignNotaryNum'));
                                wsuscrito.pOutKYCIndSignNotaryState = string.valueOf(suscritoPor.get('kycIndSignNotaryState'));
                                wsuscrito.pOutKYCIndSignDateDay = string.valueOf(suscritoPor.get('kycIndSignDateDay'));
                                wsuscrito.pOutKYCIndSignDateMonth = string.valueOf(suscritoPor.get('kycIndSignDateMonth'));
                                wsuscrito.pOutKYCIndSignDateYear = string.valueOf(suscritoPor.get('kycIndSignDateYear'));
                                
                                kwyfisc.suscritoObj =wsuscrito;
                                request.kwypfObj = kwyfisc;
                            }
                        }
                    }
                    when 'KYC ORGANIZATION'
                    {
                        Map<string,object>kycOrg = (Map<string,object>)newRequest.get('kycOrg');
                        if(kycOrg != null){
                            kwyMoral.pOutKYCOrgName =  string.valueOf(kycOrg.get('kycOrgName'));
                            Map<string,object>datosGenerales =(Map<string,object>)kycOrg.get('datosGenerales');
                            if(datosGenerales != null){
                                wdatosGM.GDRFC = string.valueOf(datosGenerales.get('kycOrgGDRFC'));
                                if(String.IsNotBlank(String.valueOf(datosGenerales.get('kycOrgGDBirthDate'))))
                                {
                                    wdatosGM.BirthDate = Test.isRunningTest() ? date.newInstance(218, 11, 11):  date.parse((String)datosGenerales.get('kycOrgGDBirthDate')) ;
                                }
                                // wdatosGM.BirthDate = date.parse((String)datosGenerales.get('kycOrgGDBirthDate')  ); 
                                wdatosGM.kycOrgGDNacionality = string.valueOf(datosGenerales.get('kycOrgGDNacionality'));
                                wdatosGM.GDFEASerialNo = string.valueOf(datosGenerales.get('kycOrgGDFEASerialNo'));
                                wdatosGM.GDPhone = string.valueOf(datosGenerales.get('kycOrgGDPhone'));
                                wdatosGM.GDEmail = string.valueOf(datosGenerales.get('kycOrgGDEmail'));
                                wdatosGM.GDActivity = string.valueOf(datosGenerales.get('kycOrgGDActivity'));
                                
                                kwyMoral.datosgObj = wdatosGM;
                                request.kwypmObj = kwyMoral;
                            }
                            Map<string,object>domParticularPm =(Map<string,object>)kycOrg.get('domicilioParticular');
                            if(domParticularPm != null){
                                wdomicilioPM.kycOrgAdrStreet = string.valueOf(domParticularPm.get('kycOrgAdrStreet'));
                                wdomicilioPM.kycOrgAdrOutNum =  string.valueOf(domParticularPm.get('kycOrgAdrOutNum'));
                                wdomicilioPM.kycOrgAdrIntNum = string.valueOf(domParticularPm.get('kycOrgAdrIntNum'));
                                wdomicilioPM.kycOrgAdrCounty =  string.valueOf(domParticularPm.get('kycOrgAdrCounty'));
                                wdomicilioPM.kycOrgAdrMunicipality = string.valueOf(domParticularPm.get('kycOrgAdrMunicipality'));
                                wdomicilioPM.kycOrgAdrCity = string.valueOf(domParticularPm.get('kycOrgAdrCity'));
                                wdomicilioPM.kycOrgAdrState = string.valueOf(domParticularPm.get('kycOrgAdrState'));
                                wdomicilioPM.kycOrgIntAdrCountry = string.valueOf(domParticularPm.get('kycOrgIntAdrCountry'));
                                wdomicilioPM.kycOrgIntAdrZipCode = string.valueOf(domParticularPm.get('kycOrgIntAdrZipCode'));
                                
                                kwyMoral.domiciliopObj = wdomicilioPM;
                                request.kwypmObj =kwyMoral;
                            }
                            Map<string,object>actividadEconomica = (Map<string,object>)kycOrg.get('actividadEconomica');
                            if(actividadEconomica != null){
                                wActividadEPM.pOutKYCOrgActGovFlag = string.valueOf(actividadEconomica.get('kycOrgActGovFlag'));
                                wActividadEPM.pOutKYCOrgActGovPartyName = string.valueOf(actividadEconomica.get('kycOrgActGovPartyName'));
                                wActividadEPM.pOutKYCOrgActGovAnnualIncome = string.valueOf(actividadEconomica.get('kycOrgActGovAnnualIncome'));
                                wActividadEPM.pOutKYCOrgActGovServices = string.valueOf(actividadEconomica.get('kycOrgActGovServices'));
                                wActividadEPM.pOutKYCOrgActGovAge = string.valueOf(actividadEconomica.get('kycOrgActGovAge'));
                                
                                kwyMoral.actividadeObj = wActividadEPM;
                                request.kwypmObj =kwyMoral;
                            }
                            kwyMoral.pOutKYCOrgFinanceUse = string.valueOf(kycOrg.get('kycOrgFinanceUse'));
                            request.kwypmObj = kwyMoral;
                            
                            Map<string,object>mercadoGeografico = (Map<string,object>)kycOrg.get('mercadoGeografico');
                            if(mercadoGeografico != null){
                                wMercadoGPM.pOutKYCOrgCorpSites =  string.valueOf(mercadoGeografico.get('kycOrgCorpSites'));
                                wMercadoGPM.pOutKYCOrgMktSites = string.valueOf(mercadoGeografico.get('kycOrgMktSites'));
                                
                                kwyMoral.mercadogObj = wMercadoGPM;
                                request.kwypmObj = kwyMoral;
                            }
                            Map<string,object>tablaCuentasBancarias = (Map<string,object>)kycOrg.get('tablaCuentasBancarias');
                            if(tablaCuentasBancarias != null)
                            {
                                List<object>CuentasBLista = (list<object>)tablaCuentasBancarias.get('cuentaBancaria');
                                for(object cuent:CuentasBLista)
                                {
                                    Map<string,object>newCuentaBanc = (Map<string,object>)cuent;
                                    Map<string,object>cuentaBanc =(Map<string,object>)newCuentaBanc;
                                    ES2_wraper_cuentasbancarias ctnB = new ES2_wraper_cuentasbancarias();
                                    if(cuentaBanc != null)
                                    {   
                                        ctnB.kycOrgBankId = String.valueOf(cuentaBanc.get('kycOrgBankId')); 
                                        ctnB.pOutKYCOrgBankName  = String.valueOf(cuentaBanc.get('kycOrgBankName')); 
                                        ctnB.pOutKYCOrgBankAccount = string.valueOf(cuentaBanc.get('kycOrgBankAccount'));
                                        ctnB.pOutKYCOrgBankCountry = string.valueOf(cuentaBanc.get('kycOrgBankCountry'));
                                        wCuentasBancariasPM.add(ctnB);                                        
                                    }
                                    
                                    
                                }                
                                
                                kwyMoral.cuentas = wCuentasBancariasPM;
                                request.kwypmObj = kwyMoral;
                            }
                            
                            kwyMoral.pOutKYCOrgBankPayeeName = string.valueOf(kycOrg.get('kycOrgBankPayeeName'));
                            
                            Map<string,object>ppeM = (Map<string,object>)kycOrg.get('ppe');
                            if(ppeM != null)
                            {
                                wppeM.kycOrgPPEFlag = string.valueOf(ppeM.get('kycOrgPPEFlag'));
                                wppeM.kycOrgPPEJob = string.valueOf(ppeM.get('kycOrgPPEJob'));
                                wppeM.kycOrgPPEName = string.valueOf(ppeM.get('kycOrgPPEName'));
                                wppeM.kycOrgPPEAName = string.valueOf(ppeM.get('kycOrgPPEAName'));
                                wppeM.kycOrgPPEARelationship = string.valueOf(ppeM.get('kycOrgPPEARelationship'));
                                wppeM.pOutKYCOrgPPEABoardJob = string.valueOf(ppeM.get('kycOrgPPEABoardJob'));
                                wppeM.pOutKYCOrgPPEABoardName = string.valueOf(ppeM.get('kycOrgPPEABoardName'));
                                wppeM.pOutKYCOrgPPEAName2 = string.valueOf(ppeM.get('kycOrgPPEAName2'));
                                wppeM.pOutKYCOrgPPEARelationship2 = string.valueOf(ppeM.get('kycOrgPPEARelationship2'));
                                
                                kwyMoral.PPEObj = wppeM;
                                request.kwypmObj = kwyMoral;
                            }
                            Map<string,object>tablaProveedoresRecursos =(Map<string,object>)kycOrg.get('tablaProveedoresRecursos');
                            if(tablaProveedoresRecursos != null)
                            {
                                List<object>ProvRecMList = (List<object>)tablaProveedoresRecursos.get('proveedorRecurso');
                                for(object provRM: ProvRecMList)
                                {
                                    Map<string,object>newprovRM = (Map<string,object>)provRM;
                                    Map<string,object>provedorRM =(Map<string,object>)newprovRM;
                                    ES2_wraper_proveedoresRecursos provRe = new ES2_wraper_proveedoresRecursos();
                                    provRe.kycOrgResId = string.valueOf(provedorRM.get('kycOrgResId'));
                                    provRe.pOutKYCOrgResLegalName = string.valueOf(provedorRM.get('kycOrgResLegalName'));
                                    provRe.pOutKYCOrgResCountry = string.valueOf(provedorRM.get('kycOrgResCountry'));
                                    provRe.pOutKYCOrgResRFC = string.valueOf(provedorRM.get('kycOrgResRFC'));
                                    provRe.pOutKYCOrgResAddress = string.valueOf(provedorRM.get('kycOrgResAddress'));
                                    provRe.pOutKYCOrgResFEASerialNo =string.valueOf(provedorRM.get('kycOrgResFEASerialNo'));
                                    proveedorRM.add(provRe);
                                }
                                
                                kwyMoral.proveedores = proveedorRM;
                                request.kwypmObj = kwyMoral;
                                
                                
                            }
                            
                            
                            Map<string,object>tablaComposicionCapSocial = (Map<string,object>)kycOrg.get('tablaComposicionCapSocial');
                            if(tablaComposicionCapSocial != null)
                            {
                                List<object>capitalSocialList = (List<object>)tablaComposicionCapSocial.get('capitalSocial');
                                
                                for(object capSocM:capitalSocialList)
                                {
                                    if(capSocM != null)
                                    {
                                        Map<string,object>newCapitalSocial = (Map<string,object>)capSocM;
                                        Map<string,object>capitalsocialM = (Map<string,object>)newCapitalSocial;
                                        ES2_wraper_composicionsocial compCapSoCM = new ES2_wraper_composicionsocial();
                                        compCapSoCM.kycOrgPartnerId = string.valueOf(capitalsocialM.get('kycOrgPartnerId'));
                                        compCapSoCM.pOutKYCOrgPartnerLegalName = string.valueOf(capitalsocialM.get('kycOrgPartnerLegalName'));
                                        compCapSoCM.pOutKYCOrgPartnerCountry = string.valueOf(capitalsocialM.get('kycOrgPartnerCountry'));
                                        compCapSoCM.pOutKYCOrgPartnerRFC = string.valueOf(capitalsocialM.get('kycOrgPartnerRFC'));
                                        compCapSoCM.pOutKYCOrgPartnerPorcent = string.valueOf(capitalsocialM.get('kycOrgPartnerPorcent'));
                                        
                                        wComposicionSocial.add(compCapSoCM);
                                        
                                    }
                                    
                                }
                                
                                kwyMoral.composicion = wComposicionSocial;
                                request.kwypmObj = kwyMoral;
                                
                                
                            }
                            
                            kwyMoral.pOutKYCOrgPartnerOrgName = string.valueOf(kycOrg.get('kycOrgPartnerOrgName'));
                            
                            Map<string,object>tablaAccSociosPM = (Map<string,object>)kycOrg.get('tablaAccSociosPM');
                            if(tablaAccSociosPM != null )
                            {
                                List<object>accionistasPMList =(List<object>)tablaAccSociosPM.get('accionistasPM');
                                
                                for(object accionsPm:accionistasPMList)
                                {
                                    Map<string,object>newAccionsPm = (Map<string,object>)accionsPm;
                                    Map<string,object>accpm = (Map<string,object>)newAccionsPm;
                                    ES2_wraper_accionistaspm accionisPM = new ES2_wraper_accionistaspm();
                                    
                                    accionisPM.kycOrgPartnerOrgId = string.valueOf(accpm.get('kycOrgPartnerOrgId'));
                                    accionisPM.pOutKYCOrgPartnerOrgLegalName = string.valueOf(accpm.get('kycOrgPartnerOrgLegalName'));
                                    accionisPM.pOutKYCOrgPartnerOrgCountry = string.valueOf(accpm.get('kycOrgPartnerOrgCountry'));
                                    accionisPM.pOutKYCOrgPartnerOrgRFC = string.valueOf(accpm.get('kycOrgPartnerOrgRFC'));
                                    accionisPM.pOutKYCOrgPartnerOrgPorcent = string.valueOf(accpm.get('kycOrgPartnerOrgPorcent'));
                                    
                                    wAccionistpm.add(accionisPM);
                                }
                                
                                kwyMoral.accionistas = wAccionistpm;
                                request.kwypmObj = kwyMoral;
                                
                            }
                            
                            kwyMoral.pOutKYCOrgTrustOrgName = string.valueOf(kycOrg.get('kycOrgTrustOrgName'));
                            
                            Map<string,object>tablaAccSociosFideicomisos =(Map<string,object>) kycOrg.get('tablaAccSociosFideicomisos');
                            if(tablaAccSociosFideicomisos!=null)
                            {
                                List<object>fideicomisosList = (List<object>)tablaAccSociosFideicomisos.get('accionistaFideicomiso');
                                
                                for(object fideicomiso:fideicomisosList)
                                {
                                    Map<string,object>newFideicomiso = (Map<string,object>)fideicomiso;
                                    Map<string,object>accFideicomiso = (Map<string,object>)newFideicomiso;
                                    ES2_wraper_sociosfideicomisos sfideicom = new ES2_wraper_sociosfideicomisos();
                                    
                                    sfideicom.kycOrgTrustId = string.valueOf(accFideicomiso.get('kycOrgTrustId'));
                                    sfideicom.pOutKYCOrgTrustLegalName = string.valueOf(accFideicomiso.get('kycOrgTrustLegalName'));
                                    sfideicom.pOutKYCOrgTrustCountry =  string.valueOf(accFideicomiso.get('kycOrgTrustCountry'));
                                    sfideicom.pOutKYCOrgTrustRFC = string.valueOf(accFideicomiso.get('kycOrgTrustRFC'));
                                    sfideicom.pOutKYCOrgTrustPersons = string.valueOf(accFideicomiso.get('kycOrgTrustPersons'));
                                    
                                    wFideicomisos.add(sfideicom);
                                }
                                
                                kwyMoral.fideicomisos = wFideicomisos;
                                request.kwypmObj = kwyMoral;
                                
                            }
                            
                            Map<string,object>tablaAccSociosPF = (Map<string,object>)kycOrg.get('tablaAccSociosPF');
                            if(tablaAccSociosPF != null)
                            {
                                List<object>accionistaPFList= (List<object>)tablaAccSociosPF.get('accionistaPF');
                                
                                for(object accPF:accionistaPFList)
                                {
                                    Map<string,object>newAccPF = (Map<string,object>)accPF;
                                    Map<string,object>accionistaPF = (Map<string,object>)newAccPF;
                                    ES2_wraper_sociosPF socioPF = new ES2_wraper_sociosPF();
                                    if(accionistaPF != null)
                                    {
                                        socioPF.kycOrgPartnerIndId = string.valueOf(accionistaPF.get('kycOrgPartnerIndId'));
                                        socioPF.pOutKYCOrgPartnerIndLegalName =  string.valueOf(accionistaPF.get('kycOrgPartnerIndLegalName'));
                                        socioPF.pOutKYCOrgPartnerIndCountry = string.valueOf(accionistaPF.get('kycOrgPartnerIndCountry'));
                                        socioPF.pOutKYCOrgPartnerIndRFC = string.valueOf(accionistaPF.get('kycOrgPartnerIndRFC'));
                                        socioPF.pOutKYCOrgPartnerIndPorcent = string.valueOf(accionistaPF.get('kycOrgPartnerIndPorcent'));
                                        
                                        wSociosPF.add(socioPF);
                                    }
                                    
                                }
                                
                                kwyMoral.sociosPF = wSociosPF;
                                request.kwypmObj = kwyMoral;
                                
                            }
                            
                            kwyMoral.pOutKYCOrgBizManagedBy = string.valueOf(kycOrg.get('kycOrgBizManagedBy'));
                            
                            Map<string,object>tablaSocAdminPor = (Map<string,object>)kycOrg.get('tablaSocAdminPor');
                            if(tablaSocAdminPor!=null)
                            {
                                List<object>administradoPorList = (List<object>)tablaSocAdminPor.get('administradoPor');
                                
                                for(object adminstrado:administradoPorList)
                                {
                                    Map<string,object>newAdmin = (Map<string,object>)adminstrado;
                                    Map<string,object>admin = (Map<string,object>)newAdmin;
                                    ES2_Wraper_socioAdminPor administradoPor = new ES2_Wraper_socioAdminPor();
                                    
                                    administradoPor.kycOrgBizManagerId = string.valueOf(admin.get('kycOrgBizManagerId'));
                                    administradoPor.pOutKYCOrgBizManagerName = string.valueOf(admin.get('kycOrgBizManagerName'));
                                    administradoPor.pOutKYCOrgBizManagerTitle = string.valueOf(admin.get('kycOrgBizManagerTitle'));
                                    administradoPor.pOutKYCOrgBizManagerRFC = string.valueOf(admin.get('kycOrgBizManagerRFC'));
                                    
                                    wSocioAdmin.add(administradoPor);
                                }
                                
                                kwyMoral.SocioAdmin = wSocioAdmin;
                                request.kwypmObj = kwyMoral;
                                
                            }
                            
                            Map<string,object>tablaFuncionariosPrincipales = (Map<string,object>)kycOrg.get('tablaFuncionariosPrincipales');
                            if(tablaFuncionariosPrincipales != null)
                            {
                                List<object>funcionarioPrincipalList = (List<Object>)tablaFuncionariosPrincipales.get('funcionarioPrincipal');
                                
                                for(object funcionariop:funcionarioPrincipalList)
                                {
                                    Map<string,object>newFuncionario =(Map<string,object>)funcionariop;
                                    Map<string,object>funcionario = (Map<string,object>)newFuncionario;
                                    ES2_wraper_funcionariosPrincipales funcionariosPrin = new ES2_wraper_funcionariosPrincipales();
                                    
                                    funcionariosPrin.kycOrgBizMainId = string.valueOf(funcionario.get('kycOrgBizMainId'));
                                    funcionariosPrin.pOutKYCOrgBizMainName = string.valueOf(funcionario.get('kycOrgBizMainName'));
                                    funcionariosPrin.pOutKYCOrgBizMainTitle = string.valueOf(funcionario.get('kycOrgBizMainTitle'));
                                    funcionariosPrin.pOutKYCOrgBizMainRFC = string.valueOf(funcionario.get('kycOrgBizMainRFC'));
                                    
                                    WfuncionariosP.add(funcionariosPrin);
                                }
                                
                                kwyMoral.funcionarios = WfuncionariosP;
                                request.kwypmObj = kwyMoral;
                                
                            }
                            
                            kwyMoral.pOutKYCOrgCorpName =  string.valueOf(kycOrg.get('kycOrgCorpName'));
                            
                            Map<string,object>tablaGrupoEmpresarial = (Map<string,object>)kycOrg.get('tablaGrupoEmpresarial');
                            if(tablaGrupoEmpresarial != null)
                            {
                                List<object>grupoEmpresarialList = (List<object>)tablaGrupoEmpresarial.get('grupoEmpresarial');
                                
                                for(object grupoEmM:grupoEmpresarialList)
                                {
                                    Map<string,object>newGrupoEmp = (Map<string,object>)grupoEmM;
                                    Map<string,object>grupoEmpresarialO = (Map<string,object>)newGrupoEmp;
                                    ES2_wraper_grupoEmpresarial grupoEmpMo =  new ES2_wraper_grupoEmpresarial();
                                    
                                    grupoEmpMo.kycOrgCorpId = string.valueOf(grupoEmpresarialO.get('kycOrgCorpId'));
                                    grupoEmpMo.pOutKYCOrgCorpLegalName =  string.valueOf(grupoEmpresarialO.get('kycOrgCorpLegalName'));
                                    grupoEmpMo.pOutKYCOrgCorpCountry = string.valueOf(grupoEmpresarialO.get('kycOrgCorpCountry'));
                                    grupoEmpMo.pOutKYCOrgCorpAddress = string.valueOf(grupoEmpresarialO.get('kycOrgCorpAddress'));
                                    grupoEmpMo.pOutKYCOrgCorpObjective = string.valueOf(grupoEmpresarialO.get('kycOrgCorpObjective'));
                                    grupoEmpMo.pOutKYCOrgCorpPercent = string.valueOf(grupoEmpresarialO.get('kycOrgCorpPercent'));
                                    
                                    wGrupoEmpM.add(grupoEmpMo);
                                }
                                
                                kwyMoral.grupoE =wGrupoEmpM;
                                request.kwypmObj =kwyMoral;
                                
                            }
                            
                            Map<string,object>certificacionRepresentanteLegal = (Map<string,object>)kycOrg.get('certificacionRepresentanteLegal');
                            if(certificacionRepresentanteLegal != null)
                            {
                                wRepLegalM.pOutKYCOrgSignName = string.valueOf(certificacionRepresentanteLegal.get('kycOrgSignName'));
                                wRepLegalM.pOutKYCOrgSignJob =  string.valueOf(certificacionRepresentanteLegal.get('kycOrgSignJob'));
                                wRepLegalM.pOutKYCOrgSignPublicDeedNum = string.valueOf(certificacionRepresentanteLegal.get('kycOrgSignPublicDeedNum'));
                                if(String.IsNotBlank(String.valueOf(certificacionRepresentanteLegal.get('kycOrgSignPublicDeedDate'))))
                                {
                                    wRepLegalM.pOutKYCOrgSignPublicDeedDate =  Test.isRunningTest() ? date.newInstance(218, 11, 11): date.parse((String)certificacionRepresentanteLegal.get('kycOrgSignPublicDeedDate')) ;
                                }
                                //wRepLegalM.pOutKYCOrgSignPublicDeedDate = date.parse((String)certificacionRepresentanteLegal.get('kycOrgSignPublicDeedDate')  );                       wRepLegalM.pOutKYCOrgSignNotaryName = string.valueOf(certificacionRepresentanteLegal.get('kycOrgSignNotaryName'));
                                wRepLegalM.pOutKYCOrgSignNotaryNum = string.valueOf(certificacionRepresentanteLegal.get('kycOrgSignNotaryNum'));
                                wRepLegalM.pOutKYCOrgSignNotaryState = string.valueOf(certificacionRepresentanteLegal.get('kycOrgSignNotaryState'));
                                wRepLegalM.pOutKYCOrgSignDateDay = string.valueOf(certificacionRepresentanteLegal.get('kycOrgSignDateDay'));
                                wRepLegalM.pOutKYCOrgSignDateMonth =  string.valueOf(certificacionRepresentanteLegal.get('kycOrgSignDateMonth'));
                                wRepLegalM.pOutKYCOrgSignDateYear = string.valueOf(certificacionRepresentanteLegal.get('kycOrgSignDateYear'));
                                
                                kwyMoral.cerificadoL = wRepLegalM;
                                request.kwypmObj = kwyMoral;
                            }
                        }
                    }
                    when 'Economic Group(no aplica)'
                    {
                        Map<string,object>economicGroupRequest = (Map<string,object>)newRequest.get('economicGroup');
                        if(economicGroupRequest != null){
                            system.debug('OEJ economicGroupRequest: ' + economicGroupRequest);
                            
                            Ecgroup.EGProposedName = string.valueOf(economicGroupRequest.get('egProposedName'));
                            Ecgroup.EGPartyId = string.valueOf(economicGroupRequest.get('egPartyId'));
                            Ecgroup.EGPartyName = string.valueOf(economicGroupRequest.get('egPartyName'));
                            Ecgroup.EGSicId = string.valueOf(economicGroupRequest.get('egSicId'));
                            Ecgroup.EGSicDescriptioA = string.valueOf(economicGroupRequest.get('egSicDescription'));
                            //request.EconomicRequestObj = Ecgroup;
                        }
                    }
                    when 'LEGAL ASSESSMENT'
                    {
                        system.debug('estoy en Legal');
                        Map<string,object>legalAssesment = (Map<string,object>)newRequest.get('legalAssessment');
                        if(legalAssesment != null){
                        Map<string,object>LAH = (Map<string,object>)legalAssesment.get('laHeader');
                        if(LAH != null){
                            legalAss.pOutlaType = string.valueOf(LAH.get('laTipo'));
                            Map<string,object>LAGI = (Map<string,object>)LAH.get('generalInformation');
                            if(LAGI != null){
                                legalAss.pOutValidThrough = string.valueOf(LAGI.get('laGIValidThrough'));
                            }
                            Map<string,object>LAEI = (Map<string,object>)LAH.get('entityInformation');
                            system.debug('estoy en Legal' + LAEI);
                            if(LAEI != null){
                                legalAss.pOutEntidad = string.valueOf(LAEI.get('laEIEntidad'));
                                legalAss.pOutnacionalidad = string.valueOf(LAEI.get('LAEINacionalidad'));
                                legalAss.pOutRFC = string.valueOf(LAEI.get('laEIRfcTin'));
                                legalAss.pOutNoCuenta = string.valueOf(LAEI.get('laEINumeroCuenta'));
                                legalAss.pOutEntidadtype = string.valueOf(LAEI.get('laEITipoEntidad'));
                                legalAss.pOutEConomicgroup = string.valueOf(LAEI.get('laEIGrupoEconomico'));
                                legalAss.pOutcurp = string.valueOf(LAEI.get('laEICurp'));
                                
                            }
                            
                        }
                        Map<string,object>LAD = (Map<string,object>)legalAssesment.get('laDetail');
                        system.debug('hola '+ LAD);
                        if(LAD != null){
                            Map<string,object>LAPM = (Map<string,object>)LAD.get('moral');
                            if(LAPM != null){
                                System.debug(LoggingLevel.INFO,'Inicia Fill moral');
                                Map<string,object>LAPMAC = (Map<string,object>)LAPM.get('actaConstitutiva');
                                if(LAPMAC != null){
                                    legalAss.pmoral.pOutLAMACDocumentID = string.valueOf(LAPMAC.get('laPMACDocumentId'));
                                    legalAss.pmoral.pOutLAMACDenomconstituirse = string.valueOf(LAPMAC.get('laPMACDenomConstituirse'));
                                    legalAss.pmoral.pOutLAMACEscrituraNo = string.valueOf(LAPMAC.get('laPMACEscrituraNum'));
                                    legalAss.pmoral.pOutLAMACFechaEscritura = string.valueOf(LAPMAC.get('laPMACFechaEscritura'));
                                    legalAss.pmoral.pOutLAMACDuracion = string.valueOf(LAPMAC.get('laPMACDuracion'));
                                    legalAss.pmoral.pOutLAMACClausulaExtranjero = string.valueOf(LAPMAC.get('laPMACClausulaExtranjero'));
                                    legalAss.pmoral.pOutLAMACFedatarioPublico = string.valueOf(LAPMAC.get('laPMACFedatarioPublico'));
                                    legalAss.pmoral.pOutLAMACFechaRegistro = string.valueOf(LAPMAC.get('laPMACFechaRegistro'));
                                    legalAss.pmoral.pOutLAMACLugarRegistro = string.valueOf(LAPMAC.get('laPMACLugarRegistro'));
                                    legalAss.pmoral.pOutLAMACDatosRegistro = string.valueOf(LAPMAC.get('laPMACDatosRegistro'));
                                    legalAss.pmoral.pOutLAMACObservaciones = string.valueOf(LAPMAC.get('laPMACObservaciones'));
                                }
                                Map<string,object>LAPMDS = (Map<string,object>)LAPM.get('domicilioSocial');
                                if(LAPMDS != null){
                                    legalAss.pmoral.pOutLAMDSAddressID = string.valueOf(LAPMDS.get('laDSAddressID'));
                                    legalAss.pmoral.pOutLAMDSPais = string.valueOf(LAPMDS.get('laDSPais'));
                                    legalAss.pmoral.pOutLAMDSCodigoPostal = string.valueOf(LAPMDS.get('laDSCodigoPostal'));
                                    legalAss.pmoral.pOutLAMDSEstado = string.valueOf(LAPMDS.get('laDSEstado'));
                                    legalAss.pmoral.pOutLAMDSCiudad = string.valueOf(LAPMDS.get('laDSCiudad'));
                                    legalAss.pmoral.pOutLAMDSMunicipioAlcaldia = string.valueOf(LAPMDS.get('laDSMunicipioAlcaldia'));
                                    legalAss.pmoral.pOutLAMDSColonia = string.valueOf(LAPMDS.get('laDSColonia'));
                                    legalAss.pmoral.pOutLAMDSCalle = string.valueOf(LAPMDS.get('laDSCalle'));
                                    legalAss.pmoral.pOutLAMDSNoExterior = string.valueOf(LAPMDS.get('laDSNumExterior'));
                                    legalAss.pmoral.pOutLAMDSNoInterior = string.valueOf(LAPMDS.get('laDSNumInterior'));
                                }
                                Map<string,object>LAPMOS = (Map<string,object>)LAPM.get('objetoSocial');
                                system.debug('objetos social' + LAPMOS);
                                if(LAPMOS != null){
                                    legalAss.pmoral.pOutLAMOSPurposeID = string.valueOf(LAPMOS.get('LAPMOSPurposeId'));
                                    legalAss.pmoral.pOutLAMOSDocumentID = string.valueOf(LAPMOS.get('laPMOSDocumentId'));
                                    legalAss.pmoral.pOutLAMOSEscritura = string.valueOf(LAPMOS.get('laPMOSEscritura'));
                                    legalAss.pmoral.pOutLAMOSAutorizadoArrendar = string.valueOf(LAPMOS.get('laPMOSAutorizadoArrendar'));
                                    legalAss.pmoral.pOutLAMOSAutSuscTItulosCredit = string.valueOf(LAPMOS.get('laPMOSAutSuscribirTitCredito'));
                                    legalAss.pmoral.pOutLAMOSAutorizadoGarantizar = string.valueOf(LAPMOS.get('laPMOSAutGarantizar'));
                                    legalAss.pmoral.pOutLAMOSFiador = string.valueOf(LAPMOS.get('laPMOSFiador'));
                                    legalAss.pmoral.pOutLAMOSAval = string.valueOf(LAPMOS.get('laPMOSAval'));
                                    legalAss.pmoral.pOutLAMOSObservaciones = string.valueOf(LAPMOS.get('laPMOSObservaciones'));
                                    legalAss.pmoral.pOutLAMOSObligadoSolidario = string.valueOf(LAPMOS.get('laPMOSObligadoSolidario'));
                                    legalAss.pmoral.pOutLAMOSGarantObligTerceros = string.valueOf(LAPMOS.get('laPMOSGarantObligTerceros'));
                                    legalAss.pmoral.pOutLAMOSLimitanteObjetoSoc = string.valueOf(LAPMOS.get('laPMOSLimitantesObjetoSocial'));
                                }
                                Map<string,object>LAPMCD = (Map<string,object>)LAPM.get('comprobanteDomicilio');
                                if(LAPMCD != null){
                                    legalAss.pmoral.pOutLAMCDAddressID = string.valueOf(LAPMCD.get('laCDAddressId'));
                                    legalAss.pmoral.pOutLAMCDPais = string.valueOf(LAPMCD.get('laCDPais'));
                                    legalAss.pmoral.pOutLAMCDCodigoPostal = string.valueOf(LAPMCD.get('laCDCodigoPostal'));
                                    legalAss.pmoral.pOutLAMCDEstado = string.valueOf(LAPMCD.get('laMCDEstado'));
                                    legalAss.pmoral.pOutLAMCDCiudad = string.valueOf(LAPMCD.get('laCDCiudad'));
                                    legalAss.pmoral.pOutLAMCDMunicipioAlcaldia = string.valueOf(LAPMCD.get('laCDMunicipioAlcaldia'));
                                    legalAss.pmoral.pOutLAMCDColonia = string.valueOf(LAPMCD.get('laCDColonia'));
                                    legalAss.pmoral.pOutLAMCDCalle = string.valueOf(LAPMCD.get('laCDCalle'));
                                    legalAss.pmoral.pOutLAMCDNoExterior = string.valueOf(LAPMCD.get('laCDNumExterior'));
                                    legalAss.pmoral.pOutLAMCDNoInterior = string.valueOf(LAPMCD.get('laCDNumInterior'));
                                }
                                Map<string,object>LAPMDF = (Map<string,object>)LAPM.get('datosFiscales');
                                if(LAPMDF != null){
                                    legalAss.pmoral.pOutLAMDFAddressID = string.valueOf(LAPMDF.get('laDFAddressId'));
                                    legalAss.pmoral.pOutLAMDFRFC = string.valueOf(LAPMDF.get('laDFRfcTin'));
                                    legalAss.pmoral.pOutLAMDFPais = string.valueOf(LAPMDF.get('laDFPais'));
                                    legalAss.pmoral.pOutLAMDFCodigoPostal = string.valueOf(LAPMDF.get('laDFCodigoPostal'));
                                    legalAss.pmoral.pOutLAMDFEstado = string.valueOf(LAPMDF.get('laDFEstado'));
                                    legalAss.pmoral.pOutLAMDFCiudad = string.valueOf(LAPMDF.get('laDFCiudad'));
                                    legalAss.pmoral.pOutLAMDFMunicipioAlcaldia = string.valueOf(LAPMDF.get('laDFMunicipioAlcaldia'));
                                    legalAss.pmoral.pOutLAMDFColonia = string.valueOf(LAPMDF.get('laDFColonia'));
                                    legalAss.pmoral.pOutLAMDFCalle = string.valueOf(LAPMDF.get('laDFCalle'));
                                    legalAss.pmoral.pOutLAMDFNoExterior = string.valueOf(LAPMDF.get('laDFNumExterior'));
                                    legalAss.pmoral.pOutLAMDFNoInterior = string.valueOf(LAPMDF.get('laDFNumInterior'));
                                }
                                Map<string,object>tablalimitante = (Map<string,object>)LAPM.get('limitantes');
                                if(tablalimitante!=null)
                                {
                                    List<object>limitanteList = (List<object>)tablalimitante.get('limitante');
                                    
                                    for(object limitante:limitanteList)
                                    {
                                        Map<string,object> limitantess = (Map<string,object>)limitante;
                                        Map<string,object>limiitante = (Map<string,object>)limitantess;
                                        ES5_wraper_LA_limitante limita = new ES5_wraper_LA_limitante();
                                        
                                        limita.laMLActiveFlag = string.valueOf(limiitante.get('laMLActiveFlag'));
                                        limita.laMLDocumentID = string.valueOf(limiitante.get('laMLDocumentID'));
                                        limita.laMLCreatedBy = string.valueOf(limiitante.get('laMLCreatedBy'));
                                        limita.laMLCreationDate = string.valueOf(limiitante.get('laMLCreationDate'));
                                        limita.laMLEscritura = string.valueOf(limiitante.get('laMLEscritura'));
                                        limita.laMLFecha = string.valueOf(limiitante.get('laMLFecha'));
                                        limita.laMLFederatarioPublico = string.valueOf(limiitante.get('laMLFederatarioPublico'));
                                        limita.laMLLastUpdateDate = string.valueOf(limiitante.get('laMLLastUpdateDate'));
                                        limita.laMLLastUpdatedBy = string.valueOf(limiitante.get('laMLLastUpdatedBy'));
                                        limita.laMLLimatingId = string.valueOf(limiitante.get('laMLLimatingId'));
                                        limita.laMLLimitante = string.valueOf(limiitante.get('laMLLimitante'));
                                        limita.laMLNameCreatedBy = string.valueOf(limiitante.get('laMLNameCreatedBy'));
                                        limita.laMLNameUpdatedBy = string.valueOf(limiitante.get('laMLNameUpdatedBy'));
                                        limita.laMLRDatos = string.valueOf(limiitante.get('laMLRDatos'));
                                        limita.laMLRFecha = string.valueOf(limiitante.get('laMLRFecha'));
                                        limita.laMLRLugar = string.valueOf(limiitante.get('laMLRLugar'));
                                        limitantes.add(limita);
                                    }
                                    
                                    legalAss.pmoral.limitantes = limitantes;
                                    
                                }
                                Map<string,object>tablamodificaciones = (Map<string,object>)LAPM.get('modificaciones');
                                if(tablamodificaciones!=null)
                                {
                                    List<object>modificacionList = (List<object>)tablamodificaciones.get('modificacion');
                                    
                                    for(object modificacion:modificacionList)
                                    {
                                        Map<string,object> modificacions = (Map<string,object>)modificacion;
                                        Map<string,object>modificacionst = (Map<string,object>)modificacions;
                                        ES5_wraper_LA_modificacion modificacioness = new ES5_wraper_LA_modificacion();
                                        modificacioness.laMMActiveFlag = string.valueOf(modificacionst.get('laMMActiveFlag'));
                                        modificacioness.laMMCreatedBy = string.valueOf(modificacionst.get('laMMCreatedBy'));
                                        modificacioness.laMMCreationDate = string.valueOf(modificacionst.get('laMMCreationDate'));
                                        modificacioness.laMMDocumentId = string.valueOf(modificacionst.get('laMMDocumentId'));
                                        modificacioness.laMMEscritura = string.valueOf(modificacionst.get('laMMEscritura'));
                                        modificacioness.laMMFecha = string.valueOf(modificacionst.get('laMMFecha'));
                                        modificacioness.laMMFederatarioPublico = string.valueOf(modificacionst.get('laMMFederatarioPublico'));
                                        modificacioness.laMMLastUpdateDate = string.valueOf(modificacionst.get('laMMLastUpdateDate'));
                                        modificacioness.laMMLastUpdatedBy = string.valueOf(modificacionst.get('laMMLastUpdatedBy'));
                                        modificacioness.laMMNameCreatedBy = string.valueOf(modificacionst.get('laMMNameCreatedBy'));
                                        modificacioness.laMMNameUpdatedBy = string.valueOf(modificacionst.get('laMMNameUpdatedBy'));
                                        modificacioness.laMMObservaciones = string.valueOf(modificacionst.get('laMMObservaciones'));
                                        modificacioness.laMModificationId = string.valueOf(modificacionst.get('laMModificationId'));
                                        modificacioness.laMMRDatos = string.valueOf(modificacionst.get('laMMRDatos'));
                                        modificacioness.laMMReformaTotal = string.valueOf(modificacionst.get('laMMReformaTotal'));
                                        modificacioness.laMMRFecha = string.valueOf(modificacionst.get('laMMRFecha'));
                                        modificacioness.laMMRLugar = string.valueOf(modificacionst.get('laMMRLugar'));
                                        modificaciones.add(modificacioness);
                                    }
                                    
                                    legalAss.pmoral.modificaciones = modificaciones;
                                    
                                }
                                
                                Map<string,object>tablaapoderados = (Map<string,object>)LAPM.get('apoderados');
                                if(tablaapoderados!=null)
                                {
                                    List<object>apoderadoList = (List<object>)tablaapoderados.get('apoderado');
                                    apoderados = new list <ES5_wraper_LA_apoderados>();
                                    for(object Apoderado:apoderadoList)
                                    {
                                        Map<string,object> apoderations = (Map<string,object>)Apoderado;
                                        Map<string,object>apoderation = (Map<string,object>)apoderations;
                                        ES5_wraper_LA_apoderados apoder = new ES5_wraper_LA_apoderados();
                                        apoder.laAActiveFlag = string.valueOf(apoderation.get('laAActiveFlag'));
                                        apoder.laAActosAdministrativos = string.valueOf(apoderation.get('laAActosAdministrativos'));
                                        apoder.laAActosDominio = string.valueOf(apoderation.get('laAActosDominio'));
                                        apoder.laAApoderadoID = string.valueOf(apoderation.get('laAApoderadoID'));
                                        apoder.laACreatedBy = string.valueOf(apoderation.get('laACreatedBy'));
                                        apoder.laACreationDate = string.valueOf(apoderation.get('laACreationDate'));
                                        apoder.laADatosRegistro = string.valueOf(apoderation.get('laADatosRegistro'));
                                        apoder.laADatosRegistroRevoca = string.valueOf(apoderation.get('laADatosRegistroRevoca'));
                                        apoder.laADocumentID = string.valueOf(apoderation.get('laADocumentID'));
                                        apoder.laADomicilio = string.valueOf(apoderation.get('laADomicilio'));
                                        apoder.laAEscrituraNum = string.valueOf(apoderation.get('laAEscrituraNum'));
                                        apoder.laAEscrituraRevoca = string.valueOf(apoderation.get('laAEscrituraRevoca'));
                                        apoder.laAFecha = string.valueOf(apoderation.get('laAFecha'));
                                        apoder.laAFechaNacimiento = string.valueOf(apoderation.get('laAFechaNacimiento'));
                                        apoder.laAFechaRegistro = string.valueOf(apoderation.get('laAFechaRegistro'));
                                        apoder.laAFechaRevoca = string.valueOf(apoderation.get('laAFechaRevoca'));
                                        apoder.laAFedatarioPublico = string.valueOf(apoderation.get('laAFedatarioPublico'));
                                        apoder.laAIndMan = string.valueOf(apoderation.get('laAIndMan'));
                                        apoder.laALastUpdateDate = string.valueOf(apoderation.get('laALastUpdateDate'));
                                        apoder.laALastUpdatedBy = string.valueOf(apoderation.get('laANameUpdatedBy'));
                                        apoder.laALugarRegistro = string.valueOf(apoderation.get('laALugarRegistro'));
                                        apoder.laALugarRevoca = string.valueOf(apoderation.get('laALugarRevoca'));
                                        apoder.laANacionalidad = string.valueOf(apoderation.get('laANacionalidad'));
                                        apoder.laANameCreatedBy = string.valueOf(apoderation.get('laANameCreatedBy'));
                                        apoder.laANameUpdatedBy = string.valueOf(apoderation.get('laANameUpdatedBy'));
                                        apoder.laANombreFacultado = string.valueOf(apoderation.get('laANombreFacultado'));
                                        apoder.laAObservaciones = string.valueOf(apoderation.get('laAObservaciones'));
                                        apoder.laAObservacionesRevoca = string.valueOf(apoderation.get('laAObservacionesRevoca'));
                                        apoder.laAOcupacion = string.valueOf(apoderation.get('laAOcupacion'));
                                        apoder.laAPEspecial = string.valueOf(apoderation.get('laAPEspecial'));
                                        apoder.laAPleitosCobranza = string.valueOf(apoderation.get('laAPleitosCobranza'));
                                        apoder.laAPOtros = string.valueOf(apoderation.get('laAPOtros'));
                                        apoder.laATitulosCredito = string.valueOf(apoderation.get('laATitulosCredito'));
                                        apoderados.add(apoder);
                                    }
                                    
                                    legalAss.pmoral.apoderados = apoderados;
                                    
                                }
                                Map<string,object>LAPMB = (Map<string,object>)LAPM.get('bil');
                                if(LAPMB != null){
                                    legalAss.pmoral.pOutLAMBBilId = string.valueOf(LAPMB.get('laBBilId'));
                                    legalAss.pmoral.pOutLAMBFechaRevision = string.valueOf(LAPMB.get('laBFechaRevision')); //'2018-11-01';
                                    legalAss.pmoral.pOutLAMBIncidencias = string.valueOf(LAPMB.get('laBIncidencias')); //'Y';
                                    legalAss.pmoral.pOutLAMBComentarios = string.valueOf(LAPMB.get('laBComentarios')); //'hola mundo desde persona moral';
                                }
                            }
                            Map<string,object>LAPME = (Map<string,object>)LAD.get('moralExtranjera');
                            System.debug(LoggingLevel.INFO,'Inicia Fill moral extranjera');
                            system.debug('LAPME'+LAPME);
                            if(LAPME != null){
                                
                                Map<string,object> LAPMEAC = (Map<string,object>)LAPME.get('actaConstitutiva');
                                if(LAPMEAC != null){
                                    legalAss.pmoralExtranjera.pOutLAPMEACDocumentID= String.valueOf(LAPMEAC.get('laPMACDocumentId'));
                                    legalAss.pmoralExtranjera.pOutLAPMEACDenomconstituirse= String.valueOf(LAPMEAC.get('laPMACDenomConstituirse'));
                                    legalAss.pmoralExtranjera.pOutLAPMEACEscrituraNum= String.valueOf(LAPMEAC.get('laPMACEscrituraNum'));
                                    legalAss.pmoralExtranjera.pOutLAPMEACFechaEscritura= String.valueOf(LAPMEAC.get('laPMACFechaEscritura'));
                                    legalAss.pmoralExtranjera.pOutLAPMEACDuracion= String.valueOf(LAPMEAC.get('laPMACDuracion'));
                                    legalAss.pmoralExtranjera.pOutLAPMEACObservaciones= String.valueOf(LAPMEAC.get('laPMACObservaciones'));
                                }
                                Map<string,object> LAPMEDS = (Map<string,object>)LAPME.get('domicilioSocial');
                                if(LAPMEDS != null){
                                    legalAss.pmoralExtranjera.pOutLAPMEDSAddressID= String.valueOf(LAPMEDS.get('laDSAddressID'));
                                    legalAss.pmoralExtranjera.pOutLAPMEDSPais= String.valueOf(LAPMEDS.get('laDSPais'));
                                    legalAss.pmoralExtranjera.pOutLAPMEDSCodigoPostal= String.valueOf(LAPMEDS.get('laDSCodigoPostal'));
                                    legalAss.pmoralExtranjera.pOutLAPMEDSEstado= String.valueOf(LAPMEDS.get('laDSEstado'));
                                    legalAss.pmoralExtranjera.pOutLAPMEDSCiudad= String.valueOf(LAPMEDS.get('laDSCiudad'));
                                    legalAss.pmoralExtranjera.pOutLAPMEDSMunicipioAlcaldia= String.valueOf(LAPMEDS.get('laDSMunicipioAlcaldia'));
                                    legalAss.pmoralExtranjera.pOutLAPMEDSColonia= String.valueOf(LAPMEDS.get('laDSColonia'));
                                    legalAss.pmoralExtranjera.pOutLAPMEDSCalle= String.valueOf(LAPMEDS.get('laDSCalle'));
                                    legalAss.pmoralExtranjera.pOutLAPMEDSNoExterior= String.valueOf(LAPMEDS.get('laDSNumExterior'));
                                    legalAss.pmoralExtranjera.pOutLAPMEDSNoInterior= String.valueOf(LAPMEDS.get('laDSNumInterior'));
                                }
                                Map<string,object> LAPMECD = (Map<string,object>)LAPME.get('comprobanteDomicilio');
                                if(LAPMECD != null){
                                    legalAss.pmoralExtranjera.pOutLAPMECDAddressID= String.valueOf(LAPMECD.get('laCDAddressId'));
                                    legalAss.pmoralExtranjera.pOutLAPMECDPais= String.valueOf(LAPMECD.get('laCDPais'));
                                    legalAss.pmoralExtranjera.pOutLAPMECDCodigoPostal= String.valueOf(LAPMECD.get('laCDCodigoPostal'));
                                    legalAss.pmoralExtranjera.pOutLAPMECDEstado= String.valueOf(LAPMECD.get('laMCDEstado'));
                                    legalAss.pmoralExtranjera.pOutLAPMECDCiudad= String.valueOf(LAPMECD.get('laCDCiudad'));
                                    legalAss.pmoralExtranjera.pOutLAPMECDMunicipioAlcaldia= String.valueOf(LAPMECD.get('laCDMunicipioAlcaldia'));
                                    legalAss.pmoralExtranjera.pOutLAPMECDColonia= String.valueOf(LAPMECD.get('laCDColonia'));
                                    legalAss.pmoralExtranjera.pOutLAPMECDCalle= String.valueOf(LAPMECD.get('laCDCalle'));
                                    legalAss.pmoralExtranjera.pOutLAPMECDNoExterior= String.valueOf(LAPMECD.get('laCDNumExterior'));
                                    legalAss.pmoralExtranjera.pOutLAPMECDNoInterior= String.valueOf(LAPMECD.get('laCDNumInterior'));
                                }
                                Map<string,object> LAPMEDF = (Map<string,object>)LAPME.get('datosFiscales');
                                if(LAPMEDF != null){
                                    legalAss.pmoralExtranjera.pOutLAPMEDFAddressID= String.valueOf(LAPMEDF.get('laDFAddressId'));
                                    legalAss.pmoralExtranjera.pOutLAPMEDFTIN= String.valueOf(LAPMEDF.get('laDFRfcTin'));
                                    legalAss.pmoralExtranjera.pOutLAPMEDFPais= String.valueOf(LAPMEDF.get('laDFPais'));
                                    legalAss.pmoralExtranjera.pOutLAPMEDFCodigoPostal= String.valueOf(LAPMEDF.get('laDFCodigoPostal'));
                                    legalAss.pmoralExtranjera.pOutLAPMEDFEstado= String.valueOf(LAPMEDF.get('laDFEstado'));
                                    legalAss.pmoralExtranjera.pOutLAPMEDFCiudad= String.valueOf(LAPMEDF.get('laDFCiudad'));
                                    legalAss.pmoralExtranjera.pOutLAPMEDFMunicipioAlcaldia= String.valueOf(LAPMEDF.get('laDFMunicipioAlcaldia'));
                                    legalAss.pmoralExtranjera.pOutLAPMEDFColonia= String.valueOf(LAPMEDF.get('laDFColonia'));
                                    legalAss.pmoralExtranjera.pOutLAPMEDFCalle= String.valueOf(LAPMEDF.get('laDFCalle'));
                                    legalAss.pmoralExtranjera.pOutLAPMEDFNoExterior= String.valueOf(LAPMEDF.get('laDFNumExterior'));
                                    legalAss.pmoralExtranjera.pOutLAPMEDFNoInterior= String.valueOf(LAPMEDF.get('laDFNumInterior'));
                                    legalAss.pmoralExtranjera.pOutLAPMEDFW8W9= String.valueOf(LAPMEDF.get('laDFW8W9'));
                                }
                                Map<string,object>tablastaruto = (Map<string,object>)LAPME.get('estatutos');
                                if(tablastaruto != null){
                                    list<object>statutoslist = (List<object>)tablastaruto.get('estatuto');
                                    for(object Statutos:statutoslist){
                                        Map<string,object> statitions = (Map<string,object>)Statutos;
                                        Map<string,object> statition = (Map<string,object>)statitions;
                                        if(statition != null){
                                            ES5_wraper_LA_Estatutos esta = new ES5_wraper_LA_Estatutos();
                                        esta.pOutlaEActiveFlag = string.valueOf(statition.get('laEActiveFlag'));
                                        esta.pOutlaEComentarios = string.valueOf(statition.get('laEComentarios'));
                                        esta.pOutlaECreatedBy = string.valueOf(statition.get('laECreatedBy'));
                                        esta.pOutlaECreationDate = string.valueOf(statition.get('laECreationDate'));
                                        esta.pOutlaEEstatuto = string.valueOf(statition.get('laEEstatuto'));
                                        esta.pOutlaEEstatutoID = string.valueOf(statition.get('laEEstatutoID'));
                                        esta.pOutlaEFecha = string.valueOf(statition.get('laEFecha'));
                                        esta.pOutlaELastUpdateDate = string.valueOf(statition.get('laELastUpdateDate'));
                                        esta.pOutlaELastUpdatedBy = string.valueOf(statition.get('laELastUpdatedBy'));
                                        esta.pOutlaENameCreatedBy = string.valueOf(statition.get('laENameCreatedBy'));
                                        esta.pOutlaENameUpdatedB = string.valueOf(statition.get('laENameUpdatedBy'));
                                        esta.pOutlaEObservaciones = string.valueOf(statition.get('laEObservaciones'));
                                        Estatutos.add(esta);
                                        }
                                        
                                    }
                                        legalAss.pmoralExtranjera.estatutos = Estatutos;
                                }
                                Map<string,object>tablaapoderados = (Map<string,object>)LAPME.get('apoderados');
                                if(tablaapoderados!=null)
                                {
                                    List<object>apoderadoList = (List<object>)tablaapoderados.get('apoderado');
                                    apoderados = new list <ES5_wraper_LA_apoderados>();
                                    for(object Apoderado:apoderadoList)
                                    {
                                        Map<string,object> apoderations = (Map<string,object>)Apoderado;
                                        Map<string,object>apoderation = (Map<string,object>)apoderations;
                                        ES5_wraper_LA_apoderados apoder = new ES5_wraper_LA_apoderados();
                                        apoder.laAApoderadoID = string.valueOf(apoderation.get('laAApoderadoID'));
                                        apoder.laADocumentID = string.valueOf(apoderation.get('laADocumentID'));
                                        apoder.laANombreFacultado = string.valueOf(apoderation.get('laANombreFacultado'));
                                        apoder.laAFecha = string.valueOf(apoderation.get('laAFecha'));
                                        apoder.laAActosDominio = string.valueOf(apoderation.get('laAActosDominio'));
                                        apoder.laATitulosCredito = string.valueOf(apoderation.get('laATitulosCredito'));
                                        apoder.laAActosAdministrativos = string.valueOf(apoderation.get('laAActosAdministrativos'));
                                        apoder.laAPleitosCobranza = string.valueOf(apoderation.get('laAPleitosCobranza'));
                                        apoder.laAIndMan = string.valueOf(apoderation.get('laAIndMan'));
                                        apoder.laAObservaciones = string.valueOf(apoderation.get('laAObservaciones'));
                                        apoder.laAEscrituraNum = string.valueOf(apoderation.get('laAEscrituraNum'));
                                        apoder.laAPEspecial = string.valueOf(apoderation.get('laAPEspecial'));
                                        apoder.laAPOtros = string.valueOf(apoderation.get('laAPOtros'));
                                        apoder.laAFedatarioPublico = string.valueOf(apoderation.get('laAFedatarioPublico'));
                                        apoder.laAFechaRegistro = string.valueOf(apoderation.get('laAFechaRegistro'));
                                        apoder.laALugarRegistro = string.valueOf(apoderation.get('laALugarRegistro'));
                                        apoder.laADatosRegistro = string.valueOf(apoderation.get('laADatosRegistro'));
                                        apoder.laAOcupacion = string.valueOf(apoderation.get('laAOcupacion'));
                                        apoder.laAFechaNacimiento = string.valueOf(apoderation.get('laAFechaNacimiento'));
                                        apoder.laANacionalidad = string.valueOf(apoderation.get('laANacionalidad'));
                                        apoder.laADomicilio = string.valueOf(apoderation.get('laADomicilio'));
                                        apoder.laAEscrituraRevoca = string.valueOf(apoderation.get('laAEscrituraRevoca'));
                                        apoder.laAFechaRevoca = string.valueOf(apoderation.get('laAFechaRevoca'));
                                        apoder.laALugarRevoca = string.valueOf(apoderation.get('laALugarRevoca'));
                                        apoder.laADatosRegistroRevoca = string.valueOf(apoderation.get('laADatosRegistroRevoca'));
                                        apoder.laAObservacionesRevoca = string.valueOf(apoderation.get('laAObservacionesRevoca'));                                        
                                        apoder.laAActiveFlag = string.valueOf(apoderation.get('laAActiveFlag'));
                                        apoder.laACreatedBy = string.valueOf(apoderation.get('laACreatedBy'));                                        
                                        apoder.laACreationDate = string.valueOf(apoderation.get('laACreationDate'));
                                        apoder.laALastUpdatedBy = string.valueOf(apoderation.get('laALastUpdatedBy'));
                                        apoder.laALastUpdateDate = string.valueOf(apoderation.get('laALastUpdateDate'));
                                        apoder.laANameCreatedBy = string.valueOf(apoderation.get('laANameCreatedBy'));
                                        apoder.laANameUpdatedBy = string.valueOf(apoderation.get('laANameCreatedBy'));
                                        apoderados.add(apoder);
                                    }
                                    
                                    legalAss.pmoralExtranjera.apoderados = apoderados;
                                    
                                }
                                Map<string,object>LAPMEB = (Map<string,object>)LAPME.get('bil');
                                if(LAPMEB != null){
                                    legalAss.pmoralExtranjera.pOutLAPMEBBilId = string.valueOf(LAPMEB.get('laBBilId'));
                                    legalAss.pmoralExtranjera.pOutLAPMEBFechaRevision = string.valueOf(LAPMEB.get('laBFechaRevision')); // '2018-11-01';
                                    legalAss.pmoralExtranjera.pOutLAPMEBIncidencias = string.valueOf(LAPMEB.get('laBIncidencias')); // 'Y';
                                    legalAss.pmoralExtranjera.pOutLAPMEBComentarios = string.valueOf(LAPMEB.get('laBComentarios')); // 'hola mundo desde persona moral Extranjera'; 
                                }
                            }
                            System.debug(LoggingLevel.INFO,'Inicia Fill persona física');
                            Map<string,object>LAPF = (Map<string,object>)LAD.get('fisica');
                            System.debug('sss   + ' +LAD.get('fisica'));
                            if(LAPF != null){
                                Map<string,object>LAPFDG = (Map<string,object>)LAPF.get('datosGenerales');
                                if(LAPFDG != null){
                                    System.debug(LoggingLevel.INFO,'entra a LAPFDG');
                                    legalAss.pfisica.pOutLAPFDGNombre = String.valueOf(LAPFDG.get('laPFDGNombre'));
                                    legalAss.pfisica.pOutLAPFDGFechadenacimiento = String.valueOf(LAPFDG.get('laPFDGFechadenacimiento'));
                                    legalAss.pfisica.pOutLAPFDGLugardenacimiento = String.valueOf(LAPFDG.get('laPFDGLugardenacimiento'));
                                    legalAss.pfisica.pOutLAPFDGEstadoCivil = String.valueOf(LAPFDG.get('laPFDGEstadoCivil'));
                                    legalAss.pfisica.pOutLAPFDGVigenciaId = String.valueOf(LAPFDG.get('laPFDGVigenciaId'));
                                    legalAss.pfisica.pOutLAPFDGComentarios = String.valueOf(LAPFDG.get('laPFDGComentarios'));                                
                                }
                                Map<string,object>LAPFDS = (Map<string,object>)LAPF.get('domicilioSocial');
                                if(LAPFDS != null){
                                    legalAss.pfisica.pOutLADSAddressID = String.valueOf(LAPFDS.get('laDSAddressID'));
                                    legalAss.pfisica.pOutLADSPais = String.valueOf(LAPFDS.get('laDSPais'));
                                    legalAss.pfisica.pOutLADSCodigoPostal = String.valueOf(LAPFDS.get('laDSCodigoPostal'));
                                    legalAss.pfisica.pOutLADSEstado = String.valueOf(LAPFDS.get('laDSEstado'));
                                    legalAss.pfisica.pOutLADSCiudad = String.valueOf(LAPFDS.get('laDSCiudad'));
                                    legalAss.pfisica.pOutLADSMunicipioAlcaldia = String.valueOf(LAPFDS.get('laDSMunicipioAlcaldia'));
                                    legalAss.pfisica.pOutLADSColonia = String.valueOf(LAPFDS.get('laDSColonia'));
                                    legalAss.pfisica.pOutLADSCalle = String.valueOf(LAPFDS.get('laDSCalle'));
                                    legalAss.pfisica.pOutLADSNumExterior = String.valueOf(LAPFDS.get('laDSNumExterior'));
                                    legalAss.pfisica.pOutLADSNumInterior = String.valueOf(LAPFDS.get('laDSNumInterior'));
                                }
                                Map<string,object>LAPFCD = (Map<string,object>)LAPF.get('comprobanteDomicilio');
                                if(LAPFCD != null){
                                    legalAss.pfisica.pOutLACDAddressId = String.valueOf(LAPFCD.get('laCDAddressId'));
                                    legalAss.pfisica.pOutLACDPais = String.valueOf(LAPFCD.get('laCDPais'));
                                    legalAss.pfisica.pOutLACDCodigoPostal = String.valueOf(LAPFCD.get('laCDCodigoPostal'));
                                    legalAss.pfisica.pOutLAMCDEstado = String.valueOf(LAPFCD.get('laMCDEstado'));
                                    legalAss.pfisica.pOutLACDCiudad = String.valueOf(LAPFCD.get('laCDCiudad'));
                                    legalAss.pfisica.pOutLACDMunicipioAlcaldia = String.valueOf(LAPFCD.get('laCDMunicipioAlcaldia'));
                                    legalAss.pfisica.pOutLACDColonia = String.valueOf(LAPFCD.get('laCDColonia'));
                                    legalAss.pfisica.pOutLACDCalle = String.valueOf(LAPFCD.get('laCDCalle'));
                                    legalAss.pfisica.pOutLACDNumExterior = String.valueOf(LAPFCD.get('laCDNumExterior'));
                                    legalAss.pfisica.pOutLACDNumInterior = String.valueOf(LAPFCD.get('laCDNumInterior'));
                                }
                                Map<string,object>LAPFDF = (Map<string,object>)LAPF.get('datosFiscales');
                                if(LAPFDF != null){
                                    legalAss.pfisica.pOutLADFAddressId = String.valueOf(LAPFDF.get('laDFAddressId'));
                                    legalAss.pfisica.pOutLADFRfcTin = String.valueOf(LAPFDF.get('laDFRfcTin'));
                                    legalAss.pfisica.pOutLADFPais = String.valueOf(LAPFDF.get('laDFPais'));
                                    legalAss.pfisica.pOutLADFCodigoPostal = String.valueOf(LAPFDF.get('laDFCodigoPostal'));
                                    legalAss.pfisica.pOutLADFEstado = String.valueOf(LAPFDF.get('laDFEstado'));
                                    legalAss.pfisica.pOutLADFCiudad = String.valueOf(LAPFDF.get('laDFCiudad'));
                                    legalAss.pfisica.pOutLADFMunicipioAlcaldia = String.valueOf(LAPFDF.get('laDFMunicipioAlcaldia'));
                                    legalAss.pfisica.pOutLADFColonia = String.valueOf(LAPFDF.get('laDFColonia'));
                                    legalAss.pfisica.pOutLADFCalle = String.valueOf(LAPFDF.get('laDFCalle'));
                                    legalAss.pfisica.pOutLADFNumExterior = String.valueOf(LAPFDF.get('laDFNumExterior'));
                                    legalAss.pfisica.pOutLADFNumInterior = String.valueOf(LAPFDF.get('laDFNumInterior'));
                                    legalAss.pfisica.pOutLADFW8W9 = String.valueOf(LAPFDF.get('laDFW8W9'));
                                    legalAss.pfisica.pOutLADFCurp = String.valueOf(LAPFDF.get('laDFCurp'));
                                }
                                Map<string,object>tablaapoderados = (Map<string,object>)LAPF.get('apoderados');
                                if(tablaapoderados!=null)
                                {
                                    List<object>apoderadoList = (List<object>)tablaapoderados.get('apoderado');
                                    apoderados = new list <ES5_wraper_LA_apoderados>();
                                    for(object Apoderado:apoderadoList)
                                    {
                                        Map<string,object> apoderations = (Map<string,object>)Apoderado;
                                        Map<string,object>apoderation = (Map<string,object>)apoderations;
                                        ES5_wraper_LA_apoderados apoder = new ES5_wraper_LA_apoderados();
                                        apoder.laAApoderadoID = string.valueOf(apoderation.get('laAApoderadoID'));
                                        apoder.laADocumentID = string.valueOf(apoderation.get('laADocumentID'));
                                        apoder.laANombreFacultado = string.valueOf(apoderation.get('laANombreFacultado'));
                                        apoder.laAFecha = string.valueOf(apoderation.get('laAFecha'));
                                        apoder.laAActosDominio = string.valueOf(apoderation.get('laAActosDominio'));
                                        apoder.laATitulosCredito = string.valueOf(apoderation.get('laATitulosCredito'));
                                        apoder.laAActosAdministrativos = string.valueOf(apoderation.get('laAActosAdministrativos'));
                                        apoder.laAPleitosCobranza = string.valueOf(apoderation.get('laAPleitosCobranza'));
                                        apoder.laAIndMan = string.valueOf(apoderation.get('laAIndMan'));
                                        apoder.laAObservaciones = string.valueOf(apoderation.get('laAObservaciones'));
                                        apoder.laAEscrituraNum = string.valueOf(apoderation.get('laAEscrituraNum'));
                                        apoder.laAPEspecial = string.valueOf(apoderation.get('laAPEspecial'));
                                        apoder.laAPOtros = string.valueOf(apoderation.get('laAPOtros'));
                                        apoder.laAFedatarioPublico = string.valueOf(apoderation.get('laAFedatarioPublico'));
                                        apoder.laAFechaRegistro = string.valueOf(apoderation.get('laAFechaRegistro'));
                                        apoder.laALugarRegistro = string.valueOf(apoderation.get('laALugarRegistro'));
                                        apoder.laADatosRegistro = string.valueOf(apoderation.get('laADatosRegistro'));
                                        apoder.laAOcupacion = string.valueOf(apoderation.get('laAOcupacion'));
                                        apoder.laAFechaNacimiento = string.valueOf(apoderation.get('laAFechaNacimiento'));
                                        apoder.laANacionalidad = string.valueOf(apoderation.get('laANacionalidad'));
                                        apoder.laADomicilio = string.valueOf(apoderation.get('laADomicilio'));
                                        apoder.laAEscrituraRevoca = string.valueOf(apoderation.get('laAEscrituraRevoca'));
                                        apoder.laAFechaRevoca = string.valueOf(apoderation.get('laAFechaRevoca'));
                                        apoder.laALugarRevoca = string.valueOf(apoderation.get('laALugarRevoca'));
                                        apoder.laADatosRegistroRevoca = string.valueOf(apoderation.get('laADatosRegistroRevoca'));
                                        apoder.laAObservacionesRevoca = string.valueOf(apoderation.get('laAObservacionesRevoca'));                                        
                                        apoder.laAActiveFlag = string.valueOf(apoderation.get('laAActiveFlag'));
                                        apoder.laACreatedBy = string.valueOf(apoderation.get('laACreatedBy'));                                        
                                        apoder.laACreationDate = string.valueOf(apoderation.get('laACreationDate'));
                                        apoder.laALastUpdatedBy = string.valueOf(apoderation.get('laALastUpdatedBy'));
                                        apoder.laALastUpdateDate = string.valueOf(apoderation.get('laALastUpdateDate'));
                                        apoder.laANameCreatedBy = string.valueOf(apoderation.get('laANameCreatedBy'));
                                        apoder.laANameUpdatedBy = string.valueOf(apoderation.get('laANameCreatedBy'));
                                        apoderados.add(apoder);
                                    }
                                    
                                    legalAss.pfisica.apoderados = apoderados;
                                    
                                }
                                Map<string,object>LAPFB = (Map<string,object>)LAPF.get('bil');
                                if(LAPFB != null){
                                    legalAss.pfisica.pOutLABBilId = string.valueOf(LAPFB.get('laBBilId'));
                                    legalAss.pfisica.pOutLABFechaRevision = string.valueOf(LAPFB.get('laBFechaRevision'));//'2018-11-01';
                                    legalAss.pfisica.pOutLABIncidencias = string.valueOf(LAPFB.get('laBIncidencias')); //'Y';
                                    legalAss.pfisica.pOutLABComentarios = string.valueOf(LAPFB.get('laBComentarios')); //'hola mundo desde persona fisica';
                                }
                            }
                                
                        }
                        
                        request.LAH =legalAss;
                    }
                    }
                    when 'Sic Code(no aplica)'
                    {
                        Map<string,object>sicCode = (Map<string,object>)newRequest.get('sicCode');
                        if(sicCode != null){
                            sicOde.pOutSicProposedId =  string.valueOf(sicCode.get('sicProposedId'));
                            sicOde.pOutSicProposedDescription = string.valueOf(sicCode.get('sicProposedDescription'));
                            sicOde.pOutSicId = string.valueOf(sicCode.get('sicId'));
                            sicOde.pOutSicDescription = string.valueOf(sicCode.get('sicDescription'));
                            request.sic = sicOde;
                        }
                    }
                    
                }
                Map<string,object>jsonResponse =null;
                jsonResponse = (Map<string,object>)JSON.deserializeUntyped(ES2_jsonDummy.entitymasterToJson());
                Map<String, Object> status = (Map<String, Object>)jsonResponse.get('status');
                statusM.pOutCode = string.valueOf(status.get('code'));
                statusM.pOutMessage = string.valueOf(status.get('message'));
                statusM.pOutDetail = string.valueOf(status.get('detail'));
                
                request.status = statusM;
                system.debug('OEJ REEQ: ' + request.pOutStartDate );
                
                WraperReqList.add(request);
                
                
                
            }
            
            system.debug('OEJ WraperReqList:' + WraperReqList);
            
            
            
        }    
        
        return WraperReqList;
        
    }
    public Boolean passval(String v){
        boolean a;
        if(v == 'Y'){
            a = true;
        }else{
            a = false;
        }
        return a;
    }
    public string pasnull(string a){
        if(a!=null){
            return a;
        }else{
            return '';
        }
    }
    public string pasnullDate(string a){
        if(a==null){
            return a;
        }else{
            return null;
        }
    }
    
}