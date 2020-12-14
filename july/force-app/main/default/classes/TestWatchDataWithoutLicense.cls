public Without Sharing class TestWatchDataWithoutLicense {
    public List<wrapper> getPricinPQ(){
        List<wrapper> listWrapper = new List<wrapper>();
        for(IST__SuperTRUMP_Pricing_Quote__c pq : [Select id, name, Of_Payments__c, IST__Cost__c, EBO__c, QuoteToGo_Use_Count__c,BookYield__c, IST__Delivery_Date__c from IST__SuperTRUMP_Pricing_Quote__c limit 20]){
        	wrapper w = new wrapper();
            w.ids = pq.id;
            w.name = pq.Name;
            w.Of_Payments = String.valueof(pq.Of_Payments__c);
            w.Cost = String.valueof(pq.IST__Cost__c);
            w.EBO = String.valueof(pq.EBO__c);
            w.QuoteToGo_Use_Count = string.valueof(pq.QuoteToGo_Use_Count__c);
            w.BookYield = string.valueof(pq.BookYield__c);
            w.Delivery_Date = string.valueof(pq.IST__Delivery_Date__c);
            listWrapper.add(w);
            
        }
        return listWrapper;
    }
    public class wrapper {
        public String ids {get;set;}
        public String name {get;set;}
        public String Of_Payments {get;set;}
        public String Cost {get;set;}
        public String EBO {get;set;}
        public String QuoteToGo_Use_Count {get;set;}
        public String BookYield {get;set;}
        public String Delivery_Date {get;set;}    
    }
    

}