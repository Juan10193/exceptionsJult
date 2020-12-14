/**
 * @File Name          : TKD_supplierInTD_NewSupplierHelper.js
 * @Description        :
 * @Author             : eduardo.villegas@engeniumcapital.com
 * @Group              :
 * @Last Modified By   : eduardo.amiens@outlook.com
 * @Last Modified On   : 16/6/2020 0:04:48
 * @Modification Log   :
 * Ver       Date            Author      		    Modification
 * 1.0    27/11/2019   eduardo.villegas@engeniumcapital.com     Initial Version
 **/
({
  newSupplier: function(component, event, helper, obj) {
    console.log("Inicia helper ");
    console.log(JSON.stringify(obj));
    console.log(JSON.stringify(component.get("v.recordId")));
    var insertSupplier = component.get("c.insertSupplier");
    insertSupplier.setParams({
      takedownId: component.get("v.recordId"),
      supplierDetail: obj
    });
    insertSupplier.setCallback(this, function(response) {
      var state = response.getState();
      if (state === "SUCCESS") {
        console.log("Success" + state);
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
          title: "Success!",
          type: "success",
          message: "The Supplier has been Created successfully."
        });
        toastEvent.fire();
        component.set("v.spinner", false);
        var appEvent = $A.get("e.c:TKD_SaveNewSupplier");
        appEvent.fire();
      } else if (state === "ERROR") {
        console.log("Failed with state: " + state);
        console.log( response.getError());
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

    $A.enqueueAction(insertSupplier);
  },
  showToast: function(title, message, type) {
    var toastEvent = $A.get("e.force:showToast");
    toastEvent.setParams({
      title: title,
      message: message,
      type: type
    });
    toastEvent.fire();
  },
  removeSite: function(component, row) {
    var rows = component.get("v.siteData");
    var rowIndex = rows.indexOf(row);

    rows.splice(rowIndex, 1);
    component.set("v.siteData", rows);
  },
  removeBankAccount: function(component, row) {
    var rows = component.get("v.accountData");
    var rowIndex = rows.indexOf(row);

    rows.splice(rowIndex, 1);
    component.set("v.accountData", rows);
  },
  removeContact: function(component, row) {
    var rows = component.get("v.contactData");
    var rowIndex = rows.indexOf(row);

    rows.splice(rowIndex, 1);
    component.set("v.contactData", rows);
  },
  editSite: function(component, row) {
    console.log('editSite');
    console.log('row ' + JSON.stringify(row));
    
    component.set("v.isEditSite",true)
    component.set("v.addSite",row)
    component.set("v.isOpenSite", true);
    component.set("v.isOpenAccount", false);
    component.set("v.isOpenContact", false);

    
  },
  editBankAccount: function(component, row, event) {
    console.log('editBankAccount');
    console.log('row ' + JSON.stringify(row));
    console.log('event ' + JSON.stringify(event));
    
    
    component.set("v.isEditAccount", true);
    component.set("v.addAccount", row);
    component.set("v.isOpenSite", false);
    component.set("v.isOpenAccount", true);

    var rows = component.get("v.accountData");
    console.log('rows ' + JSON.stringify(rows));
    var rowIndex = component.get("v.indexEditRecord");
    for(var i = 0; i < rows.length; i++){
      if(JSON.stringify(row) === JSON.stringify(rows[i])){
        rowIndex = i;
      }
    }
    //rowIndex = rows.findIndex(row);
    console.log('rowIndex ' + rowIndex)
    component.set("v.indexEditRecord", rowIndex);
  },
  editContact: function(component, row) {
    console.log('editContact');
    console.log('row ' + JSON.stringify(row));

    component.set("v.isEditContact", true);
    component.set("v.addContact", row);
    component.set("v.isOpenSite", false);
    component.set("v.isOpenContact", true);

    var rows = component.get("v.contactData");
    console.log('rows ' + JSON.stringify(rows));
    var rowIndex = component.get("v.indexEditRecord");
    for(var i = 0; i < rows.length; i++){
      if(JSON.stringify(row) === JSON.stringify(rows[i])){
        rowIndex = i;
      }
    }
    //rowIndex = rows.findIndex(row);
    console.log('rowIndex ' + rowIndex)
    component.set("v.indexEditRecord", rowIndex);
  },
  eraseSites: function(component, helper) {
    component.set("v.addSite", {
      Tkd_ls_Org_Name: component.get("v.operationUnit"),
      bankAccount: [],
      supplierContact: []
    });
  },
  eraseAccount: function(component, helper) {
    component.set("v.addAccount", {
    });
  },
  eraseContact: function(component, helper) {
    component.set("v.addContact", {
    });
  },
  autoWritteSwiftBanc: function(component) {
    var Bank_Name  = component.get('v.addAccount.Bank_Name');
    var metadataSwiftDesition  = component.get('v.metadataSwiftDesition');
    var selectedBank  = metadataSwiftDesition.filter(index => index.MasterLabel === Bank_Name)
    console.log('selectedBank ' + JSON.stringify(selectedBank))
    if(selectedBank.length > 0){
      component.set('v.addAccount.Codigo_BIC', selectedBank[0].Alternative_Api_Name__c);
    }
  }
  
});