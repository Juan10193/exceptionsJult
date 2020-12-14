trigger ES2_tr_triggerPrescreening on ES2_Obj_Prescreening__c (before insert,before update) {
    for( ES2_Obj_Prescreening__c ps: Trigger.new)
    {
        String sCurrencyOpp = [Select CurrencyIsoCode from opportunity where id =:ps.ES2_rb_Opportunity__c][0].CurrencyIsoCode;
        ps.CurrencyIsoCode = sCurrencyOpp;
        if(ps.CurrencyIsoCode == 'MXN')
        {
            ps.ES2_lst_USD_Sales_50__c = 'N/A';
        }
        if( String.isNotBlank( ps.ES2_fm_Economic_Group__c ))
        {
            ps.ES2_ls_Existing_Customer__c = 'Yes';
        }
        else
        {
            ps.ES2_ls_Existing_Customer__c = 'No';
        }
        
              
    }
}