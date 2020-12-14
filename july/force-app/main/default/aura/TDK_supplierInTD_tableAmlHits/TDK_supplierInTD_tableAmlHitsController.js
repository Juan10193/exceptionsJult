/**
 * @description       : 
 * @author            : eduardo.amiens@outlook.com
 * @group             : 
 * @last modified on  : 09-18-2020
 * @last modified by  : eduardo.amiens@outlook.com
 * Modifications Log 
 * Ver   Date         Author                       Modification
 * 1.0   08-04-2020   eduardo.amiens@outlook.com   Initial Version
**/
({
    init: function (component, event, helper) {
        helper.onSaveSupplierInApproval(component, event, helper, component.get("v.recordId"));
        //helper.updateInformationSupp(component,event,helper,component.get("v.recordId"));        
        //helper.getDatatblSites(component,event,helper,component.get("v.recordId"));

    },
    validateHits: function (component, event, helper) {
        helper.updateInformationSupp(component, event, helper, component.get("v.recordId"))
    },
    openModalHitsDesc: function (component, event, helper) {
        component.set("v.isOpenHitsDesc", true);
        var index = event.getSource().get("v.tabindex");
        var allSupplier = component.get("v.lstSites");
        component.set("v.idSupplierSelect", allSupplier[index].idSupplier);
        var params = {
            'recordId': component.get("v.recordId"),
            'id': allSupplier[index].idSupplier
        };
        //alert('Paramas Hits: '+ JSON.stringify(params));
        helper.getHitsDesc(component, event, helper, params);
    },
    openModalInvoice: function (component, event, helper) {
        component.set("v.isOpenInvoice", true);
        var suppSelectd = event.currentTarget;
        var index = suppSelectd.dataset.sited;
        console.log('index: ' + index);

        var allSupplier = component.get("v.lstSites");
        console.log('ALL SUPPLIERS: ')
        console.log(allSupplier);
        component.set("v.idSupplierSelect", allSupplier[index].idSupplier);
        component.set("v.rfcSupplierSelect", allSupplier[index].rfc);
        component.set("v.nameSupplierSelect", allSupplier[index].name);
        var params = {
            'recordId': component.get("v.recordId"),
            'id': allSupplier[index].idSupplier,
            'rfc': allSupplier[index].rfc,
            'name': allSupplier[index].name
        };
        //alert('Params: '+ JSON.stringify(params));
        console.log("Params Invoice: " + JSON.stringify(params));
        helper.getInvoices(component, event, helper, params);
    },
    deleteSupplier: function (component, event, helper) {
        var index = event.getSource().get("v.alternativeText");
        let siteId = event.getSource().get("v.title")
        var allSupplier = component.get("v.lstSites");
        //var params = {'idReg': allSupplier[index].Supplier__r.Id};
        var params;
        let rec;
        /*  if (siteId === null || siteId ==='' || siteId===undefined){
             params = {'idSite':index, 'isSite':false};
             console.log('SUPPLIER A BORRAR'+ index);
         }else{
             params = {'idSite': index, 'isSite':true} //allSupplier[index].idSite};
             console.log('site A BORRAR'+ siteId);
         } */

        if (siteId !== null && siteId !== '' && siteId !== undefined) {
            params = { 'idSite': siteId, 'isSite': true } //allSupplier[index].idSite};
            console.log('site A BORRAR' + siteId);
            rec = 'Site';
        } else if ((index !== null && index !== '' && index !== undefined) && (siteId !== null || siteId !== '' || siteId !== undefined)) {
            params = { 'idSite': index, 'isSite': false } //allSupplier[index].idSite};
            console.log('Supplier A BORRAR' + index);
            rec = 'Supplier'
        }

        let confirmacion = confirm(`Are you sure to delete this ${rec} ? `);
        if (confirmacion === true) {
            //var params = {'recordId': component.get("v.recordId")};
            helper.deleteSupplier(component, event, helper, params);
        }

    },
    openEditSupplier: function (component, event, helper) {
        event.preventDefault();
        component.find('tkdmanagesupplier').handleOpenSupplierModal();
        component.set("v.supplierSelected", event.target.dataset.customattribute);
    },
    openEditSite: function (component, event, helper) {
        event.preventDefault();
        component.find('tkdmodalsitedetail').handleOpenSiteModal();
        component.set("v.siteSelected", event.target.dataset.customattribute);
    }
})