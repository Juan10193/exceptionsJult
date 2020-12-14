/**
 * @File Name          : TKD_Supplier_ApprovalProcessController.js
 * @Description        :
 * @Author             : eduardo.villegas@engeniumcapital.com
 * @Group              :
 * @Last Modified By   : eduardo.villegas@engeniumcapital.com
 * @Last Modified On   : 11/12/2019 13:24:18
 * @Modification Log   :
 * Ver       Date            Author      		    Modification
 * 1.0    11/12/2019   eduardo.villegas@engeniumcapital.com     Initial Version
 **/
({
  init: function(component, event, helper) {
    console.log('component.get("v.recordId") ' + component.get("v.recordId"));
    document.addEventListener("click", function(event) {
      let targetElement = event.target || event.srcElement;
      console.log(targetElement);
    });
    helper.getStatusSuppInApproval(
      component,
      event,
      helper,
      component.get("v.recordId")
    );
  },

  validateSupplierSit: function(component, event) {
    
    let validation = event.getParam("supplierWithoutSites");
    console.log("LOS SUPPLIERS SI TIENEN SITES " + validation);
    component.set("v.supplierWithoutSites", validation);
  },
  handleAddSupplier: function(component, event, helper) {
    let icono = event.getSource().get("v.iconName");
    if (icono === "utility:add") {
      event.getSource().set("v.iconName", "utility:clear");
      event.getSource().set("v.label", "Close Add Supplier");
      let addsupplierEvent = $A.get("e.c:TKD_SupplierBundle_Event");
      addsupplierEvent.setParams({ showTable: true });
      addsupplierEvent.fire();
    } else if (icono === "utility:clear") {
      event.getSource().set("v.iconName", "utility:add");
      event.getSource().set("v.label", "Add Supplier");
      let addsupplierEvent = $A.get("e.c:TKD_SupplierBundle_Event");
      addsupplierEvent.setParams({ showTable: false });
      addsupplierEvent.fire();
    }
  },
  openDocsSuppliers: function(component) {
    component.set("v.isModalDocsOpen", true);
  },
  isModalDocsClosed: function(component) {
    console.log("el evento se cacha");
    component.set("v.isModalDocsOpen", false);
  },
  gotoURlSupplier: function(component, event, helper) {
    let supSites = component.get("v.supplierWithoutSites");
    console.log('supsites ' + supSites);
    if (supSites === true) {
      let confirmacion = confirm(
        "Does Exist Suppliers Without Sites  are you sure to continue?"
      );
      if (confirmacion === true) {
        var idSuppInApp = component.get("v.statusSuppApp");
        console.log(JSON.stringify(component.get("v.statusSuppApp")));
        ////alert('idSuppInApp: ' + JSON.stringify(idSuppInApp) +'id: '+ idSuppInApp.Id);
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
          recordId: idSuppInApp.Id,
          slideDevName: "related"
        });
        navEvt.fire();
      }
    } else {
      var idSuppInApp = component.get("v.statusSuppApp");
      console.log(JSON.stringify(component.get("v.statusSuppApp")));
      ////alert('idSuppInApp: ' + JSON.stringify(idSuppInApp) +'id: '+ idSuppInApp.Id);
      var navEvt = $A.get("e.force:navigateToSObject");
      navEvt.setParams({
        recordId: idSuppInApp.Id,
        slideDevName: "related"
      });
      navEvt.fire();
    }
  },
  clickChangeComponent: function(component, event, helper) {
    var expense = component.get("v.expense");
    var updateEvent = component.getEvent("updateExpense");
    updateEvent.setParams({ expense: expense });
    updateEvent.fire();
  },
  handleSaveNewSupplier: function(component, event) {
    component.find("addsup").set("v.iconName", "utility:add");
    component.find("addsup").set("v.label", "Add Supplier");
  },

  onTabFocused: function(component, event, helper) {
    console.log("Tab Focused");
    var focusedTabId = event.getParam("currentTabId");
    var workspaceAPI = component.find("menussupp");
    workspaceAPI
      .getTabInfo({
        tabId: focusedTabId
      })
      .then(function(response) {
        console.log(response);
      });
  }
});