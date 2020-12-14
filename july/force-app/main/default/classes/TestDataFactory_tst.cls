@isTest
public class TestDataFactory_tst {
    
    public static User createUser(String userName, String profileName, String roleName) {
        
        Profile profile = [SELECT Id FROM Profile WHERE Name = :profileName];
        UserRole r = new UserRole(DeveloperName = 'Sales_Rep_Mexico_1', Name = 'Sales Rep - México 1');
		insert r;
        
        User usr = new User();
        usr.Alias = 'test';
        usr.Email = 'test@engenium.com';
        usr.EmailEncodingKey = 'UTF-8';
        usr.LastName = 'User';
        usr.FirstName = 'Test';
        usr.LanguageLocaleKey = 'en_US';
        usr.LocaleSidKey = 'en_US';
        usr.ProfileId = profile.Id;
        usr.UserRoleId = r.Id;
        usr.USU_ls_Region__c = 'Mexico 1';
        usr.TimeZoneSidKey = 'America/Los_Angeles';
        usr.USU_ls_Line_of_Business__c = 'Equipment';
        usr.Username = userName;
        
        insert usr;
        
        return usr;
    }
    
    public static User createUser(String userName, String profileName, String roleName, String lineBusiness) {
        
        Profile profile = [SELECT Id FROM Profile WHERE Name = :profileName];
        UserRole r = new UserRole(DeveloperName = 'Sales_Rep_Mexico_1', Name = 'Sales Rep - México 1');
		insert r;
        
        User usr = new User();
        usr.Alias = 'test';
        usr.Email = 'test@engenium.com';
        usr.EmailEncodingKey = 'UTF-8';
        usr.LastName = 'User';
        usr.FirstName = 'Test';
        usr.LanguageLocaleKey = 'en_US';
        usr.LocaleSidKey = 'en_US';
        usr.ProfileId = profile.Id;
        usr.UserRoleId = r.Id;
        usr.USU_ls_Region__c = 'Mexico 1';
        usr.TimeZoneSidKey = 'America/Los_Angeles';
        usr.USU_ls_Line_of_Business__c = lineBusiness;
        usr.Username = userName;
        
        insert usr;
        
        return usr;
    }
    public static OpportunityContactRole createOpportunityContactRole(Opportunity opp, Contact cont){
        OpportunityContactRole OppContRole = new OpportunityContactRole();
        OppContRole.OpportunityId = opp.id;
        OppContRole.ContactId = cont.id;
        OppContRole.IsPrimary = true;
        insert OppContRole;
        return OppContRole;
    } 
    public static TBO002_SIC_code__c createSICcode(){
        TBO002_SIC_code__c sicCode = new TBO002_SIC_code__c();
        sicCode.name = 'Test';
        insert sicCode;
        return sicCode;
        
    }
    public static Account createSimpleAccount(id sicCode){
        Account acc = new Account();
        acc.name = 'TestAccount';
        acc.ACC_rb_SIC_Code__c = sicCode;
        acc.BillingStreet = 'BillingStreet';
        acc.BillingCity = 'México';
        acc.BillingState = 'Chiapas';
        acc.BillingPostalCode = '10110';
        acc.BillingCountry = 'México';
        insert acc;
        return acc;
    }
    
    public static Account createAccount() {
        Account accnt = new Account();
        accnt.Name = 'Test Account';
        accnt.BillingStreet = 'Test Street';
        accnt.BillingCity = 'Test City';
        accnt.BillingState = 'Estado de México';
        accnt.BillingPostalCode = '1111';
        accnt.BillingCountry = 'México';
        accnt.ACC_tx_EXT_REF_ID__c = '123456';
        accnt.ACC_un_Capex_Exposure__c = 100;
        accnt.ACC_un_Fleet_Exposure__c = 200;
        accnt.ACC_un_Technology_Exposure__c = 300;
        accnt.ACC_un_Real_Estate_Exposure__c = 400;
        
        insert accnt;
        
        return accnt;
    }
    
