public class TakedownCPTgrServiceCreatePP { 
    
    public Map<Id, Takedowns_Contingency_plan__c> newMapTakedownCP {get;set;}
    
    public TakedownCPTgrServiceCreatePP(map<Id, Takedowns_Contingency_plan__c> newMapTakedownCP){
        this.newMapTakedownCP = newMapTakedownCP;        
    }    
    public void makeProgressPayment(){
        string fechaLimiteParam = [Select EIV_tx_parameter__c From EIV_Parameter__c Where Name ='fecha limite'][0].EIV_tx_parameter__c;
        set<id> setIdAnnex_Pricing_SuperTrump = new set<id>();
        for(Takedowns_Contingency_plan__c tkd_cp : this.newMapTakedownCP.values()){
        	setIdAnnex_Pricing_SuperTrump.add(tkd_cp.Annex_Pricing_SuperTrump__c);	    
        }
        map<id,IST__SuperTRUMP_Pricing_Quote__c> mapSTAnnexPricing = new map<id,IST__SuperTRUMP_Pricing_Quote__c>();
        for(IST__SuperTRUMP_Pricing_Quote__c IST_SuperTRUMP_Pricing_Quote : [Select id,IST__Commencement__c from IST__SuperTRUMP_Pricing_Quote__c where id in :setIdAnnex_Pricing_SuperTrump]){
        	mapSTAnnexPricing.put(IST_SuperTRUMP_Pricing_Quote.id, IST_SuperTRUMP_Pricing_Quote);    
        }        
        InsertPP(UpdatePP(mapSTAnnexPricing), mapSTAnnexPricing, fechaLimiteParam);
    }
    public Map<Id, Takedowns_Contingency_plan__c> UpdatePP(map<id,IST__SuperTRUMP_Pricing_Quote__c> mapSTAnnexPricing){
        list<Progress_Payment__c> listPp = new list<Progress_Payment__c>();
        Map<Id, Takedowns_Contingency_plan__c> newMapTakedownCPToInsert = new Map<Id, Takedowns_Contingency_plan__c>();
        newMapTakedownCPToInsert = this.newMapTakedownCP.clone();
        for(Progress_Payment__c pp : [Select id,PPF_rb_Original_Takedown_ProgressPayment__c,PPF_rb_Original_Takedown_ProgressPayment__r.Annex_Pricing_SuperTrump__c from Progress_Payment__c where PPF_rb_Original_Takedown_ProgressPayment__c in : this.newMapTakedownCP.keySet()]){
            system.debug('JDD:'+ pp);
        	pp.PPF_dt_Commencement__c = mapSTAnnexPricing.get(pp.PPF_rb_Original_Takedown_ProgressPayment__r.Annex_Pricing_SuperTrump__c).IST__Commencement__c;            
            if(String.isNotBlank(newMapTakedownCPToInsert.get(pp.PPF_rb_Original_Takedown_ProgressPayment__c).CLI_rb_Inside_sales_owner__c)){
            	pp.PPE_rb_User_ISC__c = newMapTakedownCPToInsert.get(pp.PPF_rb_Original_Takedown_ProgressPayment__c).CLI_rb_Inside_sales_owner__c;
            }
            listPp.add(pp);
            newMapTakedownCPToInsert.remove(pp.PPF_rb_Original_Takedown_ProgressPayment__c);            
        }        
        
        if(listPp.size() > 0){ 
            update listPp;
        }
        return newMapTakedownCPToInsert;
   	}	
    public void InsertPP(Map<Id, Takedowns_Contingency_plan__c> newMapTakedownCPToInsert, map<id,IST__SuperTRUMP_Pricing_Quote__c> mapSTAnnexPricing, string fechaLimiteParam){
        list<Progress_Payment__c> listProgress_Payment = new list<Progress_Payment__c>();
        
        for(id idTakedown: newMapTakedownCPToInsert.keySet()){
            if( String.isNotBlank(newMapTakedownCPToInsert.get(idTakedown).Annex_Pricing_SuperTrump__c) 
           && String.valueOf(newMapTakedownCPToInsert.get(idTakedown).CLI_nu_PP_Number__c) == '1' 
           && Date.valueOf(newMapTakedownCPToInsert.get(idTakedown).CreatedDate) >= Date.valueOf(fechaLimiteParam)
               && newMapTakedownCPToInsert.get(idTakedown).CPL_ls_Deal_Category__c == 'Progress Payment'){
                   	System.debug('OEJ Entramos en el IF de Progress Payment'); 
                    //No existe ningun registro con el mismo TD en el campo PPF_rb_Original_Takedown_CP__c
                    IST__SuperTRUMP_Pricing_Quote__c STPQ = mapSTAnnexPricing.get(newMapTakedownCPToInsert.get(idTakedown).Annex_Pricing_SuperTrump__c);
                    System.debug('OEJ Entramos en el IF de Progress Payment STPQ:' + STPQ); 
                    Progress_Payment__c pp = new Progress_Payment__c();
                    System.debug('OEJ trigger.new[i].name:' + newMapTakedownCPToInsert.get(idTakedown).name); 
                    pp.PPE_txid_Original_Takedown_CP__c = newMapTakedownCPToInsert.get(idTakedown).name;
                    pp.PPF_rb_Opportunity__c = newMapTakedownCPToInsert.get(idTakedown).CPL_rb_Opp__c;
                    pp.CurrencyIsoCode = newMapTakedownCPToInsert.get(idTakedown).CurrencyIsoCode;
                    pp.PPF_dt_Commencement__c = STPQ.IST__Commencement__c;
                    pp.PPE_rb_User_ISC__c = newMapTakedownCPToInsert.get(idTakedown).CLI_rb_Inside_Sales_Owner__c;
                    //pp.PPF_rb_Takedown__c = trigger.new[i].id;
                    pp.PPF_rb_Original_Takedown_ProgressPayment__c = idTakedown;
                    System.debug('OEJ pp:' + pp);
                    listProgress_Payment.add(pp);                   
               }            
        }
        if(listProgress_Payment.size() > 0 ){
        	insert listProgress_Payment;    
        }
        	
        
    }
}