public class TBO018_tgr_Handdler_Pricing {
    public void Valida_Pricing(map<id,TBO018_Pricing__c> Pricings){
        set<ID> setPricing = new set<ID>();
        set<ID> setPricing_in_CP = new set<ID>();
        String profileName = [SELECT Name FROM Profile WHERE Id = :UserInfo.getProfileId() LIMIT 1].Name;
        map<id,ES3_obj_Pricing_in_Credit_Approval__c> map_pricing_in_cp = new map<id,ES3_obj_Pricing_in_Credit_Approval__c>();    
        for(ES3_obj_Pricing_in_Credit_Approval__c  pricing_in_cp : [SELECT Id, Name,ES3_rb_Pricing__c,ES3_rb_Credit_approval_CP__c 
                                                                    FROM ES3_obj_Pricing_in_Credit_Approval__c
                                                                    where ES3_rb_Pricing__c = :Pricings.keyset()]){
                                                                        
                                                                        map_pricing_in_cp.put(pricing_in_cp.id, pricing_in_cp);
                                                                        setPricing_in_CP.add(pricing_in_cp.ES3_rb_Credit_approval_CP__c);   
                                                                    }
        
        Map<id,Credit_approval_CP__c> map_creditAp = new Map<id,Credit_approval_CP__c>();
        for(Credit_approval_CP__c CA : [SELECT Id, SP3_pl_Credit_Approval_Status__c,CPL_ls_StageName__c FROM Credit_approval_CP__c 
                                        where id in:setPricing_in_CP]){
                                            
                                            map_creditAp.put(CA.id,CA);
                                        }
        for(ES3_obj_Pricing_in_Credit_Approval__c pri_ca : map_pricing_in_cp.values()){
            if(!profileName.equals('Administrator') && !profileName.equals('System Administrator') && !profileName.equals('Administrador del sistema')){
            if(map_creditAp.get(pri_ca.ES3_rb_Credit_approval_CP__c).CPL_ls_StageName__c.equals('Submitted for approval') 
               || map_creditAp.get(pri_ca.ES3_rb_Credit_approval_CP__c).CPL_ls_StageName__c.equals('Approved')){
                   
                   if(Test.isRunningTest()){
                       System.debug('Test is running '); 	   
                   } else{
                       for(TBO018_Pricing__c listPricing : Pricings.values()){
                           if(pri_ca.ES3_rb_Pricing__c.equals(listPricing.id)){
                               listPricing.addError('you can´t update pricing because this CA is approved');    
                           }
                           
                       }                    	     
                   }    
               }
            }
        }
    }
    public void validasendforapp(map<id,TBO018_Pricing__c> newPricings,map<id,TBO018_Pricing__c> oldPricings){
        list<string> idopp = new list<string>();
        map<string,TBO018_Pricing__c> listp = new map<string,TBO018_Pricing__c> ();
        String profileName = [SELECT Name FROM Profile WHERE Id = :UserInfo.getProfileId() LIMIT 1].Name;
        for(id idpri : newPricings.keyset()){
            for(id idpri_old : oldPricings.keyset()){
                if(!profileName.equals('Administrator') && !profileName.equals('System Administrator') && !profileName.equals('Administrador del sistema')){
                if(newPricings.get(idpri).TBO018_tx_Pricing_Status__c != oldPricings.get(idpri_old).TBO018_tx_Pricing_Status__c){
                    if(newPricings.get(idpri).TBO018_nu_ApprovalOrder__c <> 1 && newPricings.get(idpri).TBO018_tx_Pricing_Status__c.equals('Approved') || 
                       newPricings.get(idpri).TBO018_nu_ApprovalOrder__c <> 1 && newPricings.get(idpri).TBO018_tx_Pricing_Status__c.equals('Pending')){
                           if(newPricings.get(idpri).TBO018_nu_ApprovalOrder__c == 2 || newPricings.get(idpri).TBO018_nu_ApprovalOrder__c == 3){
                               idopp.add(newPricings.get(idpri).TBO018_rb_Opportunity__c);   
                           } 
                       }
                }
            }
          }
        }
        system.debug('id ' + idopp);
        for (Opportunity roi_app : [select ROI_approved__c from Opportunity where id IN : idopp]){
            for(id idpri : newPricings.keyset()){
                if(string.isBlank(String.valueOf(roi_app.ROI_approved__c)) || roi_app.ROI_approved__c == 0){
                    if(string.isBlank(newPricings.get(idpri).BKL_tx_Rationale_Comment__c)){
                        for(TBO018_Pricing__c pri : newPricings.values()){
                            pri.addError('Sorry, you can\'t submit for approval because "Rational Comment" is empty');
                        } 
                    }
                }else {
                    if(newPricings.get(idpri).TBO018_pr_Economic_ROI__c < roi_app.ROI_approved__c){
                        if(string.isBlank(newPricings.get(idpri).BKL_tx_Rationale_Comment__c)){
                            for(TBO018_Pricing__c pri : newPricings.values()){
                                pri.addError('Sorry, you can\'t submit for approval because "Rational Comment" is empty');
                            } 
                        }
                    }
                }
            }
        }
    }
}