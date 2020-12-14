@isTest
public class EM_UpdateInvoicesTest {
    @isTest static void EM_UpdateInvoices(){
        EIV_InvoicingWrapClass test_EIV_InvoicingWrapClass = new EIV_InvoicingWrapClass();
        test_EIV_InvoicingWrapClass.partySiteId = 'test';
        test_EIV_InvoicingWrapClass.party_Id = 'test'; 
        test_EIV_InvoicingWrapClass.p_cust_acct_site_id = 'test'; 
        test_EIV_InvoicingWrapClass.EC_Operating_Unit_Name = 'test'; 
        test_EIV_InvoicingWrapClass.EC_Operating_Unit_ID = 'test'; 
        test_EIV_InvoicingWrapClass.EC_CLABE = 'test'; 
        test_EIV_InvoicingWrapClass.EC_Payment_Account = 'test'; 
        test_EIV_InvoicingWrapClass.Payment_Method = 'test'; 
        test_EIV_InvoicingWrapClass.Billing_Mails = 'test'; 
        test_EIV_InvoicingWrapClass.Source_Created_by = 'test'; 
        test_EIV_InvoicingWrapClass.Source_Updated_by = 'test'; 
        test_EIV_InvoicingWrapClass.Source_Application_ID = 'test'; 
        test_EIV_InvoicingWrapClass.Oracle_Created_by = 'test';
        test_EIV_InvoicingWrapClass.Oracle_Updated_by = 'test';
        test_EIV_InvoicingWrapClass.invoiceId = 'test';	
        list<EIV_InvoicingWrapClass> listtest_EIV_InvoicingWrapClass = new list<EIV_InvoicingWrapClass>();
        listtest_EIV_InvoicingWrapClass.add(test_EIV_InvoicingWrapClass);
        test_EIV_InvoicingWrapClass = new EIV_InvoicingWrapClass();
        test_EIV_InvoicingWrapClass.partySiteId = 'test';
        test_EIV_InvoicingWrapClass.party_Id = 'test'; 
        test_EIV_InvoicingWrapClass.p_cust_acct_site_id = 'tet'; 
        test_EIV_InvoicingWrapClass.EC_Operating_Unit_Name = 'test'; 
        test_EIV_InvoicingWrapClass.EC_Operating_Unit_ID = 'test'; 
        test_EIV_InvoicingWrapClass.EC_CLABE = 'test'; 
        test_EIV_InvoicingWrapClass.EC_Payment_Account = 'test'; 
        test_EIV_InvoicingWrapClass.Payment_Method = 'test'; 
        test_EIV_InvoicingWrapClass.Billing_Mails = 'test'; 
        test_EIV_InvoicingWrapClass.Source_Created_by = 'test'; 
        test_EIV_InvoicingWrapClass.Source_Updated_by = 'test'; 
        test_EIV_InvoicingWrapClass.Source_Application_ID = 'test'; 
        test_EIV_InvoicingWrapClass.Oracle_Created_by = 'test';
        test_EIV_InvoicingWrapClass.Oracle_Updated_by = 'test';
        test_EIV_InvoicingWrapClass.invoiceId = 'test';
        listtest_EIV_InvoicingWrapClass.add(test_EIV_InvoicingWrapClass);
        EIV_AddressWrapClass Test_AddressList = new EIV_AddressWrapClass();        
        datetime Test_DateTime = datetime.now();

        Test_AddressList.Location_ID = 'Test1';
        Test_AddressList.Street = 'Test2';
        Test_AddressList.Outdoor_Number = 'Test3';
        Test_AddressList.Interior_Number = 'Test4';
        Test_AddressList.County = 'Test5';
        Test_AddressList.Municipality = 'Test6';
        Test_AddressList.Country = 'Test7';
        Test_AddressList.City = 'Test8';
        Test_AddressList.Zip_Code = 'Test9';
        Test_AddressList.State = 'Test10';
        Test_AddressList.Status = 'Test11';
        Test_AddressList.Purpose = 'BILL_TO, SHIP_TO, INSTALL_AT';
        Test_AddressList.party_ID = 'Test13';
        Test_AddressList.Source_Created_by = 'Test14';
        Test_AddressList.Source_Updated_by = 'Test15';
        Test_AddressList.Source_Application_ID = 'Test16';
        Test_AddressList.Source_Create_Date = Test_DateTime;
        Test_AddressList.Source_Last_Update_Date = Test_DateTime;
        Test_AddressList.Oracle_Created_by = 'Test17';
        Test_AddressList.Oracle_Updated_by = 'Test18';
        Test_AddressList.Oracle_Create_Date = Test_DateTime;
        Test_AddressList.Oracle_Last_Update_Date = Test_DateTime;
        Test_AddressList.PostalCodeId = 'Test19';
        Test_AddressList.EntityPartyId = 'Test20';
        Test_AddressList.s_397 = 'Test21';
        Test_AddressList.s_789 = 'Test22';
        Test_AddressList.xa7 = 'Test23';
        Test_AddressList.s1u = 'Test24';
        Test_AddressList.addressReference = 'Test25';
        Test_AddressList.addressLinesPhonetic = 'Test26';
        Test_AddressList.normalizedAddress = 'Test27';
        
        list<EIV_AddressWrapClass> listTest_AddressList = new list<EIV_AddressWrapClass>();  
        listTest_AddressList.add(Test_AddressList);
        EM_UpdateInvoices.UpdateEntity(test_EIV_InvoicingWrapClass, listtest_EIV_InvoicingWrapClass, listTest_AddressList, 'test');
        
    }

}