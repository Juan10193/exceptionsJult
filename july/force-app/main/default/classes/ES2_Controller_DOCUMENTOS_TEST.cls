@isTest
public class ES2_Controller_DOCUMENTOS_TEST {
    @isTest
    static void testDocumentos(){
        ES2_Controller_DOCUMENTOS instDoc = new ES2_Controller_DOCUMENTOS();
        instDoc.OracleAccountName = null;
        instDoc.TopParentName = null;
        instDoc.legalname = null;
        instDoc.filename = null;
        instDoc.fileurl = null;
        instDoc.filetype = null;
        instDoc.filevalue = null;
        instDoc.docTypesToURL = null;
        String dato = null;
        instDoc.BackDocumentos();
        PageReference pr = Page.ES2_ReadPage_DOCUMENTOS;
        pr.getParameters().put('requestId', 'ID1234');
        Test.setCurrentPage(pr);
        System.debug('1234dsfkl'+ pr);
        instDoc.SaveDoCTOS();
        instDoc.getDocOptions();
        instDoc.nullTovacio(dato);
    }
    
    @isTest
    static void testDocumentosDelete(){
        ES2_Controller_DOCUMENTOS instDoc = new ES2_Controller_DOCUMENTOS();
        String partyId = 'null';
        String requestId = 'requestId';
        String url = 'null';
        String idDoc = 'null';
        String sourceAccountId = 'null';
        String sourceTopParentId = 'sourceTopParentName';
        String sourceTopParentName = 'null';
        String pOutPartyName = 'null';
        String egPartyId = 'null';
        String egPartyName = 'null';
        
        instDoc.DeleteDocs(partyId, requestId, url, idDoc, sourceAccountId, sourceTopParentId, sourceTopParentName, pOutPartyName, egPartyId, egPartyName);
    }
    
    @isTest
    static void  testDocumentosjson(){
       ES2_Controller_DOCUMENTOS inst = new ES2_Controller_DOCUMENTOS();
        inst.req =new ES2_WraperRequest();
        inst.doc =  new ES2_Wraper_documents();
        inst.OracleAccountName ='mauricia';
        inst.TopParentName = 'lagar';
        inst.legalname = 'Mara SA';
        inst.dir = 'aleluya';
        inst.x = date.today();
        inst.y =  date.today();
        inst.fileurl = 'ama/pdf';
        inst.filetype = 'KYC_DOCUMENT';
        inst.sServiceURL ='asdad';
        inst.sSSO='1231231';
        inst.dts = new list<ES2_WraperRequest>();
        inst.docTypesToURL = 'pdf';
        inst.filename = 'marta.pdf';
        inst.SaveDoCTOS();
        ES2_Controller_DOCUMENTOS.deleteDoc('12', '13', 'https:lol.com', 'Insurance', '12', 'lol' );
        inst.page('CB');
        
        
        
    }
     @isTest
    static void  testDocumentosNDA(){
        ES2_Controller_DOCUMENTOS inst = new ES2_Controller_DOCUMENTOS();
        inst.page('NDA');
    }
     @isTest
    static void  testDocumentosAML(){
        ES2_Controller_DOCUMENTOS inst = new ES2_Controller_DOCUMENTOS();
        inst.page('AML');
    }
    
     @isTest
    static void  testDocumentoskycpm(){
        ES2_Controller_DOCUMENTOS inst = new ES2_Controller_DOCUMENTOS();
        inst.page('kycpm');
    }
     @isTest
    static void  testDocumentoskycpf(){
        ES2_Controller_DOCUMENTOS inst = new ES2_Controller_DOCUMENTOS();
        inst.page('kycpf');
    }
    
     @isTest
    static void  testDocumentosnulopag(){
        ES2_Controller_DOCUMENTOS inst = new ES2_Controller_DOCUMENTOS();
        inst.page('');
    }
    
}