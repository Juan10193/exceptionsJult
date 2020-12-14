({
	hinitListaCont : function(component, sourceCAId) {
		let a = component.get("c.getContentVersions");
        a.setParams({
            "sourceCAID":sourceCAId
        })
        
        a.setCallback(this, function(response){
            let state = response.getReturnValue();
            component.set('v.ListaDocs',state);
            console.log('este es la respuesta' +  JSON.stringify(state));
        });
        
        $A.enqueueAction(a);
    },
    
})