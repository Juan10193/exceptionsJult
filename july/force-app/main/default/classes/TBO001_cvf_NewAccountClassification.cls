public class TBO001_cvf_NewAccountClassification {
    public TBO001_AccountClassification__c accountClassification {get; set;}
    public String  tier    {get; set;}
    public Boolean hasPrivileges {get; set;}
    
    public TBO001_cvf_NewAccountClassification() {
    	this.accountClassification = new TBO001_AccountClassification__c();
        
        Id accountId = ApexPages.currentPage().getParameters().get('Id');
        
        this.accountClassification.TBO001_rb_Account__c = accountId;
        this.accountClassification.OwnerId = UserInfo.getUserId();
        this.accountClassification.TBO001_ls_Region__c = [SELECT USU_ls_Region__c FROM User WHERE Id = :UserInfo.getUserId()].USU_ls_Region__c;
        tier = this.accountClassification.TBO001_ls_Tier__c;
        
        String profileName = [SELECT Name FROM Profile WHERE Id = :UserInfo.getProfileId() LIMIT 1].Name;
        
        this.hasPrivileges = (profileName == 'Administrator') || (profileName == 'System Administrator');
    }
    
    public void setTier() {
        tier = this.accountClassification.TBO001_ls_Tier__c;
    }
    
    public PageReference btnSave() {
        
        if (String.isEmpty(this.accountClassification.TBO001_ls_Tier__c)) {
            this.accountClassification.TBO001_ls_Tier__c.addError('You must select a value.');
            
            return null;
        }
        
        if (String.isEmpty(this.accountClassification.TBO001_ls_Line_of_Business__c)) {
            this.accountClassification.TBO001_ls_Line_of_Business__c.addError('You must select a value.');
            
            return null;
        }
        
        if (this.accountClassification.TBO001_ls_Tier__c.equals('Tier Three') && String.isEmpty(this.accountClassification.TBO001_ls_CompanyRank__c)) {
            this.accountClassification.TBO001_ls_CompanyRank__c.addError('You must specify a value.');
            
            return null;
        }
        
        if (this.accountClassification.TBO001_ls_Tier__c.equals('Tier Four')) {
            
 			List<TBO001_AccountClassification__c> accountClassificationUptList = new List<TBO001_AccountClassification__c>();
            
            for (TBO001_AccountClassification__c accClassification : [SELECT TBO001_ls_Tier__c, TBO001_ls_CompanyRank__c FROM TBO001_AccountClassification__c WHERE TBO001_rb_Account__c = :accountClassification.TBO001_rb_Account__c]) {
                accClassification.TBO001_ls_Tier__c = this.accountClassification.TBO001_ls_Tier__c;
                
                accountClassificationUptList.add(accClassification);
            }
            
            if (accountClassificationUptList.size() > 0) {
                try {
                    upsert accountClassificationUptList;
                }
                catch(Exception exUdtAccountClass) {
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,exUdtAccountClass.getMessage()));
                }
        	}
        }
            
        if (!this.accountClassification.TBO001_ls_Tier__c.equals('Tier Three')) {
            this.accountClassification.TBO001_ls_CompanyRank__c = null;
        }
                
        try {
            insert this.accountClassification;
        }
        catch(Exception exInsAccountClass) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,exInsAccountClass.getMessage()));
        }
        
        if (this.accountClassification.TBO001_ls_Tier__c.equals('Tier Four')) {
            Account account;
            
            try {
            	account	= [SELECT Id, ACC_tx_Account_Tier__c FROM Account WHERE Id = :this.accountClassification.TBO001_rb_Account__c];
            }
            catch (Exception exGetAccount) {
                System.debug('Error: ' + exGetAccount.getMessage() + ' (Line: ' + exGetAccount.getLineNumber() + ')');
            }
            
            if (account != null) {
            	account.ACC_tx_Account_Tier__c = this.accountClassification.TBO001_ls_Tier__c;
                
                try {
                    upsert account;
                }
                catch(Exception exUpdAccount) {
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,exUpdAccount.getMessage()));
                }
            }
        }
        
        PageReference goBack = new PageReference('/' + this.accountClassification.Id);
        goBack.setRedirect(true);
        
        return goBack;
    }
    
    public PageReference btnCancel() {
        PageReference cancel = new PageReference('/' + this.accountClassification.TBO001_rb_Account__c);
        cancel.setRedirect(true);
        
        return cancel;
    }
}