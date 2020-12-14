/**
 * @File Name          : TKD_Supplier_TableAMLHitsController.js
 * @Description        : 
 * @Author             : eduardo.villegas@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : eduardo.villegas@engeniumcapital.com
 * @Last Modified On   : 12/12/2019 13:41:33
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    10/12/2019   eduardo.villegas@engeniumcapital.com     Initial Version
**/
({
    init : function(component, event, helper) {
        component.set('v.supplierDataTableColumns', [
            { label: 'RFC', fieldName: 'TKD_RFC', type: 'text' },
            { label: 'Name', fieldName: 'TKD_Name', type: 'text' },
            { label: 'Sites', fieldName: 'TKD_Sites', type: 'text' },
            { label: 'Tax code', fieldName: 'TKD_TaxCode', type: 'text' },
            { label: 'Currency', fieldName: 'TKD_Currency', type: 'text' },
            { label: 'AML Hits', cellAttributes: {
                iconName: { fieldName: 'TKD_AML_Hits' },
                iconPosition: 'left'
            } },
            //{ label: 'Hits Description', fieldName: 'TKD_Hits_description', type: 'text' },
            { label: 'Oracle Supplier', cellAttributes: {
                iconName: { fieldName: 'TKD_Oracle_Supplier' },
                iconPosition: 'left'
            } },            
            { label: 'Invoice', fieldName: 'TKD_Invoice', type: 'text' },
            { type: 'action', typeAttributes: { rowActions: [
                                                  {label: 'View detail', name: 'viewDetail' },
                                                  {label: 'Edit', name: 'edit' },
                                                  {label: 'Delete', name: 'delete' }]
                                                }}
                                            ]);
        helper.getInitialData(component,event,helper,component.get("v.recordId"));        
    },
    handleRowAction: function (cmp, event, helper) {
        var action = event.getParam('action');
        var row = event.getParam('row');
    
        switch (action.name) {
          case 'delete':
            helper.delete(cmp, row);
            break;
          case 'edit':
              helper.edit(cmp, row);
              break;
        }
      }
})