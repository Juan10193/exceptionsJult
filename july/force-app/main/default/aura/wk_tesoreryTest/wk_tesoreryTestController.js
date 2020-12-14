({
    init: function (cmp, event, helper) {
        var recordId  = cmp.get("v.recordId");
        helper.getAllTesoreryTest(cmp,event,helper,recordId); 
        helper.getResponses(cmp,event,helper,recordId);
       // helper.getRecordType(cmp,event,helper,recordId);
        console.log("recordId Controller: "+recordId);    		 
            },    
	handleChange: function (cmp, event, helper) {
        var changeValue = event.getParam("value");
        if(changeValue == "option1"){
            document.getElementById("questionare").style.display = "block";
        }else{
            
            document.getElementById("questionare").style.display = "none";
        }
    },
    onRefresh : function(cmp, event, helper) {
        var navigateEvent = $A.get("e.force:navigateToSObject");
        navigateEvent.setParams({ "recordId": cmp.get('v.recordId') });
        navigateEvent.fire();
	},
    onChange: function (cmp, evt, helper) {
        alert(cmp.find('resp1').get('v.value') + ' pie is good.');
    }, 
    createRecord: function(cmp, evt, helper){
        //alert('metodo createRecord c' + cmp.get("v.recordId"));
        //alert('metodo createRecord c New' + cmp.get("v.newTesoreryTest.wk_pd_creditApproval__c"));
        cmp.set("v.newTesoreryTest.wk_pd_creditApproval__c", cmp.get("v.recordId"));
        //alert('metodo createRecord c' + cmp.get("v.newTesoreryTest.wk_pd_creditApproval__c"));       
        var newTesoreryTest = cmp.get("v.newTesoreryTest");
        var recordId  = cmp.get("v.recordId");
        console.log('new: '+newTesoreryTest);
        helper.createRecord(cmp,newTesoreryTest,evt, helper);
        helper.getResponses(cmp,event,helper,recordId);
        
       
    },
    openModel: function(cmp, event, helper) {
      // for Display Model,set the "isOpen" attribute to "true"
      cmp.set("v.isOpen", true);
   },
 
   closeModel: function(cmp, event, helper) {
      // for Hide/Close Model,set the "isOpen" attribute to "Fasle"  
      cmp.set("v.isOpen", false);
       var navigateEvent = $A.get("e.force:navigateToSObject");
        navigateEvent.setParams({ "recordId": cmp.get('v.recordId') });
        navigateEvent.fire();
   },
 
   likenClose: function(component, event, helper) {
      // Display alert message on the click on the "Like and Close" button from Model Footer 
      // and set set the "isOpen" attribute to "False for close the model Box.
      alert('thanks for like Us :)');
      component.set("v.isOpen", false);
   },
    rerender : function(component, helper){
        //this.superRerender();-->
         $A.get("e.force:refreshView").fire();
        // custom rerendering logic here
    }
    
})