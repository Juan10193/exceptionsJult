trigger TBO018_tgr_Pricing on TBO018_Pricing__c (before insert, before update) {
    
    TBO018_tgr_Handdler_Pricing handdler_pricing = new TBO018_tgr_Handdler_Pricing();
    
    for (TBO018_Pricing__c pricing : Trigger.new) {
        if (Trigger.isBefore) {
            if (Trigger.isInsert || Trigger.isUpdate) {
                
                Boolean BookYieldChanged = false;
                
                if (Trigger.isInsert) {
                    if (pricing.TBO018_pr_Book_Yield__c != null) {
                        BookYieldChanged = true;
                    }
                }
                else if (Trigger.isUpdate) {
                    if ((pricing.TBO018_pr_Book_Yield__c != Trigger.oldMap.get(pricing.Id).TBO018_pr_Book_Yield__c)) {
                        BookYieldChanged = true;
                    }
                }
                
                if (String.isNotEmpty(pricing.TBO018_rb_Opportunity__c) && String.isNotEmpty(pricing.TBO018_tx_Supertrump_Template__c) && BookYieldChanged) {
                    
                    Opportunity opp = [SELECT AccountId, OPP_ls_Line_of_Business__c, OPP_ls_Collateral__c,CPL_dv_Approved_Amount__c,Target_Market_LMM__c FROM Opportunity WHERE Id = :pricing.TBO018_rb_Opportunity__c];
                    
                    if (String.isNotEmpty(opp.AccountId) && String.isNotEmpty(opp.OPP_ls_Line_of_Business__c) && String.isNotEmpty(opp.OPP_ls_Collateral__c)) {
                        
                       // Account acc = [SELECT ACC_fm_Target_Market__c FROM Account WHERE Id = :opp.AccountId];
                        
                        if (String.isNotEmpty(opp.Target_Market_LMM__c /*acc.ACC_fm_Target_Market__c*/)) {
                              
                            Decimal MaxBookYield = 0;
                            Decimal MinBookYield = 0;
                            Decimal TargetBookYield = 0;
                            Decimal MontoOpp = 0;
                            Decimal MontoPric = 0;

                       if(/*acc.ACC_fm_Target_Market__c == 'Lower middle market' && pricing.CurrencyIsoCode =='MXN' ||*/ opp.Target_Market_LMM__c== 'Lower middle market' && pricing.CurrencyIsoCode =='MXN'){
                    
                           if(pricing.TBO018_dv_Amount__c < 10000000){
                               
                               MontoPric = 10000000;
                           } else   if(pricing.TBO018_dv_Amount__c > 10000000 && pricing.TBO018_dv_Amount__c < 15000000 ){
                               
                               MontoPric = 15000000;
                           } else {
                               
                               MontoPric = 15000001;
                           }
                           
                           
                       } else  if(/*acc.ACC_fm_Target_Market__c == 'Lower middle market' && pricing.CurrencyIsoCode =='USD' ||*/ opp.Target_Market_LMM__c== 'Lower middle market' && pricing.CurrencyIsoCode =='USD'){
                           
                           
                           if(pricing.TBO018_dv_Amount__c < 500000){
                               
                               MontoPric = 500000;
                           } else   if(pricing.TBO018_dv_Amount__c > 500000 && pricing.TBO018_dv_Amount__c < 750000 ){
                               
                               MontoPric = 750000;
                           } else {
                               
                               MontoPric = 750001;
                           }
                           
                           
                       } else {
                           
                           MontoPric= 0;
                           
                       }
                          
                                
                            List <ReglasAprobacionBookYield__c>  Valores = new List <ReglasAprobacionBookYield__c> ([Select Min_Book_Yield__c, Max_Book_Yield__c, Target_Book_Yield__c  from ReglasAprobacionBookYield__c where Tipo_Moneda__c =: pricing.CurrencyIsoCode and Target_Market_BY__c =: opp.Target_Market_LMM__c /*acc.ACC_fm_Target_Market__c*/ and Collateral_Oportunidad__c =: opp.OPP_ls_Collateral__c and Line_of_Business_BY__c =: opp.OPP_ls_Line_of_Business__c and Supertrump_Template_BY__c =:pricing.TBO018_tx_Supertrump_Template__c and Monto_Opportunidad__c =:MontoPric LIMIT 1]);                            
                                  
                             if (Valores.size ()> 0) {
                           
                                 MaxBookYield = Valores[0].Max_Book_Yield__c;
                                         MinBookYield = Valores[0].Min_Book_Yield__c;
                                         TargetBookYield = Valores[0].Target_Book_Yield__c;
                                      
                                    
                                     system.debug('target ' + TargetBookYield +'Maximo' + MaxBookYield +  'Minimo ' +  MinBookYield + 'BookYield '+ pricing.TBO018_pr_Book_Yield__c );

                                                if (pricing.TBO018_pr_Book_Yield__c >= TargetBookYield) {
                                                    pricing.TBO018_nu_ApprovalOrder__c = 1;
                                                }
        
                                                else if ((pricing.TBO018_pr_Book_Yield__c < TargetBookYield) && (pricing.TBO018_pr_Book_Yield__c >= MaxBookYield)) {
                                                    pricing.TBO018_nu_ApprovalOrder__c = 2;
                                                }
                                                
                                                else if ((pricing.TBO018_pr_Book_Yield__c <= MaxBookYield)) {
                                                    pricing.TBO018_nu_ApprovalOrder__c = 3;
                                                }
                                
                             }
                                
                       
                        }
                    }
                }
            }
        }
    }
    //submited for aproval y approved     
    if (Trigger.isUpdate && Trigger.isBefore){
        handdler_pricing.Valida_Pricing(Trigger.newMap); 
        handdler_pricing.validasendforapp(Trigger.newMap,Trigger.oldMap);
    }
    
}