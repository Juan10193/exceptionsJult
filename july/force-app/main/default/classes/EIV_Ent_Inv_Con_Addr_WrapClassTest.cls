@istest
private class EIV_Ent_Inv_Con_Addr_WrapClassTest {
    @isTest static void setTestEntity(){
        EIV_EntityWrapClass e = new EIV_EntityWrapClass();
        e.entityName='entity';
        e.Customer_Name='new';
        e.Customer_Alias='new';    
        e.Customer_Type='asdf';
        e.Customer_Status='qwe';
        e.Cust_AccountId='222';
        e.Top_Parent_ID='333';
        e.Top_Parent_Name='pruebaa';
        e.Account_ID='1111';
        e.SF_Account_Name='sebb';
        e.RFC='wers121212';
        e.TIN='12234er';
        e.Economic_Group_ID='12';
        e.Economic_Group_Name='ert';
        e.EconomicGroupPartyId='4444';
        e.Limited_information_entity=true;
        e.Tax_Regime='persona moral';
        e.Foreign_Entity='ddsd';
        e.Nationality='mexico';
        e.Oracle_Account_Number='sfbd';
        e.CURP='wers121212qwqwqw12';
        e.Prefix='sr';
        e.First_Name='el';
        e.Middle_Name='se';
        e.First_Last_Name='ba';
        e.Second_Last_Name='st';
        e.Sales_Representative='ia';
        e.Supplier_Flag='an';
        e.Legal_Name_sin_denominacion='sepa';
        e.Company_Legal_Name_termination='www';
        e.Oracle_Account_Name='eee';
        e.Source_Created_by='el';
        e.Source_Updated_by='sancho';
        e.Source_Application_ID='33';
        e.Source_Create_Date= date.today();
        e.Source_Last_Update_Date= date.today();
        e.Oracle_Created_by='';
        e.Oracle_Updated_by='';
        e.Oracle_Create_Date= date.today();
        e.Oracle_Last_Update_Date= date.today();
        e.Target_Market_Jurisdiction='qw';
        e.CRR='low';
        e.CRR_Override='low';
        e.CRR_Comments='se';
        e.Entity_Type='larga';
        e.MRA_ID='qq';
        e.Bloomberg_ID='qq';
        e.HNWI_ID='qq';
        //Agregadas para SicCode
        e.SIC_Code='34344';
        e.SIC_Description='code raro';
        e.Economic_group_SIC_Code='ee';
        e.Economic_Group_SIC_Description='eer'; 
        //Agregadas y que faltan en el esquema
        e.Party_Id='23';
        e.SIC_CodeId='434';
        e.SIC_CodeIndustry='chabelo';
        e.Economic_group_SIC_CodeId='66'; 
        e.foreingn_TAX_ID='77';
        //variable para el manejo del formato correspondiente
        e.vfSNameRead='el';   
        e.vfSNameEdit='chocolate';      
        //Agregadas para buro
        e.buroFlag='muy alto';
    }
    @isTest static void setTestinvoicing(){
        EIV_InvoicingWrapClass b = new EIV_InvoicingWrapClass();
        b.Billing_Mails='tt@gg.com';
        b.partySiteId='44';
        b.party_Id ='7789';
        b.p_cust_acct_site_id='3434';
        b.EC_Operating_Unit_Name='pancho';
        b.EC_Operating_Unit_ID='6677';
        b.EC_CLABE='43454566767566777';
        b.EC_Payment_Account ='4545345645343242354';
        b.Payment_Method ='55';
        b.Source_Created_by ='pancho';
        b.Source_Updated_by='kara';
        b.Source_Application_ID='45435';
        b.Source_Create_Date= date.today();
        b.Source_Last_Update_Date=date.today();
        b.Oracle_Created_by  ='erasmo';
        b.Oracle_Updated_by ='yuliana';
        b.Oracle_Create_Date =date.today();
        b.Oracle_Last_Update_Date =date.today();
        b.invoiceId='96969';
        System.assertEquals(b.Billing_Mails, 'tt@gg.com');
        System.assertEquals(b.partySiteId, '44');
        System.assertEquals(b.party_Id, '7789');
        System.assertEquals(b.p_cust_acct_site_id, '3434');
        System.assertEquals(b.EC_Operating_Unit_Name, 'pancho');
        System.assertEquals(b.EC_Operating_Unit_ID, '6677');
        System.assertEquals(b.EC_CLABE, '43454566767566777');
        System.assertEquals(b.EC_Payment_Account, '4545345645343242354');
        System.assertEquals(b.Payment_Method, '55');
        System.assertEquals(b.Source_Created_by, 'pancho');
        System.assertEquals(b.Source_Updated_by, 'kara');
        System.assertEquals(b.Source_Application_ID, '45435');
        System.assertEquals(b.Source_Create_Date, date.today());
        System.assertEquals(b.Source_Last_Update_Date, date.today());
        System.assertEquals(b.Oracle_Created_by, 'erasmo');
        System.assertEquals(b.Oracle_Updated_by, 'yuliana');
        System.assertEquals(b.Oracle_Create_Date, date.today());
        System.assertEquals(b.Oracle_Last_Update_Date, date.today());
        System.assertEquals(b.invoiceId, '96969');
    }
    @isTest static void setContactFields(){
        EIV_ContactWrapClass a = new EIV_ContactWrapClass();
        a.Contact_id = 'Norma';
        a.partyContact_Id = '12314';
        a.party_ID = '123456';
        a.Prefix = 'Mr.';
        a.First_Name ='LOL';
        a.middleName ='LOL';
        a.First_Last_Name = 'LOL';
        a.secondLastName = 'LOL';
        a.title = 'PROF.';
        a.Status ='as';
        a.Country_code ='MEX';
        a.Area_code ='55';
        a.Phone = '1021012';
        a.Phone_number_extension ='144';
        a.Mobile ='12345678';
        a.Email ='juand10193@hotmail.com';
        a.TypeContact='lol';
        a.Source_Created_by= 'lel';
        a.Source_Updated_by='lil';
        a.Source_Application_ID = '123';
        a.Source_Create_Date= Datetime.valueOf('2018-1-14 23:00:03');
        a.Source_Last_Update_Date = Datetime.valueOf('2018-1-15 23:00:03');
        a.Oracle_Created_by ='LUL';
        a.Oracle_Updated_by = 'LAL';
        a.Oracle_Create_Date = Datetime.valueOf('2018-1-16 23:00:03');
        a.Oracle_Last_Update_Date = Datetime.valueOf('2018-1-17 23:00:03');
        a.EntitypartyID='1234';
        
        System.assertEquals(a.Contact_id, 'Norma');
        System.assertEquals(a.partyContact_Id,'12314');
        System.assertEquals(a.party_ID, '123456');
        System.assertEquals(a.Prefix, 'Mr.');
        System.assertEquals(a.First_Name, 'LOL');
        System.assertEquals(a.middleName, 'LOL');
        System.assertEquals(a.First_Last_Name, 'LOL');
        System.assertEquals(a.secondLastName, 'LOL');
        System.assertEquals(a.title, 'PROF.');
        System.assertEquals(a.Status, 'as');
        System.assertEquals(a.Country_code, 'MEX');
        System.assertEquals(a.Area_code, '55');
        System.assertEquals(a.Phone, '1021012');
        System.assertEquals(a.Phone_number_extension, '144');
        System.assertEquals(a.Mobile, '12345678');
        System.assertEquals(a.Email, 'juand10193@hotmail.com');
        System.assertEquals(a.TypeContact, 'lol');
        System.assertEquals(a.Source_Created_by, 'lel');
        System.assertEquals(a.Source_Updated_by, 'lil');
        System.assertEquals(a.Source_Application_ID, '123');
        System.assertEquals(a.Source_Create_Date, Datetime.valueOf('2018-1-14 23:00:03'));
        System.assertEquals(a.Source_Last_Update_Date, Datetime.valueOf('2018-1-15 23:00:03'));
        System.assertEquals(a.Oracle_Created_by, 'LUL');
        System.assertEquals(a.Oracle_Updated_by, 'LAL');
        System.assertEquals(a.Oracle_Create_Date, Datetime.valueOf('2018-1-16 23:00:03'));
        System.assertEquals(a.Oracle_Last_Update_Date, Datetime.valueOf('2018-1-17 23:00:03'));
        System.assertEquals(a.EntitypartyID, '1234');
    }
    @isTest static void setTestaddress(){
        EIV_AddressWrapClass b = new EIV_AddressWrapClass();
        b.Location_ID='33';
        b.street='manzana';
        b.Outdoor_Number='4';             
        b.Interior_Number='10';
        b.County='El charco';
        b.Municipality='ecatepec';
        b.Country='mexico';
        b.City='mexico';
        b.Zip_Code='55404';
        b.State='Edo mex';
        b.Status='mexico';
        b.Purpose='credic contact';
        b.party_ID='22';
        b.Source_Created_by='prueba uno';
        b.Source_Updated_by='prueba dos';
        b.Source_Application_ID='35';
        b.Source_Create_Date= date.today();
        b.Source_Last_Update_Date= date.today();
        b.Oracle_Created_by='sebas';
        b.Oracle_Updated_by='dany';
        b.Oracle_Create_Date= date.today();
        b.Oracle_Last_Update_Date= date.today();
        b.PostalCodeId='6';
        b.EntityPartyId='7';
        b.s_397='55';
        b.s_789='77';
        b.xa7='66';
        b.s1u='88';
        //public string custAccountID              {get;set;}
        b.addressReference='casa azul';
        b.addressLinesPhonetic='tests';
        b.normalizedAddress='sdscvfdfv';
        //public string identifyingAddressFlag     {get;set;}
        System.assertEquals(b.Location_ID,'33');
        System.assertEquals(b.street,'manzana');
        System.assertEquals(b.Outdoor_Number,'4');             
        System.assertEquals(b.Interior_Number,'10');
        System.assertEquals(b.County,'El charco');
        System.assertEquals(b.Municipality,'ecatepec');
        System.assertEquals(b.Country,'mexico');
        System.assertEquals(b.City,'mexico');
        System.assertEquals(b.Zip_Code,'55404');
        System.assertEquals(b.State,'Edo mex');
        System.assertEquals(b.Status,'mexico');
        System.assertEquals(b.Purpose,'credic contact');
        System.assertEquals(b.party_ID,'22');
        System.assertEquals(b.Source_Created_by,'prueba uno');
        System.assertEquals(b.Source_Updated_by,'prueba dos');
        System.assertEquals(b.Source_Application_Id,'35');
        System.assertEquals(b.Source_Create_Date, date.today());
        System.assertEquals(b.Source_Last_Update_Date, date.today());
        System.assertEquals(b.Oracle_Created_by,'sebas');
        System.assertEquals(b.Oracle_Updated_by,'dany');
        System.assertEquals(b.Oracle_Create_Date, date.today());
        System.assertEquals(b.Oracle_Last_Update_Date, date.today());
        System.assertEquals(b.PostalCodeId,'6');
        System.assertEquals(b.EntityPartyId,'7');
        System.assertEquals(b.s_397,'55');
        System.assertEquals(b.s_789,'77');
        System.assertEquals(b.xa7,'66');
        System.assertEquals(b.s1u,'88');
        //public string custAccountID              {get;set;}
        System.assertEquals(b.addressReference,'casa azul');
        System.assertEquals(b.addressLinesPhonetic,'tests');
        System.assertEquals(b.normalizedAddress,'sdscvfdfv');
        
    }
     @isTest static void setTestbotones(){
        EIV_PrivilegesWrapClass a = new EIV_PrivilegesWrapClass();
        
        a.sso='12';
        a.applicationName='chona';   
        a.applicationCode='56';
        a.screen='78';
        a.section='2';
        a.employeeName='2';
        a.screenType='3';
        a.vCrud='true';
        /*
•	V -> Visible 
•	C -> Create
•	R -> Read
•	U -> Update
•	D -> Delete
*/
        a.bVisible='V';
        a.bCreate='C';
        a.bRead='R';
        a.bUpdate='U';
        a.bDelete='D';
        
       // public String getvCrud() {
        //    return vCrud;
        //}
        
        a.setvCrud('');
        a.getvCrud();
        
                
    }
    @isTest static void setTestbotonesno(){
        EIV_PrivilegesWrapClass a = new EIV_PrivilegesWrapClass();
        
        a.sso='12';
        a.applicationName='chono';   
        a.applicationCode='56';
        a.screen='78';
        a.section='2';
        a.employeeName='2';
        a.screenType='3';
        a.vCrud='false';
        /*-
•	V -> Visible 
•	C -> Create
•	R -> Read
•	U -> Update
•	D -> Delete
*/
        a.bVisible='h';
        a.bCreate='t';
        a.bRead='3';
        a.bUpdate='e';
        a.bDelete='d';
        
       // public String getvCrud() {
        //    return vCrud;
        //}
        
        a.setvCrud('0000');
        a.getvCrud();
        
                
    }
    
    @istest static void setTestdetai(){
        EIV_DetailWrapClass d = new EIV_DetailWrapClass();
        
        d.sDate='';
        d.status='';
        d.errorCode='';
        d.description='';
        d.message='';    		
        
    }
    
    @isTest static void setTestentityselec(){
        EIV_EntitySelectTypeClass s = new EIV_EntitySelectTypeClass();
         //Id de la entidad seleccionada y variables de la cuenta
    s.sAccountId='23';
    s.sAccountName='chona';
    s.sTopParentId='33';
    s.sTopParentName='la';
    s.sPartyId='44';
    s.sTargetMarket='gfd';

    
    //Variable del tipo de entidad seleccionado
    s.s = 'Individual';

        
        s.getString();
        s.setString('qq');
        S.NewEntity();
        S.Cancel();
    }
    
    
    
}