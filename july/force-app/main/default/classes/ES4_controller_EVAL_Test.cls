@isTest
private class ES4_controller_EVAL_Test {
    @istest static void responseToEntityObjTest(){
         ES4_Controller_EVAL inst = new ES4_Controller_EVAL();
         Map<String, object> MyStrings = new Map<String, object>();
         inst.responseToEntityObj(MyStrings);
    }
    
    @isTest static void testgetEntitiesOptions(){
         ES4_Controller_EVAL inst = new ES4_Controller_EVAL();
        Test.setMock(HttpCalloutMock.class, new MockHttpEntitiesTP());
       
        // Call method to test.
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock. 
        inst.req.pOutSourceAccountId='345';
        inst.sSSO='123';
        inst.sServiceURL='http://160.34.7.97:7033'; 
        inst.getListEntities();
    }
    
    @isTest 
    private static void runTestnoreq(){
        Catalogo_Colaterals__c catalog = new Catalogo_Colaterals__c();
        catalog.COLATERAL_DESCRIPTION__c = 'TRANSPORTATION ACCESSORIES';
        catalog.COLATERAL_TYPE__c = 'TRANSPORTATION - TRUCK';
        catalog.MODEL__c = '';
        catalog.MANUFACTURER__c = 'OTHER';
        catalog.MODEL_YEAR__c = '';
        insert catalog;        
        
        ES4_Controller_EVAL inst = new ES4_Controller_EVAL();
        inst.idcloneass ='12313';
        
        //Creación de archivo para lectura
        String[] csvFileLines;
        Blob csvFileBody;
        String csvReading = 'ASSET_ID,ASSET_DESCRIPTION,VALUATION_ID,TERM_MONTHS,FMV_AMOUNT,NRV_AMOUNT,OLV_AMOUNT,RV_AMOUNT,FMV_PERCENT,NRV_PERCENT,OLV_PERCENT,RV_PERCENT,INSURANCE_PRIMA,No_Tocar\n522,Prueba,12345,48,789,789,789,789,10,45,10,10,10,';
       	csvFileBody = Blob.valueOf(csvReading);
        String csvAsString = csvFileBody.toString();
        csvFileLines = csvAsString.split('\n'); 
        
        inst.req = new ES2_WraperRequest();
        inst.req.pOutRequestId = '1121';
        inst.colateral_Desq=new list<SelectOption>();
        inst.Manufacture=new list<SelectOption>();
        inst.dts = new list<ES2_WraperRequest>();
        inst.btentbtn =true;
        inst.btoppbtn=true;
        inst.reasingbtn=true;
        inst.typeS='aa';
        inst.nameDoc='a6';
        inst.idDoc='12';
        inst.requestIdDoc='12';
        inst.partyIdDoc='12';
        inst.oraId='12';
        inst.docType='al';
        inst.docId='12';
        inst.docUrl='nalgas';
        inst.cddate='12';
        inst.urlflag=true;
        inst.doctypess=new list<string>();
        inst.doctiposString='ana';
        inst.csvFileBodyAss= blob.valueOf('a5');
        inst.csvAsStringAss='a4';
        inst.csvFileBodyVal= blob.valueOf(csvReading);
        inst.csvAsStringVal='a2';
        inst.csvFileLinesVal = new list<string>();
        inst.manlist='12';
        inst.colaBox='12';
        inst.colaDescBox='12';
        inst.manufacBox='12';
        inst.modelBox='12';
        inst.AyearBox='12';
        inst.sIdTypeRequest='12';
        inst.encodedTextAES='12';
        inst.getsEntityMasterIdSelected();
        inst.accept();
        inst.onHold();
        inst.rework();
        inst.reject();
        inst.approve();
        inst.preApprove();
        inst.cancel();
        inst.editEVAL();
        inst.backOPP();
        inst.editAsset1();
        inst.editValuation();
        inst.editEndorsement();
        inst.newAsset1();
        inst.newInsurance();
        inst.newRapid();
        inst.backAsset();
        inst.newValuation();
        inst.newEndorsement();
        inst.viewRequest();
        inst.years_list();
        inst.model_list();
        inst.cloneEVAL();
        inst.send();
        inst.returnToGroup();
        inst.PrintPDF();
        inst.viewEndorsement();
        inst.colateraldesq();
        inst.getEntitiesOptions(); 
        inst.maufactur();
        ES4_Controller_EVAL.OracleFAID('TRANSPORTATION - TRUCK', 'TRANSPORTATION ACCESSORIES');
        inst.backEVAL();
        inst.pasnullnum(null);
        inst.pasnullnum('w');
        inst.viewValuation();
        inst.doctypesList();
        inst.cargaDummy();
        inst.cargaDummy2();
        inst.req.pOutRequestId = '1121';
        inst.NewAsset();
        inst.EditAsset();
        inst.delateAsset();
        inst.remplase('');
        inst.uploadExelASS();
        inst.NewEndodorsement();
        inst.NewValua();
        inst.newcoment();
        inst.recarga();
        inst.cargaValuation();
        inst.cargaEndorsement();
        inst.uploadExelVAL();        
        //inst.getListEntities();
    }
    @isTest 
    private static void runTest(){
        ES4_Controller_EVAL inst = new ES4_Controller_EVAL();
        inst.sSSO='765765';
        inst.sendbtn=true;
        inst.aceptbtn=false;
        inst.onhdbtn=true;
        inst.reworkbtn=false;
        inst.docId='43e2234';
        inst.doctiposString='rtlgrfdm';
        inst.docUrl='hgbfrvd';
        inst.cddate='hgbfrvd';
        inst.urlflag=true;
        inst.backUrl='hgbfrvd';
        inst.UrlAppDoctos='ikjuhyg';
        inst.EncriptationType='ikjuhyg';
        inst.KeyEncriptation='ikjuhyg';
        inst.URL_Servicio_Externa='ikjuhyg';
        inst.rejbtn=true;
        inst.preaprbtn=false;
        inst.aprbtn=true;
        inst.Aaprbtn=false;
        inst.cancelbtn=true;
        inst.editbtn=true;
        inst.Ncombtn=false;
        inst.Ndocbtn=true;
        inst.nameDoc='gbvf';
        inst.idDoc='gbvf';
        inst.requestIdDoc='gbvf';
        inst.partyIdDoc='gbvf';
        inst.oraId='gbvf';
        inst.docType='gbvf';
        inst.detail = new EIV_DetailWrapClass();
        inst.detail.errorCode = 'S';
        inst.detail.description ='success';
        inst.detail.message =  'bgknfdmvbcnbnxcb';
        inst.type=  'bgknfdmvbcnbnxcb';
        inst.man=  'bgknfdmvbcnbnxcb';
        inst.model=  'bgknfdmvbcnbnxcb';
        inst.modelYear=  'bgknfdmvbcnbnxcb';
        inst.mancam=  'bgknfdmvbcnbnxcb';
        inst.manlist=  'bgknfdmvbcnbnxcb';
        inst.colaBox=  'bgknfdmvbcnbnxcb';
        inst.colaDescBox=  'bgknfdmvbcnbnxcb';
        inst.manufacBox=  'bgknfdmvbcnbnxcb';
        inst.modelBox=  'bgknfdmvbcnbnxcb';
        inst.AyearBox=  'bgknfdmvbcnbnxcb';
        inst.accept();
        inst.approve();
        inst.cancel();
        inst.rework();
        inst.backEVAL();
        inst.onHold();
        inst.reject();
        inst.preApprove();
        inst.doctypesList();
        inst.newcoment();
        inst.recarga();
       // inst.templeteval();
        inst.yesnobtn();
        inst.colateraldesq();
        inst.maufactur();
        
        
    }

    @isTest 
    static void backToEntityTest(){
        ES4_controller_EVAL inst = new ES4_controller_EVAL();
        
        TBO002_SIC_code__c sic = new TBO002_SIC_code__c();
        sic.Name = '999';
        sic.TBO002_tx_SIC_industry_description__c = 'Description';
        insert sic;
        sic.id = [Select id from TBO002_SIC_code__c where name =:'999'][0].id;
        inst.backToEntity();
        inst.passUrlback();
        inst.saveEVAL();
       // inst.NewValua();
       // inst.NewEndodorsement();
        
		ES2_jsonDummy.JsonnULO('requesty');
        ES2_jsonDummy.entitymasterToJsonTes('requestType');
        ES2_jsonDummy.jsondocs();
        
    } 
    public static testMethod void aftIns()
    {
        
        ES4_controller_EVAL.newdocument('hhgf', 'hhgf', 'hhgf', 'hhgf', 'hhgf');
        ES4_controller_EVAL.downloadDoctos('1234','87654');
        ES4_controller_EVAL.deleteDocument('87654', '87654','87654','87654','87654','87654', '87654');
        
    }
    
}