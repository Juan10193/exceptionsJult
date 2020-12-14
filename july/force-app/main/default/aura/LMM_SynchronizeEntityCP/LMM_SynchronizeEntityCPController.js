/**
 * @File Name          : LMM_SynchronizeEntityCPController.js
 * @Description        : 
 * @Author             : eduardo.amiens@outlook.com
 * @Group              : 
 * @Last Modified By   : eduardo.amiens@outlook.com
 * @Last Modified On   : 12/6/2020 7:54:55
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    12/6/2020   eduardo.amiens@outlook.com     Initial Version
**/
({
    doInit: function (component, helper) {
        console.log('recordId' + JSON.stringify(component.get("v.recordId")));
        var updateEntityCP = component.get("c.updateEntityCP");
        updateEntityCP.setParams({
            enitytCPId: component.get("v.recordId")
        });
        updateEntityCP.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log("Success" + state);
                
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title: "Success!",
                    type: "success",
                    message: "The Entity CP has been Updated successfully."
                });
                toastEvent.fire();
                component.set("v.spinner", false);
                $A.get('e.force:refreshView').fire();
                //var appEvent = $A.get("e.c:TKD_SaveNewSupplier");
                //appEvent.fire();
            } else if (state === "ERROR") {
                console.log("Failed with state: " + state);
                console.log(response.getError());
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    mode: "sticky",
                    type: "warning",
                    title: "Error!",
                    message: JSON.stringify(response.getError()[0].message)
                });
                toastEvent.fire();
                component.set("v.spinner", false);
            }
        });

        $A.enqueueAction(updateEntityCP);
    }
})