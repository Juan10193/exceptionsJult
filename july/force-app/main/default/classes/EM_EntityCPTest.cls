@Istest
private class EM_EntityCPTest {
    @Istest
    static void entityCPFromEntityMaster(){
        Entity_CP__c entitycPSF = Data_Factory_EntityCp.createEntityCP('PEPE PECAS PICA PAPAS', 'HARN820612QL5');
        entitycPSF.EM_Party_ID__c ='1028506';
        update entitycPSF;
        account a = Data_Factory_Account_Test.createNewAccount('tot');
        EM_EntityCP entitycp = new EM_EntityCP();
        string typeofSandbox = GetSandboxType.getTypeOfSandbox();
		string namecred;
		if (typeofSandbox =='QA') {
            namecred ='getsServiceUrlQa';
        }else if(typeofSandbox =='PROD'){
            namecred = 'getsServiceUrlProd';
        }else{
            namecred ='getsServiceUrl';
        }
        String testEndpoint = 'callout:'+ namecred + '/EcEntityMasterSbDat/EntitySvcRs/entities/?partyID=' + '1028506' + '&sso=9000102850600007'+ '&applicationCode='+ 'SF'  + '&screen=UI_ENTITYMASTER';
        String getResponse = '{'+
		'  "entityInfo" : {'+
		'    "entity" : {'+
		'      "sFaccountID" : "'+ a.id + '",'+
		'      "custAccountId" : "418640",'+
		'      "partyID" : 1028506,'+
		'      "rfc" : "HARN820612QL5",'+
		'      "customerType" : "INDIVIDUAL",'+
		'      "customerStatus" : "YES",'+
		'      "topParentId" : "0018A00000M1KOC",'+
		'      "topParentName" : "Sonidero Digital",'+
		'      "sfAccountName" : "Sonidero Digital",'+
		'      "tin" : null,'+
		'      "economicGroupId" : 371414,'+
		'      "economicGroupName" : "PRUEBA ECO GROUP",'+
		'      "limitedInformationEntity" : false,'+
		'      "taxRegime" : "PERSONA FISICA CON ACTIVIDAD EMPRESARIAL",'+
		'      "foreignEntity" : false,'+
		'      "nationality" : "MEX",'+
		'      "oracleAccountNumber" : "000002118",'+
		'      "curp" : null,'+
		'      "prefix" : "MR.",'+
		'      "firstName" : "PEPE",'+
		'      "middleName" : "PECAS",'+
		'      "firstLastName" : "PICA",'+
		'      "secondLastName" : "PAPAS",'+
		'      "salesRepresentative" : null,'+
		'      "supplierFlag" : true,'+
		'      "legalName" : "PICA",'+
		'      "companyLegalNameTermination" : "PAPAS",'+
		'      "oracleAccountName" : "PEPE PECAS PICA PAPAS",'+
		'      "sourceCreatedBy" : "223005130",'+
		'      "sourceUpdatedBy" : "223005130",'+
		'      "sourceApplicationID" : "SF",'+
		'      "sourceCreateDate" : "2019-11-22T11:17:39.000-06:00",'+
		'      "sourceLastUpdateDate" : "2019-11-22T11:17:39.000-06:00",'+
		'      "aml" : {'+
		'        "targetMarketJurisdiction" : null,'+
		'        "ccr" : null,'+
		'        "crrComments" : null,'+
		'        "ccrOverride" : null,'+
		'        "entityType" : null'+
		'      },'+
		'      "rating" : {'+
		'        "mraId" : null,'+
		'        "bloombergId" : null,'+
		'        "hnwiId" : null,'+
		'        "orRating" : null,'+
		'        "transactionDate" : null,'+
		'        "riskClassification" : null'+
		'      },'+
		'      "sic" : {'+
		'        "sicCode" : null,'+
		'        "sicDescription" : null,'+
		'        "economicGroupSicCode" : 3452,'+
		'        "economicGroupSicDescription" : "Mfg bolts/screws/rivets"'+
		'      },'+
		'      "buro" : {'+
		'        "customerAlias" : "PEPE PECAS PICA PAPAS",'+
		'        "buroFlag" : null'+
		'      }'+
		'    },'+
		'    "contactInfo" : {'+
		'      "contacts" : {'+
		'        "contact" : [ {'+
		'          "contactId" : 1028512,'+
		'          "partyID" : 1028506,'+
		'          "prefix" : "MR.",'+
		'          "firstName" : "MORTHEN",'+
		'          "middleName" : "LILIA",'+
		'          "firstLastName" : "12",'+
		'          "secondLastName" : "24",'+
		'          "title" : "LOL",'+
		'          "status" : "A",'+
		'          "countryCode" : "39",'+
		'          "areaCode" : "12",'+
		'          "phone" : "12",'+
		'          "phoneNumberExtension" : "12",'+
		'          "mobile" : "121",'+
		'          "email" : "ASDASDA@GMAIL.COM",'+
		'          "type" : "BILLING",'+
		'          "sourceCreatedBy" : "502718854",'+
		'          "sourceUpdatedBy" : "900000023",'+
		'          "sourceApplicationId" : "SALES FORCE",'+
		'          "sourceCreateDate" : "2019-11-24T00:00:00.000-06:00",'+
		'          "sourceLastUpdateDate" : "2019-11-24T00:00:00.000-06:00"'+
		'        } ]'+
		'      },'+
		'      "privilege" : {'+
		'        "sso" : "900000007",'+
		'        "applicationName" : "Salesforce",'+
		'        "applicationCode" : "SF",'+
		'        "screen" : "ENTITYMASTER",'+
		'        "employeeName" : "narain.harjani@engeniumcapital.comxx",'+
		'        "vCrud" : "11111"'+
		'      }'+
		'    },'+
		'    "addressInfo" : {'+
		'      "addresses" : {'+
		'        "address" : [ {'+
		'          "locationId" : 25293,'+
		'          "partyID" : 1028506,'+
		'          "street" : "CALLE ARMENIA",'+
		'          "outdoorNumber" : "1111",'+
		'          "interiorNumber" : "BLA3 BLA6 BLA9",'+
		'          "county" : "COLARMENIA",'+
		'          "municipality" : "MUNIARMENIA",'+
		'          "country" : "ARM",'+
		'          "city" : "OF ARMENIA",'+
		'          "zipCode" : "1312312",'+
		'          "state" : "AREMANIA STATE",'+
		'          "status" : "YES",'+
		'          "purpose" : "BILL_TO, SHIP_TO, INSTALL_AT",'+
		'          "sourceCreatedBy" : "223005130",'+
		'          "sourceUpdatedBy" : "223005130",'+
		'          "sourceApplicationId" : "SF",'+
		'          "sourceCreateDate" : "2019-11-22T10:47:04.000-06:00",'+
		'          "sourceLastUpdateDate" : "2019-11-22T10:47:04.000-06:00",'+
		'          "_397" : "Y",'+
		'          "_789" : "Y",'+
		'          "xa7" : "Y",'+
		'          "s1u" : null,'+
		'          "addressReference" : null,'+
		'          "normalizedAddress" : "CALLE ARMENIA, 1111, BLA3 BLA6 BLA9, COLARMENIA, MUNIARMENIA, OF ARMENIA, AREMANIA STATE, C.P. 1312312"'+
		'        }, {'+
		'          "locationId" : 25294,'+
		'          "partyID" : 1028506,'+
		'          "street" : "JAIME DOVALI",'+
		'          "outdoorNumber" : "700",'+
		'          "interiorNumber" : "TORRE C PISO 4",'+
		'          "county" : "SANTA FE",'+
		'          "municipality" : "ALVARO OBREGON",'+
		'          "country" : "MEX",'+
		'          "city" : "CDMX",'+
		'          "zipCode" : "06600",'+
		'          "state" : "DF",'+
		'          "status" : "YES",'+
		'          "purpose" : "BILL_TO, SHIP_TO, INSTALL_AT",'+
		'          "sourceCreatedBy" : "223005130",'+
		'          "sourceUpdatedBy" : "223005130",'+
		'          "sourceApplicationId" : "SF",'+
		'          "sourceCreateDate" : "2019-11-22T11:23:18.000-06:00",'+
		'          "sourceLastUpdateDate" : "2019-11-22T11:23:18.000-06:00",'+
		'          "_397" : "Y",'+
		'          "_789" : "Y",'+
		'          "xa7" : "Y",'+
		'          "s1u" : null,'+
		'          "addressReference" : null,'+
		'          "normalizedAddress" : "JAIME DOVALI, 700, TORRE C PISO 4, SANTA FE, ALVARO OBREGON, CDMX, DF, C.P. 06600"'+
		'        }, {'+
		'          "locationId" : 25295,'+
		'          "partyID" : 1028506,'+
		'          "street" : "STREET HERE",'+
		'          "outdoorNumber" : "NUM HERE",'+
		'          "interiorNumber" : "INT NUM HERE",'+
		'          "county" : "COUNTY HERE",'+
		'          "municipality" : "MUN HERE",'+
		'          "country" : "ATG",'+
		'          "city" : "CITY HERE",'+
		'          "zipCode" : "55555",'+
		'          "state" : "STATE HERE",'+
		'          "status" : "YES",'+
		'          "purpose" : "BILL_TO, SHIP_TO, INSTALL_AT",'+
		'          "sourceCreatedBy" : "223005130",'+
		'          "sourceUpdatedBy" : "223005130",'+
		'          "sourceApplicationId" : "SF",'+
		'          "sourceCreateDate" : "2019-11-22T11:34:54.000-06:00",'+
		'          "sourceLastUpdateDate" : "2019-11-22T11:34:54.000-06:00",'+
		'          "_397" : "Y",'+
		'          "_789" : "Y",'+
		'          "xa7" : "Y",'+
		'          "s1u" : null,'+
		'          "addressReference" : null,'+
		'          "normalizedAddress" : "STREET HERE, NUM HERE, INT NUM HERE, COUNTY HERE, MUN HERE, CITY HERE, STATE HERE, C.P. 55555"'+
		'        } ]'+
		'      },'+
		'      "privilege" : {'+
		'        "sso" : "900000007",'+
		'        "applicationName" : "Salesforce",'+
		'        "applicationCode" : "SF",'+
		'        "screen" : "ENTITYMASTER",'+
		'        "employeeName" : "narain.harjani@engeniumcapital.comxx",'+
		'        "vCrud" : "11111"'+
		'      }'+
		'    },'+
		'    "invoiceInfo" : {'+
		'      "invoices" : {'+
		'        "invoice" : [ {'+
		'          "custAcctSiteId" : 476951,'+
		'          "ecOperatingUnitName" : "25295 - XA7",'+
		'          "ecOperatingUnitId" : 225,'+
		'          "ecClabe" : null,'+
		'          "ecPaymentAccount" : null,'+
		'          "paymentMethod" : null,'+
		'          "billingMails" : null,'+
		'          "sourceCreatedBy" : "223005130",'+
		'          "sourceUpdatedBy" : "223005130",'+
		'          "sourceApplicationId" : "SF",'+
		'          "sourceCreateDate" : "2019-11-22T11:17:39.000-06:00",'+
		'          "sourceLastUpdateDate" : "2019-11-22T11:17:39.000-06:00"'+
		'        }, {'+
		'          "custAcctSiteId" : 476950,'+
		'          "ecOperatingUnitName" : "25295 - 798",'+
		'          "ecOperatingUnitId" : 224,'+
		'          "ecClabe" : null,'+
		'          "ecPaymentAccount" : null,'+
		'          "paymentMethod" : null,'+
		'          "billingMails" : null,'+
		'          "sourceCreatedBy" : "223005130",'+
		'          "sourceUpdatedBy" : "223005130",'+
		'          "sourceApplicationId" : "SF",'+
		'          "sourceCreateDate" : "2019-11-22T11:17:39.000-06:00",'+
		'          "sourceLastUpdateDate" : "2019-11-22T11:17:39.000-06:00"'+
		'        }, {'+
		'          "custAcctSiteId" : 476949,'+
		'          "ecOperatingUnitName" : "25295 - 397",'+
		'          "ecOperatingUnitId" : 223,'+
		'          "ecClabe" : null,'+
		'          "ecPaymentAccount" : null,'+
		'          "paymentMethod" : null,'+
		'          "billingMails" : null,'+
		'          "sourceCreatedBy" : "223005130",'+
		'          "sourceUpdatedBy" : "223005130",'+
		'          "sourceApplicationId" : "SF",'+
		'          "sourceCreateDate" : "2019-11-22T11:17:39.000-06:00",'+
		'          "sourceLastUpdateDate" : "2019-11-22T11:17:39.000-06:00"'+
		'        }, {'+
		'          "custAcctSiteId" : 476948,'+
		'          "ecOperatingUnitName" : "25294 - XA7",'+
		'          "ecOperatingUnitId" : 225,'+
		'          "ecClabe" : null,'+
		'          "ecPaymentAccount" : null,'+
		'          "paymentMethod" : null,'+
		'          "billingMails" : null,'+
		'          "sourceCreatedBy" : "223005130",'+
		'          "sourceUpdatedBy" : "223005130",'+
		'          "sourceApplicationId" : "SF",'+
		'          "sourceCreateDate" : "2019-11-22T11:17:39.000-06:00",'+
		'          "sourceLastUpdateDate" : "2019-11-22T11:17:39.000-06:00"'+
		'        }, {'+
		'          "custAcctSiteId" : 476947,'+
		'          "ecOperatingUnitName" : "25294 - 798",'+
		'          "ecOperatingUnitId" : 224,'+
		'          "ecClabe" : null,'+
		'          "ecPaymentAccount" : null,'+
		'          "paymentMethod" : null,'+
		'          "billingMails" : null,'+
		'          "sourceCreatedBy" : "223005130",'+
		'          "sourceUpdatedBy" : "223005130",'+
		'          "sourceApplicationId" : "SF",'+
		'          "sourceCreateDate" : "2019-11-22T11:17:39.000-06:00",'+
		'          "sourceLastUpdateDate" : "2019-11-22T11:17:39.000-06:00"'+
		'        }, {'+
		'          "custAcctSiteId" : 476946,'+
		'          "ecOperatingUnitName" : "25294 - 397",'+
		'          "ecOperatingUnitId" : 223,'+
		'          "ecClabe" : null,'+
		'          "ecPaymentAccount" : null,'+
		'          "paymentMethod" : null,'+
		'          "billingMails" : null,'+
		'          "sourceCreatedBy" : "223005130",'+
		'          "sourceUpdatedBy" : "223005130",'+
		'          "sourceApplicationId" : "SF",'+
		'          "sourceCreateDate" : "2019-11-22T11:17:39.000-06:00",'+
		'          "sourceLastUpdateDate" : "2019-11-22T11:17:39.000-06:00"'+
		'        }, {'+
		'          "custAcctSiteId" : 476945,'+
		'          "ecOperatingUnitName" : "25293 - XA7",'+
		'          "ecOperatingUnitId" : 225,'+
		'          "ecClabe" : null,'+
		'          "ecPaymentAccount" : null,'+
		'          "paymentMethod" : null,'+
		'          "billingMails" : null,'+
		'          "sourceCreatedBy" : "223005130",'+
		'          "sourceUpdatedBy" : "223005130",'+
		'          "sourceApplicationId" : "SF",'+
		'          "sourceCreateDate" : "2019-11-22T11:17:39.000-06:00",'+
		'          "sourceLastUpdateDate" : "2019-11-22T11:17:39.000-06:00"'+
		'        }, {'+
		'          "custAcctSiteId" : 476944,'+
		'          "ecOperatingUnitName" : "25293 - 798",'+
		'          "ecOperatingUnitId" : 224,'+
		'          "ecClabe" : null,'+
		'          "ecPaymentAccount" : null,'+
		'          "paymentMethod" : null,'+
		'          "billingMails" : null,'+
		'          "sourceCreatedBy" : "223005130",'+
		'          "sourceUpdatedBy" : "223005130",'+
		'          "sourceApplicationId" : "SF",'+
		'          "sourceCreateDate" : "2019-11-22T11:17:39.000-06:00",'+
		'          "sourceLastUpdateDate" : "2019-11-22T11:17:39.000-06:00"'+
		'        }, {'+
		'          "custAcctSiteId" : 476943,'+
		'          "ecOperatingUnitName" : "25293 - 397",'+
		'          "ecOperatingUnitId" : 223,'+
		'          "ecClabe" : null,'+
		'          "ecPaymentAccount" : null,'+
		'          "paymentMethod" : null,'+
		'          "billingMails" : null,'+
		'          "sourceCreatedBy" : "223005130",'+
		'          "sourceUpdatedBy" : "223005130",'+
		'          "sourceApplicationId" : "SF",'+
		'          "sourceCreateDate" : "2019-11-22T11:17:39.000-06:00",'+
		'          "sourceLastUpdateDate" : "2019-11-22T11:17:39.000-06:00"'+
		'        } ]'+
		'      },'+
		'      "privilege" : {'+
		'        "sso" : "900000007",'+
		'        "applicationName" : "Salesforce",'+
		'        "applicationCode" : "SF",'+
		'        "screen" : "ENTITYMASTER",'+
		'        "employeeName" : "narain.harjani@engeniumcapital.comxx",'+
		'        "vCrud" : "11111"'+
		'      }'+
		'    },'+
		'    "privilege" : {'+
		'      "sso" : "900000007",'+
		'      "applicationName" : "Salesforce",'+
		'      "applicationCode" : "SF",'+
		'      "screen" : "ENTITYMASTER",'+
		'      "employeeName" : "narain.harjani@engeniumcapital.comxx",'+
		'      "vCrud" : "11111"'+
		'    }'+
		'  },'+
		'  "status" : {'+
		'    "code" : null,'+
		'    "message" : "Success",'+
		'    "detail" : "S"'+
		'  }'+
		'}';
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseHandler_cls(testEndpoint, getResponse, 'GET', 'application/json', 200));
        entitycp.entityCPFromEntityMaster( 'HARN820612QL5',  null,  '1028506',  '900000007', false);
       
    }
    
    @Istest
    static void entityCPFromEntityMasterNoPartyRFCY(){
        Entity_CP__c entitycpSF = new Entity_CP__c();
        entitycpSF = Data_Factory_EntityCp.createEntityCP('PEPE PECAS PICA PAPAS', 'HARN820612QL5');
        entitycpSF.CPI_tx_RFC_TIN__c ='HARN820612QL5';
        account a = Data_Factory_Account_Test.createNewAccount('tot');
        EM_EntityCP entitycp = new EM_EntityCP();
        string typeofSandbox = GetSandboxType.getTypeOfSandbox();
		string namecred;
		if (typeofSandbox =='QA') {
            namecred ='getsServiceUrlQa';
        }else if(typeofSandbox =='PROD'){
            namecred = 'getsServiceUrlProd';
        }else{
            namecred ='getsServiceUrl';
        }
        String testEndpoint = 'callout:'+ namecred + '/EcEntityMasterSbDat/EntitySvcRs/entities/?partyID=' + '1028506' + '&sso=9000102850600007'+ '&applicationCode='+ 'SF'  + '&screen=UI_ENTITYMASTER';
        String getResponse = '{'+
		'  "entityInfo" : {'+
		'    "entity" : {'+
		'      "sFaccountID" : "' + a.id + '",'+
		'      "custAccountId" : "418640",'+
		'      "partyID" : 1028506,'+
		'      "rfc" : "HARN820612QL6",'+
		'      "customerType" : "INDIVIDUAL",'+
		'      "customerStatus" : "YES",'+
		'      "topParentId" : "0018A00000M1KOC",'+
		'      "topParentName" : "Sonidero Digital",'+
		'      "sfAccountName" : "Sonidero Digital",'+
		'      "tin" : null,'+
		'      "economicGroupId" : 371414,'+
		'      "economicGroupName" : "PRUEBA ECO GROUP",'+
		'      "limitedInformationEntity" : false,'+
		'      "taxRegime" : "PERSONA FISICA CON ACTIVIDAD EMPRESARIAL",'+
		'      "foreignEntity" : false,'+
		'      "nationality" : "MEX",'+
		'      "oracleAccountNumber" : "000002118",'+
		'      "curp" : null,'+
		'      "prefix" : "MR.",'+
		'      "firstName" : "PEPE",'+
		'      "middleName" : "PECAS",'+
		'      "firstLastName" : "PICA",'+
		'      "secondLastName" : "PAPAS",'+
		'      "salesRepresentative" : null,'+
		'      "supplierFlag" : true,'+
		'      "legalName" : "PICA",'+
		'      "companyLegalNameTermination" : "PAPAS",'+
		'      "oracleAccountName" : "PEPE PECAS PICA PAPAS",'+
		'      "sourceCreatedBy" : "223005130",'+
		'      "sourceUpdatedBy" : "223005130",'+
		'      "sourceApplicationID" : "SF",'+
		'      "sourceCreateDate" : "2019-11-22T11:17:39.000-06:00",'+
		'      "sourceLastUpdateDate" : "2019-11-22T11:17:39.000-06:00",'+
		'      "aml" : {'+
		'        "targetMarketJurisdiction" : null,'+
		'        "ccr" : null,'+
		'        "crrComments" : null,'+
		'        "ccrOverride" : null,'+
		'        "entityType" : null'+
		'      },'+
		'      "rating" : {'+
		'        "mraId" : null,'+
		'        "bloombergId" : null,'+
		'        "hnwiId" : null,'+
		'        "orRating" : null,'+
		'        "transactionDate" : null,'+
		'        "riskClassification" : null'+
		'      },'+
		'      "sic" : {'+
		'        "sicCode" : null,'+
		'        "sicDescription" : null,'+
		'        "economicGroupSicCode" : 3452,'+
		'        "economicGroupSicDescription" : "Mfg bolts/screws/rivets"'+
		'      },'+
		'      "buro" : {'+
		'        "customerAlias" : "PEPE PECAS PICA PAPAS",'+
		'        "buroFlag" : null'+
		'      }'+
		'    },'+
		'    "contactInfo" : {'+
		'      "contacts" : {'+
		'        "contact" : [ {'+
		'          "contactId" : 1028512,'+
		'          "partyID" : 1028506,'+
		'          "prefix" : "MR.",'+
		'          "firstName" : "MORTHEN",'+
		'          "middleName" : "LILIA",'+
		'          "firstLastName" : "12",'+
		'          "secondLastName" : "24",'+
		'          "title" : "LOL",'+
		'          "status" : "A",'+
		'          "countryCode" : "39",'+
		'          "areaCode" : "12",'+
		'          "phone" : "12",'+
		'          "phoneNumberExtension" : "12",'+
		'          "mobile" : "121",'+
		'          "email" : "ASDASDA@GMAIL.COM",'+
		'          "type" : "BILLING",'+
		'          "sourceCreatedBy" : "502718854",'+
		'          "sourceUpdatedBy" : "900000023",'+
		'          "sourceApplicationId" : "SALES FORCE",'+
		'          "sourceCreateDate" : "2019-11-24T00:00:00.000-06:00",'+
		'          "sourceLastUpdateDate" : "2019-11-24T00:00:00.000-06:00"'+
		'        } ]'+
		'      },'+
		'      "privilege" : {'+
		'        "sso" : "900000007",'+
		'        "applicationName" : "Salesforce",'+
		'        "applicationCode" : "SF",'+
		'        "screen" : "ENTITYMASTER",'+
		'        "employeeName" : "narain.harjani@engeniumcapital.comxx",'+
		'        "vCrud" : "11111"'+
		'      }'+
		'    },'+
		'    "addressInfo" : {'+
		'      "addresses" : {'+
		'        "address" : [ {'+
		'          "locationId" : 25293,'+
		'          "partyID" : 1028506,'+
		'          "street" : "CALLE ARMENIA",'+
		'          "outdoorNumber" : "1111",'+
		'          "interiorNumber" : "BLA3 BLA6 BLA9",'+
		'          "county" : "COLARMENIA",'+
		'          "municipality" : "MUNIARMENIA",'+
		'          "country" : "ARM",'+
		'          "city" : "OF ARMENIA",'+
		'          "zipCode" : "1312312",'+
		'          "state" : "AREMANIA STATE",'+
		'          "status" : "YES",'+
		'          "purpose" : "BILL_TO, SHIP_TO, INSTALL_AT",'+
		'          "sourceCreatedBy" : "223005130",'+
		'          "sourceUpdatedBy" : "223005130",'+
		'          "sourceApplicationId" : "SF",'+
		'          "sourceCreateDate" : "2019-11-22T10:47:04.000-06:00",'+
		'          "sourceLastUpdateDate" : "2019-11-22T10:47:04.000-06:00",'+
		'          "_397" : "Y",'+
		'          "_789" : "Y",'+
		'          "xa7" : "Y",'+
		'          "s1u" : null,'+
		'          "addressReference" : null,'+
		'          "normalizedAddress" : "CALLE ARMENIA, 1111, BLA3 BLA6 BLA9, COLARMENIA, MUNIARMENIA, OF ARMENIA, AREMANIA STATE, C.P. 1312312"'+
		'        }, {'+
		'          "locationId" : 25294,'+
		'          "partyID" : 1028506,'+
		'          "street" : "JAIME DOVALI",'+
		'          "outdoorNumber" : "700",'+
		'          "interiorNumber" : "TORRE C PISO 4",'+
		'          "county" : "SANTA FE",'+
		'          "municipality" : "ALVARO OBREGON",'+
		'          "country" : "MEX",'+
		'          "city" : "CDMX",'+
		'          "zipCode" : "06600",'+
		'          "state" : "DF",'+
		'          "status" : "YES",'+
		'          "purpose" : "BILL_TO, SHIP_TO, INSTALL_AT",'+
		'          "sourceCreatedBy" : "223005130",'+
		'          "sourceUpdatedBy" : "223005130",'+
		'          "sourceApplicationId" : "SF",'+
		'          "sourceCreateDate" : "2019-11-22T11:23:18.000-06:00",'+
		'          "sourceLastUpdateDate" : "2019-11-22T11:23:18.000-06:00",'+
		'          "_397" : "Y",'+
		'          "_789" : "Y",'+
		'          "xa7" : "Y",'+
		'          "s1u" : null,'+
		'          "addressReference" : null,'+
		'          "normalizedAddress" : "JAIME DOVALI, 700, TORRE C PISO 4, SANTA FE, ALVARO OBREGON, CDMX, DF, C.P. 06600"'+
		'        }, {'+
		'          "locationId" : 25295,'+
		'          "partyID" : 1028506,'+
		'          "street" : "STREET HERE",'+
		'          "outdoorNumber" : "NUM HERE",'+
		'          "interiorNumber" : "INT NUM HERE",'+
		'          "county" : "COUNTY HERE",'+
		'          "municipality" : "MUN HERE",'+
		'          "country" : "ATG",'+
		'          "city" : "CITY HERE",'+
		'          "zipCode" : "55555",'+
		'          "state" : "STATE HERE",'+
		'          "status" : "YES",'+
		'          "purpose" : "BILL_TO, SHIP_TO, INSTALL_AT",'+
		'          "sourceCreatedBy" : "223005130",'+
		'          "sourceUpdatedBy" : "223005130",'+
		'          "sourceApplicationId" : "SF",'+
		'          "sourceCreateDate" : "2019-11-22T11:34:54.000-06:00",'+
		'          "sourceLastUpdateDate" : "2019-11-22T11:34:54.000-06:00",'+
		'          "_397" : "Y",'+
		'          "_789" : "Y",'+
		'          "xa7" : "Y",'+
		'          "s1u" : null,'+
		'          "addressReference" : null,'+
		'          "normalizedAddress" : "STREET HERE, NUM HERE, INT NUM HERE, COUNTY HERE, MUN HERE, CITY HERE, STATE HERE, C.P. 55555"'+
		'        } ]'+
		'      },'+
		'      "privilege" : {'+
		'        "sso" : "900000007",'+
		'        "applicationName" : "Salesforce",'+
		'        "applicationCode" : "SF",'+
		'        "screen" : "ENTITYMASTER",'+
		'        "employeeName" : "narain.harjani@engeniumcapital.comxx",'+
		'        "vCrud" : "11111"'+
		'      }'+
		'    },'+
		'    "invoiceInfo" : {'+
		'      "invoices" : {'+
		'        "invoice" : [ {'+
		'          "custAcctSiteId" : 476951,'+
		'          "ecOperatingUnitName" : "25295 - XA7",'+
		'          "ecOperatingUnitId" : 225,'+
		'          "ecClabe" : null,'+
		'          "ecPaymentAccount" : null,'+
		'          "paymentMethod" : null,'+
		'          "billingMails" : null,'+
		'          "sourceCreatedBy" : "223005130",'+
		'          "sourceUpdatedBy" : "223005130",'+
		'          "sourceApplicationId" : "SF",'+
		'          "sourceCreateDate" : "2019-11-22T11:17:39.000-06:00",'+
		'          "sourceLastUpdateDate" : "2019-11-22T11:17:39.000-06:00"'+
		'        }, {'+
		'          "custAcctSiteId" : 476950,'+
		'          "ecOperatingUnitName" : "25295 - 798",'+
		'          "ecOperatingUnitId" : 224,'+
		'          "ecClabe" : null,'+
		'          "ecPaymentAccount" : null,'+
		'          "paymentMethod" : null,'+
		'          "billingMails" : null,'+
		'          "sourceCreatedBy" : "223005130",'+
		'          "sourceUpdatedBy" : "223005130",'+
		'          "sourceApplicationId" : "SF",'+
		'          "sourceCreateDate" : "2019-11-22T11:17:39.000-06:00",'+
		'          "sourceLastUpdateDate" : "2019-11-22T11:17:39.000-06:00"'+
		'        }, {'+
		'          "custAcctSiteId" : 476949,'+
		'          "ecOperatingUnitName" : "25295 - 397",'+
		'          "ecOperatingUnitId" : 223,'+
		'          "ecClabe" : null,'+
		'          "ecPaymentAccount" : null,'+
		'          "paymentMethod" : null,'+
		'          "billingMails" : null,'+
		'          "sourceCreatedBy" : "223005130",'+
		'          "sourceUpdatedBy" : "223005130",'+
		'          "sourceApplicationId" : "SF",'+
		'          "sourceCreateDate" : "2019-11-22T11:17:39.000-06:00",'+
		'          "sourceLastUpdateDate" : "2019-11-22T11:17:39.000-06:00"'+
		'        }, {'+
		'          "custAcctSiteId" : 476948,'+
		'          "ecOperatingUnitName" : "25294 - XA7",'+
		'          "ecOperatingUnitId" : 225,'+
		'          "ecClabe" : null,'+
		'          "ecPaymentAccount" : null,'+
		'          "paymentMethod" : null,'+
		'          "billingMails" : null,'+
		'          "sourceCreatedBy" : "223005130",'+
		'          "sourceUpdatedBy" : "223005130",'+
		'          "sourceApplicationId" : "SF",'+
		'          "sourceCreateDate" : "2019-11-22T11:17:39.000-06:00",'+
		'          "sourceLastUpdateDate" : "2019-11-22T11:17:39.000-06:00"'+
		'        }, {'+
		'          "custAcctSiteId" : 476947,'+
		'          "ecOperatingUnitName" : "25294 - 798",'+
		'          "ecOperatingUnitId" : 224,'+
		'          "ecClabe" : null,'+
		'          "ecPaymentAccount" : null,'+
		'          "paymentMethod" : null,'+
		'          "billingMails" : null,'+
		'          "sourceCreatedBy" : "223005130",'+
		'          "sourceUpdatedBy" : "223005130",'+
		'          "sourceApplicationId" : "SF",'+
		'          "sourceCreateDate" : "2019-11-22T11:17:39.000-06:00",'+
		'          "sourceLastUpdateDate" : "2019-11-22T11:17:39.000-06:00"'+
		'        }, {'+
		'          "custAcctSiteId" : 476946,'+
		'          "ecOperatingUnitName" : "25294 - 397",'+
		'          "ecOperatingUnitId" : 223,'+
		'          "ecClabe" : null,'+
		'          "ecPaymentAccount" : null,'+
		'          "paymentMethod" : null,'+
		'          "billingMails" : null,'+
		'          "sourceCreatedBy" : "223005130",'+
		'          "sourceUpdatedBy" : "223005130",'+
		'          "sourceApplicationId" : "SF",'+
		'          "sourceCreateDate" : "2019-11-22T11:17:39.000-06:00",'+
		'          "sourceLastUpdateDate" : "2019-11-22T11:17:39.000-06:00"'+
		'        }, {'+
		'          "custAcctSiteId" : 476945,'+
		'          "ecOperatingUnitName" : "25293 - XA7",'+
		'          "ecOperatingUnitId" : 225,'+
		'          "ecClabe" : null,'+
		'          "ecPaymentAccount" : null,'+
		'          "paymentMethod" : null,'+
		'          "billingMails" : null,'+
		'          "sourceCreatedBy" : "223005130",'+
		'          "sourceUpdatedBy" : "223005130",'+
		'          "sourceApplicationId" : "SF",'+
		'          "sourceCreateDate" : "2019-11-22T11:17:39.000-06:00",'+
		'          "sourceLastUpdateDate" : "2019-11-22T11:17:39.000-06:00"'+
		'        }, {'+
		'          "custAcctSiteId" : 476944,'+
		'          "ecOperatingUnitName" : "25293 - 798",'+
		'          "ecOperatingUnitId" : 224,'+
		'          "ecClabe" : null,'+
		'          "ecPaymentAccount" : null,'+
		'          "paymentMethod" : null,'+
		'          "billingMails" : null,'+
		'          "sourceCreatedBy" : "223005130",'+
		'          "sourceUpdatedBy" : "223005130",'+
		'          "sourceApplicationId" : "SF",'+
		'          "sourceCreateDate" : "2019-11-22T11:17:39.000-06:00",'+
		'          "sourceLastUpdateDate" : "2019-11-22T11:17:39.000-06:00"'+
		'        }, {'+
		'          "custAcctSiteId" : 476943,'+
		'          "ecOperatingUnitName" : "25293 - 397",'+
		'          "ecOperatingUnitId" : 223,'+
		'          "ecClabe" : null,'+
		'          "ecPaymentAccount" : null,'+
		'          "paymentMethod" : null,'+
		'          "billingMails" : null,'+
		'          "sourceCreatedBy" : "223005130",'+
		'          "sourceUpdatedBy" : "223005130",'+
		'          "sourceApplicationId" : "SF",'+
		'          "sourceCreateDate" : "2019-11-22T11:17:39.000-06:00",'+
		'          "sourceLastUpdateDate" : "2019-11-22T11:17:39.000-06:00"'+
		'        } ]'+
		'      },'+
		'      "privilege" : {'+
		'        "sso" : "900000007",'+
		'        "applicationName" : "Salesforce",'+
		'        "applicationCode" : "SF",'+
		'        "screen" : "ENTITYMASTER",'+
		'        "employeeName" : "narain.harjani@engeniumcapital.comxx",'+
		'        "vCrud" : "11111"'+
		'      }'+
		'    },'+
		'    "privilege" : {'+
		'      "sso" : "900000007",'+
		'      "applicationName" : "Salesforce",'+
		'      "applicationCode" : "SF",'+
		'      "screen" : "ENTITYMASTER",'+
		'      "employeeName" : "narain.harjani@engeniumcapital.comxx",'+
		'      "vCrud" : "11111"'+
		'    }'+
		'  },'+
		'  "status" : {'+
		'    "code" : null,'+
		'    "message" : "Success",'+
		'    "detail" : "S"'+
		'  }'+
		'}';
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseHandler_cls(testEndpoint, getResponse, 'GET', 'application/json', 200));
        entitycp.entityCPFromEntityMaster( 'rfc',  null,  '1028506',  '900000007', true);
       
    }
	
     @Istest
    static void entityCPFromEntityMasterNoPartyTest(){
        EM_EntityCP entitycp = new EM_EntityCP();
        account a = Data_Factory_Account_Test.createNewAccount('tot');
        string typeofSandbox = GetSandboxType.getTypeOfSandbox();
		string namecred;
		if (typeofSandbox =='QA') {
            namecred ='getsServiceUrlQa';
        }else if(typeofSandbox =='PROD'){
            namecred = 'getsServiceUrlProd';
        }else{
            namecred ='getsServiceUrl';
        }
        String testEndpoint = 'callout:'+ namecred + '/EcEntityMasterSbDat/EntitySvcRs/entities/?partyID=' + '1028506' + '&sso=9000102850600007'+ '&applicationCode='+ 'SF'  + '&screen=UI_ENTITYMASTER';
        String getResponse = '{'+
		'  "entityInfo" : {'+
		'    "entity" : {'+
		'      "sFaccountID" : "' + a.id + '",'+
		'      "custAccountId" : "418640",'+
		'      "partyID" : 1028506,'+
		'      "rfc" : "HARN820612QL5",'+
		'      "customerType" : "INDIVIDUAL",'+
		'      "customerStatus" : "YES",'+
		'      "topParentId" : "0018A00000MC",'+
		'      "topParentName" : "Sonidero Digital",'+
		'      "sfAccountName" : "Sonidero Digital",'+
		'      "tin" : null,'+
		'      "economicGroupId" : 371414,'+
		'      "economicGroupName" : "PRUEBA ECO GROUP",'+
		'      "limitedInformationEntity" : false,'+
		'      "taxRegime" : "PERSONA FISICA CON ACTIVIDAD EMPRESARIAL",'+
		'      "foreignEntity" : false,'+
		'      "nationality" : "MEX",'+
		'      "oracleAccountNumber" : "000002118",'+
		'      "curp" : null,'+
		'      "prefix" : "MR.",'+
		'      "firstName" : "PEPE",'+
		'      "middleName" : "PECAS",'+
		'      "firstLastName" : "PICA",'+
		'      "secondLastName" : "PAPAS",'+
		'      "salesRepresentative" : null,'+
		'      "supplierFlag" : true,'+
		'      "legalName" : "PICA",'+
		'      "companyLegalNameTermination" : "PAPAS",'+
		'      "oracleAccountName" : "PEPE PECAS PICA PAPAS",'+
		'      "sourceCreatedBy" : "223005130",'+
		'      "sourceUpdatedBy" : "223005130",'+
		'      "sourceApplicationID" : "SF",'+
		'      "sourceCreateDate" : "2019-11-22T11:17:39.000-06:00",'+
		'      "sourceLastUpdateDate" : "2019-11-22T11:17:39.000-06:00",'+
		'      "aml" : {'+
		'        "targetMarketJurisdiction" : null,'+
		'        "ccr" : null,'+
		'        "crrComments" : null,'+
		'        "ccrOverride" : null,'+
		'        "entityType" : null'+
		'      },'+
		'      "rating" : {'+
		'        "mraId" : null,'+
		'        "bloombergId" : null,'+
		'        "hnwiId" : null,'+
		'        "orRating" : null,'+
		'        "transactionDate" : null,'+
		'        "riskClassification" : null'+
		'      },'+
		'      "sic" : {'+
		'        "sicCode" : null,'+
		'        "sicDescription" : null,'+
		'        "economicGroupSicCode" : 3452,'+
		'        "economicGroupSicDescription" : "Mfg bolts/screws/rivets"'+
		'      },'+
		'      "buro" : {'+
		'        "customerAlias" : "PEPE PECAS PICA PAPAS",'+
		'        "buroFlag" : null'+
		'      }'+
		'    },'+
		'    "contactInfo" : {'+
		'      "contacts" : {'+
		'        "contact" : [ {'+
		'          "contactId" : 1028512,'+
		'          "partyID" : 1028506,'+
		'          "prefix" : "MR.",'+
		'          "firstName" : "MORTHEN",'+
		'          "middleName" : "LILIA",'+
		'          "firstLastName" : "12",'+
		'          "secondLastName" : "24",'+
		'          "title" : "LOL",'+
		'          "status" : "A",'+
		'          "countryCode" : "39",'+
		'          "areaCode" : "12",'+
		'          "phone" : "12",'+
		'          "phoneNumberExtension" : "12",'+
		'          "mobile" : "121",'+
		'          "email" : "ASDASDA@GMAIL.COM",'+
		'          "type" : "BILLING",'+
		'          "sourceCreatedBy" : "502718854",'+
		'          "sourceUpdatedBy" : "900000023",'+
		'          "sourceApplicationId" : "SALES FORCE",'+
		'          "sourceCreateDate" : "2019-11-24T00:00:00.000-06:00",'+
		'          "sourceLastUpdateDate" : "2019-11-24T00:00:00.000-06:00"'+
		'        } ]'+
		'      },'+
		'      "privilege" : {'+
		'        "sso" : "900000007",'+
		'        "applicationName" : "Salesforce",'+
		'        "applicationCode" : "SF",'+
		'        "screen" : "ENTITYMASTER",'+
		'        "employeeName" : "narain.harjani@engeniumcapital.comxx",'+
		'        "vCrud" : "11111"'+
		'      }'+
		'    },'+
		'    "addressInfo" : {'+
		'      "addresses" : {'+
		'        "address" : [ {'+
		'          "locationId" : 25293,'+
		'          "partyID" : 1028506,'+
		'          "street" : "CALLE ARMENIA",'+
		'          "outdoorNumber" : "1111",'+
		'          "interiorNumber" : "BLA3 BLA6 BLA9",'+
		'          "county" : "COLARMENIA",'+
		'          "municipality" : "MUNIARMENIA",'+
		'          "country" : "ARM",'+
		'          "city" : "OF ARMENIA",'+
		'          "zipCode" : "1312312",'+
		'          "state" : "AREMANIA STATE",'+
		'          "status" : "YES",'+
		'          "purpose" : "BILL_TO, SHIP_TO, INSTALL_AT",'+
		'          "sourceCreatedBy" : "223005130",'+
		'          "sourceUpdatedBy" : "223005130",'+
		'          "sourceApplicationId" : "SF",'+
		'          "sourceCreateDate" : "2019-11-22T10:47:04.000-06:00",'+
		'          "sourceLastUpdateDate" : "2019-11-22T10:47:04.000-06:00",'+
		'          "_397" : "Y",'+
		'          "_789" : "Y",'+
		'          "xa7" : "Y",'+
		'          "s1u" : null,'+
		'          "addressReference" : null,'+
		'          "normalizedAddress" : "CALLE ARMENIA, 1111, BLA3 BLA6 BLA9, COLARMENIA, MUNIARMENIA, OF ARMENIA, AREMANIA STATE, C.P. 1312312"'+
		'        }, {'+
		'          "locationId" : 25294,'+
		'          "partyID" : 1028506,'+
		'          "street" : "JAIME DOVALI",'+
		'          "outdoorNumber" : "700",'+
		'          "interiorNumber" : "TORRE C PISO 4",'+
		'          "county" : "SANTA FE",'+
		'          "municipality" : "ALVARO OBREGON",'+
		'          "country" : "MEX",'+
		'          "city" : "CDMX",'+
		'          "zipCode" : "06600",'+
		'          "state" : "DF",'+
		'          "status" : "YES",'+
		'          "purpose" : "BILL_TO, SHIP_TO, INSTALL_AT",'+
		'          "sourceCreatedBy" : "223005130",'+
		'          "sourceUpdatedBy" : "223005130",'+
		'          "sourceApplicationId" : "SF",'+
		'          "sourceCreateDate" : "2019-11-22T11:23:18.000-06:00",'+
		'          "sourceLastUpdateDate" : "2019-11-22T11:23:18.000-06:00",'+
		'          "_397" : "Y",'+
		'          "_789" : "Y",'+
		'          "xa7" : "Y",'+
		'          "s1u" : null,'+
		'          "addressReference" : null,'+
		'          "normalizedAddress" : "JAIME DOVALI, 700, TORRE C PISO 4, SANTA FE, ALVARO OBREGON, CDMX, DF, C.P. 06600"'+
		'        }, {'+
		'          "locationId" : 25295,'+
		'          "partyID" : 1028506,'+
		'          "street" : "STREET HERE",'+
		'          "outdoorNumber" : "NUM HERE",'+
		'          "interiorNumber" : "INT NUM HERE",'+
		'          "county" : "COUNTY HERE",'+
		'          "municipality" : "MUN HERE",'+
		'          "country" : "ATG",'+
		'          "city" : "CITY HERE",'+
		'          "zipCode" : "55555",'+
		'          "state" : "STATE HERE",'+
		'          "status" : "YES",'+
		'          "purpose" : "BILL_TO, SHIP_TO, INSTALL_AT",'+
		'          "sourceCreatedBy" : "223005130",'+
		'          "sourceUpdatedBy" : "223005130",'+
		'          "sourceApplicationId" : "SF",'+
		'          "sourceCreateDate" : "2019-11-22T11:34:54.000-06:00",'+
		'          "sourceLastUpdateDate" : "2019-11-22T11:34:54.000-06:00",'+
		'          "_397" : "Y",'+
		'          "_789" : "Y",'+
		'          "xa7" : "Y",'+
		'          "s1u" : null,'+
		'          "addressReference" : null,'+
		'          "normalizedAddress" : "STREET HERE, NUM HERE, INT NUM HERE, COUNTY HERE, MUN HERE, CITY HERE, STATE HERE, C.P. 55555"'+
		'        } ]'+
		'      },'+
		'      "privilege" : {'+
		'        "sso" : "900000007",'+
		'        "applicationName" : "Salesforce",'+
		'        "applicationCode" : "SF",'+
		'        "screen" : "ENTITYMASTER",'+
		'        "employeeName" : "narain.harjani@engeniumcapital.comxx",'+
		'        "vCrud" : "11111"'+
		'      }'+
		'    },'+
		'    "invoiceInfo" : {'+
		'      "invoices" : {'+
		'        "invoice" : [ {'+
		'          "custAcctSiteId" : 476951,'+
		'          "ecOperatingUnitName" : "25295 - XA7",'+
		'          "ecOperatingUnitId" : 225,'+
		'          "ecClabe" : null,'+
		'          "ecPaymentAccount" : null,'+
		'          "paymentMethod" : null,'+
		'          "billingMails" : null,'+
		'          "sourceCreatedBy" : "223005130",'+
		'          "sourceUpdatedBy" : "223005130",'+
		'          "sourceApplicationId" : "SF",'+
		'          "sourceCreateDate" : "2019-11-22T11:17:39.000-06:00",'+
		'          "sourceLastUpdateDate" : "2019-11-22T11:17:39.000-06:00"'+
		'        }, {'+
		'          "custAcctSiteId" : 476950,'+
		'          "ecOperatingUnitName" : "25295 - 798",'+
		'          "ecOperatingUnitId" : 224,'+
		'          "ecClabe" : null,'+
		'          "ecPaymentAccount" : null,'+
		'          "paymentMethod" : null,'+
		'          "billingMails" : null,'+
		'          "sourceCreatedBy" : "223005130",'+
		'          "sourceUpdatedBy" : "223005130",'+
		'          "sourceApplicationId" : "SF",'+
		'          "sourceCreateDate" : "2019-11-22T11:17:39.000-06:00",'+
		'          "sourceLastUpdateDate" : "2019-11-22T11:17:39.000-06:00"'+
		'        }, {'+
		'          "custAcctSiteId" : 476949,'+
		'          "ecOperatingUnitName" : "25295 - 397",'+
		'          "ecOperatingUnitId" : 223,'+
		'          "ecClabe" : null,'+
		'          "ecPaymentAccount" : null,'+
		'          "paymentMethod" : null,'+
		'          "billingMails" : null,'+
		'          "sourceCreatedBy" : "223005130",'+
		'          "sourceUpdatedBy" : "223005130",'+
		'          "sourceApplicationId" : "SF",'+
		'          "sourceCreateDate" : "2019-11-22T11:17:39.000-06:00",'+
		'          "sourceLastUpdateDate" : "2019-11-22T11:17:39.000-06:00"'+
		'        }, {'+
		'          "custAcctSiteId" : 476948,'+
		'          "ecOperatingUnitName" : "25294 - XA7",'+
		'          "ecOperatingUnitId" : 225,'+
		'          "ecClabe" : null,'+
		'          "ecPaymentAccount" : null,'+
		'          "paymentMethod" : null,'+
		'          "billingMails" : null,'+
		'          "sourceCreatedBy" : "223005130",'+
		'          "sourceUpdatedBy" : "223005130",'+
		'          "sourceApplicationId" : "SF",'+
		'          "sourceCreateDate" : "2019-11-22T11:17:39.000-06:00",'+
		'          "sourceLastUpdateDate" : "2019-11-22T11:17:39.000-06:00"'+
		'        }, {'+
		'          "custAcctSiteId" : 476947,'+
		'          "ecOperatingUnitName" : "25294 - 798",'+
		'          "ecOperatingUnitId" : 224,'+
		'          "ecClabe" : null,'+
		'          "ecPaymentAccount" : null,'+
		'          "paymentMethod" : null,'+
		'          "billingMails" : null,'+
		'          "sourceCreatedBy" : "223005130",'+
		'          "sourceUpdatedBy" : "223005130",'+
		'          "sourceApplicationId" : "SF",'+
		'          "sourceCreateDate" : "2019-11-22T11:17:39.000-06:00",'+
		'          "sourceLastUpdateDate" : "2019-11-22T11:17:39.000-06:00"'+
		'        }, {'+
		'          "custAcctSiteId" : 476946,'+
		'          "ecOperatingUnitName" : "25294 - 397",'+
		'          "ecOperatingUnitId" : 223,'+
		'          "ecClabe" : null,'+
		'          "ecPaymentAccount" : null,'+
		'          "paymentMethod" : null,'+
		'          "billingMails" : null,'+
		'          "sourceCreatedBy" : "223005130",'+
		'          "sourceUpdatedBy" : "223005130",'+
		'          "sourceApplicationId" : "SF",'+
		'          "sourceCreateDate" : "2019-11-22T11:17:39.000-06:00",'+
		'          "sourceLastUpdateDate" : "2019-11-22T11:17:39.000-06:00"'+
		'        }, {'+
		'          "custAcctSiteId" : 476945,'+
		'          "ecOperatingUnitName" : "25293 - XA7",'+
		'          "ecOperatingUnitId" : 225,'+
		'          "ecClabe" : null,'+
		'          "ecPaymentAccount" : null,'+
		'          "paymentMethod" : null,'+
		'          "billingMails" : null,'+
		'          "sourceCreatedBy" : "223005130",'+
		'          "sourceUpdatedBy" : "223005130",'+
		'          "sourceApplicationId" : "SF",'+
		'          "sourceCreateDate" : "2019-11-22T11:17:39.000-06:00",'+
		'          "sourceLastUpdateDate" : "2019-11-22T11:17:39.000-06:00"'+
		'        }, {'+
		'          "custAcctSiteId" : 476944,'+
		'          "ecOperatingUnitName" : "25293 - 798",'+
		'          "ecOperatingUnitId" : 224,'+
		'          "ecClabe" : null,'+
		'          "ecPaymentAccount" : null,'+
		'          "paymentMethod" : null,'+
		'          "billingMails" : null,'+
		'          "sourceCreatedBy" : "223005130",'+
		'          "sourceUpdatedBy" : "223005130",'+
		'          "sourceApplicationId" : "SF",'+
		'          "sourceCreateDate" : "2019-11-22T11:17:39.000-06:00",'+
		'          "sourceLastUpdateDate" : "2019-11-22T11:17:39.000-06:00"'+
		'        }, {'+
		'          "custAcctSiteId" : 476943,'+
		'          "ecOperatingUnitName" : "25293 - 397",'+
		'          "ecOperatingUnitId" : 223,'+
		'          "ecClabe" : null,'+
		'          "ecPaymentAccount" : null,'+
		'          "paymentMethod" : null,'+
		'          "billingMails" : null,'+
		'          "sourceCreatedBy" : "223005130",'+
		'          "sourceUpdatedBy" : "223005130",'+
		'          "sourceApplicationId" : "SF",'+
		'          "sourceCreateDate" : "2019-11-22T11:17:39.000-06:00",'+
		'          "sourceLastUpdateDate" : "2019-11-22T11:17:39.000-06:00"'+
		'        } ]'+
		'      },'+
		'      "privilege" : {'+
		'        "sso" : "900000007",'+
		'        "applicationName" : "Salesforce",'+
		'        "applicationCode" : "SF",'+
		'        "screen" : "ENTITYMASTER",'+
		'        "employeeName" : "narain.harjani@engeniumcapital.comxx",'+
		'        "vCrud" : "11111"'+
		'      }'+
		'    },'+
		'    "privilege" : {'+
		'      "sso" : "900000007",'+
		'      "applicationName" : "Salesforce",'+
		'      "applicationCode" : "SF",'+
		'      "screen" : "ENTITYMASTER",'+
		'      "employeeName" : "narain.harjani@engeniumcapital.comxx",'+
		'      "vCrud" : "11111"'+
		'    }'+
		'  },'+
		'  "status" : {'+
		'    "code" : null,'+
		'    "message" : "Success",'+
		'    "detail" : "S"'+
		'  }'+
		'}';
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseHandler_cls(testEndpoint, getResponse, 'GET', 'application/json', 200));
        entitycp.entityCPFromEntityMaster( 'rfc',  null,  '1028506',  '900000007', true);
       
    }
}