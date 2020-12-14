public class LMM_UpdateOpportunityTotalAmount {
    private List<EC_Quote__c> newListECQuote;
     private List<EC_Quote__c> oldListECQuote;
    private Map<Id, EC_Quote__c>oldMapECQuote;
    
    public LMM_UpdateOpportunityTotalAmount(List<EC_Quote__c> newListECQuote, Map<Id, EC_Quote__c>oldMapECQuote, list<EC_Quote__c>oldListQuote){
        system.debug('OLD MAP');
        system.debug(oldMapECQuote);
        this.newListECQuote = newListECQuote;
        this.oldMapECQuote = oldMapECQuote;
        this.oldListECQuote = oldListQuote;
    }
    
    public void searChOppsToUpdate(){
        list<Id>oppsIDS = new list<Id>();
        for(EC_Quote__c eq :newListECQuote ){
            if(eq.Opportunity__c != null){
                oppsIDS.add(eq.Opportunity__c);
            }
            
        }
        
        list<Opportunity> opps = [Select Id,Amount, (Select Id from EC_Quotes__r)  from Opportunity where Id IN:oppsIDS];
        
        sumOppsAmount(opps, newListECQuote);
       
    }
    
    public void searchOppsaFterUpdate(){
        boolean sumar = true;
        list<Id>oppsIDS = new list<Id>();
        for(EC_Quote__c eq :newListECQuote ){
            EC_Quote__c oldEquote = oldMapECQuote.get(eq.Id);
            if(eq.Opportunity__c != null && oldEquote.Opportunity__c ==null){
                oppsIDS.add(eq.Opportunity__c);
                sumar = true;
            }
            
            if(eq.Opportunity__c !=null && eq.Opportunity__c != oldEquote.Opportunity__c ){
                oppsIDS.add(oldEquote.Opportunity__c);
                sumar = false;
            }

            if(eq.Opportunity__c ==null && eq.Opportunity__c != oldEquote.Opportunity__c ){
                oppsIDS.add(oldEquote.Opportunity__c);
                sumar = false;
            }
            
        } 
        
        list<Opportunity> opps = [Select Id, Amount, (Select Id from EC_Quotes__r) from Opportunity where Id IN:oppsIDS];
        if(sumar == true){
            sumOppsAmount(opps,newListECQuote);
        }else{
            restOppsAmount(opps,oldListECQuote);
            searChOppsToUpdate();
        }
    }
    
    public void searchOppsaFterDelete(){
        list<Id>oppsIDS = new list<Id>();
        for(EC_Quote__c eq: oldListECQuote){
           if(eq.Opportunity__c != null){
                oppsIDS.add(eq.Opportunity__c);
            }
        }
        
         list<Opportunity> opps = [Select Id, Amount,(Select Id from EC_Quotes__r) from Opportunity where Id IN:oppsIDS];
        system.debug('LISTA DE OPS A RESTAR AL BORAR');
        system.debug(oppsIDS);
         restOppsAmount(opps,oldListECQuote);
    }
    
    public void sumOppsAmount(list<Opportunity>opps, list<EC_Quote__c>quotes){
        list<Opportunity>OppsToUpdate = new List<Opportunity>();
        for(EC_Quote__c quo: quotes){
            for(Opportunity opp: opps){
                if(quo.Opportunity__c == opp.Id){
                    opp.LMM_Count_EcQuotes__c = opp.EC_Quotes__r.size();
                    if(opp.Amount ==null){
                        opp.Amount = 0 + quo.Monto_Total__c;
                    }else{
                        opp.Amount += quo.Monto_Total__c;
                    }
                    
                    OppsToUpdate.add(opp);
                }
            }
        }
        if(OppsToUpdate.size()>0){
            update OppsToUpdate;
        }else{
            system.debug('No hay opps para sumar montos');
        }
        
    }
    
    public void restOppsAmount(list<Opportunity>opps, list<EC_Quote__c>oLdquotes){
        list<Opportunity>OppsToUpdate = new List<Opportunity>();
        for(EC_Quote__c quo: oLdquotes){
            for(Opportunity opp: opps){
                if(quo.Opportunity__c == opp.Id){
                    opp.LMM_Count_EcQuotes__c =opp.EC_Quotes__r.size();
                    opp.Amount = opp.Amount - quo.Monto_Total__c;
                    OppsToUpdate.add(opp);
                }
            }
        }
        if(OppsToUpdate.size()>0){
            update OppsToUpdate;
        }else{
            system.debug('No hay opps para restar montos');
        }
        
        
    }
    
    
}