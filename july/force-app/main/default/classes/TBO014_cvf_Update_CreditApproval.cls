public class TBO014_cvf_Update_CreditApproval {
	public TBO014_Credit_Approval__c creditApproval    		  {set; get;}
    
    public Boolean					 isReadOnly				  {set; get;}
    
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
    Map<Id, String> pricingsValuesRemove                      {set; get;}
    
    public Boolean hasPrivileges 							  {set; get;}
    public Boolean hasErrorMessages 						  {set; get;}
    
    // The extension constructor initializes the private member
    // variable preScreeningRecord by using the getRecord method from the standard
    // controller.
    public TBO014_cvf_Update_CreditApproval() {
        Id idCreditApproval = ApexPages.currentPage().getParameters().get('id');
        
        this.creditApproval = [SELECT Id, Name, OwnerId, CreatedById, LastModifiedById, TBO014_tx_EXT_REF_ID__c, TBO014_ls_Approval_Category__c, TBO014_rb_Credit_Approval_Original__c, TBO014_rb_Account__c, TBO014_un_Amount_USD__c, TBO014_un_Amount_MXN__c, TBO014_un_Total_Amount_USD_Converted__c, TBO014_tx_Approval_Type__c, TBO014_tx_Region__c, TBO014_tx_Status__c, TBO014_fh_Status_Date__c, TBO014_ca_Active__c, TBO014_fh_Effective_Start_Date__c, TBO014_fh_Effective_End_Date__c, TBO014_ls_EFA_required__c, CurrencyIsoCode FROM TBO014_Credit_Approval__c WHERE Id = :idCreditApproval];
        
        String profileName = [SELECT Name FROM Profile WHERE Id = :UserInfo.getProfileId() LIMIT 1].Name;
        
        this.hasPrivileges = (UserInfo.getUserId() == this.creditApproval.OwnerId) || (profileName == 'Administrator');
        
        if (this.creditApproval.TBO014_tx_Status__c.equals('Approved')) {
            this.isReadOnly = true;
        }
        else {
            this.isReadOnly = false;
        }
        
        this.selectedOpportunitiesLeft = new List<String>();
        this.selectedOpportunitiesRight= new List<String>();
        
        List<Opportunity> oppList = [SELECT Id, Name FROM Opportunity WHERE AccountId = :this.creditApproval.TBO014_rb_Account__c AND StageName = 'Proposal Awarded'];
                
        this.opportunitiesValues = new Map<Id, String>();
        
        for (Opportunity opp : oppList) {
            AggregateResult pricingAR = [SELECT COUNT(Id) Quantity FROM TBO018_Pricing__c WHERE  TBO018_rb_Opportunity__c = :opp.Id AND TBO018_rb_Credit_Approval__c = null];
            
            if (((Integer) pricingAr.get('Quantity')) > 0) {
            	this.opportunitiesValues.put(opp.Id, opp.Name);
            }
        }
        
        this.opportunitiesValuesLeft= new Map<Id, String>();
        this.opportunitiesValuesLeft.putAll(this.opportunitiesValues);
        
        this.opportunitiesValuesRight = new Map<Id, String>();
        
        List<Opportunity> existingOPPList;
        
        try {
        	existingOPPList = [SELECT Id, Name FROM Opportunity WHERE AccountId = :this.creditApproval.TBO014_rb_Account__c AND OPP_rb_Credit_Approval__c = :this.creditApproval.Id];
        }
        catch (Exception exGetOpps) {
            System.debug('Error: ' + exGetOpps.getMessage() + ' (Line: ' + exGetOpps.getLineNumber() + ').');
        }
            
        if (existingOPPList != null) {
            for (Opportunity opp : existingOPPList) {
                this.opportunitiesValuesRight.put(opp.Id, opp.Name);
            }
        }
        
        this.selectedPricingsLeft = new List<String>();
        this.selectedPricingsRight = new List<String>();
        
        this.pricingsValues = new Map<Id, String>();
        this.pricingsValuesLeft = new Map<Id, String>();
        this.pricingsValuesRight = new Map<Id, String>();
        this.pricingsValuesRemove = new Map<Id, String>();
        
        List<TBO018_Pricing__c> existingPricingList;
            
        try {
        	existingPricingList = [SELECT Id, Name, TBO018_tx_Description__c FROM TBO018_Pricing__c WHERE TBO018_rb_Credit_Approval__c = :this.creditApproval.Id];
        }
        catch (Exception exGetPricing) {
            System.debug('Error: ' + exGetPricing.getMessage() + ' (Line: ' + exGetPricing.getLineNumber() + ').');
        }
        
        if (existingPricingList != null) {
            for (TBO018_Pricing__c pricing : existingPricingList) {
                this.pricingsValuesRight.put(pricing.Id, pricing.Name + ' ' + pricing.TBO018_tx_Description__c);
            }
        }
        
        getPricingValues();
    }

    public void selectOpportunityClick() {
        selectedOpportunitiesRight.clear();
        for (String oppId: selectedOpportunitiesLeft) {
            opportunitiesValuesRight.put(oppId, opportunitiesValuesLeft.get(oppId));
            opportunitiesValuesLeft.remove(oppId);
        }
        
        Util_cls.calculateAmounts(this.creditApproval, opportunitiesValuesRight.keySet());
        Util_cls.getFinancingNeeds(this.creditApproval, opportunitiesValuesRight.keySet());
        
        this.getPricingValues();
    }
    
    public void unselectOpportunityClick() {
        selectedOpportunitiesLeft.clear();
        for (String oppId: selectedOpportunitiesRight) {
            opportunitiesValuesLeft.put(oppId, opportunitiesValuesRight.get(oppId));
            opportunitiesValuesRight.remove(oppId);
        }
        
        Util_cls.calculateAmounts(this.creditApproval, opportunitiesValuesRight.keySet());
        
        this.getPricingValues();
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
            
            this.hasErrorMessages = true;
            return null;
        }
        
        Util_cls.getFinancingNeeds(this.creditApproval, opportunitiesValuesRight.keySet());
        
        try {
            update this.creditApproval;
        }
        catch (Exception exInsCreditApproval) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,Util_cls.obtieneMensajeReglaValidacion(exInsCreditApproval)));
            this.hasErrorMessages = true;
            return null;
        }
        
        try {
            List<Opportunity> listaOppUpdate = [SELECT Id, OPP_rb_Credit_Approval__c FROM Opportunity WHERE Id IN :this.opportunitiesValuesRight.keySet() AND OPP_rb_Credit_Approval__c = null];
            
            for (Opportunity oppUpdate : listaOppUpdate) {
                oppUpdate.OPP_rb_Credit_Approval__c = this.creditApproval.Id;
            }
            
            update listaOppUpdate;
        }
        catch (Exception exUpdtOpp) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,Util_cls.obtieneMensajeReglaValidacion(exUpdtOpp)));
            this.hasErrorMessages = true;
            return null;
        }
        
        try {
            List<Opportunity> listaRemoveOppUpdate = [SELECT Id, OPP_rb_Credit_Approval__c FROM Opportunity WHERE Id IN :this.opportunitiesValuesLeft.keySet() AND OPP_rb_Credit_Approval__c <> null];
            
            for (Opportunity oppUpdate : listaRemoveOppUpdate) {
                oppUpdate.OPP_rb_Credit_Approval__c = null;
            }
            
            update listaRemoveOppUpdate;
        }
        catch (Exception exRemUpdtOpp) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,Util_cls.obtieneMensajeReglaValidacion(exRemUpdtOpp)));
            this.hasErrorMessages = true;
            return null;
        }
        
        try {
            List<TBO018_Pricing__c> listaPricingUpdate = [SELECT Id, TBO018_rb_Credit_Approval__c FROM TBO018_Pricing__c WHERE Id IN :this.pricingsValuesRight.keySet() AND TBO018_rb_Credit_Approval__c = null];
            
            for (TBO018_Pricing__c pricingUpdate : listaPricingUpdate) {
                pricingUpdate.TBO018_rb_Credit_Approval__c = this.creditApproval.Id;
            }
            
            update listaPricingUpdate;
        }
        catch (Exception exUpdtPricing) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,Util_cls.obtieneMensajeReglaValidacion(exUpdtPricing)));
            this.hasErrorMessages = true;
            return null;
        }
        
        try {
            List<TBO018_Pricing__c> listaRemovePricingUpdate = [SELECT Id, TBO018_rb_Credit_Approval__c FROM TBO018_Pricing__c WHERE Id IN :this.pricingsValuesRemove.keySet() AND TBO018_rb_Credit_Approval__c <> null];
            
            for (TBO018_Pricing__c pricingUpdate : listaRemovePricingUpdate) {
                pricingUpdate.TBO018_rb_Credit_Approval__c = null;
            }
            
            update listaRemovePricingUpdate;
        }
        catch (Exception exRemUpdtPricing) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,Util_cls.obtieneMensajeReglaValidacion(exRemUpdtPricing)));
            this.hasErrorMessages = true;
            return null;
        }
        
        PageReference back = new PageReference('/' + this.creditApproval.Id);
        back.setRedirect(true);
        
        return back;
    }
    
    public PageReference btnCancel() {
        PageReference cancel = new PageReference('/' + this.creditApproval.Id);
        cancel.setRedirect(true);
        
        return cancel;
    }
    
    public void getPricingValues() {
         this.pricingsValues.clear();
            
        for (TBO018_Pricing__c pricing : [SELECT Id, Name, TBO018_tx_Description__c FROM TBO018_Pricing__c WHERE TBO018_ls_Type__c = 'Proposal' AND TBO018_tx_Pricing_Status__c = 'Approved' AND TBO018_rb_Opportunity__c IN : opportunitiesValuesRight.keySet() AND TBO018_rb_Credit_Approval__c = null]) {
            this.pricingsValues.put(pricing.Id, pricing.Name + ' ' + pricing.TBO018_tx_Description__c);
        }
        
        for (TBO018_Pricing__c existingPricing : [SELECT Id, Name, TBO018_tx_Description__c FROM TBO018_Pricing__c WHERE TBO018_ls_Type__c = 'Proposal' AND TBO018_tx_Pricing_Status__c = 'Approved' AND TBO018_rb_Opportunity__c IN : opportunitiesValuesRight.keySet() AND Id NOT IN :this.pricingsValuesRight.keySet() AND TBO018_rb_Credit_Approval__c <> null]) {
            this.pricingsValues.put(existingPricing.Id, existingPricing.Name + ' ' + existingPricing.TBO018_tx_Description__c);
        }
        
        Set<Id> originalCreditApprovalOpps = new Set<Id>();
        
        for (Opportunity oppCA : [SELECT Id FROM Opportunity WHERE OPP_rb_Credit_Approval__c = :this.creditApproval.Id]) {
            originalCreditApprovalOpps.add(oppCA.Id);
        }
        
        if (this.creditApproval.TBO014_rb_Credit_Approval_Original__c != null) {
            
            for (Opportunity oppCAO : [SELECT Id FROM Opportunity WHERE OPP_rb_Credit_Approval__c = :this.creditApproval.TBO014_rb_Credit_Approval_Original__c]) {
                originalCreditApprovalOpps.add(oppCAO.Id);
            }
        }
            
        for (TBO018_Pricing__c pricingCAO : [SELECT Id, Name, TBO018_tx_Description__c FROM TBO018_Pricing__c WHERE TBO018_ls_Type__c = 'Proposal' AND TBO018_tx_Pricing_Status__c = 'Approved' AND TBO018_rb_Opportunity__c IN : originalCreditApprovalOpps AND TBO018_rb_Credit_Approval__c = null]) {
            this.pricingsValues.put(pricingCAO.Id, pricingCAO.Name + ' ' + pricingCAO.TBO018_tx_Description__c);
        }
        
        this.pricingsValuesLeft.clear();
        this.pricingsValuesLeft.putAll(this.pricingsValues);
        
        this.pricingsValuesRemove.clear();
        
        for (TBO018_Pricing__c pricingLeft : [SELECT Id, Name, TBO018_tx_Description__c FROM TBO018_Pricing__c WHERE TBO018_ls_Type__c = 'Proposal' AND TBO018_tx_Pricing_Status__c = 'Approved' AND TBO018_rb_Opportunity__c IN : opportunitiesValuesLeft.keySet()]) {
            this.pricingsValuesRemove.put(pricingLeft.Id, pricingLeft.Name + ' ' + pricingLeft.TBO018_tx_Description__c);
            this.pricingsValuesRight.remove(pricingLeft.Id);
        }
    }
}