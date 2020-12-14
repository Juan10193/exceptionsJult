global class Wrapper_Takedown_seguro {
    public Takedowns_Contingency_plan__c[] takedownCP {get; set;}
    public Integer numberPage {get; set;}
    
    public Wrapper_Takedown_seguro (Takedowns_Contingency_plan__c[] takedownCP, Integer numberPage) {
        this.takedownCP = takedownCP;
        this.numberPage = numberPage;
    }
}