    public static Account createAccount(String name, String extRefId) {
        Account accnt = new Account();
        accnt.Name = name;
        accnt.BillingStreet = 'Test Street';
        accnt.BillingCity = 'Test City';
        accnt.BillingState = 'Estado de México';
        accnt.BillingPostalCode = '1111';
        accnt.BillingCountry = 'México';
        accnt.ACC_tx_EXT_REF_ID__c = extRefId;
        accnt.ACC_un_Capex_Exposure__c = 100;
        accnt.ACC_un_Fleet_Exposure__c = 200;
        accnt.ACC_un_Technology_Exposure__c = 300;
        accnt.ACC_un_Real_Estate_Exposure__c = 400;
        
        insert accnt;
        
        return accnt;
    }
    
    public static Account createAccount(Id topParentId) {
        Account accnt = new Account();
        accnt.ACC_rb_Top_Parent_Account__c = topParentId;
        accnt.Name = 'Test Account';
        accnt.BillingStreet = 'Test Street';
        accnt.BillingCity = 'Test City';
        accnt.BillingState = 'Estado de México';
        accnt.BillingPostalCode = '1111';
        accnt.BillingCountry = 'México';
        accnt.ACC_tx_EXT_REF_ID__c = '123456';
        accnt.ACC_un_Capex_Exposure__c = 100;
        accnt.ACC_un_Fleet_Exposure__c = 200;
        accnt.ACC_un_Technology_Exposure__c = 300;
        accnt.ACC_un_Real_Estate_Exposure__c = 400;
        
        insert accnt;
        
        return accnt;
    }
    
    public static Account createAccount(Id topParentId, String name, String extRefId) {
        Account accnt = new Account();
        accnt.ACC_rb_Top_Parent_Account__c = topParentId;
        accnt.Name = name;
        accnt.BillingStreet = 'Test Street';
        accnt.BillingCity = 'Test City';
        accnt.BillingState = 'Estado de México';
        accnt.BillingPostalCode = '1111';
        accnt.BillingCountry = 'México';
        accnt.ACC_tx_EXT_REF_ID__c = extRefId;
        accnt.ACC_un_Capex_Exposure__c = 100;
        accnt.ACC_un_Fleet_Exposure__c = 200;
        accnt.ACC_un_Technology_Exposure__c = 300;
        accnt.ACC_un_Real_Estate_Exposure__c = 400;
        
        insert accnt;
        
        return accnt;
    }
    
    public static List<Account> createAccounts(Map<String, Id> topParentIdMap, Map<String, String> nameMap, List<String> extRefIdList) {
        List<Account> accInsList = new List<Account>();
        
        for (String extRefId : extRefIdList) {
            Account accnt = new Account();
            
            String name = nameMap.get(extRefId);
            
            if (String.isNotEmpty(name)) {
                accnt.Name = name;
                
                Id topParentId = topParentIdMap.get(extRefId);
                
                if (String.isNotEmpty(topParentId)) {
                    accnt.ACC_rb_Top_Parent_Account__c = topParentId;
                }
                
                accnt.BillingStreet = 'Test Street';
                accnt.BillingCity = 'Test City';
                accnt.BillingState = 'Estado de México';
                accnt.BillingPostalCode = '1111';
                accnt.BillingCountry = 'México';
                accnt.ACC_tx_EXT_REF_ID__c = extRefId;
                accnt.ACC_un_Capex_Exposure__c = 100;
                accnt.ACC_un_Fleet_Exposure__c = 200;
                accnt.ACC_un_Technology_Exposure__c = 300;
                accnt.ACC_un_Real_Estate_Exposure__c = 400;
                
                accInsList.add(accnt);
            }
        }
        
        if (accInsList.size() > 0) {
        	insert accInsList;
        }
        
        return accInsList;
    } 
    
    public static Contact createContact() {
        Contact contact = new Contact();
        contact.FirstName = 'Test';
        contact.LastName = 'Contact';
        
        insert contact;
        
        return contact;
    }
    
