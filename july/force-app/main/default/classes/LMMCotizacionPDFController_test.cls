@isTest
public class LMMCotizacionPDFController_test {
    @isTest
    static void initController(){ 
        EC_Quote__c EC_Quote = new EC_Quote__c(); 
        EC_Quote.RequestAmortizacion__c = '{"userId":"64","programId":"104","data":{"detFreeQuotationDTO":{"strPersonType":"Moral","strRfc":'
            + '"MOME0930523CJ0","strPhoneNumber":"5611157946","annualIncomeTypeDTO":{"strDescription":"Menos de 50 millones","dtModifiedOn":'
            + 'null,"intAnnualIncomeTypeId":2,"dtCreatedOn":null}},"strClientName":"Prueba cotizacion","strContactName":"Edna Samaria","strE'
            + 'mailToSend":"molinamednas@gmail.com","financialType":{"strDescription":"A. Puro","strFinancialTypeKey":"PURE_LEASE","statusDT'
            + 'O":{"strDescription":"Active","strStatusKey":"A","intStatusId":1,"dtCreatedOn":1588360951946},"intFinancialTypeId":1,"dtCreat'
            + 'edOn":1574379343000,"selected":false},"stateDTO":{"countryDTO":{"strName":null,"intCountryId":null,"strCode":null,"intNumber"'
            + ':null},"strName":"BAJA CALIFORNIA","strCode":"BC","intNumber":2,"intStateId":2},"financialTermsDTO":{"strDescription":"36 m",'
            + '"intTermValue":36,"statusDTO":{"strDescription":"Active","strStatusKey":"A","intStatusId":1,"dtCreatedOn":1588360951948},"int'
            + 'FinancialTermId":3,"dtCreatedOn":1574378806000,"selected":false},"lstQuotationAssets":[{"lngAssetId":1010,"coverageDTO":{"str'
            + 'Description":"ElectrÃ³nico fijo","bgdCoverageCost":32000,"intCoverageId":1,"bgdFactor":1.67},"intYear":2020,"assetDTO":{"strD'
            + 'escription":"IT Equipment- Hardware // Laptops","lngAssetId":1010,"strModel":"Generico","groupDTO":{"strDescription":"Engen C'
            + 'apital","intGroupId":105},"strBrand":"Generico"},"fltAmount":"21000","intQuantity":1}],"currencyDTO":{"strDescription":"Dolar'
            + 'Americano","statusDTO":{"strDescription":"Active","strStatusKey":"A","intStatusId":1,"dtCreatedOn":1588360951949},"strCurrenc'
            + 'yCode":"USD","intCurrencyId":1,"selected":false},"quoteDetailDTO":{"currencyAssetsDTO":{"strDescription":"Dolar Americano","s'
            + 'tatusDTO":{"strDescription":"Active","strStatusKey":"A","intStatusId":1,"dtCreatedOn":1588360951949},"strCurrencyCode":"USD",'
            + '"intCurrencyId":1,"selected":false}},"financialInsuranceDTO":{"strDescription":"Si","intFinancialInsuranceId":1,"statusDTO":n'
            + 'ull,"dtCreatedOn":null},"financialTypeDTO":{"strDescription":"A. Puro","strFinancialTypeKey":"PURE_LEASE","statusDTO":{"strDe'
            + 'scription":"Active","strStatusKey":"A","intStatusId":1,"dtCreatedOn":1588360951946},"intFinancialTypeId":1,"dtCreatedOn":1574'
            + '379343000,"selected":false}}}';
        insert EC_Quote;
        ApexPages.StandardController sc = new ApexPages.StandardController(EC_Quote);
        LMMCotizacionPDFController LMMCotizacionPDFCtr = new LMMCotizacionPDFController(sc);
        
        PageReference pageRef = Page.LMMCotizacionPDF;
        pageRef.getParameters().put('id', String.valueOf(EC_Quote.Id));
        Test.setCurrentPage(pageRef);      
    }
    @isTest
    static void date1(){ 
        LMMCotizacionPDFController LMMCotizacionPDFCtr = new LMMCotizacionPDFController(1, 'Monday'); 
        LMMCotizacionPDFCtr.getDay();
        LMMCotizacionPDFCtr.getMonth();
    }
    @isTest
    static void date2(){ 
        LMMCotizacionPDFController LMMCotizacionPDFCtr = new LMMCotizacionPDFController(2, 'Tuesday'); 
        LMMCotizacionPDFCtr.getDay();
        LMMCotizacionPDFCtr.getMonth();
    }
    @isTest
    static void date3(){ 
        LMMCotizacionPDFController LMMCotizacionPDFCtr = new LMMCotizacionPDFController(3, 'Wednesday'); 
        LMMCotizacionPDFCtr.getDay();
        LMMCotizacionPDFCtr.getMonth();
    }
    @isTest
    static void date4(){ 
        LMMCotizacionPDFController LMMCotizacionPDFCtr = new LMMCotizacionPDFController(4, 'Thursday'); 
        LMMCotizacionPDFCtr.getDay();
        LMMCotizacionPDFCtr.getMonth();
    }
    @isTest
    static void date5(){ 
        LMMCotizacionPDFController LMMCotizacionPDFCtr = new LMMCotizacionPDFController(5, 'Friday'); 
        LMMCotizacionPDFCtr.getDay();
        LMMCotizacionPDFCtr.getMonth();
    }
    @isTest
    static void date6(){ 
        LMMCotizacionPDFController LMMCotizacionPDFCtr = new LMMCotizacionPDFController(6, 'Saturday'); 
        LMMCotizacionPDFCtr.getDay();
        LMMCotizacionPDFCtr.getMonth();
    }
    @isTest
    static void date7(){ 
        LMMCotizacionPDFController LMMCotizacionPDFCtr = new LMMCotizacionPDFController(7, 'Sunday'); 
        LMMCotizacionPDFCtr.getDay();
        LMMCotizacionPDFCtr.getMonth();
    }
    @isTest
    static void date8(){ 
        LMMCotizacionPDFController LMMCotizacionPDFCtr = new LMMCotizacionPDFController(8, 'SunSun'); 
        LMMCotizacionPDFCtr.getDay();
        LMMCotizacionPDFCtr.getMonth();
    }
    @isTest
    static void date9(){ 
        LMMCotizacionPDFController LMMCotizacionPDFCtr = new LMMCotizacionPDFController(9, 'SunSun'); 
        LMMCotizacionPDFCtr.getDay();
        LMMCotizacionPDFCtr.getMonth();
    }
    @isTest
    static void date10(){ 
        LMMCotizacionPDFController LMMCotizacionPDFCtr = new LMMCotizacionPDFController(10, 'SunSun'); 
        LMMCotizacionPDFCtr.getDay();
        LMMCotizacionPDFCtr.getMonth();
    }
    @isTest
    static void date11(){ 
        LMMCotizacionPDFController LMMCotizacionPDFCtr = new LMMCotizacionPDFController(11, 'SunSun'); 
        LMMCotizacionPDFCtr.getDay();
        LMMCotizacionPDFCtr.getMonth();
    }
    @isTest
    static void date12(){ 
        LMMCotizacionPDFController LMMCotizacionPDFCtr = new LMMCotizacionPDFController(12, 'SunSun'); 
        LMMCotizacionPDFCtr.getDay();
        LMMCotizacionPDFCtr.getMonth();
    }
    @isTest
    static void date13(){ 
        LMMCotizacionPDFController LMMCotizacionPDFCtr = new LMMCotizacionPDFController(13, 'SunSun'); 
        LMMCotizacionPDFCtr.getDay();
        LMMCotizacionPDFCtr.getMonth();
    }
}