@Istest
public class Data_Factory_TakedownInvoice_Test {
    public static Takedown_Invoice__c createTakedownInvoice(string fileExtension){
        
        //Crea TkedowngetContentDocumentId
        //
        Takedowns_Contingency_plan__c takedown = Data_Factory_Takedown_Test.createTakedown('AFINAN-FIJA', 'FISHERS', 'FISH1092');
        ContentVersion contentVersionInsert = new ContentVersion();
        contentVersionInsert.ContentLocation ='S';
        contentVersionInsert.Title ='TEST';
        contentVersionInsert.PathOnClient ='TEST.PDF';
        contentVersionInsert.VersionData = Blob.valueOf('Test content Data');
        contentVersionInsert.IsMajorVersion = true;
        //Crea contentversion
        insert contentVersionInsert;
         
        ContentVersion testContent = [SELECT id, ContentDocumentId, ContentLocation, Title,PathOnClient,VersionData,IsMajorVersion,FileExtension   FROM ContentVersion where Id =:contentVersionInsert.Id][0];
        system.debug('contentId:' + testContent.Id);
        ContentDocumentLink contentlink = new ContentDocumentLink();
        contentlink.LinkedEntityId = takedown.Id;
        contentlink.ShareType ='V';
        contentlink.ContentDocumentId = testContent.ContentDocumentId;
        //ligar el documento al takedown
        insert contentlink;
        
        //Crear takedown Invoice
        Takedown_Invoice__c  invoice =new Takedown_Invoice__c();
        invoice.TKD_txt_Content_Version_ID__c = testContent.Id;
        invoice.TKD_txt_Extension__c =fileExtension;
        invoice.TKD_pd_Takedown_CP__c = takedown.Id;
        invoice.Name = testContent.Title;
        invoice.TKD_txt_Document_ID__c = testContent.ContentDocumentId;
        invoice.TKD_ls_SAT_Status__c =Takedown_Invoices_cls.getDocumentStatus(fileExtension);
        invoice.TKD_ls_Eng_Status__c =Takedown_Invoices_cls.getDocumentStatus(fileExtension);
        insert invoice;
        return invoice;
    }
    
