@isTest
public class ES2_controller_POSTjsonTest {

    static testmethod void Test_Tables(){
        ES2_controller_POSTjson a = new ES2_controller_POSTjson();
        a.Post_Limitantes_Edit('20',ES2_controller_POSTjsonTest.WraperLimitante());
        a.Post_Limitantes_New('20',ES2_controller_POSTjsonTest.WraperLimitante());
        a.Post_Modificaciones_EDIT_NEW('20',ES2_controller_POSTjsonTest.WraperModificacion());
        a.Post_Apoderados_NEW('20',ES2_controller_POSTjsonTest.WraperApoderados());
        a.Post_Apoderados_EDIT('20',ES2_controller_POSTjsonTest.WraperApoderados());
        a.Post_Estatutos_EDIT('20',ES2_controller_POSTjsonTest.WraperEstatuto());
        a.Post_Estatutos_NEW('20',ES2_controller_POSTjsonTest.WraperEstatuto());
    }
    static testmethod void Test_postLA_AND_Get_Post_General(){
        ES2_WraperRequest req = new ES2_WraperRequest();
        ES2_controller_POSTjson a = new ES2_controller_POSTjson();
        ES2_Controller_KWYPMoralFill rellena = new  ES2_Controller_KWYPMoralFill();
        Map<string,object>jsonResponse =null;
        jsonResponse = (Map<string,object>)JSON.deserializeUntyped(ES2_jsonDummy.entitymasterToJson());
        Map<String, Object> mapRequests = (Map<String, Object>)jsonResponse.get('requests');
        list<ES2_WraperRequest> dts = new list<ES2_WraperRequest>();
                dts = rellena.rellenarHeader(mapRequests);
                if(dts.size()>0)
                { 
                    req = dts[0];
                }
        a.postLA(req, 'laPersonaMoral');
        a.postLA(req, 'laPersonaMoralExtranjera');
        a.postLA(req, 'laPersonaFisica');
        a.Get_Post_General(req);
        a.postgeneral('Test',req);
    }
    
    static testmethod ES5_wraper_LA_limitante WraperLimitante(){
        ES5_wraper_LA_limitante Limitante = new ES5_wraper_LA_limitante();
        Limitante.laMLLimatingId ='10';
        Limitante.laMLLimitante  ='test'; 
        Limitante.laMLDocumentID  ='10';
        Limitante.laMLEscritura  ='test';
        Limitante.laMLFecha  ='test';
        Limitante.laMLFederatarioPublico  ='test';
        Limitante.laMLRLugar  ='test';
        Limitante.laMLRFecha  ='test';
        Limitante.laMLRDatos  ='test';
        Limitante.laMLActiveFlag  ='test';
        Limitante.laMLCreatedBy  ='test';
        Limitante.laMLCreationDate  ='test';
        Limitante.laMLLastUpdatedBy  ='test';
        Limitante.laMLLastUpdateDate  ='test';
        Limitante.laMLNameCreatedBy  ='test';
        Limitante.laMLNameUpdatedBy ='test';
        return Limitante;
    }
    static testmethod ES5_wraper_LA_modificacion WraperModificacion(){
        ES5_wraper_LA_modificacion modificacion = new ES5_wraper_LA_modificacion();
        modificacion.laMModificationId ='10';
        modificacion.laMMDocumentId ='12';
        modificacion.laMMReformaTotal ='test';
        modificacion.laMMEscritura ='test';
        modificacion.laMMFecha ='test';
        modificacion.laMMFederatarioPublico ='test';
        modificacion.laMMRLugar ='test';
        modificacion.laMMRFecha ='test';
        modificacion.laMMRDatos ='test';
        modificacion.laMMObservaciones ='test';
        modificacion.laMMActiveFlag ='test';
        modificacion.laMMCreatedBy ='test';
        modificacion.laMMCreationDate ='test';
        modificacion.laMMLastUpdatedBy ='test';
        modificacion.laMMLastUpdateDate ='test';
        modificacion.laMMNameCreatedBy ='test';
        modificacion.laMMNameUpdatedBy ='test';
        return modificacion;
    }
    static testmethod ES5_wraper_LA_apoderados WraperApoderados(){
        ES5_wraper_LA_apoderados apoderados = new ES5_wraper_LA_apoderados();
        apoderados.laAApoderadoID = '12';
        apoderados.laADocumentID= '12'; 
        apoderados.laANombreFacultado = 'test';
        apoderados.laAFecha = 'test';
        apoderados.laAActosDominio = 'test';
        apoderados.laATitulosCredito = 'test';
        apoderados.laAActosAdministrativos = 'test';
        apoderados.laAPleitosCobranza = 'test';
        apoderados.laAIndMan = 'test';
        apoderados.laAObservaciones = 'test';
        apoderados.laAEscrituraNum = 'test';
        apoderados.laAPEspecial = 'test';
        apoderados.laAPOtros = 'test';
        apoderados.laAFedatarioPublico = 'test';
        apoderados.laAFechaRegistro = 'test';
        apoderados.laALugarRegistro = 'test';
        apoderados.laADatosRegistro = 'test';
        apoderados.laAOcupacion = 'test';
        apoderados.laAFechaNacimiento = 'test';
        apoderados.laANacionalidad = 'test';
        apoderados.laADomicilio = 'test';
        apoderados.laAEscrituraRevoca = 'test';
        apoderados.laAFechaRevoca = 'test';
        apoderados.laALugarRevoca = 'test';
        apoderados.laADatosRegistroRevoca = 'test';
        apoderados.laAObservacionesRevoca = 'test';
        apoderados.laAActiveFlag = 'test';
        apoderados.laACreatedBy = 'test';
        apoderados.laACreationDate = 'test';
        apoderados.laALastUpdatedBy = 'test';
        apoderados.laALastUpdateDate = 'test';
        apoderados.laANameCreatedBy = 'test';
        apoderados.laANameUpdatedBy = 'test';
        return apoderados;
    }
    static testmethod ES5_wraper_LA_Estatutos WraperEstatuto(){
        ES5_wraper_LA_Estatutos estatuto = new ES5_wraper_LA_Estatutos();
        estatuto.pOutlaEEstatutoID = '12';
        estatuto.pOutlaEEstatuto = 'test';
        estatuto.pOutlaEFecha = 'test';
        estatuto.pOutlaEComentarios = 'test';
        estatuto.pOutlaEObservaciones = 'test';
        estatuto.pOutlaEActiveFlag = 'test';
        estatuto.pOutlaECreatedBy = 'test';
        estatuto.pOutlaECreationDate = 'test';
        estatuto.pOutlaELastUpdatedBy = 'test';
        estatuto.pOutlaELastUpdateDate = 'test';
        estatuto.pOutlaENameCreatedBy = 'test';
        estatuto.pOutlaENameUpdatedB = 'test';
        return estatuto;
    }
    //static testmethod ES5_wraper_LA_Estatutos WraperEstatuto(){}
    
    
}