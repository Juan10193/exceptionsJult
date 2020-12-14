({ // var action = cmp.get('c.getvalues');
    getData: function(cmp, event, helper,EGId) {
         cmp.set('v.columns', 
                        [
                            { label: 'Party Name', fieldName: 'WK_party_name__c', type: 'text'},
                            { label: 'Economic Group Name', fieldName: 'WK_economicGroupName__c', type: 'text'},
                            { label: 'Oracle Account Number', fieldName: 'WK_oracleAccountNumber__c', type: 'text'},
                            { label: 'Contract Number', fieldName: 'WK_contractNumber__c', type: 'text'},
                            { label: 'currency', fieldName: 'WK_currency__c', type: 'text'},
                            { label: 'product Name', fieldName: 'Name', type: 'text'},
                            { label: 'contract Oec', fieldName: 'WK_contractOec__c', type: 'number'},
                            { label: 'exposure', fieldName: 'WK_exposure__c', type: 'number'},
                            { label: 'nbv', fieldName: 'WK_nbv__c', type: 'number'},
                            { label: 'open Items Ar', fieldName: 'WK_open_Items_Ar__c', type: 'number'},
                            { label: 'days Due Ar', fieldName: 'WK_days_Due_Ar__c', type: 'number'},
                            { label: 'open Items Dlq', fieldName: 'WK_open_Items_Dlq__c', type: 'number'},
                            { label: 'days Due Dlq', fieldName: 'WK_days_Due_Dlq__c', type: 'number'},
                            { label: 'vertical', fieldName: 'vertical__c', type: 'text'}
                		]);
        // Create the action
        var action = cmp.get("c.getExposures");
         action.setParams({"EGId" : EGId});
        // Add callback behavior for when response is received
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                cmp.set("v.DataExposure", response.getReturnValue());
                console.log("Success" + state);
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        // Send action off to be executed
        $A.enqueueAction(action);
    },
    isRecordTypeWK: function(cmp, event, helper , nameCA) {
        // Create the action
        var action = cmp.get("c.getIsRecordTypeWK");
        action.setParams({"nameCA" : nameCA});
        // Add callback behavior for when response is received
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                cmp.set("v.isRecordTypeWK", response.getReturnValue());
                console.log("Success" + state);
                console.log("isRecordTypeWK: " + response.getReturnValue())
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        // Send action off to be executed
        $A.enqueueAction(action);
    }
})