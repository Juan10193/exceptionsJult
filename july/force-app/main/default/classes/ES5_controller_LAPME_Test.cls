@istest
public class ES5_controller_LAPME_Test {
    @isTest
    private static void Execute_Constructor(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        
        ES5_controller_LAPME LAPME = new ES5_controller_LAPME();
        LAPME.idReg = '1002';
        LAPME.getPostalCode();
        LAPME.setPostalCode('55423');
        LAPME.getPostalCodeCD();
        LAPME.setPostalCodeCD('55423');
        LAPME.getPostalCodeDF();
        LAPME.setPostalCodeDF('55423');
        LAPME.getpais();
        LAPME.setpais('55423');
        LAPME.getpaisCD();
        LAPME.setpaisCD('México');
        LAPME.getpaisCD();
        LAPME.setpaisCD('México');
        LAPME.getpaisDF();
        LAPME.setpaisDF('México');
        LAPME.String_To_Date('18/01/2018');
        Date expectedDate = Date.newInstance(1991, 2, 21);
        LAPME.Date_Format(expectedDate);
        LAPME.saveStatusGeneral('Nothing', 'CANCELLED BY REQUESTOR', true);
        LAPME.saveStatusGeneral('Nothing', 'IN PROCESS', false);
        LAPME.saveStatusGeneral('Nothing', null, true);
        LAPME.cambia('10000');
        LAPME.cambia('20000');
        //LAPME.yesnobtn();
           // cambia
        LAPME.send();
        LAPME.accept();
        LAPME.cancel();
        LAPME.approve();
        LAPME.onHold();
        LAPME.rework();
        LAPME.reject();
        LAPME.PrintPDF();
        LAPME.savePME();
        LAPME.savePME();
        LAPME.Backtoentity();
        //LAPME.Busca_Apoderado();
        LAPME.Redirect_New_Apoder();
        LAPME.Redirect_New_limitante();
        LAPME.Redirect_New_limitante();
        LAPME.Redirect_Read_Apoder();
        LAPME.newestatuto();
        LAPME.viewestatuto();
        LAPME.EditPME();
        LAPME.newcoment();
        //LAPME.deleteDocument(string requestIdDoc, string oraId,string docUrl,string docType,string docId,string nameDoc, string requestId)
        //LAPME.newdocument(string DocTypesObj, string requestId, string partyId, String pOutEGPartyName,string sso)
        //LAPME.downloadDoctos(string docId, string RequestId)
        LAPME.doctypesList();
        LAPME.Backtola();
        ES5_controller_LAPME.deleteDocument('requestIdDoc', 'oraId','docUrl','docType','docId','nameDoc','requestId');
        ES5_controller_LAPME.newdocument('DocTypesObj', 'requestId', 'partyId', 'pOutEGPartyName','sso');
        ES5_controller_LAPME.downloadDoctos('docId','RequestId');
    }
    @isTest 
    static void Execute_InitData(){
        ES5_controller_LAPME LAPME = new ES5_controller_LAPME();  
        LAPME.Estatutos = new ES5_wraper_LA_Estatutos();
        LAPME.Ndocbtn = true;
        LAPME.docId = 'test';
        LAPME.docUrl = 'test';
        LAPME.cddate = 'test';
        LAPME.urlflag = true;
        LAPME.backUrl = '';
        LAPME.sendbtn    = true;                            
        LAPME.aceptbtn = true;                              
        LAPME.cancelbtn = true;                 
        LAPME.editbtn = true;           
        LAPME.aprbtn    = true; 
        LAPME.rejbtn    = true;
        LAPME.reworkbtn = true;                         
        LAPME.onhdbtn = true;                   
        LAPME.btentbtn = true;                              
        LAPME.Ncombtn = true;
        
    }

}