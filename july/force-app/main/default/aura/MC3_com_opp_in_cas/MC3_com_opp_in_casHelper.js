({
	tablah : function(component) {
        let listopp = component.get('c.getCAs');
        console.log(component.get("v.recordId"));
        listopp.setParams({
            "idCA":component.get("v.recordId")
        });
        listopp.setCallback(this,function(response){
              let status=response.getState();
        if(status === "SUCCESS"){
            console.log('ya regrese')
            let reslist=response.getReturnValue();
            if(reslist == null){
                console.log('no hay nada');
            }else{
                                 
                component.set('v.listaopp',reslist);
                console.log(component.get('v.listaopp', reslist))
            }
            
        }
        })
        $A.enqueueAction(listopp);
	}
})