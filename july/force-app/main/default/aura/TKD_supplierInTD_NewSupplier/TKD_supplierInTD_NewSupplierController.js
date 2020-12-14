/**
 * @File Name          : TKD_supplierInTD_NewSupplierController.js
 * @Description        : 
 * @Author             : eduardo.villegas@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : eduardo.amiens@outlook.com
 * @Last Modified On   : 16/6/2020 0:14:06
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    27/11/2019   eduardo.villegas@engeniumcapital.com     Initial Version
**/
({
  doInit: function (component, helper) {
    component.set('v.siteColumns', [
      { label: 'Org Name', fieldName: 'Tkd_ls_Org_Name', type: 'text' },
      { label: 'Country', fieldName: 'Tkd_tx_Country', type: 'text' },
      { label: 'Phone', fieldName: 'tkd_tf_phone', type: 'text' },
      { label: 'City', fieldName: 'Tkd_tx_City', type: 'text' },
      { type: 'action', typeAttributes: { rowActions: [
                                            {label: 'Edit', name: 'editSite' },
                                            {label: 'Delete', name: 'removeSite' }] } }
    ]);
    component.set('v.accountColumns', [
      { label: 'Bank name', fieldName: 'Bank_Name', type: 'text' },
      { label: 'Currency', fieldName: 'Bank_Account_Currency', type: 'text' },
      { label: 'Account Num', fieldName: 'Name', type: 'text' },
      { label: 'Account Name', fieldName: 'Bank_Account_Name', type: 'text' },
      { type: 'action', typeAttributes: { rowActions: [
                                            {label: 'Edit', name: 'editBankAccount' },
                                            {label: 'Delete', name: 'removeBankAccount' }] } }
    ]);
    component.set('v.contactColumns', [
      { label: 'First name', fieldName: 'firstName', type: 'text' },
      { label: 'Last name', fieldName: 'lastName', type: 'text' },
      { label: 'Phone', fieldName: 'Phone', type: 'text' },
      { label: 'Email address', fieldName: 'emailAddress', type: 'text' },
      { type: 'action', typeAttributes: { rowActions: [{label: 'Edit', name: 'editContact' },
                                                       {label: 'Delete', name: 'removeContact' }] } }
    ]);
    component.set('v.supplierData', {
      Name: '',
      TKD_tx_Vendor_name_alternative: '',
      TKD_tx_Vat_Registration_Num: '',
      sites: []
    });

    var getOperationUnit = component.get("c.getOperationUnit");
    getOperationUnit.setParams({"takedownID" : component.get('v.recordId')});
    getOperationUnit.setCallback(this, function (response) {
      var state = response.getState();
      if (state === 'SUCCESS') {
        var list = response.getReturnValue();
        component.set("v.operationUnit", list);
      }
      else if (state === 'ERROR') {
        console.log('An error has been occurred');
      }
    })
    $A.enqueueAction(getOperationUnit);
	
    var getSiteVatCode = component.get("c.getSiteVatCode");
    getSiteVatCode.setCallback(this, function (response) {
      var state = response.getState();
      if (state === 'SUCCESS') {
        var list = response.getReturnValue();
        component.set("v.pickListVatCode", list);
      }
      else if (state === 'ERROR') {
        console.log('An error has been occurred');
      }
    })
    $A.enqueueAction(getSiteVatCode);

    var getCurrencyISOCode = component.get("c.getCurrencyISOCode");
    getCurrencyISOCode.setCallback(this, function (response) {
      var state = response.getState();
      if (state === 'SUCCESS') {
        var list = response.getReturnValue();
        component.set("v.pickCurrencyISOCode", list);
      }
      else if (state === 'ERROR') {
        console.log('An error has been occurred');
      }
    })
    $A.enqueueAction(getCurrencyISOCode);
    
    var pickListBankAccount = component.get("c.getBankAccount");
    pickListBankAccount.setCallback(this, function (response) {
      var state = response.getState();
      if (state === 'SUCCESS') {
        var list = response.getReturnValue();
        component.set("v.pickListBankAccount", list);
      }
      else if (state === 'ERROR') {
        console.log('An error has been occurred');
      }
    })
    $A.enqueueAction(pickListBankAccount);

    var pickListBankAccountCurrency = component.get("c.getAccountBankCurrencyPL");
    pickListBankAccountCurrency.setCallback(this, function (response) {
      var state = response.getState();
      if (state === 'SUCCESS') {
        var list = response.getReturnValue();
        component.set("v.pickListBankAccountCurrency", list);
      }
      else if (state === 'ERROR') {
        console.log('An error has been occurred');
      }
    })
    $A.enqueueAction(pickListBankAccountCurrency);

    var pickListCountry = component.get("c.getCountryPL");
    pickListCountry.setCallback(this, function (response) {
      var state = response.getState();
      if (state === 'SUCCESS') {
        var list = response.getReturnValue();
        component.set("v.pickListCountry", list);
      }
      else if (state === 'ERROR') {
        console.log('An error has been occurred');
      }
    })
    $A.enqueueAction(pickListCountry);

    var pickListState = component.get("c.getSiteState");
    pickListState.setCallback(this, function (response) {
      var state = response.getState();
      if (state === 'SUCCESS') {
        var list = response.getReturnValue();
        component.set("v.pickListState", list);
      }
      else if (state === 'ERROR') {
        console.log('An error has been occurred');
      }
    })
    $A.enqueueAction(pickListState);
    
    var pickTipoBIC = component.get("c.getTipo_BIC");
    pickTipoBIC.setCallback(this, function (response) {
      var state = response.getState();
      if (state === 'SUCCESS') {
        var list = response.getReturnValue();
        component.set("v.pickTipoBIC", list);
      }
      else if (state === 'ERROR') {
        console.log('An error has been occurred');
      }
    })
    $A.enqueueAction(pickTipoBIC);

    var pickTipo = component.get("c.getTipo");
    pickTipo.setCallback(this, function (response) {
      var state = response.getState();
      if (state === 'SUCCESS') {
        var list = response.getReturnValue();
        component.set("v.pickTipo", list);
      }
      else if (state === 'ERROR') {
        console.log('An error has been occurred');
      }
    })
    $A.enqueueAction(pickTipo);

    var pickpagoacuentaconcentradora = component.get("c.getPago_a_Cuenta_Concentradora");
    pickpagoacuentaconcentradora.setCallback(this, function (response) {
      var state = response.getState();
      if (state === 'SUCCESS') {
        var list = response.getReturnValue();
        component.set("v.pickpagoacuentaconcentradora", list);
      }
      else if (state === 'ERROR') {
        console.log('An error has been occurred');
      }
    })
    $A.enqueueAction(pickpagoacuentaconcentradora);

    var mtd_TKD_Supplier_Swift = component.get("c.getTKD_Supplier_Swift");
    mtd_TKD_Supplier_Swift.setCallback(this, function (response) {
      var state = response.getState();
      if (state === 'SUCCESS') {
        var list = response.getReturnValue();
        component.set("v.metadataSwiftDesition", list);
        console.log('metadata ' + JSON.stringify(list))
      }
      else if (state === 'ERROR') {
        console.log('An error has been occurred');
      }
    })
    $A.enqueueAction(mtd_TKD_Supplier_Swift);
      
      
  },

  clickCreate: function (component, event, helper) {
    component.set("v.spinner", true);
    console.log(JSON.stringify(component.get('v.supplierData')));
    console.log(JSON.stringify(component.get('v.siteData')));
    var supplierData = component.get('v.supplierData');
    //supplierData.sites = component.get('v.siteData');
    console.log(JSON.stringify(supplierData));
    helper.newSupplier(component, event, helper, supplierData);
  },
  newSite: function (component, event, helper) {
    component.set("v.isOpenSite", true);
    helper.eraseSites(component, event, helper);
    helper.eraseAccount(component, event, helper);
    helper.eraseContact(component, event, helper);
    component.set('v.accountData', []);
    component.set('v.contactData', []);
  },
  newAccount: function (component, event, helper) {
    helper.eraseAccount(component, event, helper);
    component.set("v.isEditAccount", false);
    component.set("v.isOpenAccount", true);
    component.set("v.isOpenSite", false);
  },
  newContact: function (component, event, helper) {
    helper.eraseContact(component, event, helper);
    component.set("v.isEditContact", false);
    component.set("v.isOpenContact", true);
    component.set("v.isOpenSite", false);
  },
  addSiteOnTable: function (component, event, helper) {
    var allValid = component.find('siteField').reduce(function (validSoFar, inputCmp) {
      inputCmp.showHelpMessageIfInvalid();  
      return validSoFar && inputCmp.get('v.validity').valid;
    }, true);
    if (allValid) {
      var data = component.get('v.supplierData.sites');
      console.log('hoy dia ' + JSON.stringify(data));
      var addSite = component.get('v.addSite');
      addSite.bankAccount = component.get('v.accountData');
      addSite.supplierContact = component.get('v.contactData');
      data.push(addSite);
      console.log('hoy dia addSite' + JSON.stringify(data));
      component.set('v.supplierData.sites', data);
      helper.showToast('Success!', 'The record has been added', 'success');
      component.set("v.isOpenSite", false);
    } else {
      helper.showToast('Sorry!', 'Please update the invalid form entries and try again.', 'warning');
    }
  },
  saveSiteOnTable: function (component, event, helper) {
    var allValid = component.find('siteField').reduce(function (validSoFar, inputCmp) {
      inputCmp.showHelpMessageIfInvalid();  
      return validSoFar && inputCmp.get('v.validity').valid;
    }, true);
    if (allValid) {
      var data = component.get('v.supplierData.sites');
      var rowIndex = component.get("v.indexEditRecord");
      data.splice(rowIndex, 1,component.get('v.addSite'));

      component.set('v.supplierData.sites', data);
      helper.showToast('Success!', 'The record has been saved', 'success');
      component.set("v.isOpenSite", false);
    } else {
      helper.showToast('Sorry!', 'Please update the invalid form entries and try again.', 'warning');
    }
  },
  addAccountOnTable: function (component, event, helper) {
    console.log('new acc')
    var allValid = component.find('accountField').reduce(function (validSoFar, inputCmp) {
      inputCmp.showHelpMessageIfInvalid();
      return validSoFar && inputCmp.get('v.validity').valid;
    }, true);
    if (allValid) {
      var data = component.get('v.accountData');
      console.log('JSON.stringify(data) ' + JSON.stringify(data))
      data.push(component.get('v.addAccount'));
      console.log('JSON.stringify(data) ' + JSON.stringify(data))
      component.set('v.accountData', data);
      helper.showToast('Success!', 'The record has been added', 'success');
      component.set("v.isOpenAccount", false);
      component.set("v.isOpenSite", true);
    } else {
      helper.showToast('Sorry!', 'Please update the invalid form entries and try again.', 'warning');
    }
  },
  saveAccountOnTable: function (component, event, helper) {
    console.log('edit acc')
    var allValid = component.find('accountField').reduce(function (validSoFar, inputCmp) {
      inputCmp.showHelpMessageIfInvalid();
      return validSoFar && inputCmp.get('v.validity').valid;
    }, true);
    if (allValid) {
      var data = component.get('v.accountData');
      var rowIndex = component.get("v.indexEditRecord");
      data.splice(rowIndex, 1,component.get('v.addAccount'));
      //data.push(component.get('v.addAccount'));
      component.set('v.accountData', data);
      helper.showToast('Success!', 'The record has been saved', 'success');
      component.set("v.isOpenAccount", false);
      component.set("v.isOpenSite", true);
    } else {
      helper.showToast('Sorry!', 'Please update the invalid form entries and try again.', 'warning');
    }
  },
  addContactOnTable: function (component, event, helper) {
    var allValid = component.find('contactField').reduce(function (validSoFar, inputCmp) {
      inputCmp.showHelpMessageIfInvalid();
      return validSoFar && inputCmp.get('v.validity').valid;
    }, true);
    if (allValid) {
      var data = component.get('v.contactData');
      data.push(component.get('v.addContact'));
      component.set('v.contactData', data);
      helper.showToast('Success!', 'The record has been added', 'success');
      component.set("v.isOpenContact", false);
      component.set("v.isOpenSite", true);
    } else {
      helper.showToast('Sorry!', 'Please update the invalid form entries and try again.', 'warning');
    }
  },
  saveContactOnTable: function (component, event, helper) {
    var allValid = component.find('contactField').reduce(function (validSoFar, inputCmp) {
      inputCmp.showHelpMessageIfInvalid();
      return validSoFar && inputCmp.get('v.validity').valid;
    }, true);
    if (allValid) {
      var data = component.get('v.contactData');
      var rowIndex = component.get("v.indexEditRecord");
      data.splice(rowIndex, 1,component.get('v.addContact'));

      component.set('v.contactData', data);
      helper.showToast('Success!', 'The record has been saved', 'success');
      component.set("v.isOpenContact", false);
      component.set("v.isOpenSite", true);
    } else {
      helper.showToast('Sorry!', 'Please update the invalid form entries and try again.', 'warning');
    }
  },
  closeModalSite: function (component, event, helper) {
    component.set("v.isOpenSite", false);
  },
  closeModalAccountAndContact: function (component, event, helper) {
    component.set("v.isOpenSite", true);
    component.set("v.isOpenAccount", false);
    component.set("v.isOpenContact", false);
  },
  handleRowAction: function (cmp, event, helper) {
    var action = event.getParam('action');
    var row = event.getParam('row');

    switch (action.name) {
      case 'removeSite':
        helper.removeSite(cmp, row);
        break;
      case 'editSite':
          helper.editSite(cmp, row);
          break;
      case 'removeBankAccount':
        helper.removeBankAccount(cmp, row);
        break;
      case 'editBankAccount':        
        helper.eraseAccount(cmp,helper);
        helper.editBankAccount(cmp, row, event);
        break;
      case 'removeContact':
        helper.removeContact(cmp, row);
        break;
      case 'editContact':        
        helper.eraseContact(cmp,helper);
        helper.editContact(cmp, row);
        break;
      
    }
  },
  onBlur: function (component, event, helper) {
    component.set("v.supplierData.TKD_tx_Vendor_name_alternative", component.get('v.supplierData.Name'));
  },
  changeSwift: function (component, event, helper) {
    var tipo_Bic  = component.get('v.addAccount.Tipo_BIC');
    var Bank_Account_Currency  = component.get('v.addAccount.Bank_Account_Currency');
    
    console.log('tipo_Bic ' + JSON.stringify(tipo_Bic));
    if(tipo_Bic === 'SWIFT' && Bank_Account_Currency === 'MXN'){      
      component.set("v.addAccount.Nombre_Banco_intermediadio", "");
      component.set("v.addAccount.Tipo", "");
      component.set("v.addAccount.Codigo", "");
      helper.autoWritteSwiftBanc(component);      
    } else if(Bank_Account_Currency === 'USD'){
      component.set("v.addAccount.Nombre_Banco_intermediadio", "CITIBANK NY");
      component.set("v.addAccount.Tipo", "SWIFT");
      component.set("v.addAccount.Codigo", "CITIUS33");
    }
  }
})