({	getAllTesoreryTest: function(cmp,event,helper,recordId){
    	var action = cmp.get("c.getTesoreryTest"); 
    	action.setParams({"recordId" : recordId});
    	console.log("recordIdHelper R: "+ recordId);
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                //alert('response.getReturnValue' + response.getReturnValue());
                if(response.getReturnValue() == null || response.getReturnValue() == '' ){
                    //alert('Entro en el if');
                    cmp.set("v.newTesoreryTest", response.getReturnValue());
                    cmp.set("v.newTesoreryTest.wk_pd_creditApproval__c", cmp.get("v.recordId"));                    
                    
                }else {
                    //alert('entro en el else' + response.getReturnValue());
                    cmp.set("v.newTesoreryTest", response.getReturnValue());                   
                    cmp.set("v.value",'option1');
                    document.getElementById("questionare").style.display = "block";
                }                                
                console.log("Success" + state);
                console.log("tesoreryTest getAllTesoreryTest : " + response.getReturnValue());
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);        
	},
  getResponses: function(cmp,event,helper,recordId){
    	var action = cmp.get("c.getResponses"); 
    	action.setParams({"recordId" : recordId});
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                cmp.set("v.responses", response.getReturnValue());                
                console.log("Success" + state);
                console.log("responses : " + response.getReturnValue());
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);        
	},
  //Fuction to create Record
  createRecord: function(cmp,tesoreryTest,evt,helper){
      //alert('metodo createRecord en h');
      this.upsertRecord(cmp,tesoreryTest, function(a){
          var tesoreryTest = cmp.get("v.tesoreryTest");
          tesoreryTest=a.getReturnValue();
          cmp.set("v.tesoreryTest",tesoreryTest)
      });
      
  },
  //Function to insert/update record 
  upsertRecord: function(cmp,tesoreryTest,callback,evt,helper){
      var action = cmp.get("c.getupsertTesoreryTest");
      action.setParams({
          "tesoreryTest" : tesoreryTest});
      console.log("tesoreryTest RMs: " + tesoreryTest);
      if(callback){
          action.setCallback(this,callback);
      }
      $A.enqueueAction(action);
      console.log("pruebas: " + tesoreryTest);
      //alert( '¡Registro Guardado Exitosamente Yea!'+ tesoreryTest);
      cmp.set("v.isOpen", true);
      
  }
})