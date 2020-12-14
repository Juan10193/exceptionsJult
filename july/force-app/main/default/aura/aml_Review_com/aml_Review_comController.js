({
  doInit : function(component, event, helper) {
    component.set("v.as__id", component.get("v.pageReference").state.as__id);
    component.set("v.as__commentType", component.get("v.pageReference").state.as__commentType);
    component.set("v.re__load", component.get("v.pageReference").state.re__load);
    let reload = component.get("v.re__load");
    let caId = component.get("v.as__id");
    let appEvent = $A.get("e.c:aml_ReviewPassV");
    appEvent.setParams({"caId": caId});

    appEvent.fire();
    console.log('eldoinit');
  },

  reloadPage : function (component, event, helper) {
    location.reload();
  },

  handleStructure : function(component,event,helper){
    var entidad = event.getParam('listaEnt');
    console.log('entidades aura');
    console.log(entidad);
    component.set('v.EntDetail', entidad);
    component.set('v.showDetail', true);
  },

  handleDetails : function(component, event, helper){
    var detalles = event.getParam('listaEnt');
    console.log('detalles aura');
    console.log(detalles);
    component.set('v.detalle', detalles);
    component.set('v.showDetalles', true);
  },

  handleadverse :function(component, event, helper){
    console.log('se refresca adverse');
    location.reload();
  },

  openCa :function(component, event, helper){
    var navEvt = $A.get("e.force:navigateToSObject");
    navEvt.setParams({
      "recordId": component.get('v.as__id'),
      "slideDevName": "Detail"
    });
    navEvt.fire();
  }


});