    public static Contact createContact(Account accnt) {
        Contact contact = new Contact();
        contact.FirstName = 'Test';
        contact.LastName = 'Contact';
        contact.AccountId = accnt.Id;
        contact.CON_ca_Principal__c = true;
        contact.CON_ls_Type__c = 'Administrator';
        insert contact;
        
        return contact;
    }
    
    public static Opportunity createOpportunity(Account accnt, User currentUser, TBO022_Competitor__c competitor) {
        Opportunity opp = new Opportunity();
        opp.Name = 'Opp with attachment';
        opp.Amount = 300000000.50;
        opp.StageName = 'Lead';
        
        Date firstFundingExpectedDate = Date.today();
        firstFundingExpectedDate = firstFundingExpectedDate.addMonths(2);
        opp.CloseDate = firstFundingExpectedDate;
        
        if (accnt != null) {
        	opp.AccountId = accnt.Id;
        }
        
        opp.OPP_ls_Product__c = 'Term Loan';
        opp.OPP_ls_Financing_Need__c = 'CapEx Lines';
        opp.OPP_ls_Collateral__c = 'Agricultural Equipment';
        opp.OPP_ls_Deal_Category__c = 'New Origination';
        opp.StageName = 'Opportunity Identified';
        opp.OPP_ls_Line_of_Business__c = 'Equipment';
        opp.OPP_ls_Region__c = currentUser.USU_ls_Region__c;
        //opp.OPP_ls_Origin_of_equipment__c = 'Benin';
        opp.OPP_ls_Insurance_Type__c = 'Engenium Capital Financed';
        opp.OPP_ls_Equipment_Import_Required__c = 'No';
        opp.OPP_ls_Reason_Won_Level_1__c = 'Ability to Execute';
        opp.OPP_ls_Reason_Won_Level_2__c = 'Ability to Deliver';
        opp.OPP_fh_Date_Customer_Expects_Credit_App__c = Date.today();
        opp.OPP_tl_Won_Comments__c = 'Won Comments.';
        opp.OPP_rb_Competitor__c = competitor.Id;
        opp.OPP_ca_No_document__c = true;
        opp.OPP_tl_Not_Signed_Proposal_Reason__c = 'Not Signed Reason.';
        opp.OPP_ls_Equipment_Condition__c = 'New';
        
        insert opp;
        
        return opp;
    }
    
    public static List<Opportunity> createOpportunities(List<Account> accntList, User currentUser, TBO022_Competitor__c competitor) {
        List<Opportunity> oppInsList = new List<Opportunity>();
        
        for (Account acc : accntList) {
            Opportunity opp = new Opportunity();
            opp.Name = 'Opp with attachment';
            opp.Amount = 300000000.50;
            opp.StageName = 'Lead';
            
            Date firstFundingExpectedDate = Date.today();
            firstFundingExpectedDate = firstFundingExpectedDate.addMonths(2);
            opp.CloseDate = firstFundingExpectedDate;
            
            if (acc != null) {
                opp.AccountId = acc.Id;
            }
            
            opp.OPP_ls_Product__c = 'Term Loan';
            opp.OPP_ls_Financing_Need__c = 'CapEx Lines';
            opp.OPP_ls_Collateral__c = 'Agricultural Equipment';
            opp.OPP_ls_Deal_Category__c = 'New Origination';
            opp.StageName = 'Opportunity Identified';
            opp.OPP_ls_Line_of_Business__c = 'Equipment';
            opp.OPP_ls_Region__c = currentUser.USU_ls_Region__c;
            //opp.OPP_ls_Origin_of_equipment__c = 'Benin';
            opp.OPP_ls_Insurance_Type__c = 'Customer Self Insurance';
            opp.OPP_ls_Equipment_Import_Required__c = 'No';
            opp.OPP_ls_Reason_Won_Level_1__c = 'Ability to Execute';
            opp.OPP_ls_Reason_Won_Level_2__c = 'Ability to Deliver';
            opp.OPP_fh_Date_Customer_Expects_Credit_App__c = Date.today();
            opp.OPP_tl_Won_Comments__c = 'Won Comments.';
            opp.OPP_rb_Competitor__c = competitor.Id;
            opp.OPP_ca_No_document__c = true;
            opp.OPP_tl_Not_Signed_Proposal_Reason__c = 'Not Signed Reason.';
            opp.OPP_ls_Equipment_Condition__c = 'New';
            
            oppInsList.add(opp);
        }
        
        insert oppInsList;
        
        return oppInsList;
    }
    
