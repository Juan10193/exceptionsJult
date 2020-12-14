trigger OpportunityTrigger on Opportunity (after update, before update, after delete, after insert) {
   
    new OpportunityTriggerHandler().run(); 
}