public class TBO014_ext_New_CreditApproval {
    private final TBO014_Credit_Approval__c creditApproval    {set; get;}
    private Id accountId                                      {set; get;}
    public List<String> selectedOpportunitiesLeft             {set; get;}
    public List<String> selectedOpportunitiesRight            {set; get;}
    Map<Id, String> opportunitiesValues                       {set; get;}
    Map<Id, String> opportunitiesValuesLeft                   {set; get;}
    Map<Id, String> opportunitiesValuesRight                  {set; get;}
    
    public List<String> selectedPricingsLeft                  {set; get;}
    public List<String> selectedPricingsRight                 {set; get;}
    Map<Id, String> pricingsValues                            {set; get;}
    Map<Id, String> pricingsValuesLeft                        {set; get;}
    Map<Id, String> pricingsValuesRight                       {set; get;}
    
    // The extension constructor initializes the private member
    // variable preScreeningRecord by using the getRecord method from the standard
    // controller.
    public TBO014_ext_New_CreditApproval(ApexPages.StandardController stdController) {
        this.creditApproval = (TBO014_Credit_Approval__c)stdController.getRecord();
        
        creditApproval.TBO014_ls_Approval_Category__c = 'New';
        creditApproval.TBO014_tx_Status__c = 'New';
        creditApproval.TBO014_un_Amount_MXN__c = 0;
        creditApproval.TBO014_un_Amount_USD__c = 0;
        creditApproval.TBO014_un_Total_Amount_USD_Converted__c = 0;
        creditApproval.TBO014_fh_Status_Date__c = Date.today();
        creditApproval.TBO014_ca_Active__c = true;
        creditApproval.TBO014_fh_Effective_Start_Date__c= Date.today();
        creditApproval.TBO014_tx_Region__c = [SELECT USU_ls_Region__c FROM User WHERE Id = :UserInfo.getUserId()].USU_ls_Region__c;
        
        this.accountId = ApexPages.currentPage().getParameters().get('account');
        
        this.creditApproval.TBO014_rb_Account__c = this.accountId;
        this.selectedOpportunitiesLeft = new List<String>();
        this.selectedOpportunitiesRight= new List<String>();
        
        List<Opportunity> oppList = [SELECT Id, Name FROM Opportunity WHERE AccountId = :this.accountId AND StageName = 'Proposal Awarded' AND OPP_rb_Credit_Approval__c = null];
        
        this.opportunitiesValues = new Map<Id, String>();
        
        for (Opportunity opp : oppList) {
            this.opportunitiesValues.put(opp.Id, opp.Name);
        }
        
        this.opportunitiesValuesLeft= new Map<Id, String>();
        this.opportunitiesValuesLeft.putAll(this.opportunitiesValues);
        
        this.opportunitiesValuesRight = new Map<Id, String>();
        
        this.selectedPricingsLeft = new List<String>();
        this.selectedPricingsRight = new List<String>();
        
        this.pricingsValues = new Map<Id, String>();
        this.pricingsValuesLeft = new Map<Id, String>();
        this.pricingsValuesRight = new Map<Id, String>();
    }

    public void selectOpportunityClick() {
        selectedOpportunitiesRight.clear();
        for (String oppId: selectedOpportunitiesLeft) {
            opportunitiesValuesRight.put(oppId, opportunitiesValuesLeft.get(oppId));
            opportunitiesValuesLeft.remove(oppId);
        }
        
        Util_cls.calculateAmounts(this.creditApproval, opportunitiesValuesRight.keySet());
        
        this.pricingsValues.clear();
            
        for (TBO018_Pricing__c pricing : [SELECT Id, Name, TBO018_tx_Description__c FROM TBO018_Pricing__c WHERE TBO018_rb_Opportunity__c IN : opportunitiesValuesRight.keySet() AND TBO018_tx_Pricing_Status__c = 'Approved']) {
            System.debug('Pricing: ' + pricing);
            this.pricingsValues.put(pricing.Id, pricing.Name + ' ' + pricing.TBO018_tx_Description__c);
        }
        
        this.pricingsValuesLeft.clear();
        this.pricingsValuesLeft.putAll(this.pricingsValues);
        this.pricingsValuesRight.clear();
    }
    
    public void unselectOpportunityClick() {
        selectedOpportunitiesLeft.clear();
        for (String oppId: selectedOpportunitiesRight) {
            opportunitiesValuesLeft.put(oppId, opportunitiesValuesRight.get(oppId));
            opportunitiesValuesRight.remove(oppId);
        }
        
        Util_cls.calculateAmounts(this.creditApproval, opportunitiesValuesRight.keySet());
        Util_cls.getFinancingNeeds(this.creditApproval, opportunitiesValuesRight.keySet());
        
        this.pricingsValues.clear();
            
        for (TBO018_Pricing__c pricing : [SELECT Id, Name, TBO018_tx_Description__c FROM TBO018_Pricing__c WHERE TBO018_rb_Opportunity__c IN : opportunitiesValuesRight.keySet() AND TBO018_tx_Pricing_Status__c = 'Approved']) {
            System.debug('Pricing: ' + pricing);
            this.pricingsValues.put(pricing.Id, pricing.Name + ' ' + pricing.TBO018_tx_Description__c);
        }
        
        this.pricingsValuesLeft.clear();
        this.pricingsValuesLeft.putAll(this.pricingsValues);
        this.pricingsValuesRight.clear();
    }
    
