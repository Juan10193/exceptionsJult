trigger PPF_TR_UpdateCommencementDateOnPP on IST__SuperTRUMP_Pricing_Quote__c (before update) {
    for(Integer i=0; i<trigger.new.size(); i++)
    {
        try{
            List<Progress_Payment__c> pp = [Select id, PPF_rb_Original_Takedown_ProgressPayment__c, PPF_rb_Original_Takedown_ProgressPayment__r.Annex_Pricing_SuperTrump__c                                            
                                            from Progress_Payment__c 
                                            where PPF_rb_Original_Takedown_ProgressPayment__r.Annex_Pricing_SuperTrump__c =: trigger.new[0].id]; 
            System.debug('OEJ pp a actualizar :' + pp + ' new date : ' +  trigger.new[0].IST__Commencement__c);
            
            for(Progress_Payment__c p : pp)
            {
                p.PPF_dt_Commencement__c = trigger.new[0].IST__Commencement__c;
                update p;
            }
            
        }
        catch(exception e)
        {
            System.debug('OEJ No hay Progres Payment que Actualizar');
        }
    }
}