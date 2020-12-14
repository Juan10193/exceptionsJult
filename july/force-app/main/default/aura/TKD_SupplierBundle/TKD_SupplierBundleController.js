/**
 * @File Name          : TKD_SupplierBundleController.js
 * @Description        : 
 * @Author             : eduardo.villegas@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : eduardo.amiens@outlook.com
 * @Last Modified On   : 09-02-2020
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    11/12/2019   eduardo.villegas@engeniumcapital.com     Initial Version
**/
({
    openDocsSuppliers: function(component){
        component.set("v.isModalDocsOpen", true);
    },
    isModalDocsClosed: function(component){
        console.log('el evento se cacha')
        component.set("v.isModalDocsOpen", false);
    },
    handleAddsupplier:function(component, event){
        console.log('ADDDSUPPLIER HANDLED');
        let isopen = event.getParam("showTable");
        component.set("v.addisopen", isopen);
    },

    handleSaveNewSupplier:function(component, event){
       component.set("v.addisopen", false);
    }
})