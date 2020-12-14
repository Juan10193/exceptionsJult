({
	warnDc : function(component, event, helper) {
		let sourceCAID = component.get("v.recordId");

		helper.getWarningF(component,sourceCAID);
	}
})