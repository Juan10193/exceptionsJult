trigger PPF_TR_CreateProgressPayment on Takedowns_Contingency_plan__c (after insert, after update) {
    
    System.debug('OEJ Entramos en el trigger size() ' + trigger.new.size());
    
    for(Integer i=0; i<trigger.new.size(); i++)
    {
        //Si cumple con las condiciones
        //Annex_Pricing_SuperTrump__c NO VACIO
        //CLI_nu_PP_Number__c = 1
        //CPL_ls_Deal_Category__c = Progress Payment
        string sr = [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='fecha limite'][0].EIV_tx_parameter__c;
        System.debug('OEJ Entramos en el trigger de progress Payment: ' + String.isNotBlank(trigger.new[i].Annex_Pricing_SuperTrump__c) 
                     + ' : ' + String.valueOf(trigger.new[i].CLI_nu_PP_Number__c) 
                     + ' : ' + trigger.new[i].CPL_ls_Deal_Category__c);
        if( String.isNotBlank(trigger.new[i].Annex_Pricing_SuperTrump__c) 
           && String.valueOf(trigger.new[i].CLI_nu_PP_Number__c) == '1' 
           && Date.valueOf(trigger.new[i].CreatedDate) >= Date.valueOf(sr)
           && trigger.new[i].CPL_ls_Deal_Category__c == 'Progress Payment')
        {
            System.debug('OEJ Entramos en el IF de Progress Payment'); 
            //No existe ningun registro con el mismo TD en el campo PPF_rb_Original_Takedown_CP__c
            IST__SuperTRUMP_Pricing_Quote__c STPQ = [Select id,IST__Commencement__c from IST__SuperTRUMP_Pricing_Quote__c where id =: trigger.new[i].Annex_Pricing_SuperTrump__c][0];
            System.debug('OEJ Entramos en el IF de Progress Payment STPQ:' + STPQ); 
            Progress_Payment__c pp = new Progress_Payment__c();
            System.debug('OEJ trigger.new[i].name:' + trigger.new[i].name); 
            pp.PPE_txid_Original_Takedown_CP__c = trigger.new[i].name;
            pp.PPF_rb_Opportunity__c = trigger.new[i].CPL_rb_Opp__c;
            pp.CurrencyIsoCode = trigger.new[i].CurrencyIsoCode;
            pp.PPF_dt_Commencement__c = STPQ.IST__Commencement__c;
            pp.PPE_rb_User_ISC__c = trigger.new[i].CLI_rb_Inside_Sales_Owner__c;
            //pp.PPF_rb_Takedown__c = trigger.new[i].id;
            pp.PPF_rb_Original_Takedown_ProgressPayment__c = trigger.new[i].id;
            System.debug('OEJ pp:' + pp);
            try{
                insert pp;
                
            }
            catch(exception e)
            {
                Progress_Payment__c ppO = new Progress_Payment__c();
                ppO = [Select id from Progress_Payment__c where PPF_rb_Original_Takedown_ProgressPayment__c =: trigger.new[i].id][0];
                ppO.PPF_dt_Commencement__c = STPQ.IST__Commencement__c;
                System.debug('OEJ Ya existe un PP para el TD, se actualiza ');
                
            }
            
        }
        if( String.isNotBlank(trigger.new[i].CLI_rb_Inside_sales_owner__c) )
        {
           List<Progress_Payment__c>  ppList = new List<Progress_Payment__c>();
            try{
                ppList = [Select id from Progress_Payment__c where PPF_rb_Original_Takedown_ProgressPayment__c =: trigger.new[i].id];
            }
            catch(exception e)
            {
                
            }
            if (ppList.size()>0)
            {
                List<Progress_Payment__c>  ppListToUpdate = new List<Progress_Payment__c>();
                for(Progress_Payment__c pp : ppList)
                {
                    pp.PPE_rb_User_ISC__c  =  trigger.new[i].CLI_rb_Inside_sales_owner__c;
                    ppListToUpdate.add(pp);
                    List<PPF_obj_Progress_Payment_Fee__c> ppfList = new List<PPF_obj_Progress_Payment_Fee__c>();
                    try{
                        ppfList = [Select id from PPF_obj_Progress_Payment_Fee__c where PPF_rb_progress_payment__c =:pp.id ];
                    }
                    catch(exception e)
                    {
                        
                    }
                    if(ppfList.size()>0)
                    {
                        List<PPF_obj_Progress_Payment_Fee__c> ppfListtoUpdate = new  List<PPF_obj_Progress_Payment_Fee__c>();
                        for(PPF_obj_Progress_Payment_Fee__c ppf : ppfList)
                        {
                            ppf.PPF_rb_User_ISC__c = trigger.new[i].CLI_rb_Inside_sales_owner__c;
                            ppfListtoUpdate.add(ppf);
                        }
                        update ppfListtoUpdate;
                    }
                    
                }
                update ppListToUpdate;
            }
        }
        
        
                 
        
    }
    
}