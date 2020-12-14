({
    doInit : function(component, event, helper) {
      let caId = component.get("v.as__id");
      let appEvent = $A.get("e.c:aml_ReviewPassV");
      appEvent.setParams({"caId": caId});
  
      appEvent.fire();
    },

    haceRefresh : function(component){
      $A.get("e.force:refreshView").fire(); 
    }
  });