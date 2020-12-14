({
	closeModalInvoice: function (component, event, helper){
        component.set("v.isOpenInvoice", false);
    },
    closeModalAlert: function (component, event, helper){
        component.set("v.isOpenModalAlert", false);
    },
     handleChangeCheckBx: function (component, event , helper) {
		 var isChecked = event.getSource().get('v.checked');
         var index = event.getSource().get('v.value');
         var invoice = component.get('v.lstInvoices')[index];
         //alert('isChecked: '+isChecked + ' index: '+index + 'invoice: '+JSON.stringify(invoice)); 
         var lstInvoicesSelected = component.get('v.lstInvoicesSelected');
         if(isChecked){
            lstInvoicesSelected.push(invoice);
         }else{
             var indexOf = lstInvoicesSelected.indexOf(invoice);
             lstInvoicesSelected.splice(indexOf,1);
         }
         component.set('v.lstInvoicesSelected',lstInvoicesSelected);
         console.log('lstInvoicesSelected: '+ JSON.stringify(component.get('v.lstInvoicesSelected')));
    },
     onSaveInvoiceController: function(component,event,helper){
	 console.log('-- Lista con ChkBx Seleccionados -- : '+JSON.stringify(component.get('v.lstInvoicesSelected')));    
         var params = {'recordId': component.get("v.recordId"), 
                          'idSupplierSelect': component.get("v.idSupplierSelect"),
                          'rfcSupplierSelect': component.get("v.rfcSupplierSelect"),
                       	  'nameSupplierSelect': component.get("v.nameSupplierSelect"),
                          'lstInvoicesSelected': component.get("v.lstInvoicesSelected")};
         console.log('params: '+ JSON.stringify(params));
     	helper.onSaveInvoiceHelper(component, event, helper, params);        
	},
    onSaveModalInvoice: function(component,event,helper){
        component.set("v.isOpenInvoice", false);
    	component.set("v.isOpenModalAlert", true);   
        //helper.getTheNamesOfTheSuppliers();
    }      
    
})