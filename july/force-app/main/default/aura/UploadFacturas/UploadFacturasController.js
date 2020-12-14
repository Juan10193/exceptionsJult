/**
 * @File Name          : UploadFacturasController.js
 * @Description        : 
 * @Author             : jhernandez@anivia.mx
 * @Group              : 
 * @Last Modified By   : jhernandez@anivia.mx
 * @Last Modified On   : 15/7/2019 9:56:47
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      		      Modification
 *==============================================================================
 * 1.0    15/7/2019 9:27:24   jhernandez@anivia.mx     Initial Version
**/
({
    handleRefreshTable : function(component, event, helper) {
        let refreshInvoices = $A.get("e.c:Takedown_RefresTableInvoices_Event");
        refreshInvoices.setParam("message", "Refresca Tabla Invoices");
        refreshInvoices.fire();
    }
})