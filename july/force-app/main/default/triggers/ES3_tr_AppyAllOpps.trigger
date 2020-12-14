trigger ES3_tr_AppyAllOpps on ES3_obj_Condition_Service_covenant__c (before insert) {
    List<ES3_obj_Condition_Service_covenant__c> SC = new List<ES3_obj_Condition_Service_covenant__c>();
    for(Integer i=0; i<trigger.new.size(); i++)
    {
        if(  String.isEmpty(String.valueOf(trigger.new[i].ES3_rb_Oportunidad__c)) )
        {
            //Debemos copiar el registro en todas las opps
            //Seleccionamos todas las opps que estan en el Credit Approval
            List<Opportunity_in_Credit_approval_CP__c> oppsInCa = new List<Opportunity_in_Credit_approval_CP__c>();
            try
            { 
            	oppsInCa = [Select Id, CP_rb_Oportunidad__c from Opportunity_in_Credit_approval_CP__c 
                            where CP_rb_Credit_approval_CP__c =: trigger.new[i].ES3_rb_Credit_approval_CP__c];
                System.debug('Oportunidades In CA OEJ.....' + oppsInCa);
            }
            Catch(Exception e)
            {
                System.debug('No hay oportunidades a quien agregar.....');
            }
            //Recorremos la lista y agregamos todas las condiciones
            if(oppsInCa.size()>0)
            {
                Integer count = 1;
                for(Opportunity_in_Credit_approval_CP__c oppInCA : oppsInCA)
                {
                    System.debug('Oportunidad In CA en el for OEJ.....' + oppInCA);
                    System.debug('Oportunidad In CA RecordType OEJ.....' + trigger.new[i]);
                    if(count == 1)
                    {
                        trigger.new[i].ES3_rb_Oportunidad__c= oppInCA.CP_rb_Oportunidad__c;
                        trigger.new[i].ES3_rb_Opportunity_in_Credit_approval_CP__c= oppInCA.Id;
                        System.debug('Oportunidad In CA Primero OEJ.....' + trigger.new[i]);
                    }
                    else
                    {
                        System.debug('Oportunidad In CA Segundos OEJ.....' + trigger.new[i]);
                        SC.add(new ES3_obj_Condition_Service_covenant__c(RecordTypeId = trigger.new[i].RecordTypeId,ES3_LST_Applies_To__c = trigger.new[i].ES3_LST_Applies_To__c,ES3_lst_Condition__c= trigger.new[i].ES3_lst_Condition__c, 
                               ES3_LST_Covenant_Cualitativo__c= trigger.new[i].ES3_LST_Covenant_Cualitativo__c ,ES3_lst_Covenant_Cuantitativo__c= trigger.new[i].ES3_lst_Covenant_Cuantitativo__c, ES3_rb_Credit_approval_CP__c= trigger.new[i].ES3_rb_Credit_approval_CP__c ,ES3_DATE_Date__c= trigger.new[i].ES3_DATE_Date__c ,ES3_TXT_Description__c= trigger.new[i].ES3_TXT_Description__c,
                               ES3_LT_Min_Max__c= trigger.new[i].ES3_LT_Min_Max__c ,ES3_rb_Oportunidad__c= oppInCA.CP_rb_Oportunidad__c ,ES3_rb_Opportunity_in_Credit_approval_CP__c= oppInCA.Id, ES3_TX_Other__c= trigger.new[i].ES3_TX_Other__c ,ES3_LST_Review__c= trigger.new[i].ES3_LST_Review__c ,ES3_txt_Service_Comments__c= trigger.new[i].ES3_txt_Service_Comments__c,
                               ES3_lst_Services__c= trigger.new[i].ES3_lst_Services__c ,ES3_lt_Status__c= trigger.new[i].ES3_lt_Status__c ,ES3_TXT_Threshold__c= trigger.new[i].ES3_TXT_Threshold__c, ES3_lt_Timing__c= trigger.new[i].ES3_lt_Timing__c, ES3_rb_Entity__c = trigger.new[i].ES3_rb_Entity__c )); 
                    }
                    count = count + 1;
                    
                }
            }
            if (SC.size()>0) { insert SC; }
        }
        else
        {
            if(  String.isEmpty(String.valueOf(trigger.new[i].ES3_rb_Opportunity_in_Credit_approval_CP__c)) )
            {
                List<Opportunity_in_Credit_approval_CP__c> oppsInCa = new List<Opportunity_in_Credit_approval_CP__c>();
                try
                { 
                    oppsInCa = [Select Id, CP_rb_Oportunidad__c from Opportunity_in_Credit_approval_CP__c 
                                where CP_rb_Credit_approval_CP__c =: trigger.new[i].ES3_rb_Credit_approval_CP__c
                                and CP_rb_Oportunidad__c =:trigger.new[i].ES3_rb_Oportunidad__c ];
                }
                Catch(Exception e)
                {
                    System.debug('No hay oportunidades a quien agregar.....');
                }
                if(oppsInCa.size()>0)
                {   
                    trigger.new[i].ES3_rb_Oportunidad__c= oppsInCa[0].CP_rb_Oportunidad__c;
                    trigger.new[i].ES3_rb_Opportunity_in_Credit_approval_CP__c= oppsInCa[0].Id;                
                }
            }
        }
    }
}