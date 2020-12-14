@istest
public class takedownTableDocumentsController_test {
    /*@istest
    static void getDocumentList(){
        
        EIV_Parameter__c parameters = new EIV_Parameter__c();
        parameters.name = 'fecha limite';
        parameters.EIV_tx_parameter__c = '2019-01-01';
        insert parameters;
        parameters = new EIV_Parameter__c(Name='PP_Limite_min',
                                     EIV_tx_parameter__c='2.0');
            insert parameters;
            
            
            parameters = new EIV_Parameter__c(Name='PP_Limite_max',
                                     EIV_tx_parameter__c='5.0');
            insert parameters;
        List<takedownTableDocumentsWrapper_cls.TableElement> listTableElement = new List<takedownTableDocumentsWrapper_cls.TableElement>();
    	takedownTableDocumentsWrapper_cls.TableElement tableElement = new takedownTableDocumentsWrapper_cls.TableElement();
        Takedown_Invoice__c tkd_invoice = Data_Factory_TakedownInvoice_Test.createTakedownInvoice('xml');
        list<string> listFilterDocType = new list<string>();
        listFilterDocType.add('xml');
        Takedowns_Contingency_plan__c cp = [SELECT Id, Name, CPL_rb_Opp__c FROM Takedowns_Contingency_plan__c where id= :tkd_invoice.TKD_pd_Takedown_CP__c];
        Opportunity op = [SELECT Id, Name FROM Opportunity where id = :cp.CPL_rb_Opp__c];
        Data_Factory_Progress_Payment_Test.createProgressPayment(cp.Id, op.Id);
        cp.other_amount__c =2.1;
        cp.CLI_rb_Inside_Sales_Owner__c = system.UserInfo.getUserId();
        update cp;
        //takedownTableDocumentsController_cls.getDocumentList(tkd_invoice.id, listFilterDocType);
        IST__SuperTRUMP_Template__c template = TestDataFactory_tst.createSTPricingTemplate();
        IST__SuperTRUMP_Pricing_Quote__c Pricing_Quote = TestDataFactory_tst.createSTPricingQuote(op,template);
        Pricing_Quote.IST__Commencement__c = date.valueOf('2018-11-03');
        update Pricing_Quote;
    }*/
   /* @istest
    static void validateInvoices(){
        
		
        EIV_Parameter__c parameters = new EIV_Parameter__c();
        parameters.name = 'fecha limite';
        parameters.EIV_tx_parameter__c = '01/12/2018';
        insert parameters;
        List<takedownTableDocumentsWrapper_cls.TableElement> listTableElement = new List<takedownTableDocumentsWrapper_cls.TableElement>();
    	takedownTableDocumentsWrapper_cls.TableElement tableElement = new takedownTableDocumentsWrapper_cls.TableElement();
        Takedown_Invoice__c tkd_invoice = Data_Factory_TakedownInvoice_Test.createTakedownInvoiceToValidation('xml');
        //Takedowns_Contingency_plan__c tkd = Data_Factory_Takedown_Test.createTakedown('OPERFIN-FIJA', 'TestEntityCP', '343434534retertre');
        tableElement.id = tkd_invoice.id;
        tableElement.name = tkd_invoice.Name;
        tableElement.TKD_fm_validation = 'test';
        tableElement.TKD_ls_Status = 'test';
        tableElement.TKD_pd_Takedown_CP = tkd_invoice.TKD_pd_Takedown_CP__c;
        tableElement.TKD_txt_Content_Version_ID = tkd_invoice.TKD_txt_Content_Version_ID__c;
        tableElement.TKD_txt_Document_ID = tkd_invoice.TKD_txt_Document_ID__c;
        tableElement.TKD_txt_Extension = tkd_invoice.TKD_txt_Extension__c;
        tableElement.TKD_ls_asset_type = tkd_invoice.TKD_pd_Takedown_CP__r.TKD_ls_asset_type__c;
        tableElement.AccountId = tkd_invoice.TKD_pd_Takedown_CP__r.CPL_rb_Opp__r.AccountId;
        listTableElement.add(tableElement);
        
        takedownTableDocumentsController_cls.uploadAndValidateInvoices(listTableElement); 
        
        
    }*/
     @istest
    static void deleteInvoice(){
        EIV_Parameter__c parameters = new EIV_Parameter__c();
        parameters.name = 'fecha limite';
        parameters.EIV_tx_parameter__c = '01/12/2018';
        insert parameters;
        List<takedownTableDocumentsWrapper_cls.TableElement> listTableElement = new List<takedownTableDocumentsWrapper_cls.TableElement>();
    	takedownTableDocumentsWrapper_cls.TableElement tableElement = new takedownTableDocumentsWrapper_cls.TableElement();
        Takedown_Invoice__c tkd_invoice = Data_Factory_TakedownInvoice_Test.createTakedownInvoice('xml');
        tkd_invoice.TKD_ls_Eng_Status__c = 'action:priority';
        update tkd_invoice;
        try{
             takedownTableDocumentsController_cls.deleteInvoice(tkd_invoice.Id, tkd_invoice.TKD_txt_Document_ID__c, true, false);
        }catch(exception e){
            system.debug(e);
        }
       
    }
    @istest
    static void deleteInvoiceWithoutDocument(){
        EIV_Parameter__c parameters = new EIV_Parameter__c();
        parameters.name = 'fecha limite';
        parameters.EIV_tx_parameter__c = '01/12/2018';
        insert parameters;
        List<takedownTableDocumentsWrapper_cls.TableElement> listTableElement = new List<takedownTableDocumentsWrapper_cls.TableElement>();
    	takedownTableDocumentsWrapper_cls.TableElement tableElement = new takedownTableDocumentsWrapper_cls.TableElement();
        Takedown_Invoice__c tkd_invoice = Data_Factory_TakedownInvoice_Test.createTakedownInvoice('xml');
        try{
            takedownTableDocumentsController_cls.deleteInvoice(tkd_invoice.Id, null, true, false);
        } catch(Exception e){
            system.debug('GetError ' + e);
        }
        
    }
     @istest
    static void deleteInvoiceAllAssets(){
        EIV_Parameter__c parameters = new EIV_Parameter__c();
        parameters.name = 'fecha limite';
        parameters.EIV_tx_parameter__c = '01/12/2018';
        insert parameters;
        List<takedownTableDocumentsWrapper_cls.TableElement> listTableElement = new List<takedownTableDocumentsWrapper_cls.TableElement>();
    	takedownTableDocumentsWrapper_cls.TableElement tableElement = new takedownTableDocumentsWrapper_cls.TableElement();
        Takedown_Invoice__c tkd_invoice = Data_Factory_TakedownInvoice_Test.createTakedownInvoice('xml');
        try{
            takedownTableDocumentsController_cls.deleteInvoice(tkd_invoice.Id, tkd_invoice.TKD_txt_Document_ID__c, false, false);
        } catch(Exception e){
            system.debug('GetError ' + e);
        }
        
    }
    @istest
    static void deleteInvoices(){
        EIV_Parameter__c parameters = new EIV_Parameter__c();
        parameters.name = 'fecha limite';
        parameters.EIV_tx_parameter__c = '01/12/2018';
        insert parameters;
        List<takedownTableDocumentsWrapper_cls.TableElement> listTableElement = new List<takedownTableDocumentsWrapper_cls.TableElement>();
    	takedownTableDocumentsWrapper_cls.TableElement tableElement = new takedownTableDocumentsWrapper_cls.TableElement();
        Takedown_Invoice__c tkd_invoice = Data_Factory_TakedownInvoice_Test.createTakedownInvoice('xml');
        tkd_invoice.TKD_ls_Eng_Status__c = 'action:priority';
        update tkd_invoice;
        list<id> listIdInvoices = new list<id>();
        listIdInvoices.add(tkd_invoice.Id);
        list<id> listdocumentId = new list<id>();
        listdocumentId.add(tkd_invoice.TKD_txt_Document_ID__c);
        //test.startTest();
        try{
            takedownTableDocumentsController_cls.deleteInvoices(listIdInvoices, listdocumentId, true, false);
        }catch(exception e){
            system.debug(e);
        }
        
        //test.stopTest();
    }
    @istest
    static void deleteInvoicesWithoutDocumentsNoPermissions(){
        EIV_Parameter__c parameters = new EIV_Parameter__c();
        parameters.name = 'fecha limite';
        parameters.EIV_tx_parameter__c = '01/12/2018';
        insert parameters;
        List<takedownTableDocumentsWrapper_cls.TableElement> listTableElement = new List<takedownTableDocumentsWrapper_cls.TableElement>();
    	takedownTableDocumentsWrapper_cls.TableElement tableElement = new takedownTableDocumentsWrapper_cls.TableElement();
        Takedown_Invoice__c tkd_invoice = Data_Factory_TakedownInvoice_Test.createTakedownInvoice('xml');
        list<id> listIdInvoices = new list<id>();
        listIdInvoices.add(tkd_invoice.Id);
        list<id> listdocumentId = new list<id>();
        listdocumentId.add(tkd_invoice.TKD_txt_Document_ID__c);
        //test.startTest();
        try{
            takedownTableDocumentsController_cls.deleteInvoices(listIdInvoices, null, true, false);
        }catch(Exception e){
            System.debug('Error ' + e);
        }
        
        //test.stopTest();
    }
     @istest
    static void deleteInvoicesWithoutDocuments(){
        EIV_Parameter__c parameters = new EIV_Parameter__c();
        parameters.name = 'fecha limite';
        parameters.EIV_tx_parameter__c = '01/12/2018';
        insert parameters;
        List<takedownTableDocumentsWrapper_cls.TableElement> listTableElement = new List<takedownTableDocumentsWrapper_cls.TableElement>();
    	takedownTableDocumentsWrapper_cls.TableElement tableElement = new takedownTableDocumentsWrapper_cls.TableElement();
        Takedown_Invoice__c tkd_invoice = Data_Factory_TakedownInvoice_Test.createTakedownInvoice('xml');
        list<id> listIdInvoices = new list<id>();
        listIdInvoices.add(tkd_invoice.Id);
        list<id> listdocumentId = new list<id>();
        listdocumentId.add(tkd_invoice.TKD_txt_Document_ID__c);
        //test.startTest();
        takedownTableDocumentsController_cls.deleteInvoices(listIdInvoices, listdocumentId, false, false);
        //test.stopTest();
    }
    @istest
    static void getAssetBreakdown(){
        EIV_Parameter__c parameters = new EIV_Parameter__c();
        parameters.name = 'fecha limite';
        parameters.EIV_tx_parameter__c = '01/12/2018';
        insert parameters;
        List<takedownTableDocumentsWrapper_cls.TableElement> listTableElement = new List<takedownTableDocumentsWrapper_cls.TableElement>();
    	takedownTableDocumentsWrapper_cls.TableElement tableElement = new takedownTableDocumentsWrapper_cls.TableElement();
        Takedown_Invoice__c tkd_invoice = Data_Factory_TakedownInvoice_Test.createTakedownInvoice('xml');        
        takedownTableDocumentsController_cls.getAssetBreakdown(tkd_invoice.id);
    }
    @istest
    static void haveAB(){
        EIV_Parameter__c parameters = new EIV_Parameter__c();
        parameters.name = 'fecha limite';
        parameters.EIV_tx_parameter__c = '01/12/2018';
        insert parameters;
        List<takedownTableDocumentsWrapper_cls.TableElement> listTableElement = new List<takedownTableDocumentsWrapper_cls.TableElement>();
    	takedownTableDocumentsWrapper_cls.TableElement tableElement = new takedownTableDocumentsWrapper_cls.TableElement();
        Takedown_Invoice__c tkd_invoice = Data_Factory_TakedownInvoice_Test.createTakedownInvoice('xml');        
        takedownTableDocumentsController_cls.haveAB(tkd_invoice.id);
    }
    @istest
    static void getProfileCurrentUser(){                
        takedownTableDocumentsController_cls.getProfileCurrentUser();
    }
    @istest
    static void getTakedownVisibilityValidateInvoices(){  
        Id currentProfileId = userinfo.getProfileId();
		string profileName = [select Name from profile where id = :currentProfileId].name;
        takedownTableDocumentsController_cls.getTakedownVisibilityValidateInvoices(profileName);
    }
    @istest
    static void getTakedownVisibilityISCSubmit(){  
        Id currentProfileId = userinfo.getProfileId();
		string profileName = [select Name from profile where id = :currentProfileId].name;
        takedownTableDocumentsController_cls.getTakedownVisibilityISCSubmit(profileName);
    }
    @istest
    static void getTakedownVisibilityBlockAB(){  
        Id currentProfileId = userinfo.getProfileId();
		string profileName = [select Name from profile where id = :currentProfileId].name;
        takedownTableDocumentsController_cls.getTakedownVisibilityBlockAB(profileName);
    }
    
    
}