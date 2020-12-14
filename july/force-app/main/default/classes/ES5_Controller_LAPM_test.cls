@istest
private class ES5_Controller_LAPM_test {
    @isTest 
    static void runTest(){
        ES5_obj_catalogo_pais__c catalog = new ES5_obj_catalogo_pais__c();
        catalog.ES5_tx_codigo_pais__c = 'hola';
        catalog.ES5_tx_nombre_pais__c = 'hola - hola';
        insert catalog;  
        
        EIV_PostalCodeCatalog__c catalog2 = new EIV_PostalCodeCatalog__c();
        catalog2.EIV_tx_Codigo_Estado__c = 'hola';
        catalog2.EIV_tx_Postal_Code__c = 'hola';
        insert catalog2;
        ES5_Controller_LAPM inst = new ES5_Controller_LAPM();
        
        inst.docId='123';
        inst.docUrl = 'hola';
        inst.cddate = '11/11/11';
        inst.urlflag = true;
        inst.backUrl = 'mundo';
        inst.Backtola();
        inst.Backtoentity();
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
        inst.newcoment();
        inst.EditPM();
        inst.Redirect_Read_Apoder();
        inst.Redirect_New_limitante();
        inst.Redirect_New_Apoder();
        inst.Redirect_New_Modificaciones();
        inst.Redirect_RP_Modificaciones();
        inst.accept();
        inst.onHold();
        inst.rework();
        inst.reject();
        inst.approve();
        inst.PrintPDF();
        inst.cancel();
        inst.send();
        inst.Redirect_RP_Limitantes();
        inst.Redirect_New_Limitantes();
        inst.savePM();
        inst.idReg = '1111';
        inst.Busca_Limitante();
        inst.Busca_Apoderado();
        inst.Busca_Modificaciones();
        inst.doctypesList();
        inst.CallApex_Validate_Country();
    }
    
    public static testMethod void aftIns()
    {
        ES5_Controller_LAPM.newdocument('hhgf', 'hhgf', 'hhgf', 'hhgf', 'hhgf');
        ES5_Controller_LAPM.downloadDoctos('1234','87654');
        ES5_Controller_LAPM.deleteDocument('87654', '87654','87654','87654','87654','87654','87654');
    }
}