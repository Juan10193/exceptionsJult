public class TBO020_cvf_NewTakedown {
	public		 	TBO020_Takedowns__c				takedown  			{set; get;}
    public			Opportunity						opportunity			{set; get;}
    
    public List<String> selectedPricingsLeft                  {set; get;}
    public List<String> selectedPricingsRight                 {set; get;}
    Map<Id, String> pricingsValues                            {set; get;}
    Map<Id, String> pricingsValuesLeft                        {set; get;}
    Map<Id, String> pricingsValuesRight                       {set; get;}
    
    public 	Boolean 						hasPrivileges 			{set; get;}
    
    // The extension constructor initializes the private member
    // variable preScreeningRecord by using the getRecord method from the standard
    // controller.
    public TBO020_cvf_NewTakedown() {
        
        String profileName = [SELECT Name FROM Profile WHERE Id = :UserInfo.getProfileId() LIMIT 1].Name;
        
        this.hasPrivileges = !profileName.equals('Genérico');
        
    	this.takedown = new TBO020_Takedowns__c();
        
        this.takedown.TBO020_rb_Takedown_Owner__c = UserInfo.getUserId();
        this.takedown.TBO020_ls_Region__c = [SELECT USU_ls_Region__c FROM User WHERE Id = :UserInfo.getUserId()].USU_ls_Region__c;
        
        Id oppId = ApexPages.currentPage().getParameters().get('id');
        
        this.opportunity = [SELECT 	Id, 
                            		AccountId,
                            		OwnerId,
                            		OPP_tx_Original_Owner__c,
                                   	OPP_ls_Opportunity_from_Vendor__c, 
                                   	OPP_ls_Vendor_Fee_Commision__c, 
                                   	OPP_pr_Vendor_Fee_Commision__c, 
                                   	OPP_ls_Vendor_Brand__c, 
                                   	OPP_ls_Vendor_Distributor__c, 
                                   	OPP_ls_Opportunity_from_Broker__c, 
                                   	OPP_ls_Broker_Fee_Commision__c,
                                   	OPP_pr_Broker_Fee_Commision__c,
                                   	OPP_ls_Broker_name__c,
                                   	OPP_ls_Origin_of_equipment__c,
                                   	OPP_ls_Equipment_Import_Required__c,
                                   	OPP_ls_Import_Type__c,
                                   	OPP_ls_Shared_Opportunity__c,
                                   	OPP_ls_Of_sharing_reps__c,
                                   	OPP_ls_Sharing_Criteria__c,
                                   	OPP_rb_Share_Rep_1__c,
                                   	OPP_pr_Sharing_1__c,
                                   	OPP_ls_Shadow_Split__c,
                                   	OPP_rb_Share_Rep_2__c,
                                   	OPP_pr_Sharing_2__c,
                                   	OPP_ls_Sharing_Type_2__c,
                                   	OPP_rb_Share_Rep_3__c,
                                   	OPP_pr_Sharing_3__c,
                                   	OPP_ls_Sharing_Type_3__c,
                                   	OPP_rb_Share_Rep_4__c,
                                   	OPP_pr_Sharing_4__c,
                                   	OPP_ls_Sharing_Type_4__c,
                            		OPP_rb_Refered_by__c,
                            		OPP_ls_Marketing_Initiative_1__c,
                            		OPP_ls_Marketing_Initiative_2__c,
                            		OPP_ls_Marketing_Initiative_3__c
                           FROM Opportunity 
                           WHERE Id = :oppId];
        
        this.takedown.TBO020_pd_Opportunity__c = this.opportunity.Id;
        this.takedown.TBO020_ls_Opportunity_from_Vendor__c = this.opportunity.OPP_ls_Opportunity_from_Vendor__c;
        this.takedown.TBO020_ls_Vendor_Fee_Commision__c = this.opportunity.OPP_ls_Vendor_Fee_Commision__c;
        this.takedown.TBO020_pr_Vendor_Fee_Commision__c = this.opportunity.OPP_pr_Vendor_Fee_Commision__c;
        this.takedown.TBO020_ls_Vendor_Brand__c = this.opportunity.OPP_ls_Vendor_Brand__c;
        this.takedown.TBO020_ls_Vendor_Distributor__c = this.opportunity.OPP_ls_Vendor_Distributor__c;
        this.takedown.TBO020_ls_Opportunity_from_Broker__c = this.opportunity.OPP_ls_Opportunity_from_Broker__c;
        this.takedown.TBO020_ls_Broker_Fee_Commision__c = this.opportunity.OPP_ls_Broker_Fee_Commision__c;
        this.takedown.TBO020_pr_Broker_Fee_Commision__c = this.opportunity.OPP_pr_Broker_Fee_Commision__c;
        //this.takedown.TBO020_rb_Broker_Name__c = this.opportunity.OPP_ls_Broker_name__c;
        this.takedown.TBO020_ls_Broker_name__c = this.opportunity.OPP_ls_Broker_name__c;
        this.takedown.TBO020_ls_Origin_of_equipment__c = this.opportunity.OPP_ls_Origin_of_equipment__c;
        this.takedown.TBO020_ls_Equipment_Import_Required__c = this.opportunity.OPP_ls_Equipment_Import_Required__c;
        this.takedown.TBO020_ls_Import_Type__c = this.opportunity.OPP_ls_Import_Type__c;
        this.takedown.TBO020_ls_Shared_Takedown__c = this.opportunity.OPP_ls_Shared_Opportunity__c;
        this.takedown.TBO020_ls_Of_sharing_reps__c = this.opportunity.OPP_ls_Of_sharing_reps__c;
        this.takedown.TBO020_ls_Sharing_Criteria__c = this.opportunity.OPP_ls_Sharing_Criteria__c;
        this.takedown.TBO020_rb_Share_Rep_1__c = this.opportunity.OPP_rb_Share_Rep_1__c;
        this.takedown.TBO020_pr_Sharing_1__c = this.opportunity.OPP_pr_Sharing_1__c;
        this.takedown.TBO020_ls_Sharing_Type_1__c = this.opportunity.OPP_ls_Shadow_Split__c;
        this.takedown.TBO020_rb_Share_Rep_2__c = this.opportunity.OPP_rb_Share_Rep_2__c;
        this.takedown.TBO020_pr_Sharing_2__c = this.opportunity.OPP_pr_Sharing_2__c;
        this.takedown.TBO020_ls_Sharing_Type_2__c = this.opportunity.OPP_ls_Sharing_Type_2__c;
        this.takedown.TBO020_rb_Share_Rep_3__c = this.opportunity.OPP_rb_Share_Rep_3__c;
        this.takedown.TBO020_pr_Sharing_3__c = this.opportunity.OPP_pr_Sharing_3__c;
        this.takedown.TBO020_ls_Sharing_Type_3__c = this.opportunity.OPP_ls_Sharing_Type_3__c;
        this.takedown.TBO020_rb_Share_Rep_4__c = this.opportunity.OPP_rb_Share_Rep_4__c;
        this.takedown.TBO020_pr_Sharing_4__c = this.opportunity.OPP_pr_Sharing_4__c;
        this.takedown.TBO020_ls_Sharing_Type_4__c = this.opportunity.OPP_ls_Sharing_Type_4__c;
        this.takedown.TBO020_rb_Refered_by__c = this.opportunity.OPP_rb_Refered_by__c;
        this.takedown.TBO020_ls_Marketing_Initiative_1__c = this.opportunity.OPP_ls_Marketing_Initiative_1__c;
        this.takedown.TBO020_ls_Marketing_Initiative_2__c = this.opportunity.OPP_ls_Marketing_Initiative_2__c;
        this.takedown.TBO020_ls_Marketing_Initiative_3__c = this.opportunity.OPP_ls_Marketing_Initiative_3__c;
                
        this.pricingsValues = new Map<Id, String>();
            
        for (TBO018_Pricing__c pricing : [SELECT Id, Name FROM TBO018_Pricing__c WHERE TBO018_ls_Type__c = 'Booking' AND TBO018_rb_Opportunity__c = : oppId AND TBO018_rb_Takedowns__c = null]) {
            this.pricingsValues.put(pricing.Id, pricing.Name);
        }
        
        this.pricingsValuesLeft = new Map<Id, String>();
        this.pricingsValuesLeft.putAll(this.pricingsValues);
        
        this.pricingsValuesRight = new Map<Id, String>();
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
        try {
            insert this.takedown;
        }
        catch(Exception exTakedown) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, exTakedown.getMessage() + ' (Line: ' + exTakedown.getLineNumber()));
        	
            return null;
        }
        
        List<TBO018_Pricing__c> pricingUpdtList = new List<TBO018_Pricing__c>();
        
        if (pricingsValuesRight.size() > 0) {
            for (TBO018_Pricing__c pricing : [SELECT TBO018_rb_Takedowns__c FROM TBO018_Pricing__c WHERE Id IN :pricingsValuesRight.keySet()]) {
                pricing.TBO018_rb_Takedowns__c = this.takedown.Id;
                
                pricingUpdtList.add(pricing);
            }
        }
        
        if (pricingUpdtList.size() > 0) {
            try {
            	update pricingUpdtList;
            }
            catch(Exception exUptPricing) {
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, exUptPricing.getMessage() + ' (Line: ' + exUptPricing.getLineNumber()));
            	
                return null;
            }
        }
        
        PageReference returnTo = new PageReference('/' + this.takedown.Id);
        returnTo.setRedirect(true);
        
        return returnTo;
    }
    
    public PageReference btnCancel() {
        PageReference cancel = new PageReference('/' + this.opportunity.Id);
        cancel.setRedirect(true);
        
        return cancel;
    }
}