({
     showInfoToast: function(component, event, helper) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title: 'Info Message',
            message: 'No have Evals in this Oportunity',
            messageTemplate: 'Record {0} created! See it {1}!',
            duration: ' 5000',
            key: 'info_alt',
            type: 'info',
            mode: 'dismissible'
        });
        toastEvent.fire();
    },
    
    gurlServ: function(component, event, helper) {

        helper.getServiceUrl(component);
    },
    
    gInstanceUrl: function(component,event,helper){
        helper.gInstanceUrlH(component);
    },
    
    gSSO : function(component,event,helper){
        
        helper.getEmployeSso(component);
    },
    
    viewEval:function(component, event, helper){
        let requestId = event.getSource().get("v.alternativeText");
        let so =component.get("v.sso");
        helper.verEval(component, requestId, so);
    },
    
	 calloutCtrl: function(component, event, helper) {
         console.log('hola');
        let sServiceUrl = component.get("v.urlServer")
        let sourceOpIdA = component.get("v.recordId");
        let sourceOpId =  sourceOpIdA.slice(0, sourceOpIdA.length-3);
         console.log("la id de la op: " + sourceOpId)
         
         
        let searchRequestId = '';
        helper.getResponse(component, sServiceUrl, searchRequestId, sourceOpId);
    },
    
    toggle: function(component, event, helper) {
        let toggleText = component.find("tabla");
        $A.util.removeClass(toggleText, "hide");
        let a = component.get('c.calloutCtrl');
        $A.enqueueAction(a);

    },
})