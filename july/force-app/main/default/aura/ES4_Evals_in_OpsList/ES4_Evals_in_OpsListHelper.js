({
	 getServiceUrl: function(component) {
        let ur = component.get("c.getUrl");

        ur.setCallback(this, function(response) {
            let state = response.getReturnValue();
            component.set("v.urlServer", state);
        });

        $A.enqueueAction(ur);
    },
    
    gInstanceUrlH : function(component){
      let ur = component.get("c.getUrlInstance");
        ur.setCallback(this, function(response){
           let state  = response.getReturnValue();
            component.set("v.instanceUri", state + '/one/one.app#/alohaRedirect/apex/ES4_ReadPage_EVAL?');
        });
        
        $A.enqueueAction(ur);
    },
    
    getEmployeSso : function(component){
        let sso = component.get("c.getSSO");
        
        sso.setCallback(this, function(response) {
            let state = response.getReturnValue();
            component.set("v.sso", state);
        });

        $A.enqueueAction(sso);
    },
    
     getResponse: function(component, sServiceUrl, searchRequestId, sourceOpId) {
        var action = component.get("c.CallbackGetEvInOps");
        action.setParams({
            "sServiceUrl": sServiceUrl,
            "searchRequestId": searchRequestId,
            "sourceOpId": sourceOpId
        });
         
        	 action.setCallback(this, function(response) {
             
             var state = response.getState();
                  if (component.isValid()) {
                      // set the response(return Map<String,object>) to response attribute.      
                      let respuesta = response.getReturnValue();
                      if (respuesta.requests != null) {
                          component.set("v.response", respuesta);
                          
                          let listaEvals = respuesta.requests.request
                          component.set("v.ListaEvals", listaEvals);
                          
                      }else{
                          let nodata = component.get("c.showInfoToast");
                          $A.enqueueAction(nodata);
                      }
                  }
         	});
         
         	$A.enqueueAction(action);
      },
    
    verEval : function(component, requestId, so){
        let url = component.get("v.instanceUri");
        
        
        window.open(url + 'requestId='+ requestId + '&sso=' + so + '&from=Opportunity');
    }
})