    public static Takedown_Invoice__c createTakedownInvoiceNoBugOP(string fileExtension, string productType, string entityCPName, string entityCPRFCTIN){
        
        //Crea TkedowngetContentDocumentId
        //
        
        Takedowns_Contingency_plan__c takedown = Data_Factory_Takedown_Test.createTakedownNowkoppStart(productType, entityCPName, entityCPRFCTIN);
        ContentVersion contentVersionInsert = new ContentVersion();
        contentVersionInsert.ContentLocation ='S';
        contentVersionInsert.Title ='TEST';
        contentVersionInsert.PathOnClient ='TEST.PDF';
        contentVersionInsert.VersionData = Blob.valueOf('Test content Data');
        contentVersionInsert.IsMajorVersion = true;
        //Crea contentversion
        insert contentVersionInsert;
        
        ContentVersion testContent = [SELECT id, ContentDocumentId, ContentLocation, Title,PathOnClient,VersionData,IsMajorVersion,FileExtension   FROM ContentVersion where Id =:contentVersionInsert.Id][0];
        system.debug('contentId:' + testContent.Id);
        ContentDocumentLink contentlink = new ContentDocumentLink();
        contentlink.LinkedEntityId = takedown.Id;
        contentlink.ShareType ='V';
        contentlink.ContentDocumentId = testContent.ContentDocumentId;
        //ligar el documento al takedown
        insert contentlink;
        
        //Crear takedown Invoice
        Takedown_Invoice__c  invoice =new Takedown_Invoice__c();
        invoice.TKD_txt_Content_Version_ID__c = testContent.Id;
        invoice.TKD_txt_Extension__c =fileExtension;
        invoice.TKD_pd_Takedown_CP__c = takedown.Id;
        invoice.Name = testContent.Title;
        invoice.TKD_txt_Document_ID__c = testContent.ContentDocumentId;
        invoice.TKD_ls_SAT_Status__c =Takedown_Invoices_cls.getDocumentStatus(fileExtension);
        invoice.TKD_ls_Eng_Status__c =Takedown_Invoices_cls.getDocumentStatus(fileExtension);
        insert invoice;
        return invoice;
        
    }
    
    
    public static Takedown_Invoice__c createTakedownInvoiceToValidation(string fileExtension){
        
        //Crea Tkedown
        Takedowns_Contingency_plan__c takedown = Data_Factory_Takedown_Test.createTakedownToValidateInvoices('AFINAN-FIJA', 'FISHERS', 'FISH1092');
        ContentVersion contentVersionInsert = new ContentVersion();
        contentVersionInsert.ContentLocation ='S';
        contentVersionInsert.Title ='TEST';
        contentVersionInsert.PathOnClient ='TEST.PDF';
        contentVersionInsert.VersionData = Blob.valueOf('Test content Data');
        contentVersionInsert.IsMajorVersion = true;
        //Crea contentversion
        insert contentVersionInsert;
        	test.startTest();
        ContentVersion testContent = [SELECT id, ContentDocumentId, ContentLocation, Title,PathOnClient,VersionData,IsMajorVersion,FileExtension   FROM ContentVersion where Id =:contentVersionInsert.Id][0];
        system.debug('contentId:' + testContent.Id);
        ContentDocumentLink contentlink = new ContentDocumentLink();
        contentlink.LinkedEntityId = takedown.Id;
        contentlink.ShareType ='V';
        contentlink.ContentDocumentId = testContent.ContentDocumentId;
        //ligar el documento al takedown
        insert contentlink;
        
        //Crear takedown Invoice
        Takedown_Invoice__c  invoice =new Takedown_Invoice__c();
        invoice.TKD_txt_Content_Version_ID__c = testContent.Id;
        invoice.TKD_txt_Extension__c =fileExtension;
        invoice.TKD_pd_Takedown_CP__c = takedown.Id;
        invoice.Name = testContent.Title;
        invoice.TKD_txt_Document_ID__c = testContent.ContentDocumentId;
        invoice.TKD_ls_SAT_Status__c =Takedown_Invoices_cls.getDocumentStatus(fileExtension);
        invoice.TKD_ls_Eng_Status__c =Takedown_Invoices_cls.getDocumentStatus(fileExtension);
        insert invoice;
        
        test.stopTest();
        return invoice;
    }
    public static Takedown_Invoice__c createOpportunityInvoice(string fileExtension){
        
        //Crea Tkedown
        Takedowns_Contingency_plan__c takedown = Data_Factory_Takedown_Test.createTakedown('AFINAN-FIJA', 'FISHERS', 'FISH1092');
        ContentVersion contentVersionInsert = new ContentVersion();
        contentVersionInsert.ContentLocation ='S';
        contentVersionInsert.Title ='TEST';
        contentVersionInsert.PathOnClient ='TEST..pdf';
        contentVersionInsert.VersionData = Blob.valueOf('Test content Data');
        contentVersionInsert.IsMajorVersion = true;
        contentVersionInsert.FirstPublishLocationId = takedown.CPL_rb_Opp__c;
        //Crea contentversion
        insert contentVersionInsert;
        
        ContentVersion testContent = [SELECT id, ContentDocumentId, ContentLocation, Title,PathOnClient,VersionData,IsMajorVersion,FileExtension   FROM ContentVersion where Id =:contentVersionInsert.Id][0];
        system.debug('contentId:' + testContent.Id);
        ContentDocumentLink contentlink = new ContentDocumentLink();
        contentlink.ShareType ='V';
        contentlink.LinkedEntityId = takedown.Id;
        contentlink.ContentDocumentId = testContent.ContentDocumentId;
        //ligar el documento al takedown
        insert contentlink;
        
        //Crear takedown Invoice
        Takedown_Invoice__c  invoice =new Takedown_Invoice__c();
        invoice.TKD_txt_Content_Version_ID__c = testContent.Id;
        invoice.TKD_txt_Extension__c =fileExtension;
        invoice.TKD_pd_Takedown_CP__c = takedown.Id;
        invoice.Name = testContent.Title;
        invoice.TKD_txt_Document_ID__c = testContent.ContentDocumentId;
        invoice.TKD_ls_SAT_Status__c =Takedown_Invoices_cls.getDocumentStatus(fileExtension);
        invoice.TKD_ls_Eng_Status__c =Takedown_Invoices_cls.getDocumentStatus(fileExtension);
        insert invoice;
        return invoice;
    }
    
