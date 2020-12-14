/**
 * @description       : 
 * @author            : eduardo.amiens@outlook.com
 * @group             : 
 * @last modified on  : 09-14-2020
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 * Modifications Log 
 * Ver   Date         Author                       Modification
 * 1.0   09-10-2020   eduardo.amiens@outlook.com   Initial Version
**/
({
    doInit: function(component, event, helper) {
        let takedownId = component.get("v.recordId");
        console.log('Do INIT RECORDID: ' + takedownId);
        helper.getVendorSiteIdsHelper(component, event, helper, takedownId);
    },

    searchSuppliers: function(component, event, helper) {
        component.set("v.spinner", true);
        console.log("searcheando suppliers");
        //alert('search');
        var params = {
            recordId: component.get("v.recordId"),
            SearchByRFC: component.get("v.SearchByRFC"),
            SearchByName: component.get("v.SearchByName"),
            SearchByCurrency: component.get("v.SearchByCurrency"),
            SearchByTaxCode: component.get("v.SearchByTaxCode")
        };
        var allValid = component
            .find("fields")
            .reduce(function(validSoFar, inputCmp) {
                inputCmp.showHelpMessageIfInvalid();
                return validSoFar && inputCmp.get("v.validity").valid;
            }, true);
        if (allValid) {
            console.log("esta valido");
            helper.getInformationKnownSupplier(component, event, helper, params);
            component.set("v.visibilityDivResult", true);
            component.set("v.loadedKS", false);
        } else {
            //alert('Please update the invalid form entries and try again.');
        }
    },
    selectSite: function(component, event, helper) {
        console.log("its work", event.getSource().get("v.tabindex"));
        let indexSupp = event.getSource().get("v.tabindex");
        let icon = event.getSource().get("v.iconName");
        if (icon === "utility:add") {
            event.getSource().set("v.iconName", "utility:check");
            let suppilers = component.get("v.filterKnownSuppliers");
            let sitesSelected = component.get("v.sitesSelected");
            sitesSelected[indexSupp] = suppilers[indexSupp];
            let operationunit = component.get("c.getTakedownOperationUnit");
            operationunit.setParams({
                recordId: component.get("v.recordId")
            });
            operationunit.setCallback(this, function(response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    let operation = response.getReturnValue();
                    console.log('operation unit seleccionado: ' + sitesSelected[indexSupp].organizationName);
                    if (operation !== sitesSelected[indexSupp].organizationName) {
                        alert('Este Takedown tiene un Operation Unit igual a : ' + operation + ' y el site seleccionado es : ' +
                            sitesSelected[indexSupp].organizationName + '. No coinciden, este Site se clonará con el  Operation Unit del takedown');
                        sitesSelected[indexSupp].organizationName = operation === 'UO_XA7 ENGECAP' ? 'UO_XA7 ENGENCAP' : operation;
                        sitesSelected[indexSupp].vendorSiteId = null;
                        if (sitesSelected[indexSupp].accounts) {
                            let acc = sitesSelected[indexSupp].accounts.account
                            acc.forEach(cuenta => {
                                cuenta.vendorSiteId = null;
                            });
                        }
                        if (sitesSelected[indexSupp].contacts) {
                            let con = sitesSelected[indexSupp].contacts.contact
                            con.forEach(contacto => {
                                contacto.vendorSiteId = null;
                            });
                        }
                        console.log('site a clonar');
                        console.log(sitesSelected[indexSupp]);
                    }
                }
            });
            $A.enqueueAction(operationunit);
        } else {
            event.getSource().set("v.iconName", "utility:add");
            let sitesSelected = component.get("v.sitesSelected");
            sitesSelected.splice(indexSupp, 1);
        }
    },
    saveListSites: function(component, event, helper) {
        component.set("v.spinner", true);
        let sites = component.get("v.sitesSelected");
        let sitesfixed = sites.filter(site => site !== undefined);
        console.log("Sites a guardar");

        if (sitesfixed.length > 0) {
            let suppliersH = [];
            let sitesh = [];
            let baccounts = [];
            let contactS = [];
            console.log(sitesfixed);
            sitesfixed.forEach(sit => {
                let Supplier__c = {
                    Name: sit.supplier.vendorName,
                    TKD_tx_Vat_Registration_Num__c: sit.supplier.vatRegistrationNum,
                    TKD_pd_Supplier_in_approval__c: null,
                    TKD_tx_Supplier_Unique_ID__c: null,
                    TKD_Vendor_ID__c: sit.supplier.vendorId.toString(),
                    TKD_tx_Vendor_name_alternative__c: sit.supplier.vendorNameAlt,
                    Nacionalidad__c: sit.supplier.attribute3,
                    TKD_ls_Pais_de_residencia__c: sit.supplier.attribute2,
                    TKD_ls_Tipo_de_tercero__c: sit.supplier.attribute1,
                    Categoria__c: sit.supplier.attributeCategory
                };
                suppliersH.push(Supplier__c);

                let TKD_Site__c = {
                    Name: sit.vendorSiteCode,
                    Supplier__c: null,
                    TKD_Vendor_Site_ID__c: sit.vendorSiteId !== null ? sit.vendorSiteId.toString() : null,
                    TKD_Vendor_ID__c: sit.vendorId.toString(),
                    CurrencyIsoCode: sit.paymentCurrencyCode,
                    Tkd_ls_Org_Name__c: sit.organizationName,
                    TKD_tx_Country__c: sit.country,
                    Tkd_at_Address_line_1__c: sit.addressLine1,
                    Tkd_at_Address_line_2__c: sit.addressLine2,
                    Tkd_tx_City__c: sit.city,
                    TKD_ls_State__c: sit.state,
                    Tkd_tx_Zip__c: sit.zip,
                    TKD_Vat_code__c: sit.vatCode,
                    primaryPaySiteFlag__c: sit.primaryPaySiteFlag !== 'Y' ? false : true,
                    Pay_Site_Flag__c: sit.paySiteFlag !== 'Y' ? false : true,
                    tkd_tf_phone__c: sit.phone,
                    inactiveDate__c: sit.inactiveDate
                };
                sitesh.push(TKD_Site__c);
                if (sit.accounts !== null) {
                    sit.accounts.account.forEach(bnk => {
                        let Bank_Account__c = {
                            SR_tx_Bank_Name__c: bnk.bankName,
                            Name: bnk.bankAccountNum,
                            Bank_Account_Currency__c: bnk.currency,
                            TKD_rb_Site__c: null,
                            TKD_Vendor_Site_ID__c: bnk.vendorSiteId !== null ? bnk.vendorSiteId.toString() : null,
                            Contexto__c: bnk.attributeCategory,
                            Tipo_BIC__c: bnk.attribute1,
                            Codigo_BIC__c: bnk.attribute2,
                            Nombre_Banco_intermediadio__c: bnk.attribute3,
                            Tipo__c: bnk.attribute4,
                            Codigo__c: bnk.attribute5,
                            Pago_a_Cuenta_Concentradora__c: bnk.attribute6,
                            Pago_a_Cta_Concentradora_RN__c: bnk.attribute7,
                            SR_tx_Country__c: bnk.countryCode,
                        	TKD_tx_OraclebankId__c:bnk.bankId.toString()

                        };
                        baccounts.push(Bank_Account__c);
                    });
                }

                if (sit.contacts !== null) {
                    sit.contacts.contact.forEach(cn => {
                        let Contact = {
                            TKD_rb_Site__c: null,
                            TKD_Vendor_Site_ID__c: cn.vendorSiteId !== null ? cn.vendorSiteId.toString() : null,
                            FirstName: cn.personFirstName,
                            LastName: cn.personLastName,
                            MiddleName: cn.personMiddleName,
                            Email: cn.emailAddress,
                            Phone: cn.phone,
                            inactiveDate__c: cn.inactiveDate
                        };

                        contactS.push(Contact);
                    });
                }
            });

            console.log('los sites para apex')
            console.log(sitesh)
            console.log("los suppliers para apex");
            console.log(suppliersH);
            console.log("los banks para apex");
            console.log(baccounts);
            console.log("los contacts para apex");
            console.log(contactS);
            component.set("v.suppliersSelected", suppliersH);
            let suppliersApex = component.get("v.suppliersSelected");
            helper.saveknowsuppliers(
                component,
                event,
                helper,
                suppliersApex,
                sitesh,
                baccounts,
                contactS
            );
        } else {
            //alert('Please Selecet First a site');
        }
    },

    showdetailSite: function(component, event, helper) {
        let siteSelectd = event.currentTarget;
        let siteId = siteSelectd.dataset.sited;
        console.log(siteId);

        let site = component
            .get("v.filterKnownSuppliers")
            .find(({ vendorSiteId }) => vendorSiteId === Number(siteId));
        console.log(site);

        var appEvent = $A.get("e.c:detailsitesEvent");

        appEvent.setParams({
            sitedata: site
        });

        appEvent.fire();
    },

});