    public List<SelectOption> getUnselectedOpportunities() {
        List<SelectOption> oppOptions = new List<SelectOption>();
        
        for(Id oppId : opportunitiesValuesLeft.keySet()) {
            oppOptions.add(new SelectOption(oppId, opportunitiesValuesLeft.get(oppId)));
        }
        
        oppOptions.sort();
        
        return oppOptions;
    }
    
    public List<SelectOption> getSelectedOpportunities() {
        List<SelectOption> oppOptions = new List<SelectOption>();
        
        System.debug('Opp Values Right: ' + opportunitiesValuesRight);
        
        for(Id oppId : opportunitiesValuesRight.keySet()) {
            oppOptions.add(new SelectOption(oppId, opportunitiesValuesRight.get(oppId)));
        }
        
        oppOptions.sort();
        
        return oppOptions;
    }
    
    public void selectPricingClick() {
        selectedPricingsRight.clear();
        for (String pricingId: selectedPricingsLeft) {
            pricingsValuesRight.put(pricingId, pricingsValuesLeft.get(pricingId));
            pricingsValuesLeft.remove(pricingId);
        }
    }
    
    public void unselectPricingClick() {
        selectedPricingsLeft.clear();
        for (String pricingId: selectedPricingsRight) {
            pricingsValuesLeft.put(pricingId, pricingsValuesRight.get(pricingId));
            pricingsValuesRight.remove(pricingId);
        }
    }
    
    public List<SelectOption> getUnselectedPricings() {
        List<SelectOption> pricingOptions = new List<SelectOption>();
        
        for(Id pricingId : pricingsValuesLeft.keySet()) {
            pricingOptions.add(new SelectOption(pricingId, pricingsValuesLeft.get(pricingId)));
        }
        
        pricingOptions.sort();
        
        return pricingOptions;
    }
    
    public List<SelectOption> getSelectedPricings() {
        List<SelectOption> pricingOptions = new List<SelectOption>();
        
        for(Id pricingId : pricingsValuesRight.keySet()) {
            pricingOptions.add(new SelectOption(pricingId, pricingsValuesRight.get(pricingId)));
        }
        
        pricingOptions.sort();
        
        return pricingOptions;
    }

    public PageReference btnSave() {
        
        if ((opportunitiesValuesRight.size() == 0) || (pricingsValuesRight.size() == 0)) {
            if (opportunitiesValuesRight.size() == 0) {
                 ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'Opportunity: Validation Error. Value is required.'));
            }
            
            if (pricingsValuesRight.size() == 0) {
                 ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'Pricing: Validation Error. Value is required.'));
            }
            
            return null;
        }
        
        Util_cls.getFinancingNeeds(this.creditApproval, opportunitiesValuesRight.keySet());
        
        try {
            insert this.creditApproval;
        }
        catch (Exception exInsCreditApproval) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,Util_cls.obtieneMensajeReglaValidacion(exInsCreditApproval)));
            
            return null;
        }
        
        try {
            List<Opportunity> listaOppUpdate = [SELECT Id, OPP_rb_Credit_Approval__c FROM Opportunity WHERE Id IN :this.opportunitiesValuesRight.keySet()];
            
            for (Opportunity oppUpdate : listaOppUpdate) {
                oppUpdate.OPP_rb_Credit_Approval__c = this.creditApproval.Id;
            }
            
            update listaOppUpdate;
        }
        catch (Exception exUpdtOpp) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,Util_cls.obtieneMensajeReglaValidacion(exUpdtOpp)));
            
            return null;
        }
        
        try {
            List<TBO018_Pricing__c> listaPricingUpdate = [SELECT Id, TBO018_rb_Credit_Approval__c FROM TBO018_Pricing__c WHERE Id IN :this.pricingsValuesRight.keySet()];
            
            for (TBO018_Pricing__c pricingUpdate : listaPricingUpdate) {
                pricingUpdate.TBO018_rb_Credit_Approval__c = this.creditApproval.Id;
            }
            
            update listaPricingUpdate;
        }
        catch (Exception exUpdtPricing) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,Util_cls.obtieneMensajeReglaValidacion(exUpdtPricing)));
            
            return null;
        }
        
        PageReference back = new PageReference('/' + creditApproval.Id);
        back.setRedirect(true);
        
        return back;
    }
    
    public PageReference btnCancel() {
        PageReference cancel = new PageReference('/' + accountId);
        cancel.setRedirect(true);
        
        return cancel;
    }
}