public class TakedownCPTgrServiceNewSuppliApp {
    
    public Map<Id, Takedowns_Contingency_plan__c> newMapTakedownCP {get;set;}
    
    public TakedownCPTgrServiceNewSuppliApp(map<Id, Takedowns_Contingency_plan__c> newMapTakedownCP){
        this.newMapTakedownCP = newMapTakedownCP;     
    }
    public void createSupplierInApproval(){
        list<Supplier_in_approval__c> listSuppInApproval = new list<Supplier_in_approval__c>();
        
        for(id takedownID : newMapTakedownCP.keySet()){
            Supplier_in_approval__c SuppInApproval = new Supplier_in_approval__c();
            SuppInApproval.TKD_rb_SupplierInApproval__c = takedownID;
            listSuppInApproval.add(SuppInApproval);
        }
        insert listSuppInApproval;
    }

}