({
	getOportunidades : function (component, sourceCAId) {
      let op = component.get("c.getListOpInCa");
      op.setParams({
          "cp": sourceCAId
      });
      
      op.setCallback(this, function (response) {
          let respuesta = response.getReturnValue();
          console.log('respuestaOps ' + respuesta);
      })
      
    },
})