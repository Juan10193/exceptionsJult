/**
 * @File Name          : TKD_Supplier_TableAMLHitsHelper.js
 * @Description        : 
 * @Author             : eduardo.villegas@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : eduardo.villegas@engeniumcapital.com
 * @Last Modified On   : 17/12/2019 16:02:11
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    10/12/2019   eduardo.villegas@engeniumcapital.com     Initial Version
**/
/**
* @File Name          : TKD_Supplier_TableAMLHitsHelper.js
* @Description        : 
* @Author             : eduardo.villegas@engeniumcapital.com
* @Group              : 
* @Last Modified By   : eduardo.villegas@engeniumcapital.com
* @Last Modified On   : 17/12/2019 16:02:11
* @Modification Log   : 
* Ver       Date            Author      		    Modification
* 1.0    10/12/2019   eduardo.villegas@engeniumcapital.com     Initial Version
**/
({
    getInitialData: function (component, event, helper, recordId) {
        //alert('Params: '+ recordId);
        //alert('helper getDatatblSites');
        var getSuppliers = component.get("c.getSuppliers");
        getSuppliers.setParams({ "recordId": recordId });
        getSuppliers.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log('Se han localizado ' + response.getReturnValue() + ' suppliers ');
                console.log('ltsSites: ' + JSON.stringify(response.getReturnValue()));
                let supplierData = response.getReturnValue();
                let invoicesData = supplierData.map(supplier => supplier.Supplier__c);

                var getInvoicesBysupplierSetID = component.get("c.getInvoicesBysupplierSetID");
                getInvoicesBysupplierSetID.setParams({ "setRecordId": invoicesData });
                getInvoicesBysupplierSetID.setCallback(this, function (responsetwo) {
                    var statetwo = responsetwo.getState();
                    if (statetwo === "SUCCESS") {
                        console.log('Se han localizado ' + responsetwo.getReturnValue() + ' Takedown Invoices');
                        console.log('2ltsSites: ' + JSON.stringify(responsetwo.getReturnValue()));
                        let invoiceData = responsetwo.getReturnValue();
                        this.buildTableData(component, supplierData, invoiceData);
                    } else {
                        console.log("Failed with state: " + state);
                    }
                });
                $A.enqueueAction(getInvoicesBysupplierSetID);
            } else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(getSuppliers);
    },
    /*getInitialData: function (component, event, helper, recordId) {
        //alert('Params: '+ recordId);
        //alert('helper getDatatblSites');
        var getSuppliers = component.get("c.getSuppliers");
        getSuppliers.setParams({ "recordId": recordId });
        getSuppliers.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log('Se han localizado ' + response.getReturnValue() + ' suppliers ');
                console.log('ltsSites: ' + JSON.stringify(response.getReturnValue()));
                let supplierData = response.getReturnValue();
                let invoicesData = supplierData.map(supplier => supplier.Supplier__c);

                var getInvoicesBysupplierSetID = component.get("c.getInvoicesBysupplierSetID");
                getInvoicesBysupplierSetID.setParams({ "setRecordId": invoicesData });
                getInvoicesBysupplierSetID.setCallback(this, function (responsetwo) {
                    var statetwo = responsetwo.getState();
                    if (statetwo === "SUCCESS") {
                        console.log('Se han localizado ' + responsetwo.getReturnValue() + ' Takedown Invoices');
                        console.log('2ltsSites: ' + JSON.stringify(responsetwo.getReturnValue()));
                        let invoiceData = responsetwo.getReturnValue();
                        this.buildTableData(component, supplierData, invoiceData);
                    } else {
                        console.log("Failed with state: " + state);
                    }
                });
                $A.enqueueAction(getInvoicesBysupplierSetID);
            } else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(getSuppliers);
    },*/
    buildTableData: function (component, supplierData, invoiceData) {
        console.log('buildTableData ');
        console.log('supplierData ' + JSON.stringify(supplierData));
        console.log('invoiceData ' + JSON.stringify(invoiceData));
        let supplierArrayObject = [];
        supplierData.forEach(element => {
            let supplierObject = {};
            console.log('element ' + JSON.stringify(element));
            supplierObject.id = element.Id;
            supplierObject.TKD_RFC = element.Supplier__r.TKD_tx_Vat_Registration_Num__c;
            supplierObject.TKD_Name = element.Supplier__r.Name;
            supplierObject.TKD_Sites = element.Name;
            supplierObject.TKD_Currency = element.CurrencyIsoCode;
            supplierObject.TKD_TaxCode = element.TKD_Vat_code__c;
            
            //let invoice = invoiceData.filter(index => index.TKD_rb_Supplier__c === element.Supplier__c);
            let invoiceArray = invoiceData.filter(index => index.TKD_rb_Supplier__c === element.Supplier__c);
            let invoiceConcat = '';
            invoiceArray.forEach(invoice =>{ 
                invoiceConcat = invoiceConcat + invoice.Name + ' ';
            });
            
            supplierObject.TKD_Invoice = invoiceConcat; 
            console.log(JSON.stringify(supplierObject.TKD_Invoice));
            console.log(JSON.stringify(invoiceArray));

            if (element.TKD_tx_amlHits__c === 'true') {
                supplierObject.TKD_AML_Hits = 'action:close';
            } else {
                supplierObject.TKD_AML_Hits = 'action:approval';
            }
            console.log('element.Supplier__r.TKD_Vendor_ID__c' + JSON.stringify(element.Supplier__r.TKD_Vendor_ID__c));
            if (element.Supplier__r.TKD_Vendor_ID__c === undefined
                || element.Supplier__r.TKD_Vendor_ID__c === null
                || element.Supplier__r.TKD_Vendor_ID__c === '') {
                supplierObject.TKD_Oracle_Supplier = 'action:close';
            } else {
                supplierObject.TKD_Oracle_Supplier = 'action:approval';
            }
            console.log('hola mango ' + JSON.stringify(supplierObject.TKD_Oracle_Supplier));
            //supplierObject.TKD_Hits_description = element.TKD_tl_hitsDescription__c;
            supplierArrayObject.push(supplierObject);
        });
        component.set('v.supplierData', supplierArrayObject);

    },
    delete: function (component, row) {
        var rows = component.get('v.supplierData');
        
        var rowIndex = rows.indexOf(row);
        console.log('rows ' + JSON.stringify(rows));
        console.log('rowIndex ' + JSON.stringify(rowIndex));
        let recordId = rows[rowIndex].id;
        console.log('rowIndex ' + JSON.stringify(recordId));
        rows.splice(rowIndex, 1);
        component.set('v.supplierData', rows);
        var deleteSupplier = component.get("c.deleteSupplier");
        deleteSupplier.setParams({ "recordId": recordId });
        deleteSupplier.setCallback(this, function (responsetwo) {
            var statetwo = responsetwo.getState();
            if (statetwo === "SUCCESS") {
                console.log('Se han eliminado el supplier con el id  ' + rows.id);
            } else {
                console.log("Failed with state: " + rows.id);
            }
        });
        $A.enqueueAction(deleteSupplier);
    },
    edit: function (component, row) {
        var rows = component.get('v.supplierData');
        var rowIndex = rows.indexOf(row);
        console.log('checa ' + JSON.stringify(rows));
        console.log('row ' + JSON.stringify(row));
        console.log('rowIndex ' + JSON.stringify(rowIndex));
        //rows.splice(rowIndex, 1);
        //component.set('v.contactData', rows);

    },
})