    public static Attachment createAttachment(String documentName, Id objId) {
        Attachment attch = new Attachment();
        attch.Name = documentName;
        attch.ParentId = objId;
        attch.Body = Blob.valueOf('This is an attached pdf document.');
        
        insert attch;
        
        return attch;
    }
    
    public static Event createEvent(Contact contact, Account accnt) {
        Event evnt = new Event();
        evnt.WhoId = contact.Id;
        evnt.WhatId = accnt.Id;
        
        DateTime startDateTime = DateTime.now();
        startDateTime = startDateTime.addDays(-1);
        
        evnt.StartDateTime = startDateTime;
        
        DateTime endDateTime = startDateTime.addSeconds(30);
        
        evnt.EndDateTime = endDateTime;
        
        insert evnt;
        
        return evnt;
    }
    
    public static Task createTask(Contact contact, Account accnt, String status, String subject, String type) {
        Task task = new Task();
        task.WhoId = contact.Id;
        task.WhatId = accnt.Id;
        task.Description = 'Description';
        task.Type = type;
        task.Subject = subject;
        task.Status = status;
        
        Date startDateTime = Date.today();
        startDateTime = startDateTime.addDays(-5);
        
        task.ActivityDate = startDateTime;
        
        insert task;
        
        return task;
    }
    
    public static IST__SuperTRUMP_Template__c createSTPricingTemplate() {
        IST__SuperTRUMP_Template__c pricingTemplate = new IST__SuperTRUMP_Template__c();
        pricingTemplate.Name = 'EC Loan';
        
        insert pricingTemplate;
        
        return pricingTemplate;
    }
    public static IST__SuperTRUMP_Template__c createSTPricingTemplateECQuasiL() {
        IST__SuperTRUMP_Template__c pricingTemplate = new IST__SuperTRUMP_Template__c();
        pricingTemplate.Name = 'EC Quasi Lease';
        
        insert pricingTemplate;
        
        return pricingTemplate;
    }
    public static IST__SuperTRUMP_Template__c createSTPricingTemplateECTrueTax() {
        IST__SuperTRUMP_Template__c pricingTemplate = new IST__SuperTRUMP_Template__c();
        pricingTemplate.Name = 'EC True Tax Lease';
        
        insert pricingTemplate;
        
        return pricingTemplate;
    }
    
    
    
