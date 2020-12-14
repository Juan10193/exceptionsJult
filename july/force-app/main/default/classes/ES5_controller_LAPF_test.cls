@isTest
private class ES5_controller_LAPF_test {
    @isTest 
    static void runTestPF(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        ES5_obj_catalogo_pais__c catalog = new ES5_obj_catalogo_pais__c();
        catalog.ES5_tx_codigo_pais__c = 'hola';
        catalog.ES5_tx_nombre_pais__c = 'hola - hola';
        insert catalog;  
        EIV_PostalCodeCatalog__c catalog2 = new EIV_PostalCodeCatalog__c();
        catalog2.EIV_tx_Codigo_Estado__c = 'hola';
        catalog2.EIV_tx_Postal_Code__c = 'hola';
        insert catalog2;
        ES5_controller_LAPF inst = new ES5_controller_LAPF();
        inst.idReg = 'hola';
        inst.pais = catalog.id;
        inst.PostalCode = catalog2.id;
        inst.getpais();
        inst.getPostalCode();
        inst.getpaisCD();
        inst.getPostalCodeCD();
        inst.getpaisDF();
        inst.getPostalCodeDF();
        inst.setpais(inst.pais);
        inst.setPostalCode(inst.PostalCode);
        inst.setpaisCD(inst.pais);
        inst.setPostalCodeCD(inst.PostalCode);
        inst.setpaisDF(inst.pais);
        inst.setPostalCodeDF(inst.PostalCode);
        inst.String_To_Date('18/01/2018');
        Date expectedDate = Date.newInstance(1991, 2, 21);
        inst.Date_Format(expectedDate);
        inst.saveStatusGeneral('Nothing', 'CANCELLED BY REQUESTOR', true);
        inst.saveStatusGeneral('Nothing', 'IN PROCESS', false);
        inst.saveStatusGeneral('Nothing', null, true);
        inst.cambia('10000');
        inst.cambia('20000');
        inst.send();
        inst.accept();
        inst.cancel();
         inst.approve();
        inst.onHold();
        inst.rework();
        inst.reject();
        inst.PrintPDF();
         inst.Redirect_New_Apoder();
        inst.Redirect_New_Limitantes();
        inst.Redirect_RP_Limitantes();
        inst.Redirect_New_limitante();
        inst.Redirect_Read_Apoder();
        inst.EditPF();
        inst.newcoment();
        inst.NewApoder();
        inst.Backtoentity();
        inst.doctypesList();
        inst.Backtola();
        inst.EditPM();
        inst.savePF();
        inst.viewApoder();
        inst.Redirect_New_Modificaciones();
        inst.Redirect_RP_Modificaciones();
        ES5_controller_LAPF.deleteDocument('requestIdDoc', 'oraId','docUrl','docType','docId','nameDoc','requestId');
        ES5_controller_LAPF.newdocument('DocTypesObj', 'requestId', 'partyId', 'pOutEGPartyName','sso');
        ES5_controller_LAPF.downloadDoctos('docId','RequestId');
    }
    
    @isTest 
    static void Execute_InitData(){
        ES5_controller_LAPF inst = new ES5_controller_LAPF();
        //LAPME.Estatutos = new ES5_wraper_LA_Estatutos();
        inst.Ndocbtn = true;
        Date expectedDate = Date.newInstance(1991, 2, 21);
        inst.laFechaVT= expectedDate ;
        inst.laFechaN= expectedDate ;
        inst.laFechaVId = expectedDate;
        inst.docId = 'test';
        inst.docUrl = 'test';
        inst.cddate = 'test';
        inst.urlflag = true;
        inst.backUrl = '';
        inst.sendbtn     = true;                            
        inst.aceptbtn = true;                               
        inst.cancelbtn = true;                  
        inst.editbtn = true;            
        inst.aprbtn = true; 
        inst.rejbtn = true;
        inst.reworkbtn = true;                          
        inst.onhdbtn = true;                    
        inst.btentbtn = true;                               
        inst.Ncombtn = true;
        
    }
}