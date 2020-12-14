@isTest 
public class ES2_Controller_AMLTest {
    @isTest 
    static void AMLTest(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new MockHttpAMLTest());
        Test.stopTest();
        //emulo una entrada a la página
        PageReference page = Page.ES2_Readpage_AML;
        page.getParameters().put('requestId','234');
        page.getParameters().put('PartyId','456');
        page.getParameters().put('TopParentID','789');
        page.getParameters().put('TopParentName','123');
        Test.setCurrentPage(page);
        
        ES4_wraper_RelatedRequest rr = new ES4_wraper_RelatedRequest();
        rr.testRelated();
        String sso= '999999999';
        String app= 'SF';
        String sServiceURL= 'http://160.34.7.97:7033';
        String searchRequestId;
        
        Map<String,object> res = EIV_EntityExtencionCalloutClass.callBackGetRequestDetailsOne(sso, app, sServiceURL, searchRequestId);
        System.debug('JDLL res test '+res);
        
        ES2_Controller_AML instanciaAML = new ES2_Controller_AML();
        instanciaAML.nameDoc ='Marta';
        instanciaAML.idDoc='12';
        instanciaAML.requestIdDoc='12';
        instanciaAML.partyIdDoc='12';
        instanciaAML.oraId='12';
        instanciaAML.docType='AML';
        instanciaAML.docId='12';
        instanciaAML.docUrl='alba';
        instanciaAML.cddate='asd';
        instanciaAML.urlflag=true;
        instanciaAML.doctypess=new list<string>();
        instanciaAML.doctiposString='hola';
        instanciaAML.backUrl='lol';
        instanciaAML.encodedTextAES='lol';
        instanciaAML.accept();
        instanciaAML.approve();
        instanciaAML.cambia('p');
        instanciaAML.cancel();
        
        instanciaAML.editAML();
        instanciaAML.newcoment();
        
        instanciaAML.onHold();
        instanciaAML.preApprove();
        instanciaAML.reject();
        instanciaAML.rework();
        instanciaAML.saveAML();
        instanciaAML.send();
        instanciaAML.passvalue('Y');
        instanciaAML.passvalue('N');
        //instanciaAML.resultado = 'ERROR';
        //instanciaAML.deleteDocument();
        //instanciaAML.yesnobtn();
        instanciaAML.recarga();
        ES2_Controller_AML.deleteDocument('2', '3', 'ana', 'Nadas', 'antidote', '21', '3');
        ES2_Controller_AML.newdocument('a', 'a', '12', 'ana', '123');
        ES2_Controller_AML.downloadDoctos('12', '12');
    }
    @isTest
    static void AMLTestReqIdNulo(){
        PageReference pr = Page.ES2_EditPage_AML;
        pr.getParameters().put('requestId','Id321');
        pr.getParameters().put('PartyId','9873hIUH');
        Test.setCurrentPage(pr);
        ES2_Controller_AML instanciaAML = new ES2_Controller_AML();
        instanciaAML.req.DocTypesObj = new List<ES2_Wraper_Doctype>();
        instanciaAML.send();
    }
    @isTest
    static void backToEntityTest(){
        ES2_Controller_AML instanciaAML = new ES2_Controller_AML();
        TBO002_SIC_code__c sic = new TBO002_SIC_code__c();
        sic.Name = '999';
        sic.TBO002_tx_SIC_industry_description__c = 'Description';
        insert sic;
        sic.id = [Select id from TBO002_SIC_code__c where name =:'999'][0].id;
        instanciaAML.backToEntity();    
    } 
}