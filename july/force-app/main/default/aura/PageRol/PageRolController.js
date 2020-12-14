({
    refreshView : function(component,event,helper){
        console.log('click');
        component.set("v.recordError", null);
    },
    initialize: function(component, event, helper) {
    // call the fetchPickListVal helper function,
    // and pass (component, Field_API_Name, target_Attribute_Name_For_Store_Value)
    
    helper.fetchPickListVal(component, 'ES2_ms_Role__c', 'listSkillsOptions');
    
},
 
 handleChange: function (component, event) {
    // get the updated/changed values   
    var selectedOptionsList = event.getParam("value");
    // get the updated/changed source  
    var targetName = event.getSource().get("v.name");
    
    // update the selected itmes  
    if(targetName == 'Skills'){ 
        component.set("v.selectedSkillsItems" , selectedOptionsList);
    }
    
},
    getSelectedItems : function(component,event,helper){
        // get selected items on button click 
        alert(component.get("v.selectedSkillsItems"));
    },
        handleSaveRecord: function(component, event, helper) {
            var seleccionados= JSON.stringify(component.get("v.selectedSkillsItems"));
            seleccionados=seleccionados.replace('[', '');
            seleccionados=seleccionados.replace(']', '');
            seleccionados=seleccionados.replace(/,/g, ';');
            var reg = new RegExp(/['"']/g);
            seleccionados=seleccionados.replace(reg, '');
            console.log('seleccionados: ' + seleccionados);
            component.find("Rol").set("v.value", seleccionados);
            component.find("recordHandler").saveRecord($A.getCallback(function(saveResult) {
                // NOTE: If you want a specific behavior(an action or UI behavior) when this action is successful 
                // then handle that in a callback (generic logic when record is changed should be handled in recordUpdated event handler)
                if (saveResult.state === "SUCCESS" || saveResult.state === "DRAFT") {
                    // handle component related logic in event handler
                    
                    location.reload();
                } else if (saveResult.state === "INCOMPLETE") {
                    console.log("User is offline, device doesn't support drafts.");
                } else if (saveResult.state === "ERROR") {
                    console.log('Problem saving record, error: ' + JSON.stringify(saveResult.error));
                    component.set("v.recordError", JSON.stringify(saveResult.error[0].message) );
                } else {
                    console.log('Unknown problem, state: ' + saveResult.state + ', error: ' + JSON.stringify(saveResult.error));
                }
            }));
        },
            
            /**
     * Control the component behavior here when record is changed (via any component)
     */
        handleRecordUpdated: function(component, event, helper) {
            var eventParams = event.getParams();
            if(eventParams.changeType === "CHANGED") {
                // get the fields that changed for this record
                var changedFields = eventParams.changedFields;
                console.log('Fields that are changed: ' + JSON.stringify(changedFields));
                // record is changed, so refresh the component (or other component logic)
                var resultsToast = $A.get("e.force:showToast");
                resultsToast.setParams({
                    "title": "Saved",
                    "message": "The record was updated."
                });
                resultsToast.fire();
                
            } else if(eventParams.changeType === "LOADED") {
                // record is loaded in the cache
            } else if(eventParams.changeType === "REMOVED") {
                // record is deleted and removed from the cache
            } else if(eventParams.changeType === "ERROR") {
                // there’s an error while loading, saving or deleting the record
            }
        },
            openModel: function(component, event, helper) {
                // for Display Model,set the "isOpen" attribute to "true"
                component.set("v.isOpen", true);
            },
                
                closeModel: function(component, event, helper) {
                    // for Hide/Close Model,set the "isOpen" attribute to "Fasle"  
                    component.set("v.isOpen", false);
                },
                    
                    save: function(component, event, helper) {
                        // Display alert message on the click on the "Like and Close" button from Model Footer 
                        // and set set the "isOpen" attribute to "False for close the model Box.
                        alert('thanks for like Us :)');
                        component.set("v.isOpen", false);
                    },
                        
})