    public static IST__SuperTRUMP_Pricing_Quote__c createSTPricingQuote(Opportunity opp, IST__SuperTRUMP_Template__c pricingTemplate) {
        IST__SuperTRUMP_Pricing_Quote__c pricingQuote = new IST__SuperTRUMP_Pricing_Quote__c();
        pricingQuote.created_in_SF__c = true;
        pricingQuote.IST__Opportunity__c = opp.Id;
        pricingQuote.Depreciation__c = 1000;
        pricingQuote.IST__Is_Synchronized__c = true;
        pricingQuote.Economic_ROI__c = 1.4418;
        pricingQuote.IST__Description__c = 'Test';
        pricingQuote.Economic_ROE__c = 10.0926;
        pricingQuote.IST__QuoteStatus__c = 'Quoted';
        pricingQuote.Economic_Yield__c = 13.1208;
        pricingQuote.IST__Total_Lending__c = 1000000;
        pricingQuote.Expense_ANI__c = 2.45;    
        pricingQuote.MC_Currency__c = 'MXN'; 
        pricingQuote.Finance_Margin__c = 4.7665; 
        pricingQuote.IST__Takedown__c = Date.today(); 
        pricingQuote.BookYield__c = 13.1070; 
        pricingQuote.IST__Lending_Rate__c = 13.2848; 
        pricingQuote.IST__Cost__c = 1000000; 
        pricingQuote.IST__Balloon__c = 0; 
        pricingQuote.Cost_of_Funds_Levered__c = 8.3543; 
        pricingQuote.IST__Commencement__c = Date.today(); 
        pricingQuote.Cost_of_Funds_Unlevered__c = 9.7467; 
        pricingQuote.IST__Term__c = 60; 
        pricingQuote.FulltermRatewithresidual__c = 13.2848; 
        pricingQuote.IST__Periodicity__c = 'Monthly'; 
        pricingQuote.Leverage__c = 14.2857; 
        pricingQuote.IST__Payment_Timing__c = 'Arrears'; 
        pricingQuote.LossANI__c = 0.2500; 
        pricingQuote.IST__Payment__c = 22899.13; 
        pricingQuote.Net_Income__c = 0; 
        pricingQuote.IST__Template__c = pricingTemplate.Id; 
        pricingQuote.Security_Deposit__c = 0; 
        pricingQuote.IST__Residual__c = 0; 
        pricingQuote.Full_Term_Rate__c = 13.2848; 
        pricingQuote.Contributed_Value__c = 134447.42; 
        pricingQuote.Net_Income_Eco__c = 0; 
        
        insert pricingQuote;
        
        return pricingQuote;
    }
    public static IST__SuperTRUMP_Pricing_Quote__c createSTPricingQuotePP(Opportunity opp, IST__SuperTRUMP_Template__c pricingTemplate) {
        IST__SuperTRUMP_Pricing_Quote__c pricingQuote = new IST__SuperTRUMP_Pricing_Quote__c();
        pricingQuote.created_in_SF__c = false;
        pricingQuote.IST__Opportunity__c = opp.Id;
        pricingQuote.Depreciation__c = 1000;
        pricingQuote.IST__Is_Synchronized__c = true;
        pricingQuote.Economic_ROI__c = 1.4418;
        pricingQuote.IST__Description__c = 'Test';
        pricingQuote.Economic_ROE__c = 10.0926;
        pricingQuote.IST__QuoteStatus__c = 'Quoted';
        pricingQuote.Economic_Yield__c = 13.1208;
        pricingQuote.IST__Total_Lending__c = 1000000;
        pricingQuote.Expense_ANI__c = 2.45;    
        pricingQuote.MC_Currency__c = 'MXN'; 
        pricingQuote.Finance_Margin__c = 4.7665; 
        pricingQuote.IST__Takedown__c = Date.today(); 
        pricingQuote.BookYield__c = 13.1070; 
        pricingQuote.IST__Lending_Rate__c = 13.2848; 
        pricingQuote.IST__Cost__c = 1000000;
        pricingQuote.IST__Commencement__c =date.valueOf('2019-02-03');
        pricingQuote.IST__Balloon__c = 0; 
        pricingQuote.Cost_of_Funds_Levered__c = 8.3543;
        pricingQuote.Cost_of_Funds_Unlevered__c = 9.7467; 
        pricingQuote.IST__Term__c = 60; 
        pricingQuote.FulltermRatewithresidual__c = 13.2848; 
        pricingQuote.IST__Periodicity__c = 'Monthly'; 
        pricingQuote.Leverage__c = 14.2857; 
        pricingQuote.IST__Payment_Timing__c = 'Arrears'; 
        pricingQuote.LossANI__c = 0.2500; 
        pricingQuote.IST__Payment__c = 22899.13; 
        pricingQuote.Net_Income__c = 0; 
        pricingQuote.IST__Template__c = pricingTemplate.Id; 
        pricingQuote.Security_Deposit__c = 0; 
        pricingQuote.IST__Residual__c = 0; 
        pricingQuote.Full_Term_Rate__c = 13.2848; 
        pricingQuote.Contributed_Value__c = 134447.42; 
        pricingQuote.Net_Income_Eco__c = 0; 
        
        insert pricingQuote;
        
        return pricingQuote;
    }
    
