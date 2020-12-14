({	 
   
    getHitsDesc: function(component,event,helper,params){
    	var action = component.get("c.getHitsDesc"); 
    	action.setParams(params);
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                if(response.getReturnValue().TKD_tl_hitsDescription__c == null || response.getReturnValue().TKD_tl_hitsDescription__c == '' ){
                   component.set("v.hitsDesc", 'No hay Hits'); 
                }else{
                     component.set("v.hitsDesc", response.getReturnValue().TKD_tl_hitsDescription__c);
                }
                console.log("Success" + state);
            }
            else {
                console.log("Failed with state: " + state);
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
                //alert('OnSaveSupplierInApproval se envio params Save');
                helper.getSupplierByInvoice(component,event,helper,component.get("v.recordId"));
                console.log("Success" + state);
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);        
	},
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
	},
    
    getSupplierByInvoice : function(component,event,helper,recordId){
        //alert('getSupplierByInvoice 2');
        var action = component.get("c.getSupplierByInvoice"); 
    	action.setParams({"recordId" : recordId});
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {   
                var lstSupplierByInvoice = response.getReturnValue();
                //alert('lstSupplierByInvoice:' + JSON.stringify(lstSupplierByInvoice));   
                //helper.getAllSupplier(component,event,helper,recordId); 
                console.log("Success" + state);
            }
            else {
                console.log("Failed with state: " + state);
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
                component.set("v.statusAML", sizeSupplier[0].TKD_tx_amlStatus__c);
                component.set("v.statusApproval", sizeSupplier[0].TKD_tx_approvalStatus__c);
                //alert("getAllSupplier : " + JSON.stringify(response.getReturnValue()));
                    
                }
                
                
            }                        
            else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);        
	},
    
    
    getInformationSupplier: function(component,event,helper,params){
        //alert('params GIS:' + JSON.stringify(params));
        var action = component.get("c.getInformationSupplier"); 
    	action.setParams(params);
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var lstInformationSuppliers = component.get("v.InformationSuppliers");
                var returnValue = response.getReturnValue();
                var results = returnValue.result.amlHits;                
                for(var index=0; index < results.length; index++){                                      
                    if(JSON.stringify(lstInformationSuppliers).includes(JSON.stringify(results[index]))){
                        //alert('El proveedor ya existe');
                    }else {
                        lstInformationSuppliers.push(results[index]);
                        //alert('El proveedor se guardo con exito');
                    }
                }                
                
                params['lstInformationSuppliers'] = lstInformationSuppliers;
                helper.onSaveSuppliers(component,event,helper,params);
                helper.getAllSupplier(component,event,helper,component.get("v.recordId")); 
                
                console.log("Success" + state);
                console.log('response.getReturnValue() --- ' + JSON.stringify(lstInformationSuppliers)); 
                component.set('v.loaded', true);
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
    },
    getInformationKnownSupplier: function(component,event,helper,params){
        //alert('Nuevos cambios');
        var action = component.get("c.getKnownSupplier"); 
    	action.setParams(params);
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log('entrando en la busqueda success')
                component.set("v.InformationKnownSuppliers", [])
                var lstInformationKnownSuppliers = component.get("v.InformationKnownSuppliers"); 
                //alert('KNOW SUPPLIER: '+ JSON.stringify(lstInformationKnownSuppliers));
               console.log('---lstInformationKnownSuppliers --- ' + JSON.stringify(lstInformationKnownSuppliers));    
                var results = JSON.parse(response.getReturnValue()).suppliers.supplier;
                console.log(results);
                //alert('results: ' + JSON.stringify(results));
                for(var index=0; index < results.length; index++){
                    /*var currentDate = new Date();
                    var startDateActive = new Date(results[index].startDateActive);
                    var endDateActive = new Date(results[index].endDateActive);
                    results[index]['activeStatus'] = ((currentDate > startDateActive && !results[index].endDateActive) || (currentDate > startDateActive && currentDate < endDateActive) ? 'Yes' : 'No');*/
                    if(JSON.stringify(lstInformationKnownSuppliers).includes(JSON.stringify(results[index]))){
                        //alert('El proveedor ya existe');
                    }else {                       
                        lstInformationKnownSuppliers.push(results[index]);
                        //alert('El proveedor se guardo con exito');
                    }
                }                
                component.set("v.InformationKnownSuppliers",lstInformationKnownSuppliers);      
                component.set('v.loadedKS', true);
                component.set("v.SearchByRFC",  "");
                component.set("v.SearchByName",  "");
                component.set("v.SearchByCurrency",  "");
                component.set("v.SearchByTaxCode",  "");
                
                console.log("Success" + state);

                let operationunit = component.get("c.getTakedownOperationUnit");
                operationunit.setParams({
                    recordId: component.get("v.recordId")
                })
                console.log('recordidoperation: ' +component.get("v.recordId"));
                operationunit.setCallback(this, function(response) {
                    var state = response.getState();
                    if (state ==='SUCCESS') {
                        let operation =response.getReturnValue();
                        console.log('SUCCESS operation unit');
                        console.log('LA COSA DE LA ESA')
                        console.log(lstInformationKnownSuppliers);
                        let filterSites = [];
                        lstInformationKnownSuppliers.forEach(supp=>{
                            let sitefiltered=[...supp.sites.site.filter(({organizationName})=>organizationName===operation)];
                              sitefiltered.forEach(val=>{
                               val.supplier = supp;
                               delete val.supplier.sites
                               filterSites.push(val);
                             })   
                         })
                        
                        
                        component.set("v.filterKnownSuppliers",filterSites);
                        console.log('LISTA FLTRADA')
                        console.log(component.get("v.filterKnownSuppliers"));
                    }else{
                        console.log('FAILED TO FILTERED SITES ON GET OPERATION UNIT');
                    }
                });

                $A.enqueueAction(operationunit);
                console.log('lstInformationKnownSuppliers: Met KNONW--- ' + JSON.stringify(lstInformationKnownSuppliers));
               
            }
            else {
                console.log("Failed with state: " + state);
                console.log(response.getError());
                component.set('v.loadedKS', true);
            }
        });
        $A.enqueueAction(action);
    },

    saveknowsuppliers :function(component,event, helper, suppliersApex, sitesh, baccounts, contactS){
        console.log('SUPPLIERS HELPER')
        console.log(suppliersApex);
        let saveSuppliers = component.get("c.saveListSitess")

        saveSuppliers.setParams({
            recordId: component.get("v.recordId"),
            supplierList: suppliersApex,
            sites: sitesh,
            banckaccounts: baccounts
        })

        saveSuppliers.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log('Se insertaron los suppliers')
            }else{
                console.log('fail to insert suppliers', state)
            }
        })

        $A.enqueueAction(saveSuppliers);
    },

    onSaveSuppliers: function(component,event,helper,params){
    	var action = component.get("c.onSaveSuppliers");
        
    	action.setParams(params);
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {  
                //component.set("v.InformationSuppliers", response.getReturnValue());
                console.log("Success" + state);
                console.log("perfil" + JSON.stringify(response.getReturnValue()));
            }
            else {
                console.log("Failed with state: " + state);
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
                //alert('Facturas: ' + JSON.stringify(response.getReturnValue()));
                console.log("Success" + state);
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);        
	},
     onSaveInvoice: function(component,event,helper,params){
        // alert('On Save -- params: ' + JSON.stringify(params));
         	
	},
    showDetailknowSupplier: function(component,event,helper,params){
       // alert('Metodo ShowDetailKnowSupplier');
        var action = component.get("c.getShowDetailknowSupplier");        
    	action.setParams(params);
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.InformationDetKnownSuppliers", response.getReturnValue().suppliers.supplier);
                console.log("Details: " + JSON.stringify(response.getReturnValue().suppliers.supplier));
                console.log("Success" + state);
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action); 
    },
    delete: function(component,event,helper,params){
    	var action = component.get("c.deleteReg"); 
    	action.setParams(params);
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
    		 	helper.getAllSupplier(component,event,helper,component.get("v.recordId"));
                console.log("Success" + state);
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);        
	}
    
    
})