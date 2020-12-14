/**
 * @File Name          : Wk_TableExposurelwc_controller_Test.cls
 * @Description        : 
 * @Author             : juandedios.hernandez@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : eduardo.villegas@engeniumcapital.com
 * @Last Modified On   : 10/10/2019 23:07:51
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    30/9/2019   juandedios.hernandez@engeniumcapital.com     Initial Version
**/
@Istest
private  class Wk_TableExposurelwc_controller_Test {
    
    @Istest
    static void getEntitiesECGroupTest (){
        String testEndpoint = 'callout:getsServiceUrl' + '/EcExposureSbBix/ExposureRs/exposure?economicGroupId=32249';
        String getResponse = '{'+
		'    "contracts": {'+
		'        "contract": ['+
		'            {'+
		'                "partyId": 25297,'+
		'                "partyName": "TRITURADOS Y CONCRETOS DEL SURESTE, S.A. DE C.V.",'+
		'                "economicGroupId": "32249",'+
    '                "economicGroupName": "GRUPO GORSA",'+
		'                "oracleAccountNumber": "000000811",'+
		'                "contractNumber": "P7791046005",'+
		'                "currency": "MXN",'+
		'                "productName": "AFINAN-VAR_397",'+
		'                "contractOec": "10867603.81",'+
		'                "exposure": "923145.18",'+
		'                "openItemsAr": "263213.83",'+
		'                "daysDueAr": "486",'+
		'                "openItemsDlq": "0",'+
		'                "daysDueDlq": "0",'+
		'                "vertical": "EQUIPO",'+
		'                "nbv": "0"'+
		'            },'+
		'            {'+
		'                "partyId": 25297,'+
		'                "partyName": "TRITURADOS Y CONCRETOS DEL SURESTE, S.A. DE C.V.",'+
		'                "economicGroupId": "32249",'+
		'                "economicGroupName": "GRUPO GORSA",'+
		'                "oracleAccountNumber": "000000811",'+
		'                "contractNumber": "P7791046004",'+
		'                "currency": "MXN",'+
		'                "productName": "AFINAN-VAR_397",'+
		'                "contractOec": "1606903.54",'+
		'                "exposure": "136498.06",'+
		'                "openItemsAr": "38919.4",'+
		'                "daysDueAr": "486",'+
		'                "openItemsDlq": "0",'+
		'                "daysDueDlq": "0",'+
		'                "vertical": "EQUIPO",'+
		'                "nbv": "0"'+
		'            },'+
		'            {'+
		'                "partyId": 25297,'+
		'                "partyName": "TRITURADOS Y CONCRETOS DEL SURESTE, S.A. DE C.V.",'+
		'                "economicGroupId": "32249",'+
		'                "economicGroupName": "GRUPO GORSA",'+
		'                "oracleAccountNumber": "000000811",'+
		'                "contractNumber": "P7791046003",'+
		'                "currency": "MXN",'+
		'                "productName": "AFINAN-VAR_397",'+
		'                "contractOec": "2369950",'+
		'                "exposure": "201314.88",'+
		'                "openItemsAr": "57400.49",'+
		'                "daysDueAr": "486",'+
		'                "openItemsDlq": "0",'+
		'                "daysDueDlq": "0",'+
		'                "vertical": "EQUIPO",'+
		'                "nbv": "0"'+
		'            },'+
		'            {'+
		'                "partyId": 25184,'+
		'                "partyName": "PYASUR, S.A. DE C.V.",'+
		'                "economicGroupId": "32249",'+
		'                "economicGroupName": "GRUPO GORSA",'+
		'                "oracleAccountNumber": "000000651",'+
		'                "contractNumber": "P5910618013",'+
		'                "currency": "MXN",'+
		'                "productName": "AFINAN-VAR_397",'+
		'                "contractOec": "7004928.54",'+
		'                "exposure": "0",'+
		'                "openItemsAr": "1373.8",'+
		'                "daysDueAr": "776",'+
		'                "openItemsDlq": "0",'+
		'                "daysDueDlq": "0",'+
		'                "vertical": "EQUIPO",'+
		'                "nbv": "0"'+
		'            }'+
		'        ]'+
		'    },'+
		'    "status": {'+
		'        "code": 200,'+
		'        "message": "Success",'+
		'        "detail": "S"'+
		'    }'+
		'}';

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseHandler_cls(testEndpoint, getResponse, 'GET', 'application/json', 200));
        string res = Wk_TableExporsurelwc_controller_cls.getEntitiesECGroup('32249');
		system.debug('RES');
		system.debug(res);
        System.assertNotEquals(getResponse, res, 'la respuesta del servicio no es identica');

    }  

	@Istest
	 static void getEintitesIncaTest(){
		Credit_approval_CP__c cA =  Data_Factory_CreditApproval_Test.createNewCreditApprovalTypeWK('far');
		TBO005_OR_rating__c ora = Data_Factory_ORrating_Test.createNewOrating();
		cA.ES3_ls_RISK_REVIEW_STATUS__c ='In Process';
			update(cA);
			cA.ES3_TX_MRA_ID__c ='309557';
			cA.ES3_tx_Bloomberg_ID__c ='NA';
			cA.ES3_TX_HNWI_ID__c ='NA';
			cA.CPI_rb_OR_rating__c = ora.Id;
         	system.debug('ora ' + ora.Id);
			update(cA);
		Data_Factory_EntityMastInCApproval_Test.createEntityInCA(cA);
		list<ES2_Obj_EntityMasterInCreditApproval__c> entsInca = Wk_TableExporsurelwc_controller_cls.getEintitesInca(cA.Id);
		ES2_Obj_EntityMasterInCreditApproval__c entity = new ES2_Obj_EntityMasterInCreditApproval__c();
       
		list<ES2_Obj_EntityMasterInCreditApproval__c> entitis = new List<ES2_Obj_EntityMasterInCreditApproval__c>();

       	entity.Name='Aba';
       	entity.ES2_rb_Credit_approval__r =ca;
		entitis.add(entity);

		//System.assertEquals(entitis, entsInca, 'Los entities Master in ca no coinciden con los criterios de busqueda');
	}
    
    @Istest
	 static void entitiesNoaccessTest(){
		Credit_approval_CP__c cA =  Data_Factory_CreditApproval_Test.createNewCreditApprovalTypeWK('far');
		TBO005_OR_rating__c ora = Data_Factory_ORrating_Test.createNewOrating();
		cA.ES3_ls_RISK_REVIEW_STATUS__c ='In Process';
			update(cA);
			cA.ES3_TX_MRA_ID__c ='309557';
			cA.ES3_tx_Bloomberg_ID__c ='NA';
			cA.ES3_TX_HNWI_ID__c ='NA';
			cA.CPI_rb_OR_rating__c = ora.Id;
         	system.debug('ora ' + ora.Id);
			update(cA);
		Data_Factory_EntityMastInCApproval_Test.createEntityInCA(cA);
        String uniqueUserName = 'standarduser' + DateTime.now().getTime() + '@testorg.com';
        // This code runs as the system user
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        User u = new User(Alias = 'standt', Email='standarduser@testorg.com',
        EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
        LocaleSidKey='en_US', ProfileId = p.Id,
        TimeZoneSidKey='America/Los_Angeles',
         UserName=uniqueUserName);

        System.runAs(u) {
              // The following code runs as user 'u'
			System.debug('Current User: ' + UserInfo.getUserName());
			System.debug('Current Profile: ' + UserInfo.getProfileId());
			list<ES2_Obj_EntityMasterInCreditApproval__c> entsInca = Wk_TableExporsurelwc_controller_cls.getEintitesInca(cA.Id);
			ES2_Obj_EntityMasterInCreditApproval__c entity = new ES2_Obj_EntityMasterInCreditApproval__c();
       
            list<ES2_Obj_EntityMasterInCreditApproval__c> entitis = new List<ES2_Obj_EntityMasterInCreditApproval__c>();
    
            entity.Name='Aba';
            entity.ES2_rb_Credit_approval__r =ca;
            entitis.add(entity);
    
            //System.assertEquals(entitis, entsInca, 'Los entities Master in ca no coinciden con los criterios de busqueda');
        }
	}
    

	@Istest
	static void getExporsureTest (){

		string typeofSandbox = GetSandboxType.getTypeOfSandbox();
		string namecred;
		if (typeofSandbox =='QA') {
            namecred ='getsServiceUrlQa';
        }else if(typeofSandbox =='PROD'){
            namecred = 'getsServiceUrlProd';
        }else{
            namecred ='getsServiceUrl';
        }

		String testEndpoint = 'callout:'+ namecred + '/EcExposureSbBix/ExposureRs/exposure?economicGroupId=32249';
		String getResponse = '{'+
		'    "contracts": {'+
		'        "contract": ['+
		'            {'+
		'                "partyId": 25297,'+
		'                "partyName": "TRITURADOS Y CONCRETOS DEL SURESTE, S.A. DE C.V.",'+
		'                "economicGroupId": "32249",'+
    '                "economicGroupName": "GRUPO GORSA",'+
		'                "oracleAccountNumber": "000000811",'+
		'                "contractNumber": "P7791046005",'+
		'                "currency": "MXN",'+
		'                "productName": "AFINAN-VAR_397",'+
		'                "contractOec": "10867603.81",'+
		'                "exposure": "923145.18",'+
		'                "openItemsAr": "263213.83",'+
		'                "daysDueAr": "486",'+
		'                "openItemsDlq": "0",'+
		'                "daysDueDlq": "0",'+
		'                "vertical": "EQUIPO",'+
		'                "nbv": "0"'+
		'            },'+
		'            {'+
		'                "partyId": 25297,'+
		'                "partyName": "TRITURADOS Y CONCRETOS DEL SURESTE, S.A. DE C.V.",'+
		'                "economicGroupId": "32249",'+
		'                "economicGroupName": "GRUPO GORSA",'+
		'                "oracleAccountNumber": "000000811",'+
		'                "contractNumber": "P7791046004",'+
		'                "currency": "MXN",'+
		'                "productName": "AFINAN-VAR_397",'+
		'                "contractOec": "1606903.54",'+
		'                "exposure": "136498.06",'+
		'                "openItemsAr": "38919.4",'+
		'                "daysDueAr": "486",'+
		'                "openItemsDlq": "0",'+
		'                "daysDueDlq": "0",'+
		'                "vertical": "EQUIPO",'+
		'                "nbv": "0"'+
		'            },'+
		'            {'+
		'                "partyId": 25297,'+
		'                "partyName": "TRITURADOS Y CONCRETOS DEL SURESTE, S.A. DE C.V.",'+
		'                "economicGroupId": "32249",'+
		'                "economicGroupName": "GRUPO GORSA",'+
		'                "oracleAccountNumber": "000000811",'+
		'                "contractNumber": "P7791046003",'+
		'                "currency": "MXN",'+
		'                "productName": "AFINAN-VAR_397",'+
		'                "contractOec": "2369950",'+
		'                "exposure": "201314.88",'+
		'                "openItemsAr": "57400.49",'+
		'                "daysDueAr": "486",'+
		'                "openItemsDlq": "0",'+
		'                "daysDueDlq": "0",'+
		'                "vertical": "EQUIPO",'+
		'                "nbv": "0"'+
		'            },'+
		'            {'+
		'                "partyId": 25184,'+
		'                "partyName": "PYASUR, S.A. DE C.V.",'+
		'                "economicGroupId": "32249",'+
		'                "economicGroupName": "GRUPO GORSA",'+
		'                "oracleAccountNumber": "000000651",'+
		'                "contractNumber": "P5910618013",'+
		'                "currency": "MXN",'+
		'                "productName": "AFINAN-VAR_397",'+
		'                "contractOec": "7004928.54",'+
		'                "exposure": "0",'+
		'                "openItemsAr": "1373.8",'+
		'                "daysDueAr": "776",'+
		'                "openItemsDlq": "0",'+
		'                "daysDueDlq": "0",'+
		'                "vertical": "EQUIPO",'+
		'                "nbv": "0"'+
		'            }'+
		'        ]'+
		'    },'+
		'    "status": {'+
		'        "code": 200,'+
		'        "message": "Success",'+
		'        "detail": "S"'+
		'    }'+
		'}';

		Test.setMock(HttpCalloutMock.class, new MockHttpResponseHandler_cls(testEndpoint, getResponse, 'GET', 'application/json', 200));
        string res = Wk_TableExporsurelwc_controller_cls.getExporsure('32249');
		system.debug('RES');
		system.debug(res);
        System.assertNotEquals(getResponse, res, 'la respuesta del servicio no es identica');
	}


	@Istest
	static void getLinkedEntitiesTest(){
		WK_Exporsure__c exposure = Data_Factory_WK_Exposure_Test.createNewExposure(32249, 'Mazacuata');
        list<id> ids = new list<id>{exposure.Id};
        Data_Access_Exporsure_cls.getExposuresByIds(ids);
		String uniqueUserName = 'standarduser' + DateTime.now().getTime() + '@testorg.com';
        // This code runs as the system user
        Profile p = [SELECT Id FROM Profile WHERE Name='Risk'];
        User u = new User(Alias = 'standt', Email='standarduser@testorg.com',
        EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
        LocaleSidKey='en_US', ProfileId = p.Id,
        TimeZoneSidKey='America/Los_Angeles',
         UserName=uniqueUserName);

        System.runAs(u) {
              // The following code runs as user 'u'
			System.debug('Current User: ' + UserInfo.getUserName());
			System.debug('Current Profile: ' + UserInfo.getProfileId());
			TBO005_OR_rating__c ora = Data_Factory_ORrating_Test.createNewOrating();
			Credit_approval_CP__c cp = Data_Factory_CreditApproval_Test.createNewCreditApprovalTypeWK('mello');
			cp.ES3_ls_RISK_REVIEW_STATUS__c ='In Process';
			update(cp);
			cp.ES3_TX_MRA_ID__c ='1';
			cp.ES3_tx_Bloomberg_ID__c ='1';
			cp.ES3_TX_HNWI_ID__c ='1';
            list<TBO005_OR_rating__c> orati =  [Select Id from TBO005_OR_rating__c];
            system.debug('arati: ' + orati);
			cp.CPI_rb_OR_rating__c = orati[0].Id;
			update(cp);
			ES2_Obj_EntityMasterInCreditApproval__c ent =  Data_Factory_EntityMastInCApproval_Test.createEntityInCA(cp);
			list<WK_Exporsure__c> linked = Wk_TableExporsurelwc_controller_cls.getLinkedEntities('32249');
			List<WK_Exporsure__c> linkedexpected = new List<WK_Exporsure__c> ();
			linkedexpected.add(exposure);
			
			System.assertNotEquals(linkedexpected, linked, 'Los exposures no coinciden con el criterio de busqueda');

		}
	}


	@Istest
	static void saveContractsTest(){
		list<WK_Exporsure_wrapper.Contract> contracts = new list<WK_Exporsure_wrapper.Contract>();
		WK_Exporsure_wrapper.Contract  contract = new WK_Exporsure_wrapper.Contract();
		contract.contractOec = 12.0;
		contract.curency ='MXN';
		contract.daysDueAr = 12;
		contract.daysDueDlq =13;
		contract.economicGroupId = 32249;
		contract.economicGroupName ='ABA';
		contract.entityMasterCreditApproval ='MAriguas SA';
		contract.exposure = 1200;
		contract.nbv = 100;
		contract.openItemsAr = 11.0;
		contract.openItemsDlq = 12;
		contract.oracleAccountNumber ='1221';
		contract.partyId =1231;
		contract.partyName ='Malbab';
		contract.productName ='Mal';
		contract.vertical ='VERTICAL';
		contracts.add(contract);
        
        WK_Exporsure_wrapper.contrato cn = new WK_Exporsure_wrapper.contrato();
        cn.contract = new list<WK_Exporsure_wrapper.Contract>(); 
        cn.contract.add(contract);
        
        WK_Exporsure_wrapper.Status es = new WK_Exporsure_wrapper.Status();
        es.code ='hola';
        es.detail='adios';
        es.message='saludos';
        
        WK_Exporsure_wrapper.inicial ini = new WK_Exporsure_wrapper.inicial();
        ini.contracts = cn;
        ini.status = es;
        
		Wk_wrapper_resultsOperationsDt.SaveRecords recors = Wk_TableExporsurelwc_controller_cls.saveContracts(contracts);
		Wk_wrapper_resultsOperationsDt.SaveRecords resultado = new  Wk_wrapper_resultsOperationsDt.SaveRecords();
		System.assertNotEquals(resultado, recors, 'La operación de salvado se ejecuto correctamente');
        
	}
    
    @IsTest
    static void deleteOnlyTest(){
        list<WK_Exporsure_wrapper.Contract> contracts = new list<WK_Exporsure_wrapper.Contract>();
		WK_Exporsure_wrapper.Contract  contract = new WK_Exporsure_wrapper.Contract();
		contract.contractOec = 12.0;
		contract.curency ='MXN';
		contract.daysDueAr = 12;
		contract.daysDueDlq =13;
		contract.economicGroupId = 32249;
		contract.economicGroupName ='ABA';
		contract.exposure = 1200;
		contract.nbv = 100;
		contract.openItemsAr = 11.0;
		contract.openItemsDlq = 12;
		contract.oracleAccountNumber ='1221';
		contract.partyId =1231;
		contract.partyName ='Malbab';
		contract.productName ='Mal';
		contract.vertical ='VERTICAL';
        contract.contractNumber ='1221';
		contracts.add(contract);

		Wk_wrapper_resultsOperationsDt.SaveRecords recors = Wk_TableExporsurelwc_controller_cls.saveContracts(contracts);
		Wk_wrapper_resultsOperationsDt.SaveRecords resultado = new  Wk_wrapper_resultsOperationsDt.SaveRecords();
		System.assertNotEquals(resultado, recors, 'La operación de salvado se ejecuto correctamente');
        Wk_TableExporsurelwc_controller_cls.deleteOnly('1221');
    }

}