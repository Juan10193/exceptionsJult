public class Data_Access_EntityCP {
    public static list<Entity_CP__c> getEntityCPbyRFCTIN(string rfcTIN){
            list<Entity_CP__c> entitycp = [SELECT Id, OwnerId, IsDeleted, Name, CurrencyIsoCode, CreatedDate, 
                                 CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, 
                                 LastActivityDate, LastViewedDate, LastReferencedDate, CPL_rb_Cuenta__c, 
                                 CPL_tx_Account_Number__c, CLI_txt_CRR_Comments__c, CPI_fm_REGIMEN_FISCAL__c,
                                 CPI_fm_SIC_Code_Description__c, CPI_fm_Target_Market_Jurisdiction__c, 
                                 CPI_fm_VENDEDOR_EN_PRODUCCI_N__c, CPI_ls_CRR_Override__c, CPI_ls_Delinquency_Bureau__c, 
                                 CPI_ls_EXTRANJERO_Y_N__c, CPI_ls_SUPPLIER_FLAG__c, CPI_ls_TIPO_DE_CLIENTE__c, 
                                 CPI_nu_Economic_Group__c, CPI_rb_OR_Override__c, CPI_rb_OR_rating__c, 
                                 CPI_rb_SIC_Code_Actividad_econ_mica__c, CPI_tx_ACTIVIDAD_ECONOMICA__c, 
                                 CPI_tx_ALIAS_BURO_DE_CREDITO__c, CPI_tx_APELLIDO_MATERNO_PERSONAS_F_SICAS__c, 
                                 CPI_tx_APELLIDO_PATERNO_PERSONAS_F_SICAS__c, CPI_tx_CLABE_INTERBANCARIA_Cliente__c, 
                                 CPI_tx_CLABE_INTERBANCARIA_ENGENIUM__c, CPI_tx_CLAVE_CONSOLIDACION__c, CPI_tx_CRR__c, 
                                 CPI_tx_CUENTA_DE_PAGO__c, CPI_tx_METODO_DE_PAGO__c, CPI_tx_NOMBRE_DEL_CLIENTE__c, 
                                 CPI_tx_OR_ID__c, CPI_tx_OR_Rating__c, CPI_tx_PRIMER_NOMBRE_Personas_F_sicas__c, 
                                 CPI_tx_RFC_TIN__c, CPI_tx_Risk_Classification__c, CPI_tx_SEGUNDOS_NOMBRES_PERSONAS_FSICAS__c,
                                 CPI_tx_Tipo_de_Entidad__c, Certified_Supplier__c, Bank_Account_MXN__c, Bank_Account_USD__c, 
                                 Bank_Account_Other__c, Call_Back_Contacts_Status__c, Supplier_Type_Of_Service__c, 
                                 Supplier_Type__c, True_Lease_Contract__c, Supplier_Tax_Retention__c, Country__c, 
                                 Mexican_State__c, Street__c, Exterior_Number__c, Interior_Number__c, City__c, 
                                 Neighborhood__c, Foreingn_State__c, ZIP_Code__c, Operation_Unit__c, VAT_Type__c, 
                                 AP_Contact_First_Name__c, AP_Contact_Last_Name__c, AP_Contact_Email__c, 
                                 Digital_Registration_Response_Link__c, Virtual_Account397__c, Virtual_Account798__c, 
                                 Virtual_AccountXA7__c, X397_CLABE__c, X798_CLABE__c, XA7_CLABE__c, EM_Party_ID__c, 
                                 EM_Economic_Group_ID__c, EM_Top_Parent_ID__c,
                                 Virtual_Account397__r.Bank__c, Virtual_Account397__r.CLABE__c, Virtual_Account397__r.CreatedById,
                                 Virtual_Account397__r.CurrencyIsoCode, Virtual_Account397__r.Engeniun_Legal_Entity__c, Virtual_Account397__r.Entity_CP_id__c,
                                 Virtual_Account397__r.Entity_CP_Name__c, Virtual_Account397__r.LastModifiedById, Virtual_Account397__r.OwnerId,
                                 Virtual_Account397__r.Name,
                                 Virtual_Account798__r.Bank__c, Virtual_Account798__r.CLABE__c, Virtual_Account798__r.CreatedById,
                                 Virtual_Account798__r.CurrencyIsoCode, Virtual_Account798__r.Engeniun_Legal_Entity__c, Virtual_Account798__r.Entity_CP_id__c,
                                 Virtual_Account798__r.Entity_CP_Name__c, Virtual_Account798__r.LastModifiedById, Virtual_Account798__r.OwnerId,
                                 Virtual_Account798__r.Name,
                                 Virtual_AccountXA7__r.Bank__c, Virtual_AccountXA7__r.CLABE__c, Virtual_AccountXA7__r.CreatedById,
                                 Virtual_AccountXA7__r.CurrencyIsoCode, Virtual_AccountXA7__r.Engeniun_Legal_Entity__c, Virtual_AccountXA7__r.Entity_CP_id__c,
                                 Virtual_AccountXA7__r.Entity_CP_Name__c, Virtual_AccountXA7__r.LastModifiedById, Virtual_AccountXA7__r.OwnerId,
                                 Virtual_AccountXA7__r.Name
                                           FROM Entity_CP__c where CPI_tx_RFC_TIN__c =:rfcTIN];
        
        return entitycp;
       
    }
    
    public static list<Entity_CP__c> getEntityCPbyPartyId(string partyId){
            list<Entity_CP__c> entitycp = [SELECT Id, OwnerId, IsDeleted, Name, CurrencyIsoCode, CreatedDate, 
                                 CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, 
                                 LastActivityDate, LastViewedDate, LastReferencedDate, CPL_rb_Cuenta__c, 
                                 CPL_tx_Account_Number__c, CLI_txt_CRR_Comments__c, CPI_fm_REGIMEN_FISCAL__c,
                                 CPI_fm_SIC_Code_Description__c, CPI_fm_Target_Market_Jurisdiction__c, 
                                 CPI_fm_VENDEDOR_EN_PRODUCCI_N__c, CPI_ls_CRR_Override__c, CPI_ls_Delinquency_Bureau__c, 
                                 CPI_ls_EXTRANJERO_Y_N__c, CPI_ls_SUPPLIER_FLAG__c, CPI_ls_TIPO_DE_CLIENTE__c, 
                                 CPI_nu_Economic_Group__c, CPI_rb_OR_Override__c, CPI_rb_OR_rating__c, 
                                 CPI_rb_SIC_Code_Actividad_econ_mica__c, CPI_tx_ACTIVIDAD_ECONOMICA__c, 
                                 CPI_tx_ALIAS_BURO_DE_CREDITO__c, CPI_tx_APELLIDO_MATERNO_PERSONAS_F_SICAS__c, 
                                 CPI_tx_APELLIDO_PATERNO_PERSONAS_F_SICAS__c, CPI_tx_CLABE_INTERBANCARIA_Cliente__c, 
                                 CPI_tx_CLABE_INTERBANCARIA_ENGENIUM__c, CPI_tx_CLAVE_CONSOLIDACION__c, CPI_tx_CRR__c, 
                                 CPI_tx_CUENTA_DE_PAGO__c, CPI_tx_METODO_DE_PAGO__c, CPI_tx_NOMBRE_DEL_CLIENTE__c, 
                                 CPI_tx_OR_ID__c, CPI_tx_OR_Rating__c, CPI_tx_PRIMER_NOMBRE_Personas_F_sicas__c, 
                                 CPI_tx_RFC_TIN__c, CPI_tx_Risk_Classification__c, CPI_tx_SEGUNDOS_NOMBRES_PERSONAS_FSICAS__c,
                                 CPI_tx_Tipo_de_Entidad__c, Certified_Supplier__c, Bank_Account_MXN__c, Bank_Account_USD__c, 
                                 Bank_Account_Other__c, Call_Back_Contacts_Status__c, Supplier_Type_Of_Service__c, 
                                 Supplier_Type__c, True_Lease_Contract__c, Supplier_Tax_Retention__c, Country__c, 
                                 Mexican_State__c, Street__c, Exterior_Number__c, Interior_Number__c, City__c, 
                                 Neighborhood__c, Foreingn_State__c, ZIP_Code__c, Operation_Unit__c, VAT_Type__c, 
                                 AP_Contact_First_Name__c, AP_Contact_Last_Name__c, AP_Contact_Email__c, 
                                 Digital_Registration_Response_Link__c, Virtual_Account397__c, Virtual_Account798__c, 
                                 Virtual_AccountXA7__c, X397_CLABE__c, X798_CLABE__c, XA7_CLABE__c, EM_Party_ID__c, 
                                 EM_Economic_Group_ID__c, EM_Top_Parent_ID__c FROM Entity_CP__c where EM_Party_ID__c =:partyId];
        
        return entitycp;
       
    }
    
    
    public static list<Entity_CP__c> getEntityCPbyRecordId(string entityCPId){
            list<Entity_CP__c> entitycp = [SELECT Id, OwnerId, IsDeleted, Name, CurrencyIsoCode, CreatedDate, 
                                 CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, 
                                 LastActivityDate, LastViewedDate, LastReferencedDate, CPL_rb_Cuenta__c, 
                                 CPL_tx_Account_Number__c, CLI_txt_CRR_Comments__c, CPI_fm_REGIMEN_FISCAL__c,
                                 CPI_fm_SIC_Code_Description__c, CPI_fm_Target_Market_Jurisdiction__c, 
                                 CPI_fm_VENDEDOR_EN_PRODUCCI_N__c, CPI_ls_CRR_Override__c, CPI_ls_Delinquency_Bureau__c, 
                                 CPI_ls_EXTRANJERO_Y_N__c, CPI_ls_SUPPLIER_FLAG__c, CPI_ls_TIPO_DE_CLIENTE__c, 
                                 CPI_nu_Economic_Group__c, CPI_rb_OR_Override__c, CPI_rb_OR_rating__c, 
                                 CPI_rb_SIC_Code_Actividad_econ_mica__c, CPI_tx_ACTIVIDAD_ECONOMICA__c, 
                                 CPI_tx_ALIAS_BURO_DE_CREDITO__c, CPI_tx_APELLIDO_MATERNO_PERSONAS_F_SICAS__c, 
                                 CPI_tx_APELLIDO_PATERNO_PERSONAS_F_SICAS__c, CPI_tx_CLABE_INTERBANCARIA_Cliente__c, 
                                 CPI_tx_CLABE_INTERBANCARIA_ENGENIUM__c, CPI_tx_CLAVE_CONSOLIDACION__c, CPI_tx_CRR__c, 
                                 CPI_tx_CUENTA_DE_PAGO__c, CPI_tx_METODO_DE_PAGO__c, CPI_tx_NOMBRE_DEL_CLIENTE__c, 
                                 CPI_tx_OR_ID__c, CPI_tx_OR_Rating__c, CPI_tx_PRIMER_NOMBRE_Personas_F_sicas__c, 
                                 CPI_tx_RFC_TIN__c, CPI_tx_Risk_Classification__c, CPI_tx_SEGUNDOS_NOMBRES_PERSONAS_FSICAS__c,
                                 CPI_tx_Tipo_de_Entidad__c, Certified_Supplier__c, Bank_Account_MXN__c, Bank_Account_USD__c, 
                                 Bank_Account_Other__c, Call_Back_Contacts_Status__c, Supplier_Type_Of_Service__c, 
                                 Supplier_Type__c, True_Lease_Contract__c, Supplier_Tax_Retention__c, Country__c, 
                                 Mexican_State__c, Street__c, Exterior_Number__c, Interior_Number__c, City__c, 
                                 Neighborhood__c, Foreingn_State__c, ZIP_Code__c, Operation_Unit__c, VAT_Type__c, 
                                 AP_Contact_First_Name__c, AP_Contact_Last_Name__c, AP_Contact_Email__c, 
                                 Digital_Registration_Response_Link__c, Virtual_Account397__c, Virtual_Account798__c, 
                                 Virtual_AccountXA7__c, X397_CLABE__c, X798_CLABE__c, XA7_CLABE__c, EM_Party_ID__c, 
                                 EM_Economic_Group_ID__c, EM_Top_Parent_ID__c FROM Entity_CP__c where Id =:entityCPId];
        
        return entitycp;
       
    }
    
    /*public static list<Entity_CP__c> getEntityCPbyName(list<string> name){
            list<Entity_CP__c> entitycp = [SELECT Id, OwnerId, IsDeleted, Name, CurrencyIsoCode, CreatedDate, 
                                 CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, 
                                 LastActivityDate, LastViewedDate, LastReferencedDate, CPL_rb_Cuenta__c, 
                                 CPL_tx_Account_Number__c, CLI_txt_CRR_Comments__c, CPI_fm_REGIMEN_FISCAL__c,
                                 CPI_fm_SIC_Code_Description__c, CPI_fm_Target_Market_Jurisdiction__c, 
                                 CPI_fm_VENDEDOR_EN_PRODUCCI_N__c, CPI_ls_CRR_Override__c, CPI_ls_Delinquency_Bureau__c, 
                                 CPI_ls_EXTRANJERO_Y_N__c, CPI_ls_SUPPLIER_FLAG__c, CPI_ls_TIPO_DE_CLIENTE__c, 
                                 CPI_nu_Economic_Group__c, CPI_rb_OR_Override__c, CPI_rb_OR_rating__c, 
                                 CPI_rb_SIC_Code_Actividad_econ_mica__c, CPI_tx_ACTIVIDAD_ECONOMICA__c, 
                                 CPI_tx_ALIAS_BURO_DE_CREDITO__c, CPI_tx_APELLIDO_MATERNO_PERSONAS_F_SICAS__c, 
                                 CPI_tx_APELLIDO_PATERNO_PERSONAS_F_SICAS__c, CPI_tx_CLABE_INTERBANCARIA_Cliente__c, 
                                 CPI_tx_CLABE_INTERBANCARIA_ENGENIUM__c, CPI_tx_CLAVE_CONSOLIDACION__c, CPI_tx_CRR__c, 
                                 CPI_tx_CUENTA_DE_PAGO__c, CPI_tx_METODO_DE_PAGO__c, CPI_tx_NOMBRE_DEL_CLIENTE__c, 
                                 CPI_tx_OR_ID__c, CPI_tx_OR_Rating__c, CPI_tx_PRIMER_NOMBRE_Personas_F_sicas__c, 
                                 CPI_tx_RFC_TIN__c, CPI_tx_Risk_Classification__c, CPI_tx_SEGUNDOS_NOMBRES_PERSONAS_FSICAS__c,
                                 CPI_tx_Tipo_de_Entidad__c, Certified_Supplier__c, Bank_Account_MXN__c, Bank_Account_USD__c, 
                                 Bank_Account_Other__c, Call_Back_Contacts_Status__c, Supplier_Type_Of_Service__c, 
                                 Supplier_Type__c, True_Lease_Contract__c, Supplier_Tax_Retention__c, Country__c, 
                                 Mexican_State__c, Street__c, Exterior_Number__c, Interior_Number__c, City__c, 
                                 Neighborhood__c, Foreingn_State__c, ZIP_Code__c, Operation_Unit__c, VAT_Type__c, 
                                 AP_Contact_First_Name__c, AP_Contact_Last_Name__c, AP_Contact_Email__c, 
                                 Digital_Registration_Response_Link__c, Virtual_Account397__c, Virtual_Account798__c, 
                                 Virtual_AccountXA7__c, X397_CLABE__c, X798_CLABE__c, XA7_CLABE__c, EM_Party_ID__c, 
                                 EM_Economic_Group_ID__c, EM_Top_Parent_ID__c FROM Entity_CP__c where name in:name];
        
        return entitycp;
       
    }*/
}