global class PrmWrapperLead {
    public Account account {get; set ;}
    public Lead lead {get; set;}

    public PrmWrapperLead(Lead le) {
        lead = le;
    } 
    
    public PrmWrapperLead(Lead le, Account a) {
        account = a;
        lead = le;
    }
    
    public static String convierteSociedad(String numero) {
		List<SelectOption> options = new List<SelectOption>();
		Schema.DescribeFieldResult fieldResult = Schema.Lead.Prm_picklist_tipos__c.getDescribe();
		List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
		for(Schema.PicklistEntry f : ple) {
			options.add(new SelectOption(f.getLabel(), f.getValue()));
		}
        return String.valueOf(options[Integer.valueOf(numero)].getLabel());
    }
}