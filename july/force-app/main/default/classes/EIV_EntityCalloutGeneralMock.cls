@isTest
global class EIV_EntityCalloutGeneralMock {
	//Get Response
    global class responseStepTwo implements HttpCalloutMock{
    	global HTTPResponse respond(HTTPRequest req) {
            System.assertEquals('GET', req.getMethod());
            
            // Create a fake response
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"example":"test"}');
            res.setStatusCode(200);
            return res;
        }  
    }
    global class badResponse implements HttpCalloutMock{
    	global HTTPResponse respond(HTTPRequest req) {
            System.assertEquals('GET', req.getMethod());
            
            // Create a fake response
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"example":"test"}');
            res.setStatusCode(404);
            return res;
        }  
    }
    global class responseEntityMaster implements HttpCalloutMock{
    	global HTTPResponse respond(HTTPRequest req) {
            System.assertEquals('GET', req.getMethod());
            
            // Create a fake response
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"entityInfo":{"entities":{"entity":[{"sFaccountID":"0013600001ur554","entityName":null,"custAccountId":"215639",'
                        + '"partyID":655434,"rfc":"ADA020125JL6","customerType":"ORGANIZATION","customerStatus":"YES","topParentId":'
                        + '"0013600001ur554","topParentName":"Eficacia Alimenticia","sfAccountName":"Eficacia Alimenticia","tin":null,'
                        + '"economicGroupId":638424,"economicGroupName":"AGROPECUARIA DALEGG","taxRegime":"PERSONA MORAL","nationality":"MEX",'
                        + '"oracleAccountNumber":"000001424","curp":null,"prefix":null,"firstName":null,"middleName":null,"firstLastName":'
                        + '"AGROPECUARIA DALEGG","secondLastName":", S.A. DE C.V.","salesRepresentative":null,"supplierFlag":false,"legalName":'
                        + '"AGROPECUARIA DALEGG","companyLegalNameTermination":", S.A. DE C.V.","oracleAccountName":"AGROPECUARIA DALEGG, S.A. '
                        + 'DE C.V.","sourceCreatedBy":"212309756","sourceUpdatedBy":"212309756","sourceApplicationID":"SF","sourceCreateDate":'
                        + '"2018-12-03T02:46:50.000-06:00","sourceLastUpdateDate":"2018-12-03T02:46:50.000-06:00","aml":{"targetMarketJurisdic'
                        + 'tion":"Lower middle market","ccr":"LOW","crrComments":"LOW","ccrOverride":"SELECTION","entityType":"PRIVATE UNREGUL'
                        + 'ATED*, EXCEPT HIGH RISK ENTITY TYPE"},"rating":{"mraId":"748","bloombergId":null,"hnwiId":null,"orRating":null,"tra'
                        + 'nsactionDate":null,"riskClassification":null},"sic":{"sicCode":252,"sicDescription":"Office furniture","economicGrou'
                        + 'pSicCode":252,"economicGroupSicDescription":"Chicken egg farm"},"buro":{"customerAlias":null,"buroFlag":null}}]},"pr'
                        + 'ivilege":{"sso":null,"applicationName":null,"applicationCode":null,"screen":null,"employeeName":null,"vCrud":null}},'
                        + '"status":{"message":"S","detail":"Success"}}');
            res.setStatusCode(200);
            return res;
        }  
    }
    global class responseEntityNotFound implements HttpCalloutMock{
    	global HTTPResponse respond(HTTPRequest req) {
            System.assertEquals('GET', req.getMethod());
            
            // Create a fake response
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"entityInfo":{"entities":null,"privilege":{"sso":null,"applicationName":null,"applicationCode":null,"screen":null,'
                        + '"employeeName":null,"vCrud":null}},"status":{"message":"S","detail":"Success"}}');
            res.setStatusCode(200);
            return res;
        }  
    }
    //PostResponse
    global class createCreditBureau implements HttpCalloutMock{
    	global HTTPResponse respond(HTTPRequest req) {
            System.assertEquals('POST', req.getMethod());
            
            // Create a fake response
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"example":"test"}');
            res.setStatusCode(200);
            return res;
        }  
    }   
    

}