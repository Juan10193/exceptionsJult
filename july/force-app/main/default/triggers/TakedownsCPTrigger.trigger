/**
 * @File Name          : TakedownsCPTrigger.trigger
 * @Description        : 
 * @Author             : eduardo.villegas@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : eduardo.villegas@engeniumcapital.com
 * @Last Modified On   : 11/11/2019 20:39:57
 * @Modification Log   : 
 * Ver       Date            Author                 Modification
 * 1.0    11/11/2019   eduardo.villegas@engeniumcapital.com     Initial Version
**/
trigger TakedownsCPTrigger on Takedowns_Contingency_plan__c (before insert, before update, after insert, after update) {
    new TakedownsCPTriggerHandler_cls().run(); 
}