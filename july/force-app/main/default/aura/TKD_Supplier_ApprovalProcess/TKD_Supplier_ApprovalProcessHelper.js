/**
 * @File Name          : TKD_Supplier_ApprovalProcessHelper.js
 * @Description        : 
 * @Author             : eduardo.villegas@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : eduardo.villegas@engeniumcapital.com
 * @Last Modified On   : 11/12/2019 11:30:04
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    11/12/2019   eduardo.villegas@engeniumcapital.com     Initial Version
**/
({
    getStatusSuppInApproval: function(component,event,helper,recordId){
    	var action = component.get("c.getStatusSuppInApproval"); 
    	action.setParams({"recordId" : recordId});
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {                
                component.set("v.statusSuppApp", response.getReturnValue());
                console.log("Success" + state);
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);        
	}
})