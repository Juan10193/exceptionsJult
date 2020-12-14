({
    updateInformationSupp: function(component,event,helper,recordId){
        component.set('v.spinner', false);
    //alert('update Information Supplier');
   var action = component.get("c.updateInformationSupp"); 
   action.setParams({"recordId" : recordId});
   action.setCallback(this, function(response) {
       var state = response.getState();
       if (state === "SUCCESS") {
           //helper.getAllSupplier(component,event,helper,recordId);
           helper.getDatatblSites(component,event,helper,component.get("v.recordId"));
           component.set('v.spinner', true);
           console.log("Success" + state);
       }
       else {
           console.log("Failed with state: " + state);
           console.log(response.getError());
       }
   });
   $A.enqueueAction(action);       
},
	 onSaveSupplierInApproval: function(component,event,helper,recordId){
    	var action = component.get("c.onSaveSupplierInApproval"); 
    	action.setParams({"recordId" : recordId});
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
               // alert('OnSaveSupplierInApproval se envio params Save');
                helper.getSupplierslist(component,event,helper,component.get("v.recordId"));
                console.log("Success onSaveSupplierInApproval" + state);
            }
            else {
                console.log("Failed with state: " + state);
                console.log(response.getError());
            }
        });
        $A.enqueueAction(action);        
	},
    getSupplierslist : function(component,event,helper,recordId){
        //alert('getSupplierByInvoice');
        var action = component.get("c.getSuppliers"); 
    	action.setParams({"recordId" : recordId});
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {   
                var lstSupplierByInvoice = response.getReturnValue(); 
                //alert('lstSupplierByInvoice B: '+ JSON.stringify(lstSupplierByInvoice));
                helper.getDatatblSites(component,event,helper,component.get("v.recordId"));
                console.log("Success" + state);
            }
            else {
                console.log("Failed with state: " + state);
                console.log(response.getError());
            }
        });
        $A.enqueueAction(action); 
        
    },
     getAllSupplier: function(component,event,helper,recordId){
    	var action = component.get("c.getAllSupplier");        
    	action.setParams({"recordId" : recordId});
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                if(response.getReturnValue() == null || response.getReturnValue() == '' ){
                    component.set("v.newSupplier", response.getReturnValue());
                    component.set("v.newSupplier.TKD_pd_TakedownCP__c", component.get("v.recordId"));                    
                }else{
                component.set("v.newSupplier", response.getReturnValue());                           
               	console.log("Success" + state);
                var sizeSupplier = response.getReturnValue();
                component.set("v.sizeSupplier", sizeSupplier.length); 
                //alert("getAllSupplier : " + JSON.stringify(response.getReturnValue()));
                    
                }
                
                
            }                        
            else { console.log("Failed with state: " + state);
            console.log(response.getError());
        }
        });
        $A.enqueueAction(action);        
	},
    
     getHitsDesc: function(component,event,helper,params){
    	var action = component.get("c.getHitsDesc"); 
    	action.setParams(params);
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.hitsDesc", response.getReturnValue().TKD_tl_hitsDescription__c);
                console.log("Success" + state);
            }
             else {console.log("Failed with state: " + state);
             console.log(response.getError());
            }
        });
        $A.enqueueAction(action);        
	},
    getInvoices: function(component,event,helper,params){        
    	var action = component.get("c.getInvoiceByNameOrRfcSupplier");        
    	action.setParams(params);
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {  
                component.set("v.lstInvoices", response.getReturnValue());
                component.set("v.lstInvoicesSelected", []);      
               // alert('id*: '+ JSON.stringify(params.id));
               // alert('Facturas: ' + JSON.stringify(response.getReturnValue()));               
                var lstInvoicesSelected = component.get("v.lstInvoicesSelected");                                
             	component.get("v.lstInvoices").forEach(function(invoice) {
                    console.log('params tbl rfc: '+ params.rfc +' params con rfc' + invoice.TKD_txt_RFC__c);
                  if (params.rfc === invoice.TKD_txt_RFC__c){
                      console.log('Entro al if');
                      lstInvoicesSelected.push(invoice);             
                  }
                });
                component.set("v.lstInvoicesSelected", lstInvoicesSelected);
                console.log('Lst invoices select : '+ JSON.stringify(lstInvoicesSelected));
                console.log("Success" + state);
            }
            else { console.log("Failed with state: " + state);}
        });
        $A.enqueueAction(action);        
	},
    deleteSupplier: function(component,event,helper,params){
        //alert('params delete B: '+ JSON.stringify(params));
        console.log('Params delete: '+ JSON.stringify(params));
    	var action = component.get("c.deleteReg"); 
    	action.setParams(params);
        action.setCallback(this, function(response) {
            var state = response.getState();            
            if (state === "SUCCESS") {
                console.log('SUCCES DELETE');
    		 	//helper.getAllSupplier(component,event,helper,component.get("v.recordId"));
    		 	helper.getDatatblSites(component,event,helper,component.get("v.recordId"));
                console.log("Success" + state);
            }
            else { console.log("Failed with state: " + state);
            console.log(response.getError());
        }
        });
        $A.enqueueAction(action);        
	},
     getDatatblSites: function(component,event,helper,recordId){
        //alert('Params: '+ recordId);
        //alert('helper getDatatblSites');
    	var action = component.get("c.getAllSupplierTblAmlHits"); 
    	action.setParams({"recordId" : recordId});
        action.setCallback(this, function(response) {
            var state = response.getState();            
            if (state === "SUCCESS") {
                //alert('ltsSites: '+ JSON.stringify(response.getReturnValue()));   
                console.log('ltsSites: '+ JSON.stringify(response.getReturnValue()));
                component.set("v.lstSites", response.getReturnValue());
                let lstSites = component.get("v.lstSites");
                console.log('LOS SITES')
                console.log(lstSites)
                let validated = true;
                let supplierValidated = true;
                lstSites.forEach(sit => {
                    if(sit.amlHits === undefined){
                        validated = false
                    }

                    if(sit.idSite === undefined){
                        supplierValidated = false;
                    }

                });
                console.log('supplierValidated: ' + supplierValidated)
                if(supplierValidated === false){
                    let succesSupplierEvnt = $A.get("e.c:TKDvalidateSupplierSites");
                    succesSupplierEvnt.setParams({"supplierWithoutSites":true});
                    console.log('No Todos los suppliers tienen site');
                    succesSupplierEvnt.fire();
                }else{
                    let succesSupplierEvnt = $A.get("e.c:TKDvalidateSupplierSites");
                    succesSupplierEvnt.setParams({"supplierWithoutSites":false});
                    console.log('Todos los suppliers tienen site');
                    succesSupplierEvnt.fire();
                }
                component.set("v.validateHits", validated);
                if(validated === true){
                    let act = component.get("c.validateHitsCheck");
                    act.setParams({"takedownId":recordId, "validation":validated});
                    act.setCallback(this, function(res){
                        let estado = res.getState();
                        if(estado === "SUCCESS"){
                            console.log('Se realizo la validacion d ehits')
                            component.set('v.spinner', true);
                        }else{
                            console.log("Failed Validation Hits with state: " + state);
                            console.log(res.getError());
                            component.set('v.spinner', true);
                        }
                    })
                    $A.enqueueAction(act);
                }else{
                    let act = component.get("c.validateHitsCheck");
                    act.setParams({"takedownId":recordId, "validation":validated});
                    act.setCallback(this, function(res){
                        let estado = res.getState();
                        if(estado === "SUCCESS"){
                            console.log('Faltan  validaciones de hits')
                            component.set('v.spinner', true);
                        }else{
                            console.log("Failed Validation Hits with state: " + state);
                            console.log(res.getError());
                            component.set('v.spinner', true);
                        }
                    })
                    $A.enqueueAction(act);
                }
              
    		 	//helper.getAllSupplier(component,event,helper,component.get("v.recordId"));
                console.log("Success" + state);
            }
            else { console.log("Failed with state: " + state);
            console.log(response.getError());
            }
        });
        $A.enqueueAction(action);        
	}

    
})