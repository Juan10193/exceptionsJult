({
  getInformationKnownSupplier: function(component, event, helper, params) {
    //alert('Nuevos cambios');
    var action = component.get("c.getKnownSupplier");
    action.setParams(params);
    action.setCallback(this, function(response) {
      var state = response.getState();
      if (state === "SUCCESS") {
        console.log("entrando en la busqueda success");
        console.log(response.getReturnValue());
        if (
          JSON.parse(response.getReturnValue()).suppliers === null &&
          JSON.parse(response.getReturnValue()).status.detail === "S"
        ) {
          alert("Unknown supplier");
          component.set("v.spinner", false);
          component.set("v.loadedKS", true);
        } else {
          component.set("v.InformationKnownSuppliers", []);
          var lstInformationKnownSuppliers = component.get(
            "v.InformationKnownSuppliers"
          );
          //alert('KNOW SUPPLIER: '+ JSON.stringify(lstInformationKnownSuppliers));
          console.log(
            "---lstInformationKnownSuppliers --- " +
              JSON.stringify(lstInformationKnownSuppliers)
          );
          var results = JSON.parse(response.getReturnValue()).suppliers
            .supplier;
          console.log(results);
          //alert('results: ' + JSON.stringify(results));
          console.log("aqui no truena 1");
          for (var index = 0; index < results.length; index++) {
            /*var currentDate = new Date();
                    var startDateActive = new Date(results[index].startDateActive);
                    var endDateActive = new Date(results[index].endDateActive);
                    results[index]['activeStatus'] = ((currentDate > startDateActive && !results[index].endDateActive) || (currentDate > startDateActive && currentDate < endDateActive) ? 'Yes' : 'No');*/
            if (
              JSON.stringify(lstInformationKnownSuppliers).includes(
                JSON.stringify(results[index])
              )
            ) {
              //alert('El proveedor ya existe');
            } else {
              lstInformationKnownSuppliers.push(results[index]);
              //alert('El proveedor se guardo con exito');
            }
          }
          console.log("aqui no truena 2");
          component.set(
            "v.InformationKnownSuppliers",
            lstInformationKnownSuppliers
          );
          component.set("v.loadedKS", true);
          component.set("v.SearchByRFC", "");
          component.set("v.SearchByName", "");
          component.set("v.SearchByCurrency", "");
          component.set("v.SearchByTaxCode", "");

          console.log("Success" + state);

          let operationunit = component.get("c.getTakedownOperationUnit");
          operationunit.setParams({
            recordId: component.get("v.recordId")
          });
          console.log("recordidoperation: " + component.get("v.recordId"));
          operationunit.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
              let operation = response.getReturnValue();
              console.log("SUCCESS operation unit");
              console.log("LA COSA DE LA ESA");
              console.log(lstInformationKnownSuppliers);
              let filterSites = [];
              lstInformationKnownSuppliers.forEach(supp => {
                let sitefiltered;
                if ((supp.sites !== null) & (supp.sites !== undefined)) {
                  sitefiltered = [
                    ...supp.sites.site
                    
                  ];
                  sitefiltered.forEach(val => {
                    val.supplier = supp;
                    let sitesids = component.get("v.sitesOraIds");
                    if (sitesids !== null) {
                      if (sitesids.includes(val.vendorSiteId.toString() + component.get("v.recordId"))) {
                        val.icon = "utility:check";
                        val.buttonstate = true;
                      } else {
                        val.icon = "utility:add";
                        val.buttonstate = false;
                      }
                    } else {
                      val.icon = "utility:add";
                      val.buttonstate = false;
                    }
                    delete val.supplier.sites;
                    filterSites.push(val);
                  });
                }
              });

              component.set("v.filterKnownSuppliers", filterSites);
              console.log("LISTA FLTRADA");
              let listafiltrada = component.get("v.filterKnownSuppliers");
              console.log(listafiltrada);
              if (listafiltrada.length === 0) {
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                  title: "Not data",
                  message: "No sites found with operation unit: " + operation
                });
                toastEvent.fire();
              }
              component.set("v.spinner", false);
            } else {
              console.log("FAILED TO FILTERED SITES ON GET OPERATION UNIT");
              component.set("v.spinner", false);
            }
          });

          $A.enqueueAction(operationunit);
          console.log(
            "lstInformationKnownSuppliers: Met KNONW--- " +
              JSON.stringify(lstInformationKnownSuppliers)
          );
        }
      } else {
        console.log("Failed with state: " + state);
        console.log(response.getError());
        component.set("v.spinner", false);
        component.set("v.loadedKS", true);
      }
    });
    $A.enqueueAction(action);
  },
  saveknowsuppliers: function(
    component,
    event,
    helper,
    suppliersApex,
    sitesh,
    baccounts,
    contactS
  ) {
    console.log("SUPPLIERS HELPER");
    console.log(suppliersApex);
    let saveSuppliers = component.get("c.saveListSitess");

    saveSuppliers.setParams({
      recordId: component.get("v.recordId"),
      supplierList: suppliersApex,
      sites: sitesh,
      banckaccounts: baccounts,
      contacts: contactS
    });

    saveSuppliers.setCallback(this, function(response) {
      var state = response.getState();
      if (state === "SUCCESS") {
        console.log("Se insertaron los suppliers");
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
          type: "success",
          title: "Success",
          message: "Sites inserted successfull"
        });
        toastEvent.fire();
        component.set("v.spinner", false);
        var appEvent = $A.get("e.c:TKD_SaveNewSupplier");
        appEvent.fire();
      } else {
        console.log("fail to insert suppliers", state);
      }
    });

    $A.enqueueAction(saveSuppliers);
  },

  getVendorSiteIdsHelper: function(component, event, helper, takedownId) {
    let getSiteOraIds = component.get("c.getallSitesOraIdByRecordId");
    getSiteOraIds.setParams({
      takedownId: takedownId
    });

    getSiteOraIds.setCallback(this, function(response) {
      var state = response.getState();
      if (state === "SUCCESS") {
        let sitesOraIds = response.getReturnValue();
        console.log("LOS IDS DE LOS SITES EN ESTE REGISTRO");
        console.log(sitesOraIds);
        component.set("v.sitesOraIds", sitesOraIds);
      } else {
        console.log(
          "Ocurrio algo inesperado al consultar los Oracle Ids DE los Sites"
        );
      }
    });

    $A.enqueueAction(getSiteOraIds);
  }
});