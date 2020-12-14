({
	getOps : function (component,event, helper) {
        let sourceCAId =  component.get("v.recordId");
        console.log(sourceCAId);
        helper.getOportunidades(component, sourceCAId);
    },
})