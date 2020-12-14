({

    doInit : function (component, event, helper){
        //call apex class method
        var action = component.get('c.getButtonsCA');
        let sourceCAId = component.get('v.recordId');
        action.setParams({
        "StatusCA": sourceCAId
        })
        
        action.setCallback(this,function(response){
        //store state of response
            let state = response.getState();
            if (state === "SUCCESS") {
                console.log(response.getReturnValue());
        //set response value(map) in myMap attribute on component.
            component.set('v.button',response.getReturnValue());
            console.log('BOTONES ESTATUS' +  response.getReturnValue);
        }
    });
        $A.enqueueAction(action);
    },
    recargarx2:function(component,event,helper){
     	let urlparams=window.location.search;
        let CAId = component.get('v.recordId');
        let jsonParameters
        console.log(urlparams.includes('?ettyinCA=yes'));
        if(urlparams){
        let parametros = urlparams.replace(/=/g,'":"');
        console.log(parametros);
        let parameteros2 = parametros.replace('?','');
        let parameters = '{"' + parameteros2 + '"}';
        console.log(parameters);
        jsonParameters = JSON.parse(parameters);
        console.log(jsonParameters);
        
        }
        
        helper.hrecargarx2(component,CAId, jsonParameters);
    },
    
    refresca:function (component, event, helper){
        
		$A.get("e.force:refreshView").fire();        
    },
    
    //EVENTOS BOTONES
    sendToRISK: function(component, event, helper) {
       let sourceCAId = component.get('v.recordId');
       let nameButton = 'Send To Risk';
       helper.hsendToRISK(component, sourceCAId, nameButton);
    },
	sendToAML: function(component, event, helper) {
    let sourceCAId = component.get('v.recordId');
    let nameButton = 'Send To AML';
    helper.hsendToAML(component, sourceCAId, nameButton);
    },
	submitForAproval: function(component, event, helper) {
    let sourceCAId = component.get('v.recordId');
    let nameButton = 'Submit for Approval';
    helper.hsubmitForAproval(component, sourceCAId, nameButton);
    },

    WithdrawnAML: function(component, event, helper) {
    let sourceCAId = component.get('v.recordId');
    let nameButton = 'Withdrawn AML';
    helper.hWithdrawnAML(component, sourceCAId, nameButton);
    },

    WithdrawnRISK: function(component, event, helper) {
    let sourceCAId = component.get('v.recordId');
    let nameButton = 'Withdrawn Risk';
    helper.hWithdrawnRISK(component, sourceCAId, nameButton);
    },

    onHoldRisk: function(component, event, helper) {
    let sourceCAId = component.get('v.recordId');
    let nameButton = 'On Hold Risk';
    helper.honHoldRisk(component, sourceCAId, nameButton);
    },

    reworkRisk: function(component, event, helper) {
    let sourceCAId = component.get('v.recordId');
    let nameButton = 'Rework Risk';
    helper.hreworkRisk(component, sourceCAId, nameButton);
    },
    
    reworkForEntRisk: function(component, event,helper){
    let sourceCAId = component.get('v.recordId');
    let nameButton = 'Rework For Entities Risk';
    helper.hreworkForEntRisk(component, sourceCAId,nameButton);
    },


    declineRisk: function(component, event, helper) {
    let sourceCAId = component.get('v.recordId');
    let nameButton = 'Decline Risk';
    helper.hdeclineRisk(component, sourceCAId, nameButton);
    },
    
    backtoInProcessRisk: function(component, event, helper) {
    let sourceCAId = component.get('v.recordId');
    let nameButton = 'Back to in Process Risk';
    helper.hbacktoInProcessRisk(component, sourceCAId, nameButton);
    },

    acceptToReviewRisk: function(component, event, helper) {
    let sourceCAId = component.get('v.recordId');
    let nameButton = 'Accept to review Risk';
    helper.hacceptToReviewRisk(component, sourceCAId, nameButton);
    },

    reworkAML: function(component, event, helper) {
    let sourceCAId = component.get('v.recordId');
    let nameButton = 'Rework AML';
    helper.hreworkAML(component, sourceCAId, nameButton);
    },
    
    reworkForEntAML: function(component, event,helper){
        let sourceCAId = component.get('v.recordId');
        let nameButton = 'Rework For Entities AML';
        helper.hreworkForEntAML(component, sourceCAId,nameButton);
    },

    onHoldAML: function(component, event, helper) {
    let sourceCAId = component.get('v.recordId');
    let nameButton = 'On Hold AML';
    helper.honHoldAML(component, sourceCAId, nameButton);
    },

    declineAML: function(component, event, helper) {
    let sourceCAId = component.get('v.recordId');
    let nameButton = 'Decline AML';
    helper.hdeclineAML(component, sourceCAId, nameButton);
    },

    backtoInProcessAML: function(component, event, helper) {
    let sourceCAId = component.get('v.recordId');
    let nameButton = 'Back to in Process AML';
    helper.hbacktoInProcessAML(component, sourceCAId, nameButton);
    },

    approveAMLWithConditions: function(component, event, helper) {
    let sourceCAId = component.get('v.recordId');
    let nameButton = 'Approve AML With conditions';
    helper.happroveAMLWithConditions(component, sourceCAId, nameButton);
    },

    approveAML: function(component, event, helper) {
    let sourceCAId = component.get('v.recordId');
    let nameButton = 'Approve AML';
    helper.happroveAML(component, sourceCAId, nameButton);
    },

    acceptToReviewAML: function(component, event, helper) {
    let sourceCAId = component.get('v.recordId');
    let nameButton = 'Accept to review AML';
    helper.hacceptToReviewAML(component, sourceCAId, nameButton);
    },

 })