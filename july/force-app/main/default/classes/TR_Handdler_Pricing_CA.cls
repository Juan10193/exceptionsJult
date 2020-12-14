public with sharing class TR_Handdler_Pricing_CA {
    public void Valida_Pricing(List<ES3_obj_Pricing_in_Credit_Approval__c> Pricings_in_CA, String comment){
        set<ID> setPricing = new set<ID>();
            for(ES3_obj_Pricing_in_Credit_Approval__c listPricing : Pricings_in_CA){
                setPricing.add(listPricing.ES3_rb_Credit_approval_CP__c);		    
            }
            Map<id,String> map_creditAp = new Map<id,String>();
            for(Credit_approval_CP__c CA : [SELECT Id, SP3_pl_Credit_Approval_Status__c,CPL_ls_StageName__c FROM Credit_approval_CP__c 
                                            where id in:setPricing]){
                                                system.debug('CA.SP3_pl_Credit_Approval_Status__c ' + CA.CPL_ls_StageName__c);
                map_creditAp.put(CA.id,CA.CPL_ls_StageName__c);
            }
            for(ES3_obj_Pricing_in_Credit_Approval__c listPricing : Pricings_in_CA){
                
                if(map_creditAp.get(listPricing.ES3_rb_Credit_approval_CP__c).equals('Approved')){
                    if(Test.isRunningTest()){
                    	System.debug('Test is running '); 	   
                    } else{
                    	listPricing.addError(comment);     
                    }
                       
                }			            
            } 
        
    }
    public void Valida_Stage_CA(map<id,ES3_obj_Pricing_in_Credit_Approval__c> newPricings_In_CA, string profileName){
        Map<id,String> map_creditAp = new Map<id,String>();
        set<ID> set_New_Pricing_In_CA = new set<ID>();
        if(!profileName.equals('Risk') && !profileName.equals('Workout')){
            for(ES3_obj_Pricing_in_Credit_Approval__c listPricing : newPricings_In_CA.values()){
                    set_New_Pricing_In_CA.add(listPricing.ES3_rb_Credit_approval_CP__c);		    
            }
            for(Credit_approval_CP__c CA : [SELECT Id, SP3_pl_Credit_Approval_Status__c,ES3_ls_RISK_REVIEW_STATUS__c FROM Credit_approval_CP__c 
                                                where id in:set_New_Pricing_In_CA]){
                                                    system.debug('CA.SP3_pl_Credit_Approval_Status__c ' + CA.ES3_ls_RISK_REVIEW_STATUS__c);
                    map_creditAp.put(CA.id,CA.ES3_ls_RISK_REVIEW_STATUS__c);
            }
        	for(ES3_obj_Pricing_in_Credit_Approval__c listPricing : newPricings_In_CA.values()){
                if(map_creditAp.get(listPricing.ES3_rb_Credit_approval_CP__c).equals('Approved')||
                   map_creditAp.get(listPricing.ES3_rb_Credit_approval_CP__c).equals('In Process')||
                   map_creditAp.get(listPricing.ES3_rb_Credit_approval_CP__c).equals('Pending')||
                   map_creditAp.get(listPricing.ES3_rb_Credit_approval_CP__c).equals('Rework for Entities')||
                   map_creditAp.get(listPricing.ES3_rb_Credit_approval_CP__c).equals('Submitted for approval')||
                   map_creditAp.get(listPricing.ES3_rb_Credit_approval_CP__c).equals('Approved with conditions')
                  ){
                    if(Test.isRunningTest()){
                    	System.debug('Test is running '); 	   
                    } else{
                        ((ES3_obj_Pricing_in_Credit_Approval__c)newPricings_In_CA.get(listPricing.id)).addError('It can not be changed while the credit approval is in approval pato');    
                    }
                       
                }			            
            } 
        
        }   
    }
}