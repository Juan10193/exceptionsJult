@isTest
public class ES2_Controller_CREDIT_BUREAU_Test{
	@testSetup
    static void setup(){
        
        EIV_Parameter__c param = new EIV_Parameter__c();
        param.EIV_tx_parameter__c = 'http://endpoint.com/';
        param.Name = 'URL_Servicio';
        Profile p = [SELECT Id FROM Profile Limit 1]; 
        User u = new User(Alias = 'standt1', Email='standarduser@testorg.com', 
		EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
		LocaleSidKey='en_US', ProfileId = p.Id, 
		TimeZoneSidKey='America/Los_Angeles', UserName='standarduserUno@testorg.com', EmployeeNumber = '555');
        insert param;
        
        ES2_Controller_CREDIT_BUREAU instBureau = new ES2_Controller_CREDIT_BUREAU();
        instBureau.OracleAccountName='ana';
        instBureau.legalname='juancho estuvo aqui';
        instBureau.sendtoCBbtn=true;
        instBureau.doctypess= new list<string>();
        instBureau.doctypess.add('REQUIRED');
        instBureau.encodedTextAES='lel';
        instBureau.formatDate(date.today());
        instBureau.quitaAnd('a&');
        instBureau.yesno('NO');
      instBureau.recarga();
        ES2_Controller_CREDIT_BUREAU.deleteDocument('12', '12', '12', '12', '12', '12', '12');
       ES2_Controller_CREDIT_BUREAU.newdocument('ana', '12', '12', 'alicia','123');
        ES2_Controller_CREDIT_BUREAU.downloadDoctos('12', '12');
        instBureau.doctypesList();
        instBureau.passUrlback();
    }  
    @isTest
    static void requestBlankTest(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new MockHttprequestBlankTest());
        Test.stopTest();
        //emulo una entrada a la página
        PageReference page = Page.ES2_Readpage_CREDIT_BUREAU;
        page.getParameters().put('requestId','234');
        page.getParameters().put('PartyId','456');
        page.getParameters().put('TopParentID','789');
        page.getParameters().put('TopParentName','123');
        page.getParameters().put('First_Name','456');
        Test.setCurrentPage(page);
        
        String sso= '999999999';
        String app= 'SF';
        String sServiceURL= 'http://160.34.7.97:7033';
        String searchRequestId;
        
        Map<String,object> res = EIV_EntityExtencionCalloutClass.callBackGetRequestDetailsOne(sso, app, sServiceURL, searchRequestId);
        System.debug('JDLL res test '+res);
        
        ES2_Controller_CREDIT_BUREAU instBureau = new ES2_Controller_CREDIT_BUREAU();
        instBureau.saveCB();
        instBureau.cambia('p');
        instBureau.cancel();
        instBureau.eToUrl('String data');
        instBureau.newcoment();
        instBureau.formatDate(null);
        
        instBureau.nameDoc='PRUEBA';
        instBureau.idDoc='123';
        instBureau.requestIdDoc='122';
        instBureau.partyIdDoc='1234';
        
        instBureau.oraId='12344';
        instBureau.docTypE='12345';
        
        instBureau.docId='12222';
        instBureau.docUrl='http:www.prueba.com';
        instBureau.cddate='16 de novienmbre';
        instBureau.urlflag=true;
        
        instBureau.backUrl='http:www.prueba.com';
        
        instBureau.doctiposString='ygfd';
        
        instBureau.EncriptationType ='AES128';
        instBureau.KeyEncriptation ='1234567890123456';
        instBureau.req.pOutRequestId = '12';
        instBureau.req.pOutPartyId = '12';
        
        
        instBureau.onHold();
        instBureau.entities('ind');
        instBureau.entities('org');
        instBureau.entities('kjmhngbv');
        instBureau.edit();
        instBureau.ECEntity('397');
        instBureau.ECEntity('798');
        instBureau.ECEntity('XA7');
        instBureau.ECEntity('');
        instBureau.fecha('23/12/12');
        instBureau.fecha('');
       // instBureau.sendToCreditBureau();
        instBureau.rework();
        instBureau.reject();
        //instBureau.deleteDocument();
        
        instBureau.send();
        instBureau.yesno('YES');
    }
    
     @isTest 
    static void testCallout(){
          
        PageReference page = Page.ES2_Readpage_CREDIT_BUREAU;
        page.getParameters().put('requestId','');
        page.getParameters().put('PartyId','456');
        page.getParameters().put('TopParentID','789');
        page.getParameters().put('TopParentName','123');
        page.getParameters().put('First_Name','456');
        Test.setCurrentPage(page);
        ES2_Controller_CREDIT_BUREAU instBureau = new ES2_Controller_CREDIT_BUREAU();
        instBureau.editCB();
        instBureau.accept();
        instBureau.approve();
        instBureau.yesno(' ');
        instBureau.passnull(' ');
        TBO002_SIC_code__c sic = new TBO002_SIC_code__c();
		sic.Name = '999';
		sic.TBO002_tx_SIC_industry_description__c = 'Description';
		insert sic;
		sic.id = [Select id from TBO002_SIC_code__c where name =:'999'][0].id;
    }
    
    
}