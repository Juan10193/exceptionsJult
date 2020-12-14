({
    onSaveInvoiceHelper: function(component,event,helper,params){        
        console.log('OnSave refreshView View Quit : '+ JSON.stringify(params));
    	var action = component.get("c.onSaveInvoice"); 
    	action.setParams(params);
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") { 
                 component.set("v.isOpenModalAlert", false);  
                 //location.reload(); 
                 helper.getDatatblSites(component,event,helper,params);                           
                 $A.get('e.force:refreshView').fire();
                 console.log("Success" + state);                    
            }
             else {console.log("Failed with state: " + state);}
        });
        $A.enqueueAction(action);        
	},
     getDatatblSites: function(component,event,helper,params){
    	var action = component.get("c.getAllSupplierTblAmlHits"); 
    	action.setParams({"recordId" : params.recordId});
        action.setCallback(this, function(response) {
            var state = response.getState();            
            if (state === "SUCCESS") {
                console.log('ltsSites: '+ JSON.stringify(response.getReturnValue()));
                component.set("v.lstSites", response.getReturnValue());
                console.log("Success" + state);
            }
            else { console.log("Failed with state: " + state);
            console.log(response.getError());
        }
        });
        $A.enqueueAction(action);        
	}
})