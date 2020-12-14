trigger EC_Quote_trigger on EC_Quote__c (after insert, after update, after delete) {
	new EC_QuoteTriggerHandler().run();
}