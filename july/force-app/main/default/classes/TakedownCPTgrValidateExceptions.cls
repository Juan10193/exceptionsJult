public class TakedownCPTgrValidateExceptions {
    public Map<Id, Takedowns_Contingency_plan__c>  newMapTakedownCP {get;set;}
    public Map<Id, Takedowns_Contingency_plan__c>  oldMapTakedownCP {get;set;}
    List<Takedowns_Contingency_plan__c> newListTakedownCP {get;set;}
    
    public TakedownCPTgrValidateExceptions (List<Takedowns_Contingency_plan__c> newListTakedownCP, Map<Id, Takedowns_Contingency_plan__c> newMapTakedownCP, Map<Id, Takedowns_Contingency_plan__c>  oldMapTakedownCP){
        this.newMapTakedownCP = newMapTakedownCP;
        this.oldMapTakedownCP = oldMapTakedownCP;
        this.newListTakedownCP = newListTakedownCP;
    }
    
    
    public void validateExceptionsForT2(){
        Set<Id>pricingIds = new Set<Id>();
        Set<Id>caIds = new Set<Id>();
        set<id>opps = new set<id>();
        
        Map<Id, Takedowns_Contingency_plan__c> takedownforError =new Map<Id,Takedowns_Contingency_plan__c>();
        
        for(Takedowns_Contingency_plan__c tkdNew: newListTakedownCP){
            if(this.oldMapTakedownCP.get(tkdNew.Id).TKD_ls_takedown_stage__c =='In Signatures' &&
               this.newMapTakedownCP.get(tkdNew.Id).TKD_ls_takedown_stage__c =='Tollgate 2'
              ){
                  pricingIds.add(this.newMapTakedownCP.get(tkdNew.Id).TKD_rb_Pricin_CA__c);
                  opps.add(this.newMapTakedownCP.get(tkdNew.Id).CPL_rb_Opp__c);
              }
        }
        
        list<Takedowns_Contingency_plan__c> takedownsNoValid = new list<Takedowns_Contingency_plan__c>();
        
        if(pricingIds.size()>0){
            system.debug('Si pricingIds');
            system.debug(pricingIds);
            
            
            for(ES3_obj_Pricing_in_Credit_Approval__c pric:[Select Id, ES3_rb_Credit_approval_CP__c from ES3_obj_Pricing_in_Credit_Approval__c where Id IN:pricingIds]){
                system.debug('existe el pricing');
                system.debug(pric.ES3_rb_Credit_approval_CP__c);
                caIds.add(pric.ES3_rb_Credit_approval_CP__c);
                for(Takedowns_Contingency_plan__c tkdNew: this.newListTakedownCP){
                    system.debug('pricing new');
                    system.debug(tkdNew.TKD_rb_Pricin_CA__c);
                    if(tkdNew.TKD_rb_Pricin_CA__c == pric.Id){
                        
                        system.debug('entrando en if');
                        system.debug(tkdNew);
                        takedownforError.put(pric.ES3_rb_Credit_approval_CP__c, tkdNew);
                    }
                }
            }
            system.debug('takedowns for error');
            system.debug(takedownforError);
            if(caIds.size()>0){
                List<WaiverToGo__c> waivers =[Select Id, Credit_Approval__c,Is_postfounding__c,LMM_Opportunity__c, Stage__c from waiverToGo__c where Credit_Approval__c IN:caIds  ];
                for(WaiverToGo__c waiver:waivers){
                    if(waiver.Stage__c !='Closed' && waiver.Stage__c !='No Remediation Closed' && waiver.Stage__c !='Cancelled' && waiver.Is_postfounding__c ==false ){
                        system.debug('Si waivers sin terminar');
                        
                        takedownsNoValid.add(takedownforError.get(waiver.Credit_Approval__c));
                    }
                }
            }
            
            
            if(takedownsNoValid.size()>0){
                system.debug('Si takedowns no validos');
                system.debug(takedownsNoValid);
                for(Takedowns_Contingency_plan__c takedown: takedownsNoValid){
                    system.debug('hola id tkd: ' + takedown.Id);
                    
                    this.newMapTakedownCP.get(takedown.Id).addError('Please validate the stage on all Waivers on the credit Approval');
                }
            }
        }
        
        list<Takedowns_Contingency_plan__c> takedownsNoValidLMM = new list<Takedowns_Contingency_plan__c>();
        
        if(opps.size()>0){
            set<id>oppsLmm = new set<Id>();
            list<opportunity> opportunidades = [select Id, RecordType_Name__c from Opportunity where id IN:opps];
            for(opportunity opp : opportunidades){
                if(opp.RecordType_Name__c =='OPP_LMM'){
                    oppsLmm.add(opp.Id);
                    for(Takedowns_Contingency_plan__c tkdNew: this.newListTakedownCP){
                        if(tkdNew.CPL_rb_Opp__c == opp.Id){
                            takedownforError.put(opp.id, tkdNew);
                        }
                    }
                }
            }
            
            if(oppsLmm.size()>0){
                List<WaiverToGo__c> waivers =[Select Id,Is_postfounding__c,LMM_Opportunity__c, Stage__c from waiverToGo__c where LMM_Opportunity__c IN:oppsLmm];
                for(WaiverToGo__c waiver:waivers){
                    if(waiver.Stage__c !='Closed' && waiver.Stage__c !='No Remediation Closed' && waiver.Stage__c !='Cancelled' && waiver.Is_postfounding__c ==false ){
                        system.debug('Si waivers LMM sin terminar');
                        
                        takedownsNoValidLMM.add(takedownforError.get(waiver.LMM_Opportunity__c));
                    }
                }
            }
            
            if(takedownsNoValidLMM.size()>0){
                system.debug('Si takedownsLMM no validos');
                system.debug(takedownsNoValid);
                for(Takedowns_Contingency_plan__c takedown: takedownsNoValidLMM){
                    system.debug('hola id tkd: ' + takedown.Id);
                    
                    this.newMapTakedownCP.get(takedown.Id).addError('Please validate the stage on all Waivers on the Opportunity LMM');
                }
            }
        }
        
    }
    
}