    public static TBO001_AccountClassification__c createAccountClassification(Account accnt, String tier) {
        TBO001_AccountClassification__c accClass = new TBO001_AccountClassification__c();
        accClass.TBO001_ls_Line_of_Business__c = 'Equipment';
        accClass.TBO001_rb_Account__c = accnt.Id;
        accClass.TBO001_ls_Tier__c = tier;
        
        if (tier.equals('Tier Three')) {
        	accClass.TBO001_ls_CompanyRank__c = 'Credit profile too low (financial performance out of Engenium scope)';
        }
        
        insert accClass;
        
        return accClass;
    }
    
    public static TBO001_AccountClassification__c createAccountClassification(Account accnt, String tier, String lineBusiness) {
        TBO001_AccountClassification__c accClass = new TBO001_AccountClassification__c();
        accClass.TBO001_ls_Line_of_Business__c = lineBusiness;
        accClass.TBO001_rb_Account__c = accnt.Id;
        accClass.TBO001_ls_Tier__c = tier;
        
        if (tier.equals('Tier Three')) {
        	accClass.TBO001_ls_CompanyRank__c = 'Credit profile too low (financial performance out of Engenium scope)';
        }
        
        insert accClass;
        
        return accClass;
    }
    
    public static TBO001_AccountClassification__c createAccountClassification(Account accnt, String tier, String lineBusiness, String customerSince) {
        TBO001_AccountClassification__c accClass = new TBO001_AccountClassification__c();
        accClass.TBO001_ls_Line_of_Business__c = lineBusiness;
        accClass.TBO001_rb_Account__c = accnt.Id;
        accClass.TBO001_ls_Tier__c = tier;
        accClass.TBO001_tx_Customer_Since__c = customerSince;
        
        if (tier.equals('Tier Three')) {
        	accClass.TBO001_ls_CompanyRank__c = 'Credit profile too low';
        }
        
        insert accClass;
        
        return accClass;
    }
    
    public static List<TBO001_AccountClassification__c> createAccountClassificationList(List<Account> accntList, String tier) {
        List<TBO001_AccountClassification__c> accClassList = new List<TBO001_AccountClassification__c>();
        
        for (Account accnt: accntList) {
            TBO001_AccountClassification__c accClass = new TBO001_AccountClassification__c();
            accClass.TBO001_ls_Line_of_Business__c = 'Equipment';
            accClass.TBO001_rb_Account__c = accnt.Id;
            accClass.TBO001_ls_Tier__c = tier;
            
            if (tier.equals('Tier Three')) {
                accClass.TBO001_ls_CompanyRank__c = 'Credit profile too low';
            }
            
            accClassList.add(accClass);
        }
        
        insert accClassList;
        
        return accClassList;
    }
    
    public static TBO006_Pre_Call_Plan__c createPreCallPlan(Account accnt) {
        TBO006_Pre_Call_Plan__c preCallPlan = new TBO006_Pre_Call_Plan__c();
        
        if (accnt != null) {
        	preCallPlan.TBO006_pd_Account__c = accnt.Id;   
        }
        
        preCallPlan.TBO006_tl_Comments__c = 'Test Comments.';
        
        insert preCallPlan;
        
        return preCallPlan;
    }
    
    public static TBO007_Account_Plan__c createAccountPlan(Account accnt) {
        TBO007_Account_Plan__c accountPlan = new TBO007_Account_Plan__c();
        
        if (accnt != null) {
        	accountPlan.TBO007_rb_Account__c = accnt.Id;   
        }
        
        accountPlan.TBO007_un_Expected_Volume_CapEx__c = 10;
        
        insert accountPlan;
        
        return accountPlan;
    }
    
    public static TBO014_Credit_Approval__c createCreditApproval() {
        TBO014_Credit_Approval__c creditApproval = new TBO014_Credit_Approval__c();
        creditApproval.TBO014_ls_Approval_Category__c = 'New';
        creditApproval.TBO014_tx_Status__c = 'New';
        
        Date effectiveStartDate = Date.today();
        
        creditApproval.TBO014_fh_Effective_Start_Date__c = effectiveStartDate;
        creditApproval.TBO014_fh_Status_Date__c = effectiveStartDate;
        creditApproval.TBO014_fh_Effective_End_Date__c = effectiveStartDate.addDays(5);
        
        insert creditApproval;
        
        return creditApproval;
    }

