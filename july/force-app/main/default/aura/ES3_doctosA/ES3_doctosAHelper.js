({
	getWarningF : function(component, sourceCAID) {
		let a = component.get("c.CallbackGetWarningDocs");
		a.setParams({
			"sourceCAId":sourceCAID
		})

		a.setCallback(this, function(response){
			let state = response.getReturnValue();
			console.log('se hiso');
		})
		$A.enqueueAction(a);
	}
})