    public static Takedowns_Contingency_plan__c getTakedownWhitInvoice(string fileExtension){
        
        //Crea Tkedown
        Takedowns_Contingency_plan__c takedown = Data_Factory_Takedown_Test.createTakedown('AFINAN-FIJA', 'FISHERS', 'FISH1092');
        ContentVersion contentVersionInsert = new ContentVersion();
        contentVersionInsert.ContentLocation ='S';
        contentVersionInsert.Title ='TEST';
        contentVersionInsert.PathOnClient ='TEST.PDF';
        contentVersionInsert.VersionData = Blob.valueOf('Test content Data');
        contentVersionInsert.IsMajorVersion = true;
        //Crea contentversion
        insert contentVersionInsert;
        
        ContentVersion testContent = [SELECT id, ContentDocumentId, ContentLocation, Title,PathOnClient,VersionData,IsMajorVersion,FileExtension   FROM ContentVersion where Id =:contentVersionInsert.Id][0];
        system.debug('contentId:' + testContent.Id);
        ContentDocumentLink contentlink = new ContentDocumentLink();
        contentlink.LinkedEntityId = takedown.Id;
        contentlink.ShareType ='V';
        contentlink.ContentDocumentId = testContent.ContentDocumentId;
        //ligar el documento al takedown
        insert contentlink;
        
        //Crear takedown Invoice
        Takedown_Invoice__c  invoice =new Takedown_Invoice__c();
        invoice.TKD_txt_Content_Version_ID__c = testContent.Id;
        invoice.TKD_txt_Extension__c =fileExtension;
        invoice.TKD_pd_Takedown_CP__c = takedown.Id;
        invoice.Name = testContent.Title;
        invoice.TKD_txt_Document_ID__c = testContent.ContentDocumentId;
        invoice.TKD_ls_SAT_Status__c =Takedown_Invoices_cls.getDocumentStatus(fileExtension);
        invoice.TKD_ls_Eng_Status__c =Takedown_Invoices_cls.getDocumentStatus(fileExtension);
        insert invoice;
        return takedown;
    }
    
    
     public static Id getContentDocumentId(string fileExtension){
        
        //Crea Tkedown
        Takedowns_Contingency_plan__c takedown = Data_Factory_Takedown_Test.createTakedown('AFINAN-FIJA', 'FISHERS', 'FISH1092');
        ContentVersion contentVersionInsert = new ContentVersion();
        contentVersionInsert.ContentLocation ='S';
        contentVersionInsert.Title ='TEST';
        contentVersionInsert.PathOnClient ='TEST.PDF';
        contentVersionInsert.VersionData = Blob.valueOf('Test content Data');
        contentVersionInsert.IsMajorVersion = true;
        //Crea contentversion
        insert contentVersionInsert;
        
        ContentVersion testContent = [SELECT id, ContentDocumentId, ContentLocation, Title,PathOnClient,VersionData,IsMajorVersion,FileExtension   FROM ContentVersion where Id =:contentVersionInsert.Id][0];
        system.debug('contentId:' + testContent.Id);
        ContentDocumentLink contentlink = new ContentDocumentLink();
        contentlink.LinkedEntityId = takedown.Id;
        contentlink.ShareType ='V';
        contentlink.ContentDocumentId = testContent.ContentDocumentId;
        //ligar el documento al takedown
        insert contentlink;
        system.debug('el aidi: ' + testContent.ContentDocumentId);
        return testContent.ContentDocumentId;
    }
    
    public static Takedowns_Contingency_plan__c createTakeDownEval(){
        Takedowns_Contingency_plan__c takedown = Data_Factory_Takedown_Test.createTakedown('AFINAN-FIJA', 'FISHERS', 'FISH1092');
        return takedown;
    }
    
    public static Id createAsset(Id idAccount, Id idColateral, Id idTakedown) {
        Asset asset = new Asset();
        asset.Name = 'CROMATOGRAFO DE LIQUIDO';
        asset.Description = 'Descipción de activo';
        asset.TKD_tx_Model__c = 'ALLIANCE E2695';
        asset.TKD_tx_model_year__c = '2020';
        asset.TKD_tx_brand__c = 'WATERS';
        asset.SerialNumber = 'G19SM4993A';
        asset.TKD_ck_active__c = true;
        
        asset.AccountId = idAccount;
        asset.TKD_rb_collateral__c = idColateral;
        asset.TKD_rb_Takedown_CP__c = idTakedown;
        
        asset.Quantity = 1;
        asset.TDK_dv_Unit_cost__c = 1000000;
        asset.TKD_dv_total_cost__c = 1000000;
        asset.CurrencyIsoCode = 'USD';
        insert asset;
        
        return asset.Id;
    }
    
    public static Id createCollaterals(){
		Catalogo_Colaterals__c collateral = new Catalogo_Colaterals__c();
        collateral.COLATERAL_DESCRIPTION__c = 'TRAILER - DRY VAN';
        collateral.COLATERAL_TYPE__c = 'TRANSPORTATION - TRAILER';
        collateral.CURRENCYISOCODE = 'USD';
        collateral.MANUFACTURER__c = 'UTILITY';
        collateral.MODEL_YEAR__c = '2019';
        collateral.MODEL__c = 'Caja Seca - 53 Pies';
        collateral.NAME = 'a2w1R0000001fSy';
        collateral.ORACLE_FA_CATEGORY_ID__C = '336';
        insert collateral;
        
        return collateral.Id;
    }
    
    public static Id createAccount(/*Id sicCode*/) {
        Account account = new Account();
        account.Name = 'Prueba comercial';
        account.BillingStreet = 'Example';
        account.BillingCountry = 'México';
        account.BillingState = 'Puebla';
        account.BillingPostalCode = '80790';
        //account.ACC_rb_SIC_Code__c = sicCode;
        insert account;
        
        return account.Id;
    }
}