@Istest
public class TKD_LinkLAtoTakedownCallTest {
    
    @Istest
    public static void searchLAsInEntityTest(){
        string typeofSandbox = GetSandboxType.getTypeOfSandbox();
        string namecred;
        if (typeofSandbox =='QA') {
            namecred ='getsServiceUrlQa';
        }else if(typeofSandbox =='PROD'){
            namecred = 'getsServiceUrlProd';
        }else{
            namecred ='getsServiceUrl';
        }
         
        
        string testEndpoint = 'callout:'+ namecred + '/EcRequestSbDat/SFRequestTypeDetailsRs/sfRequestTypeDetails?partyId=13073';
         String getResponse ='{'+
		'  "requests" : {'+
		'    "request" : [  {'+
		'      "header" : {'+
		'        "requestId" : 2146,'+
		'        "requestType" : "CREDIT BUREAU",'+
		'        "sourceTopParentId" : "00136000017t7yJ",'+
		'        "sourceTopParentName" : "Aba",'+
		'        "partyId" : 13073,'+
		'        "partyName" : "ABA, S.A. DE C.V.",'+
		'        "startDate" : "2019-03-11T10:56:10.000-05:00",'+
		'        "endDate" : "2019-03-11T11:33:56.000-05:00",'+
		'        "requestStatus" : "APPROVED",'+
		'        "createdBy" : "503001091",'+
		'        "nameCreatedBy" : "Erik Paniagua",'+
		'        "requestedBy" : "503001091",'+
		'        "nameRequestedBy" : "Erik Paniagua",'+
		'        "assignedGroup" : "APP CREDIT BUREAU GROUP",'+
		'        "assignedTo" : "221030975",'+
		'        "nameAssignedTo" : "Beatriz Fernandez",'+
		'        "activeFlag" : "Y",'+
		'        "creationDate" : "2019-03-11T10:56:10.000-05:00",'+
		'        "updatedBy" : "221030975",'+
		'        "nameUpdatedBy" : "Beatriz Fernandez",'+
		'        "lastUpdateDate" : "2019-03-11T11:33:56.000-05:00",'+
		'        "nameSolvedBy" : " ",'+
		'        "docTypes" : {'+
		'          "docType" : [ {'+
		'            "id" : 12,'+
		'            "name" : "Identification Documents",'+
		'            "reqFlag" : "Y",'+
		'            "processName" : "CREDIT BUREAU",'+
		'            "prm1" : "OK"'+
		'          }, {'+
		'            "id" : 14,'+
		'            "name" : "Credit Bureau Report",'+
		'            "reqFlag" : "N",'+
		'            "processName" : "CREDIT BUREAU",'+
		'            "prm1" : "OK"'+
		'          }, {'+
		'            "id" : 17,'+
		'            "name" : "Legal Assessment",'+
		'            "reqFlag" : "Y",'+
		'            "processName" : "CREDIT BUREAU",'+
		'            "prm1" : "OK"'+
		'          }, {'+
		'            "id" : 79,'+
		'            "name" : "Credit Bureau Letter",'+
		'            "reqFlag" : "Y",'+
		'            "processName" : "CREDIT BUREAU",'+
		'            "prm1" : "OK"'+
		'          } ]'+
		'        }'+
		'      },'+
		'      "relatedRequests" : null,'+
		'      "privileges" : {'+
		'        "privilege" : [ {'+
		'          "section" : "PENDING",'+
		'          "vCrud" : "00000"'+
		'        }, {'+
		'          "section" : "IN PROCESS",'+
		'          "vCrud" : "00000"'+
		'        }, {'+
		'          "section" : "ON HOLD",'+
		'          "vCrud" : "00000"'+
		'        }, {'+
		'          "section" : "REWORK",'+
		'          "vCrud" : "00000"'+
		'        }, {'+
		'          "section" : "REJECTED",'+
		'          "vCrud" : "00000"'+
		'        }, {'+
		'          "section" : "PRE APPROVED",'+
		'          "vCrud" : "00000"'+
		'        }, {'+
		'          "section" : "APPROVED",'+
		'          "vCrud" : "00000"'+
		'        }, {'+
		'          "section" : "AUTO APPROVED",'+
		'          "vCrud" : "00000"'+
		'        }, {'+
		'          "section" : "CANCELLED BY REQUESTOR",'+
		'          "vCrud" : "00000"'+
		'        }, {'+
		'          "section" : "WAITING FOR CUSTOMER",'+
		'          "vCrud" : "00000"'+
		'        }, {'+
		'          "section" : "COMPLETED BY CUSTOMER",'+
		'          "vCrud" : "00000"'+
		'        }, {'+
		'          "section" : "EDIT",'+
		'          "vCrud" : "00000"'+
		'        }, {'+
		'          "section" : "NEW DOCUMENT",'+
		'          "vCrud" : "00000"'+
		'        }, {'+
		'          "section" : "NEW COMMENT",'+
		'          "vCrud" : "00000"'+
		'        }, {'+
		'          "section" : "SEND TO BURO",'+
		'          "vCrud" : "00000"'+
		'        }, {'+
		'          "section" : "REASSIGN",'+
		'          "vCrud" : "00000"'+
		'        } ]'+
		'      },'+
		'      "creditBureau" : {'+
		'        "cbrfc" : "ABA831027KRA",'+
		'        "cbCustomerType" : "ORGANIZATION",'+
		'        "cbLastName" : "ABA",'+
		'        "cbSecondLastName" : ", S.A. DE C.V.",'+
		'        "cbAPIRequestor" : "503001091",'+
		'        "cbMunicipality" : "ZACAPU",'+
		'        "cbOutNum" : "404",'+
		'        "cbcompanyName" : "ABA, S.A. DE C.V.",'+
		'        "cbaddress" : "CREDITCONTACT",'+
		'        "cbecEntity" : "798",'+
		'        "cbletterSigningDate" : "11/03/2019",'+
		'        "cbalias" : "ABA SA DE CV",'+
		'        "cbstreetAndNumber" : "BOLIVAR 1019 402",'+
		'        "cbsuburb" : "NINOS HEROES DE CHAPULTEPEC                                 ",'+
		'        "cbzipCode" : "58600",'+
		'        "cbcity" : "ZACAPU",'+
		'        "cbstate" : "MICH",'+
		'        "cbcountry" : "MEX",'+
		'        "cbautorizationLetter" : "NO"'+
		'      },'+
		'      "documents" : {'+
		'        "document" : [ {'+
		'          "requestId" : 2146,'+
		'          "partyId" : 13073,'+
		'          "comment" : "Documento agregado desde Salesforce request ID: 2146",'+
		'          "egPartyId" : 13073,'+
		'          "egPartyName" : "ABA, S.A. DE C.V.",'+
		'          "contentDocId" : 196750,'+
		'          "id" : 3013,'+
		'          "type" : "Credit Bureau Report",'+
		'          "name" : "reporteCO.pdf",'+
		'          "url" : "reporteCO.pdf",'+
		'          "startDate" : "2019/03/11 00:00:00",'+
		'          "endDate" : "2019/03/11 00:00:00",'+
		'          "createdBy" : "221030975",'+
		'          "nameCreatedBy" : "Beatriz Fernandez",'+
		'          "creationDate" : "2019/03/11 11:33:45",'+
		'          "updatedBy" : "221030975",'+
		'          "nameUpdatedBy" : "Beatriz Fernandez"'+
		'        } ]'+
		'      }'+
		'    }, {'+
		'      "header" : {'+
		'        "requestId" : 1291,'+
		'        "requestType" : "CREDIT BUREAU",'+
		'        "sourceTopParentId" : "00136000017t7yJ",'+
		'        "sourceTopParentName" : "Aba",'+
		'        "partyId" : 13073,'+
		'        "partyName" : "ABA, S.A. DE C.V.",'+
		'        "startDate" : "2019-02-05T16:44:06.000-05:00",'+
		'        "endDate" : "2019-02-06T10:31:19.000-05:00",'+
		'        "requestStatus" : "APPROVED",'+
		'        "createdBy" : "221031700",'+
		'        "nameCreatedBy" : "Berenice Plascencia",'+
		'        "requestedBy" : "221031700",'+
		'        "nameRequestedBy" : "Berenice Plascencia",'+
		'        "assignedGroup" : "APP CREDIT BUREAU GROUP",'+
		'        "nameAssignedTo" : " ",'+
		'        "activeFlag" : "Y",'+
		'        "creationDate" : "2019-02-05T16:44:06.000-05:00",'+
		'        "updatedBy" : "221030975",'+
		'        "nameUpdatedBy" : "Beatriz Fernandez",'+
		'        "lastUpdateDate" : "2019-02-06T10:31:19.000-05:00",'+
		'        "nameSolvedBy" : " ",'+
		'        "docTypes" : {'+
		'          "docType" : [ {'+
		'            "id" : 12,'+
		'            "name" : "Identification Documents",'+
		'            "reqFlag" : "Y",'+
		'            "processName" : "CREDIT BUREAU",'+
		'            "prm1" : "OK"'+
		'          }, {'+
		'            "id" : 14,'+
		'            "name" : "Credit Bureau Report",'+
		'            "reqFlag" : "N",'+
		'            "processName" : "CREDIT BUREAU",'+
		'            "prm1" : "OK"'+
		'          }, {'+
		'            "id" : 17,'+
		'            "name" : "Legal Assessment",'+
		'            "reqFlag" : "Y",'+
		'            "processName" : "CREDIT BUREAU",'+
		'            "prm1" : "OK"'+
		'          }, {'+
		'            "id" : 79,'+
		'            "name" : "Credit Bureau Letter",'+
		'            "reqFlag" : "Y",'+
		'            "processName" : "CREDIT BUREAU",'+
		'            "prm1" : "OK"'+
		'          } ]'+
		'        }'+
		'      },'+
		'      "relatedRequests" : null,'+
		'      "privileges" : {'+
		'        "privilege" : [ {'+
		'          "section" : "PENDING",'+
		'          "vCrud" : "00000"'+
		'        }, {'+
		'          "section" : "IN PROCESS",'+
		'          "vCrud" : "00000"'+
		'        }, {'+
		'          "section" : "ON HOLD",'+
		'          "vCrud" : "00000"'+
		'        }, {'+
		'          "section" : "REWORK",'+
		'          "vCrud" : "00000"'+
		'        }, {'+
		'          "section" : "REJECTED",'+
		'          "vCrud" : "00000"'+
		'        }, {'+
		'          "section" : "PRE APPROVED",'+
		'          "vCrud" : "00000"'+
		'        }, {'+
		'          "section" : "APPROVED",'+
		'          "vCrud" : "00000"'+
		'        }, {'+
		'          "section" : "AUTO APPROVED",'+
		'          "vCrud" : "00000"'+
		'        }, {'+
		'          "section" : "CANCELLED BY REQUESTOR",'+
		'          "vCrud" : "00000"'+
		'        }, {'+
		'          "section" : "WAITING FOR CUSTOMER",'+
		'          "vCrud" : "00000"'+
		'        }, {'+
		'          "section" : "COMPLETED BY CUSTOMER",'+
		'          "vCrud" : "00000"'+
		'        }, {'+
		'          "section" : "EDIT",'+
		'          "vCrud" : "00000"'+
		'        }, {'+
		'          "section" : "NEW DOCUMENT",'+
		'          "vCrud" : "00000"'+
		'        }, {'+
		'          "section" : "NEW COMMENT",'+
		'          "vCrud" : "00000"'+
		'        }, {'+
		'          "section" : "SEND TO BURO",'+
		'          "vCrud" : "00000"'+
		'        }, {'+
		'          "section" : "REASSIGN",'+
		'          "vCrud" : "00000"'+
		'        } ]'+
		'      },'+
		'      "creditBureau" : {'+
		'        "cbrfc" : "ABA831027KRA",'+
		'        "cbCustomerType" : "ORGANIZATION",'+
		'        "cbAPIRequestor" : "221031700",'+
		'        "cbMunicipality" : "ZACAPU",'+
		'        "cbOutNum" : "404",'+
		'        "cbcompanyName" : "ABA, S.A DE C.V.",'+
		'        "cbaddress" : "CREDITCONTACT",'+
		'        "cbecEntity" : "798",'+
		'        "cbletterSigningDate" : "05/02/2019",'+
		'        "cbalias" : "ABA SA DE CV",'+
		'        "cbstreetAndNumber" : "BOLIVAR 1019 402",'+
		'        "cbsuburb" : "NINOS HEROES DE CHAPULTEPEC                                 ",'+
		'        "cbzipCode" : "58600",'+
		'        "cbcity" : "ZACAPU",'+
		'        "cbstate" : "MICH",'+
		'        "cbcountry" : "MEX",'+
		'        "cbautorizationLetter" : "NO"'+
		'      },'+
		'      "documents" : {'+
		'        "document" : [ {'+
		'          "requestId" : 1291,'+
		'          "partyId" : 13073,'+
		'          "comment" : "Documento agregado desde Salesforce request ID: 1291",'+
		'          "egPartyId" : 13073,'+
		'          "egPartyName" : "ABA, S.A DE C.V.",'+
		'          "contentDocId" : 98200,'+
		'          "id" : 1386,'+
		'          "type" : "Credit Bureau Report",'+
		'          "name" : "ABACB.pdf",'+
		'          "url" : "ABACB.pdf",'+
		'          "startDate" : "2019/02/06 00:00:00",'+
		'          "endDate" : "2019/02/06 00:00:00",'+
		'          "createdBy" : "221030975",'+
		'          "nameCreatedBy" : "Beatriz Fernandez",'+
		'          "creationDate" : "2019/02/06 10:30:51",'+
		'          "updatedBy" : "221030975",'+
		'          "nameUpdatedBy" : "Beatriz Fernandez"'+
		'        } ]'+
		'      },'+
		'      "audits" : {'+
		'        "audit" : [ {'+
		'          "auditUpdatedBy" : "221030975",'+
		'          "auditNameUpdatedBy" : "Beatriz Fernandez",'+
		'          "auditLastUpdateDate" : "2019/02/06 10:31:21",'+
		'          "auditField" : "Status",'+
		'          "auditLastValue" : "3",'+
		'          "auditNewValue" : "8",'+
		'          "auditComment" : "El valor del campo \"Status\" fue modificado por el SSO \"221030975\" el d��a 2019/02/06 10:31:21\". Valor actual \"APPROVED\" Valor anterior \"IN PROCESS"'+
		'        }, {'+
		'          "auditUpdatedBy" : "221030975",'+
		'          "auditNameUpdatedBy" : "Beatriz Fernandez",'+
		'          "auditLastUpdateDate" : "2019/02/05 22:53:04",'+
		'          "auditField" : "Status",'+
		'          "auditLastValue" : "2",'+
		'          "auditNewValue" : "3",'+
		'          "auditComment" : "El valor del campo \"Status\" fue modificado por el SSO \"221030975\" el d��a 2019/02/05 22:53:04\". Valor actual \"IN PROCESS\" Valor anterior \"PENDING"'+
		'        }, {'+
		'          "auditUpdatedBy" : "221031700",'+
		'          "auditNameUpdatedBy" : "Berenice Plascencia",'+
		'          "auditLastUpdateDate" : "2019/02/05 16:44:14",'+
		'          "auditField" : "Status",'+
		'          "auditLastValue" : "1",'+
		'          "auditNewValue" : "2",'+
		'          "auditComment" : "El valor del campo \"Status\" fue modificado por el SSO \"221031700\" el d��a 2019/02/05 16:44:14\". Valor actual \"PENDING\" Valor anterior \"NEW"'+
		'        } ]'+
		'      }'+
		'    } ]'+
		'  },'+
		'  "status" : {'+
		'    "code" : null,'+
		'    "message" : "Success",'+
		'    "detail" : "S"'+
		'  }'+
		'}';
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseHandler_cls(testEndpoint, getResponse, 'GET', 'application/json', 200));
        TKD_LinkLAtoTakedownCallout_cls.searchLAsInEntity('13073');
    }
    
    @Istest
    public static void searchRequestIdTest(){
         
        string typeofSandbox = GetSandboxType.getTypeOfSandbox();
        string namecred;
        if (typeofSandbox =='QA') {
            namecred ='getsServiceUrlQa';
        }else if(typeofSandbox =='PROD'){
            namecred = 'getsServiceUrlProd';
        }else{
            namecred ='getsServiceUrl';
        }
       string testEndpoint = 'callout:'+ namecred + '/EcRequestSbDat/SFRequestTypeDetailsRs/sfRequestTypeDetails?requestId=12';
       string getResponse = 'fake'; 
       Test.setMock(HttpCalloutMock.class, new MockHttpResponseHandler_cls(testEndpoint, getResponse, 'GET', 'application/json', 200));
        TKD_LinkLAtoTakedownCallout_cls.searchRequestId('12');
    }
    
    @Istest
    public static void getEntitiesInCaTest (){
       Credit_approval_CP__c ca =  Data_Factory_CreditApproval_Test.createNewCreditApprovalTypeWK('Pollos'); 
        TKD_LinkLAtoTakedownCallout_cls.getEntitiesInCa(ca.Id);
    }
    
}