({
    init: function (cmp, event, helper) {
        cmp.set('v.columns', [
            {label: 'Category', fieldName: 'attributeCategory', type: 'text', cellAttributes: { alignment: 'center' }},
            {label: 'Bank Account N°', fieldName: 'bankAccountNum', type: 'text', cellAttributes: { alignment: 'center' }},
            {label: 'Bank Name', fieldName: 'bankName', type: 'text', cellAttributes: { alignment: 'center' }},
            {label: 'Currency', fieldName: 'currency', type: 'text',  cellAttributes: { alignment: 'center' }},
            {label: 'EndDate', fieldName: 'endDate', type: 'text',  cellAttributes: { alignment: 'center' }},
            {label: 'VendorId', fieldName: 'vendorId', type: 'number', cellAttributes: { alignment: 'center' }},
            {label: 'VendorSiteId', fieldName: 'vendorSiteId', type: 'number',cellAttributes: { alignment: 'center' }}
            
        ]);
    },
    handledetailsitesEvent: function(component, event, helper) {
        let site = event.getParam("sitedata");
        console.log('se cacho el evento');
        console.log(site.country);
        component.set("v.site", site);
        component.set("v.isOpen", true);
        
    },

    closeModel: function(component){
        component.set("v.isOpen", false);
    }
})