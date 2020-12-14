@istest
private class EIV_EntityWrapClassTest {
    
    @istest
    static void EIV_EntityWrapTest(){
        string sNombre = 'Aaron';
        
        EIV_EntityWrapClass oEntity = new EIV_EntityWrapClass();
        oEntity.entityName = sNombre;
        oEntity.Customer_Name = sNombre;
        oEntity.Customer_Alias = sNombre;
        oEntity.Customer_Type = sNombre;
        oEntity.Customer_Status = sNombre;
        oEntity.Cust_AccountId = sNombre;
        oEntity.Top_Parent_ID = sNombre;
        oEntity.Top_Parent_Name = sNombre;
        oEntity.Account_ID = sNombre;
        oEntity.SF_Account_Name = sNombre;
        oEntity.RFC = sNombre;
        oEntity.TIN = sNombre;    
        oEntity.Economic_Group_ID = sNombre;
        oEntity.Economic_Group_Name = sNombre;
        oEntity.EconomicGroupPartyId = sNombre;
        oEntity.Limited_information_entity = true;
        oEntity.Tax_Regime = sNombre;
        oEntity.Foreign_Entity = sNombre;
        oEntity.Nationality = sNombre;
        oEntity.Oracle_Account_Number = sNombre;
        oEntity.CURP = sNombre;
        oEntity.Prefix = sNombre;
        oEntity.First_Name = sNombre;
        oEntity.Middle_Name = sNombre;
        oEntity.First_Last_Name = sNombre;
        oEntity.Second_Last_Name = sNombre;
        oEntity.Sales_Representative = sNombre;
        oEntity.Supplier_Flag = sNombre;
        oEntity.Legal_Name_sin_denominacion = sNombre;
        oEntity.Company_Legal_Name_termination = sNombre;
        oEntity.Oracle_Account_Name = sNombre;
        oEntity.Source_Created_by = sNombre;
        oEntity.Source_Updated_by = sNombre;
        oEntity.Source_Application_ID = sNombre;
        oEntity.Source_Create_Date = date.today();
        oEntity.Source_Last_Update_Date = date.today();
        oEntity.Oracle_Created_by = sNombre;
        oEntity.Oracle_Updated_by = sNombre;
        oEntity.Oracle_Create_Date = date.today();
        oEntity.Oracle_Last_Update_Date = date.today();
        oEntity.Target_Market_Jurisdiction = sNombre;
        oEntity.CRR = sNombre;
        oEntity.CRR_Override = sNombre;
        oEntity.CRR_Comments = sNombre;
        oEntity.Entity_Type = sNombre;
        oEntity.MRA_ID = sNombre;
        oEntity.Bloomberg_ID = sNombre;
        oEntity.HNWI_ID = sNombre;
        oEntity.orRating = sNombre;
        oEntity.riskClassification = sNombre;
        oEntity.transactionDate = sNombre;
        //Agregadas para SicCode
        oEntity.SIC_Code = sNombre;
        oEntity.SIC_Description = sNombre;
        oEntity.Economic_group_SIC_Code = sNombre;
        oEntity.Economic_Group_SIC_Description = sNombre;  
        //Agregadas y que faltan en el esquema
        oEntity.Party_Id = sNombre;
        oEntity.SIC_CodeId = sNombre;
        oEntity.SIC_CodeIndustry = sNombre;
        oEntity.Economic_group_SIC_CodeId = sNombre;
        oEntity.foreingn_TAX_ID = sNombre;
        //variable para el manejo del formato correspondiente
        oEntity.vfSNameEdit = sNombre;
        oEntity.vfSNameRead = sNombre;
        //Agregadas para buro
        oEntity.buroFlag = sNombre;
    }
}