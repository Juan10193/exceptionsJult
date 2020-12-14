({
    init: function (component, event, helper) {
        	helper.onSaveSupplierInApproval(component,event,helper,component.get("v.recordId"));  
        	helper.getStatusSuppInApproval(component,event,helper,component.get("v.recordId"));
           
    }, 
    
	openModel: function(component, event, helper) {      
      document.getElementById("tabsKNS").style.display = "block";
      document.getElementById("tableAmlHits").style.display = "none";
      component.set("v.visibilityDivSearch", true);
      //component.set("v.isOpen", true);
      component.set("v.SearchByRFC",  "");
      component.set("v.SearchByName",  "");
      component.set("v.SearchByCurrency",  "");
      component.set("v.SearchByTaxCode",  "");
      component.set("v.InformationKnownSuppliers",[]);
   },

   openDocsSuppliers: function(component){
       component.set("v.isModalDocsOpen", true);
   },

   isModalDocsClosed: function(component){
       console.log('el evento se cacha')
       component.set("v.isModalDocsOpen", false);
   },
 
   closeModel: function(component, event, helper) { 
       document.getElementById("tabsKNS").style.display = "none";
       document.getElementById("tableAmlHits").style.display = "block";
      //component.set("v.isOpen", false);
   },
   openModelNewSupplier: function(component, event, helper) {
      component.set("v.isOpenNewSupplier", true);
   },
 
   closeModelNewSupplier: function(component, event, helper) { 
      component.set("v.isOpenNewSupplier", false);
   },
   openModalHitsDesc: function(component, event, helper) {
      component.set("v.isOpenHitsDesc", true);
      var index = event.getSource().get("v.tabindex");
      var allSupplier =  component.get("v.newSupplier") ; 
      component.set("v.idSupplierSelect", allSupplier[index].Id);        
      var params = {'recordId': component.get("v.recordId"),
                      	  'id': allSupplier[index].Id};
      helper.getHitsDesc(component, event, helper,params);
       // alert('Params: '+ JSON.stringify(params));
		console.log("Params: " + JSON.stringify(params));
   }, 
   closeModalHitsDesc: function(component, event, helper) { 
      component.set("v.isOpenHitsDesc", false);
   },
   searchSuppliers: function(component, event, helper){
       console.log('searcheando suppliers')
       //alert('search');
       	var params = {'recordId': component.get("v.recordId"), 
                      'SearchByRFC' : component.get("v.SearchByRFC"), 
                      'SearchByName': component.get("v.SearchByName"),
                      'SearchByCurrency': component.get("v.SearchByCurrency"),
                      'SearchByTaxCode': component.get("v.SearchByTaxCode")
                   	}; 
        var allValid = component.find('fields').reduce(function (validSoFar, inputCmp) {
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get('v.validity').valid;
        }, true);
       if (allValid){
           console.log('esta valido')
            helper.getInformationKnownSupplier(component,event,helper,params);            
            component.set('v.visibilityDivResult', true);
           	component.set('v.loadedKS', false);
           }else {
           //alert('Please update the invalid form entries and try again.');                            
       }
    },
    onSave: function(component, event, helper) {
       // Obtener la lista de la tabla 
       //alert('On save');      
        var lstInformationKnownSuppliers = component.get("v.InformationKnownSuppliers"); 
        //cmp.set("v.newSupplier.TKD_pd_TakedownCP__c", cmp.get("v.recordId"));
        component.set("v.newSupplier.TKD_pd_TakedownCP__c", component.get("v.recordId"));
        var datosSupplier = [{'name':lstInformationKnownSuppliers[0].vendorName, 'rfc': lstInformationKnownSuppliers[0].vatRegistrationNum}]
       
      	var params = {'recordId': component.get("v.recordId"), 
                      'datosSupplier': datosSupplier
                     
                   	}; 
        //alert('datosSupp: '+ JSON.stringify(params));
        helper.getInformationSupplier(component,event,helper,params); 
        //component.set('v.loaded', false);  
            
   }, 

   saveListSites: function(component, event, helper){
        let sites = component.get("v.sitesSelected");
        let sitesfixed = sites.filter((site)=> site !== undefined);
        console.log('Sites a guardar')
        
        if(sitesfixed.length > 0){
            let suppliersH =[];
            let sitesh =[];
            let baccounts=[];
            let contactS =[];
            console.log(sitesfixed);
            sitesfixed.forEach(sit => {
                let Supplier__c = {
                    Name : sit.supplier.vendorName,
                    TKD_tx_Vat_Registration_Num__c: sit.supplier.vatRegistrationNum,
                    TKD_pd_Supplier_in_approval__c: null,
                    TKD_tx_Supplier_Unique_ID__c: null,
                    TKD_Vendor_ID__c:sit.supplier.vendorId.toString(),
                    TKD_tx_Vendor_name_alternative__c : sit.supplier.vendorNameAlt,
                    Nacionalidad__c: sit.supplier.attribute3,
                    TKD_ls_Pais_de_residencia__c:sit.supplier.attribute2,
                    TKD_ls_Tipo_de_tercero__c: sit.supplier.attribute1,
                    Categoria__c:sit.supplier.attributeCategory
                }
                suppliersH.push(Supplier__c);

                let TKD_Site__c ={
                    Name: sit.vendorSiteCode,
                    Supplier__c: null,
                    TKD_Vendor_Site_ID__c: sit.vendorSiteId.toString(),
                    TKD_Vendor_ID__c: sit.vendorId.toString(),
                    CurrencyIsoCode :sit.paymentCurrencyCode,
                    Tkd_ls_Org_Name__c: sit.organizationName,
                    TKD_tx_Country__c: sit.country,
                    Tkd_at_Address_line_1__c: sit.addressLine1,
                    Tkd_at_Address_line_2__c: sit.addressLine2,
                    Tkd_tx_City__c: sit.city,
                    TKD_ls_State__c: sit.state,
                    Tkd_tx_Zip__c: sit.zip,
                    TKD_Vat_code__c:sit.vatCode,
                    primaryPaySiteFlag__c: sit.primaryPaySiteFlag!=='Y'?false:true,
                    Pay_Site_Flag__c: sit.paySiteFlag!=='Y'?false:true,
                    tkd_tf_phone__c: sit.phone
                }
                sitesh.push(TKD_Site__c);
                if(sit.accounts !== null){
                    sit.accounts.account.forEach(bnk => {
                        let Bank_Account__c={
                            Bank_Name__c: bnk.bankName,
                            Name: bnk.bankAccountNum,
                            Bank_Account_Currency__c: bnk.currency,
                            TKD_rb_Site__c: null,
                            TKD_Vendor_Site_ID__c: bnk.vendorSiteId.toString(),
                            Contexto__c:bnk.attributeCategory,
                            Tipo_BIC__c:bnk.attribute1,
                            Codigo_BIC__c:bnk.attribute2,
                            Nombre_Banco_intermediadio__c: bnk.attribute3,
                            Tipo__c:bnk.attribute4,
                            Codigo__c:bnk.attribute5,
                            Pago_a_Cuenta_Concentradora__c:bnk.attribute6,
                            Pago_a_Cta_Concentradora_RN__c: bnk.attribute7
                        }
                        baccounts.push(Bank_Account__c);
                    });
                }

                if(sit.contacts !== null){
                    sit.contacts.contact.forEach(cn=>{
                        let Contact ={
                            TKD_rb_Site__c: null,
                            TKD_Vendor_Site_ID__c: cn.vendorSiteId.toString(),
                            FirstName: cn.personFirstName,
                            LastName: cn.personLastName,
                            MiddleName: cn.personMiddleName,
                            Email: cn.emailAddress,
                            Phone: cn.phone

                        }

                        contactS.push(cn);
                    })

                }
                
            });

           
            console.log('los suppliers para apex')
            console.log(suppliersH)
            console.log('los banks para apex')
            console.log(baccounts)
            component.set("v.suppliersSelected", suppliersH);
            let suppliersApex = component.get("v.suppliersSelected");
            helper.saveknowsuppliers(component,event, helper, suppliersApex, sitesh, baccounts, contactS);
        }else{
            //alert('Please Selecet First a site');
        }
   },
     handleChange: function (component, event , helper) {
		        
		var isChecked = component.find("chkbxSupplierAllSelected").get("v.checked");
         //alert('isChecked: '+isChecked); 
        for(var chkbxSupplierSelected in component.find("chkbxSupplierSelected")) {            
		     component.set("v.ischkbxSupplierSelected",isChecked);				               		  
        } 
    },    
    
    handleSectionToggle: function (cmp, event) {        
        var openSections = event.getParam('openSections');
    }/*,
    openModalInvoice: function (component, event, helper){
        component.set("v.isOpenInvoice", true);
        var index = event.getSource().get("v.tabindex");
        var allSupplier =  component.get("v.newSupplier") ; 
        component.set("v.idSupplierSelect", allSupplier[index].Id);        
        var params = {'recordId': component.get("v.recordId"),
                      'id'  : allSupplier[index].Id,
                      'rfc' : allSupplier[index].TKD_tx_Vat_Registration_Num__c, 
                      'name': allSupplier[index].TKD_tx_Vendor_Name__c};
        //alert('Params: '+ JSON.stringify(params));
		console.log("Params: " + JSON.stringify(params));
        helper.getInvoices(component, event, helper, params);
    }*/
    ,
    closeModalInvoice: function (component, event, helper){
        component.set("v.isOpenInvoice", false);
        component.set("v.lstInvoices",[]);
    }
     ,
    onSaveInvoice: function (component, event, helper){
        //alert('IdSupplier'+ component.get("v.idSupplierSelect"));
        	//var lstInvoicesSelected = component.get('v.lstInvoicesSelected');
        	var params = {'recordId': component.get("v.recordId"), 
                          'idSupplierSelect': component.get("v.idSupplierSelect"),
                          'lstInvoicesSelected': component.get("v.lstInvoicesSelected")}; 
        	helper.onSaveInvoice(component, event, helper , params);
        //alert('lstInvoicesSelected: ' + JSON.stringify(lstInvoicesSelected));         		  
       
    },
     handleChangeCheckBx: function (component, event , helper) {		        
		 var isChecked = event.getSource().get('v.checked');
         var index = event.getSource().get('v.value');
         var invoice = component.get('v.lstInvoices')[index];
         //alert('isChecked: '+isChecked + ' index: '+index + ' invoice: '+JSON.stringify(invoice)); 
         var lstInvoicesSelected = component.get('v.lstInvoicesSelected');
         if(isChecked){
            lstInvoicesSelected.push(invoice);
         }else{
             var indexOf = lstInvoicesSelected.indexOf(invoice);
             lstInvoicesSelected.splice(indexOf,1);
         }
        
    },
    
    showDetails: function (component, event, helper){ 
        var indexDet = event.getSource().get("v.tabindex");
        //alert('details 23: '+ indexDet);
        //var style = event.getSource().get("v.style");
        //alert('style: '+ style );
        var  knowSupplier = component.get("v.InformationKnownSuppliers");
        var params = {'vendorId'  : knowSupplier[indexDet].vendorId};
       	helper.showDetailknowSupplier(component, event, helper, params);        
        component.set('v.visibilityDivSearch', false);
        component.set('v.visibilityDivResult', false);
        component.set('v.visibilityDivDetail', true);
        
        
    }, 
    
    selectSite: function (component,event,helper){
        console.log("its work",event.getSource().get("v.tabindex"));
        let indexSupp = event.getSource().get("v.tabindex");
        let icon  =event.getSource().get("v.iconName");
        if(icon ==='utility:add'){
            event.getSource().set("v.iconName", "utility:check");
            let suppilers = component.get("v.filterKnownSuppliers");
            let sitesSelected = component.get("v.sitesSelected");
            sitesSelected[indexSupp] =suppilers[indexSupp];

        }else{
            event.getSource().set("v.iconName", "utility:add");
            let sitesSelected = component.get("v.sitesSelected");
            sitesSelected.splice(indexSupp, 1);
        }
    },
    
    showDetailsContacts: function (component, event, helper){        
        var name = event.getSource().get("v.name");
        var indexes = name.split("-");//posision 0 es supplier, posision 1 es site, posision 2 es contacto        
        var  lstSuppliers = component.get("v.InformationDetKnownSuppliers");
        var supplierSelected = lstSuppliers[indexes[0]];
        var siteSelected = supplierSelected.sites.site[indexes[1]];
        var contactSelected = siteSelected.contacts.contact[indexes[2]];
       	//alert('contactSelected: ' + JSON.stringify(contactSelected));
        component.set("v.isOpenContact", true);
	},
    closeModalContact: function (component, event, helper){
        component.set("v.isOpenContact", false);
    }, 
    
    showDetailsAccount: function (component, event, helper){        
        
        var name = event.getSource().get("v.name");
        var indexes = name.split("-");//posision 0 es supplier, posision 1 es site, posision 2 es cuenta
        var lstSuppliers = component.get("v.InformationDetKnownSuppliers");
        var supplierSelected = JSON.parse(JSON.stringify(lstSuppliers[indexes[0]]));
        var siteSelected = supplierSelected.sites.site[indexes[1]];
        var accountSelected = siteSelected.accounts.account[indexes[2]];
        supplierSelected.sites = null;
        siteSelected.contacts = null;
        siteSelected.accounts = null;
        siteSelected.supplier = supplierSelected;
        accountSelected.site = siteSelected;
		component.set("v.accountSelected", accountSelected);

        console.log('accountSelected: ' + JSON.stringify(accountSelected));
        component.set("v.isOpenAccount", true);
         
	},
    closeModalAccount: function (component, event, helper){
        component.set("v.isOpenAccount", false);
    },
    newAccount: function (component, event, helper){
        component.set("v.isOpenAccount", true); 
        var accountSelected = component.get("v.accountSelected");
        accountSelected = new Object();
        //Inicializar variables
       var name = event.getSource().get("v.name");
        var indexes = name.split("-");//posision 0 es supplier, posision 1 es site
        var lstSuppliers = component.get("v.InformationDetKnownSuppliers");
        var supplierSelected = JSON.parse(JSON.stringify(lstSuppliers[indexes[0]]));
        var siteSelected = supplierSelected.sites.site[indexes[1]];
        
        supplierSelected.sites = null;
        siteSelected.contacts = null;
        siteSelected.accounts = null;
        siteSelected.supplier = supplierSelected;
        accountSelected.site = siteSelected;
		component.set("v.accountSelected", accountSelected);

        console.log('accountSelected: ' + JSON.stringify(accountSelected));
        component.set("v.isOpenAccount", true);
    },
    newContact: function (component, event, helper){
        component.set("v.isOpenContact", true);
        //Inicializar variables
    },
    cancelDetails: function (component, event, helper){
       component.set('v.visibilityDivSearch', true);
       component.set('v.visibilityDivResult', true);
       component.set('v.visibilityDivDetail', false);
    } ,
    cancelSearch: function (component, event, helper){
       document.getElementById("tabsKNS").style.display = "none";
       document.getElementById("tableAmlHits").style.display = "block";
    },
      gotoURlSupplier : function (component, event, helper) { 
        var idSuppInApp= component.get("v.statusSuppApp");
          //alert('idSuppInApp: ' + JSON.stringify(idSuppInApp) +'id: '+ idSuppInApp.Id);
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({ 
            "recordId": idSuppInApp.Id,
            "slideDevName": "related"
        });
        navEvt.fire();
    },
     delete: function(component, event, helper) {
      var index = event.getSource().get("v.tabindex");
    //alert(index);
      var allSupplier =  component.get("v.newSupplier") ; 
      component.set("v.idSupplierSelect", allSupplier[index].Id);        
      var params = {'recordId': component.get("v.recordId"),
                      	  'id': allSupplier[index].Id};
      //alert('Params: '+ JSON.stringify(params));
	  helper.delete(component, event, helper,params);
	  console.log("Params: " + JSON.stringify(params));
   },

   showdetailSite: function(component, event, helper){
       let siteSelectd = event.currentTarget;
       let siteId =siteSelectd.dataset.sited;
       console.log( siteId);
       
       
       let site = component.get("v.filterKnownSuppliers").find(({vendorSiteId})=>vendorSiteId===Number(siteId))
       console.log(site);

       var appEvent = $A.get("e.c:detailsitesEvent");


       appEvent.setParams({
            "sitedata" : site
        });
        
        appEvent.fire();
      
   }
    
    
    
  
})