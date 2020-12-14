public class TBO006_ext_UpdatePreCallPlan {
	private final TBO006_Pre_Call_Plan__c precallPlan {get; set;}
    public Account account {get; set;}
    public Contact contact {get; set;}
    public Boolean hasPrivileges {get; set;}

    public TBO006_ext_UpdatePreCallPlan(ApexPages.StandardController stdController) {
    	this.precallPlan = (TBO006_Pre_Call_Plan__c)stdController.getRecord();
        
        String profileName = [SELECT Name FROM Profile WHERE Id = :UserInfo.getProfileId() LIMIT 1].Name;
        
        this.hasPrivileges = (UserInfo.getUserId() == this.precallPlan.OwnerId) || (profileName == 'Administrator');
        
        try {
            this.account = [SELECT Id, ACC_tx_Commercial_Name__c, ACC_dv_Sales_Annual_Revenue__c, ACC_tx_OR_rating__c, ACC_rb_SIC_Code__c, ACC_fm_SIC_Code_Description__c, Website, BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry, ParentId, ACC_fh_Last_Touched_date__c, ACC_ls_Holding_Company_Country__c, ACC_ls_Entity_Type__c FROM Account WHERE Id = :precallPlan.TBO006_pd_Account__c];
        }
        catch (Exception exAccount) {
            this.account = new Account();
        }
        
        try {
            this.contact = [SELECT Id, AccountId, FirstName, LastName, CON_ls_Tittle__c, CON_ls_Type__c, Email, Phone, CON_ca_Principal__c FROM Contact WHERE AccountId = :this.precallPlan.TBO006_pd_Account__c AND CON_ca_Principal__c = true];
        }
        catch (Exception exContact) {
            this.contact = new Contact();
            
            if (this.contact.AccountId == null) {
                if (this.account != null) {
                    this.contact.AccountId = this.account.Id;
                }
            }
        }
    }
	
    public PageReference btnSave() {
        try {
            update this.precallPlan;
        }
        catch(Exception exAccountPlan) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,Util_cls.obtieneMensajeReglaValidacion(exAccountPlan)));
            
            return null;
        }
        
        try {
            upsert this.account;
        }
        catch(Exception exAccount) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,Util_cls.obtieneMensajeReglaValidacion(exAccount)));
            
            return null;
        }
        
        try {
            if (!this.contact.CON_ca_Principal__c) {
            	this.contact.CON_ca_Principal__c = true;
            }
            
            upsert this.contact;
        }
        catch(Exception exContact) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,Util_cls.obtieneMensajeReglaValidacion(exContact)));
            
            return null;
        }
        
        PageReference regresar = new PageReference('/' + precallPlan.Id);
        regresar.setRedirect(true);
        
        return regresar;
    }
    
    public PageReference btnCancel() {
        PageReference cancel = new PageReference('/' + this.precallPlan.Id);
        cancel.setRedirect(true);
        
        return cancel;
    }
}