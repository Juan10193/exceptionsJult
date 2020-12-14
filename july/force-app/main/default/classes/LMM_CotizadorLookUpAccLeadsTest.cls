@Istest
Private class LMM_CotizadorLookUpAccLeadsTest {
	@Istest
    STATIC void LMM_CotizadorLookUpAccLeadsSear(){
        list<id> a = new list<id>();
        Account b  = Data_Factory_Account_Test.createNewAccount('Nintendo');
        b.ACC_ls_Company_Legal_Name_Termination__c ='A.C';
        update b;
        LMM_CotizadorLookUpAccLeads.search('Nintendo',a );
        Lead c = new Lead();
        LMM_CotizadorLookUpAccLeads.getAccountFields(b.Id);
        try{
            LMM_CotizadorLookUpAccLeads.getLeadFields(c.Id);
        }catch(Exception e){
            system.debug(e);
        }
        
    }
}