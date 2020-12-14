@IsTest
private class Es3_DocSInRequestCalloutClassTest {
    @isTest
    static string testSubmitClosingMemo(){
        Test.setMock(HttpCalloutMock.class, new MockHttPsubmitClossingMemo());
    	string a ='12';
        
         string resultsMap = ES3_DocSInRequestCalloutClass.submitClossingMemo(a);
        return resultsMap;
    }
    
    @Istest
    static void testccriskAHbutton(){
        ES3_DocSInRequestCalloutClass.ccriskAHbutton('12');
        
    }
    
    @Istest
    static void ccAMLAHbuttonTest(){
        ES3_DocSInRequestCalloutClass.ccAMLAHbutton('12');
    }
    
    @Istest
    static void submiteedForATest(){
        ES3_DocSInRequestCalloutClass.submiteedForA('12');
        
    }
    
    @Istest
    static void statusCA(){
         ES3_DocSInRequestCalloutClass.statusCA('12');
    }
    
    @Istest
    static void getLostiposDoctest (){
        ES3_DocSInRequestCalloutClass.getLostiposDoc('12');
        }
        
    @Istest
    static void pricingsMissingtest(){
        ES3_DocSInRequestCalloutClass.pricingsMissing('12');
    }
    
    @Istest
    static void CallbackGetWarningDocs(){
        test.setMock(HttpCalloutMock.class, new MockHttpCallbackGetWarningDocs());
        string a ='12';
        ES3_DocSInRequestCalloutClass.CallbackGetWarningDocs(a);
    }
    
    @Istest
    static void newdocumenttest(){
        
        string doctypes = 'KYC documents,Eval';
        ES3_DocSInRequestCalloutClass.newdocument(doctypes, '12', '12', 'https://backurl', 'https://externa','https:/test.com', '1234567890123456', 'AES128');
    }
    
    @Istest
    static void getUrlInstancetest(){
        
        ES3_DocSInRequestCalloutClass.getUrlInstance();
    }
    
    @Istest
    static void getListOpInCatest() {
        ES3_DocSInRequestCalloutClass.getListOpInCa('12');
        
    }
    
    @Istest
    static void getUrltest(){
        ES3_DocSInRequestCalloutClass.getUrl();
        
    }
    
    @Istest
    static void getUrlExternatest(){
        ES3_DocSInRequestCalloutClass.getUrlExterna();
    }
    
    @Istest
    static void getUrlAppdocstest(){
        ES3_DocSInRequestCalloutClass.getUrlAppdocs();
    }
    
    @Istest
    static void getEncriptationModetest(){
        ES3_DocSInRequestCalloutClass.getEncriptationMode();
        
    }
    
    @Istest
    static void getKeyEncriptationtest(){
        ES3_DocSInRequestCalloutClass.getKeyEncriptation();
    }
    
    @Istest
    static void downloadDoctostest(){
        ES3_DocSInRequestCalloutClass.downloadDoctos('12', 'https://test.com', 'https://external.com', 'https://doctos.com', 'AES128', '1234567890123456');
            
    }
        
    @Istest
    static void deleteDoctotest(){
        ES3_DocSInRequestCalloutClass.deleteDocto('12', '12', 'https://test.com', 'docType', '12', 'salesforce' , 'https://test.com');
    }
    
    @Istest
    static void CallbackGetDocumentsInReq(){
        test.setMock(HttpCalloutMock.class, new MockHttpES3_DocSInRequestCalloutClass());
        string a = '12';
        ES3_DocSInRequestCalloutClass.CallbackGetDocumentsInReq('https://test.com', '999999999', 'a');
        }  
    
    @Istest
    static void CallbackGetDocumentsCAOP(){
        test.setMock(HttpCalloutMock.class, new MockHttpCallbackGetDocumentsCAOP());
        
        ES3_DocSInRequestCalloutClass.CallbackGetDocumentsCAOP('https://test.com', '999999999', 'a', '12');
        
        
    }
    
    
}