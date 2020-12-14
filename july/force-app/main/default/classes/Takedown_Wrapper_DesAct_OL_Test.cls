@isTest
public class Takedown_Wrapper_DesAct_OL_Test {
	@isTest 
    public static void DesActRequest(){
        Takedown_Wrapper_DesAct_OL_cls.DesActRequest Test_1 = new Takedown_Wrapper_DesAct_OL_cls.DesActRequest();
        Test_1.takedownId = 'a40m0000000XcDEAA9';
    }
    @isTest 
    public static void DesActResponse(){
        Takedown_Wrapper_DesAct_OL_cls.DesActResponse Test_2 = new Takedown_Wrapper_DesAct_OL_cls.DesActResponse();
        Takedown_Wrapper_DesAct_OL_cls.Response Test_3 = new Takedown_Wrapper_DesAct_OL_cls.Response();
        Test_2.Response = Test_3; 
        Test_2.Assets = new list <Takedown_Wrapper_DesAct_OL_cls.Assets>();
    }
    @isTest 
    public static void Response(){
        Takedown_Wrapper_DesAct_OL_cls.Response Test_3 = new Takedown_Wrapper_DesAct_OL_cls.Response();
        Test_3.code = '123456';
		Test_3.message = 'Espera un poco';
		Test_3.success = 'Listo';
    }
    @isTest 
    public static void Assets(){
        Takedown_Wrapper_DesAct_OL_cls.Assets Test_4 = new Takedown_Wrapper_DesAct_OL_cls.Assets();
        Test_4.invAssetId = 'a40m0000000XcDEAA1';
		Test_4.takedownId = 'a40m0000000XcDEAA2';
		Test_4.activeFlag = 'true';
		Test_4.arrears = 'true';
		Test_4.assetId = 'a40m0000000XcDEAA0';
		Test_4.brand = 'Salesforce';
		Test_4.colateralDescription = 'Clateral';
		Test_4.collateralType = 'Sobrecarga';
		Test_4.createdBy = 'Benedick Esquivel';
		Test_4.creationDate = '02/12/2010';
		Test_4.ecPolicy = '3203203';
		Test_4.engineNum = '50300110';
		Test_4.faCategory = 'Fleet';
		Test_4.faSubcategory = 'Amount';
		Test_4.importDate = '20/02/2019';
		Test_4.importedBy = '12/05/2019';
		Test_4.incisoInsurance = 'Ejemplo';
		Test_4.insuranceCompany = 'Engen Capital';
		Test_4.insuranceExpirationDate = '12/03/2019';
		Test_4.insurancePolicy = '432556434';
		Test_4.invLinesId = 'a40m0000000XcDEAA3';
		Test_4.lastUpdateDate = '16/01/2020';
		Test_4.lastUpdatedBy = 'Benedick Esquivel';
		Test_4.model = 'a30';
		Test_4.modelYear = '2011';
		Test_4.paymentAmount = '23929239';
		Test_4.paymentFrecuency = '12';
		Test_4.paymentOrder = '49504854';
		Test_4.paymentType = 'Rapido';
		Test_4.pediment = '2';
		Test_4.period = '7';
		Test_4.plates = '9';
		Test_4.quantity = 'Super';
        Test_4.serialNumber = '240934834';
		Test_4.softCost = '332434';
		Test_4.sourceAssetDescription = 'Auto del futuro hoy';
		Test_4.sourceAssetName = 'Super Auto';
		Test_4.totalCost = '113122';
		Test_4.unitCost = '2113214';
        
    }
}