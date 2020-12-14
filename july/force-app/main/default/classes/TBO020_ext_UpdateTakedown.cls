public class TBO020_ext_UpdateTakedown {
	private final TBO020_Takedowns__c 		takedown  		  		{set; get;}
    public		  Opportunity				opportunity		  		{set; get;}
    
    public 	List<String> 					selectedPricingsLeft    {set; get;}
    public 	List<String> 					selectedPricingsRight   {set; get;}
    		Map<Id, String> 				pricingsValues          {set; get;}
    		Map<Id, String> 				pricingsValuesLeft      {set; get;}
    		Map<Id, String> 				pricingsValuesRight     {set; get;}
    
    public 	Boolean 						hasPrivileges 			{set; get;}
    
     public TBO020_ext_UpdateTakedown(ApexPages.StandardController stdController) {
        this.takedown = (TBO020_Takedowns__c)stdController.getRecord();
        
        String profileName = [SELECT Name FROM Profile WHERE Id = :UserInfo.getProfileId() LIMIT 1].Name;
         
        OpportunityShare oppShare;
         
         try {
             
             List<GroupMember> memberLists = [SELECT GroupId FROM GroupMember WHERE UserOrGroupId = :UserInfo.getUserId()];
             
             if (memberLists != null) {
                 
                 Set<Id> memberIds = new Set<Id>();
                 
                 for (GroupMember gm : memberLists) {
                     memberIds.add(gm.GroupId);
                 }
                 
             	 oppShare = [SELECT Id FROM OpportunityShare WHERE UserOrGroupId IN :memberIds AND OpportunityId = : this.takedown.TBO020_pd_Opportunity__c LIMIT 1];
             }
             else {
             	oppShare = [SELECT Id FROM OpportunityShare WHERE UserOrGroupId = :UserInfo.getUserId() AND OpportunityId = : this.takedown.TBO020_pd_Opportunity__c LIMIT 1];
             }
         }
         catch (Exception exGetOppShare) {
             System.debug('Error: ' + exGetOppShare.getMessage() + ' (Line: ' + exGetOppShare.getLineNumber() + ').');
         }
          	        
        this.opportunity = [SELECT Id, AccountId, OwnerId, OPP_tx_Original_Owner__c FROM Opportunity WHERE Id = :this.takedown.TBO020_pd_Opportunity__c];
         
         if (oppShare != null) {
             this.hasPrivileges = true;
         }
         else {
        	this.hasPrivileges = ((UserInfo.getUserId() == this.opportunity.OwnerId) || (profileName.equals('Administrator'))) && (!profileName.equals('Genérico'));
         }
         
        this.pricingsValues = new Map<Id, String>();
            
        for (TBO018_Pricing__c pricing : [SELECT Id, Name FROM TBO018_Pricing__c WHERE TBO018_ls_Type__c = 'Booking' AND TBO018_rb_Opportunity__c = :this.opportunity.Id AND TBO018_rb_Takedowns__c = null]) {
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
            update this.takedown;
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
        PageReference cancel = new PageReference('/' + this.takedown.Id);
        cancel.setRedirect(true);
        
        return cancel;
    }
}