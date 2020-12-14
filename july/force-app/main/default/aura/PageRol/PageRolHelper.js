({
	fetchPickListVal: function(component, fieldName,targetAttribute) {
      // call the apex class method and pass fieldApi name and object type
        
        var action = component.get("c.getselectOptions");
        action.setParams({
            "objObject": component.get("v.objInfo"),
            "fld": fieldName
        });
        var opts = [];
        action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                var allValues = response.getReturnValue();
                for (var i = 0; i < allValues.length; i++) {
                    opts.push({
                        label: allValues[i],
                        value: allValues[i]
                    });
                }
                component.set("v."+targetAttribute, opts);
                
            }else{
                alert('Callback Failed...');
            }
        });
        $A.enqueueAction(action);
        
        let accion =component.get("c.getRegistro");
        accion.setParams({
            "recordId":component.get("v.recordId")
        });
        
        accion.setCallback(this,function(response){
            if (response.getState() == "SUCCESS") {
                
                var cadenaValores = response.getReturnValue();
                var arrayOpt = cadenaValores.split(';');
                
                component.find("selectOptions").set("v.value", arrayOpt)
            }
        });
         $A.enqueueAction(accion);
    },
})