    public static TBO014_Credit_Approval__c createCreditApproval(Account accnt) {
        TBO014_Credit_Approval__c creditApproval = new TBO014_Credit_Approval__c();
    	creditApproval.TBO014_rb_Account__c = accnt.Id;
        creditApproval.TBO014_ls_Approval_Category__c = 'New';
        creditApproval.TBO014_tx_Status__c = 'New';
        
        Date effectiveStartDate = Date.today();
        
        creditApproval.TBO014_fh_Effective_Start_Date__c = effectiveStartDate;
        creditApproval.TBO014_fh_Status_Date__c = effectiveStartDate;
        creditApproval.TBO014_fh_Effective_End_Date__c = effectiveStartDate.addDays(5);
        
        insert creditApproval;
        
        return creditApproval;
    }
    
    public static TBO018_Pricing__c createPricing(Opportunity opp, IST__SuperTRUMP_Pricing_Quote__c pricingQuote) {
        TBO018_Pricing__c pricing = new TBO018_Pricing__c();
        pricing.TBO018_tx_Pricing_Status__c = 'New';
        pricing.TBO018_rb_SuperTRUMP_Pricing_Quote__c = pricingQuote.Id;
        pricing.TBO018_rb_Opportunity__c = opp.Id;
        pricing.TBO018_ls_Type__c = 'Proposal';
        pricing.TBO018_dv_Amount__c = 1000000;
        pricing.TBO018_tx_Product__c = 'Term Loan';
        pricing.TBO018_un_Term__c = 60;
        pricing.TBO018_pr_Security_Deposit__c = 0;
        pricing.TBO018_dv_ANI__c = 0;
        pricing.TBO018_un_Depreciation__c = 1000;
        pricing.TBO018_tx_Rate_Type__c = 'Layered';
        pricing.TBO018_dv_Residual__c = 0;
        pricing.TBO018_pr_Opening_Fee__c = 0;
        pricing.TBO018_pr_Economic_ROI__c = 1.5010;
        pricing.TBO018_pr_Economic_Yield__c = 13.1203;
        pricing.TBO018_un_Net_Income__c = 0;
        pricing.TBO018_pr_Book_Yield__c = 13.1070;
        pricing.TBO018_pr_Economic_ROE__c = 10.5072;
        pricing.TBO018_pr_Lending_Rate__c = 13.2848;
        pricing.TBO018_pr_Finance_Margin__c = 4.7993;
        pricing.TBO018_pr_Full_Term_Rate__c = 13.2848;
        pricing.TBO018_dv_Gross_margin__c = 0;
        pricing.TBO018_pr_Full_Term_Rate_w_Resid__c = 13.2848;
        pricing.TBO018_un_Contributed_Value__c = 135379.5;
        pricing.TBO018_pr_Cost_of_Funds_Levered__c = 8.3210;
        pricing.TBO018_fh_Money_Cost_Date__c = Date.today();
        pricing.TBO018_pr_Cost_of_Funds_Unlevered__c = 9.7078;
        pricing.TBO018_pr_Loss_ANI__c = 0.25;
        pricing.TBO018_pr_Expense_ANI__c = 2.4;
        pricing.TBO018_pr_Leverage__c = 0;
        pricing.TBO018_tx_Supertrump_Template__c = 'Test';
        insert pricing;
        
        return pricing;
    }
    
    public static ES3_obj_Pricing_in_Credit_Approval__c createPricingInCA(Id opp , Id oppinCaId, Id pricingId, Id caId ){
        
        ES3_obj_Pricing_in_Credit_Approval__c pricingInca = new ES3_obj_Pricing_in_Credit_Approval__c();
        pricingInca.ES3_rb_Opportunity_in_Credit_approval_CP__c = oppinCaId;
        pricingInca.ES3_rb_Oportunidad__c = opp;
        pricingInca.ES3_rb_Pricing__c = pricingId;
        pricingInca.ES3_rb_Credit_approval_CP__c = caId;
        insert pricingInca;
        return pricingInca;
    }
    
