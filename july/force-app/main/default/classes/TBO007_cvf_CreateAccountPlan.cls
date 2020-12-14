public class TBO007_cvf_CreateAccountPlan {
	public TBO007_Account_Plan__c accountPlan {get; set;}
    public Account account {get; set;}
    public Contact contact {get; set;}
    
    public TBO007_cvf_CreateAccountPlan() {
        this.accountPlan = new TBO007_Account_Plan__c();
        
        Id accountId = ApexPages.currentPage().getParameters().get('account');
       
        this.accountPlan.TBO007_rb_Account__c = accountId;
        
        try {
            this.account = [SELECT Id, ACC_tx_Commercial_Name__c, ACC_dv_Sales_Annual_Revenue__c, ACC_tx_OR_rating__c, ACC_un_Total_Exposure__c, ACC_un_Capex_Exposure__c, ACC_un_Technology_Exposure__c, ACC_un_Fleet_Exposure__c, ACC_un_Real_Estate_Exposure__c, ACC_rb_SIC_Code__c, ACC_fm_SIC_Code_Description__c, Website, BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry, ParentId, ACC_fh_Last_Touched_date__c, ACC_ls_Holding_Company_Country__c, ACC_ls_Entity_Type__c FROM Account WHERE Id = :accountId];
        }
        catch (Exception exAccount) {
            this.account = new Account();
        }
        
        try {
            this.contact = [SELECT Id, AccountId, FirstName, LastName, CON_ls_Tittle__c, CON_ls_Type__c, Email, Phone, CON_ca_Principal__c FROM Contact WHERE AccountId = :accountId AND CON_ca_Principal__c = true];
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
        
        if ((this.accountPlan.TBO007_un_Expected_Volume_CapEx__c == null) && (this.accountPlan.TBO007_un_Expected_Volume_Fleet__c == null) && (this.accountPlan.TBO007_un_Expected_Volume_Real_Estate__c == null) && (this.accountPlan.TBO007_un_Expected_Volume_TF__c == null)) {
            ApexPages.Message message = new ApexPages.message(ApexPages.severity.ERROR,'At least one of the volume fields must be filled.');
            ApexPages.addMessage(message);
            
            this.accountPlan.TBO007_un_Expected_Volume_CapEx__c.addError('At least one of the volume fields must be filled.');
            this.accountPlan.TBO007_un_Expected_Volume_Fleet__c.addError('At least one of the volume fields must be filled.');
            this.accountPlan.TBO007_un_Expected_Volume_Real_Estate__c.addError('At least one of the volume fields must be filled.');
            this.accountPlan.TBO007_un_Expected_Volume_TF__c.addError('At least one of the volume fields must be filled.');
            
            return null;
        }
        
        try {
            insert this.accountPlan;
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
        
        PageReference regresar = new PageReference('/' + accountPlan.Id);
        regresar.setRedirect(true);
        
        return regresar;
    }
    
    public PageReference btnCancel() {
        PageReference cancelar = new PageReference('/' + account.Id);
        cancelar.setRedirect(true);
        
        return cancelar;
    }
}