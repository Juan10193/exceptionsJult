/**
 * @File Name          : takedownTableDocumentsCMPController.js
 * @Description        : 
 * @Author             : jhernandez@anivia.mx
 * @Group              : 
 * @Last Modified By   : jhernandez@anivia.mx
 * @Last Modified On   : 15/7/2019 10:49:47
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      		      Modification
 *==============================================================================
 * 1.0    15/7/2019 9:50:25   jhernandez@anivia.mx     Initial Version
**/
({
    handleRefresh : function(component, event, helper) {
        let message = event.getParam("message");
        console.log(message);
        component.set('refresh', true);
        $A.get('e.force:refreshView').fire();
    }
})