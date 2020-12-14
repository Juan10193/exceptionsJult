({

    showInfoToast: function(component, event, helper) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title: 'Info Message',
            message: 'No have documents',
            messageTemplate: 'Record {0} created! See it {1}!',
            duration: ' 5000',
            key: 'info_alt',
            type: 'info',
            mode: 'dismissible'
        });
        toastEvent.fire();
    },


    showSuccessToast: function(component, event, helper) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title: 'Success Message',
            message: 'The document has been delete',
            messageTemplate: 'Record {0} created! See it {1}!',
            duration: ' 5000',
            key: 'info_alt',
            type: 'success',
            mode: 'pester'
        });
        toastEvent.fire();
    },


    openOpportunity: function(component, event, helper){
    
    },

    gInstanceUrl: function(component,event,helper){
        helper.gInstanceUrlH(component);
    },
	
    gUserProfile:function(component,event,helper){
      	helper.gUserProfileH(component);  
    },
    
    gsso:function(component,event,helper){
      	helper.gssoH(component);  
    },


    getCaOpcallout: function(component, event, helper) {
        let urlServ = component.get("v.urlServer");
        let sourceOpId = component.get("v.oportunityId");
        let sourceCAId = component.get("v.recordId");
        let requestId = '999999999';
        helper.getCaOpResponse(component, requestId, sourceCAId, sourceOpId, urlServ);
    },
    
    warnDc : function(component, event, helper) {
		let sourceCAID = component.get("v.recordId");

		helper.getWarningF(component,sourceCAID);
	},

    gurlServ: function(component, event, helper) {

        helper.getServiceUrl(component);
    },

    gurlServExt: function(component, event, helper) {

        helper.getServiceUrlExt(component);
    },

    gurlAppD: function(component, event, helper) {

        helper.getServiceUrlApp(component);
    },

    getEncriptationType: function(component, event, helper) {

        helper.getEncriptationT(component);
    },
    
    getEncriptationKey: function(component, event, helper) {

        helper.getKeyEnc(component);
    },

    getDoctypes: function(component, event, helper) {
        let sourceCAId = component.get("v.recordId");
        helper.getDoctypess(component, sourceCAId);

    },
    getOps: function(component, event, helper) {
        let sourceCAId = component.get("v.recordId");

        helper.getOportunidades(component, sourceCAId);
    },

    upload: function(component, event, helper) {
        let sourceOpId = document.getElementById("slectlists").value;
        let docTyp = component.get("v.tiposdeDoc");
        let sourceCAId = component.get("v.recordId");
        let urlserverExterna = component.get("v.urlServerExt");
        let urlAppDocs = component.get("v.urlAppDoctos");
        let backUrl = window.location.href;
        let EncriptationType = component.get("v.EncriptationType");
        let KeyEncriptation = component.get("v.KeyEncriptation");

        console.log('Oportunidad id: ' +  sourceOpId);
        console.log('Credit aproval id: ' + sourceCAId);
        console.log('urlserverExterna: ' + urlserverExterna);
        

        helper.subirDoc(component, docTyp, sourceOpId, sourceCAId, backUrl, urlserverExterna, urlAppDocs, KeyEncriptation, EncriptationType);
    },



    calloutCtrl: function(component, event, helper) {
        let urlServ = component.get("v.urlServer")


        let sourceCAId = component.get("v.recordId");
        let requestId = '999999999';
        helper.getResponse(component, requestId, sourceCAId, urlServ);
    },

    toggle: function(component, event, helper) {
        let toggleText = component.find("tabla");
        $A.util.removeClass(toggleText, "hide");
        let a = component.get('c.calloutCtrl');
        console.log(component.get("v.recordId"));
        $A.enqueueAction(a);

    },
    
    toggle2: function(component, event, helper) {
        let toggleText = component.find("tabla");
        $A.util.removeClass(toggleText, "hide");
        let a = component.get('c.getCaOpcallout');
        console.log(component.get("v.recordId"));
        $A.enqueueAction(a);

    },


    descDoc: function(component, event, helper) {

        let docId = event.getSource().get("v.alternativeText");
        let backUrl = window.location.href;
        let urlserverExterna = component.get("v.urlServerExt");
        let urlAppDocs = component.get("v.urlAppDoctos");
        let EncriptationType = component.get("v.EncriptationType");
        let KeyEncriptation = component.get("v.KeyEncriptation");
        
        helper.downDoc(component, docId, backUrl, urlserverExterna, urlAppDocs, EncriptationType, KeyEncriptation);
    },


    deleteDoc: function(component, event, helper) {
		let index = event.getSource().get("v.alternativeText");
        let docLst = component.get("v.ListaDocs")[index];
        let urlserver = component.get("v.urlServer");

        let requestIdDoc = docLst.requestId,
            oraId = docLst.id,
            docUrl = docLst.url,
            docType = docLst.type,
            docId = docLst.contentDocId,
            nameDoc = docLst.name;


        let borraras = confirm('Are you sure to delete this?')

        if (borraras == true) {

            helper.deletDoc(component, requestIdDoc, oraId, docUrl, docType, docId, nameDoc, urlserver);

            let errore = component.get("v.errores");
            console.log('valor' + errore);

            if (errore == "S") {
                let tos = component.get("c.showSuccessToast");
                $A.enqueueAction(tos);
            }
        }




        let a = component.get("c.toggle");
        $A.enqueueAction(a);


    },





})