    public static TBO020_Takedowns__c createTakedownForecast(Opportunity opp, User currentUser, String status) {
        TBO020_Takedowns__c takedownForecast = new TBO020_Takedowns__c();
        
        takedownForecast.TBO020_ls_Region__c = currentUser.USU_ls_Region__c;
        takedownForecast.TBO020_tx_Status__c = status;
        takedownForecast.TBO020_pd_Opportunity__c = opp.Id;
        takedownForecast.TBO020_ls_Financing_Need__c = 'CapEx Lines';
        takedownForecast.TBO020_tx_Pricing_Product__c = 'True Lease';
        takedownForecast.TBO020_ls_Deal_Category__c = 'New Origination';
        takedownForecast.TBO020_ls_Line_of_Business__c = 'Equipment';
        takedownForecast.TBO020_un_Pricing_Term__c = 48;
        takedownForecast.TBO020_tx_Pricing_Rate_Type__c = 'Fixed';
        takedownForecast.TBO020_pr_Pricing_Economic_ROI__c = 0.0321;
        takedownForecast.TBO020_un_Pricing_Economic_Yield__c = 0.1073;
        takedownForecast.TBO020_pr_Pricing_Finance_Margin__c = 0.0614;
        takedownForecast.TBO020_ls_Opportunity_from_Vendor__c = 'No';
        takedownForecast.TBO020_ls_Opportunity_from_Broker__c = 'No';
        takedownForecast.TBO020_ls_Shared_Takedown__c = 'No';
        
        
        Date statusDate = Date.today();
        
        takedownForecast.TBO020_fh_Creation_Date__c = statusDate;
        
        takedownForecast.TBO020_fh_Status_Date__c = statusDate;
        
        if (status.equals('Funded')) {
        	takedownForecast.TBO020_fh_Funding_Date__c = statusDate;
        	takedownForecast.TBO020_fh_Delivery_Date__c = statusDate;
        }
        
        insert takedownForecast;
        
        return takedownForecast;
    }
    
    public static TBO022_Competitor__c createCompetitor() {
        TBO022_Competitor__c competitor = new TBO022_Competitor__c();
        competitor.Name = 'Bancomer BBV';
        competitor.TBO022_ls_Type__c = 'Bank';
        
        insert competitor;
        
        return competitor;
    }
    
    public static TBO023_Customer_Since__c createCustomerSince(Account accnt, String year) {
        TBO023_Customer_Since__c customerSince = new TBO023_Customer_Since__c();
        customerSince.TBO023_tx_Ext_ref_Account_id__c = accnt.ACC_tx_EXT_REF_ID__c;
        customerSince.TBO023_ls_Line_Of_Business__c = 'Equipment';
        customerSince.TBO023_tx_Customer_since__c = year;
        
        insert customerSince;
        
        return customerSince;
    }  
    
    public static ReglasAprobacion__c createReglaApprovacion() {
        ReglasAprobacion__c regla = new ReglasAprobacion__c();
        regla.Name = '1';
        regla.SupertrumpTemplate__c = 'EC Loan';
        regla.Target_Market__c = 'Lower middle market';
        regla.Line_of_Business__c = 'Todos';
        regla.Collateral__c = 'Todos';
        regla.Target_Economic_ROI__c = 1.25;
        regla.Min_Economic_ROI_Level_1__c = 0.75;
        regla.Min_Economic_ROI__c = 0.55;
        
        insert regla;
        
        return regla;
    }
    
    public static Account_Status_Rules_Matrix__c createAccountStatusRulesMatrix(String status, String result) {
        Account_Status_Rules_Matrix__c rule = new Account_Status_Rules_Matrix__c();
        rule.Status__c = status;
        rule.Result__c = result;
        
        insert rule;
        
        return rule;
    }
}