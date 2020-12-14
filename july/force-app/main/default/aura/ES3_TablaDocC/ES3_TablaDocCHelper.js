({
   
    getServiceUrl: function(component) {
        let ur = component.get("c.getUrl");

        ur.setCallback(this, function(response) {
            let state = response.getReturnValue();
            component.set("v.urlServer", state);
        });

        $A.enqueueAction(ur);
    },
    
    gUserProfileH:function(component){
    	let user = component.get("c.getUserProfile");
        user.setCallback(this,function(response){
            let state = response.getReturnValue();
            component.set("v.userProfile", state);
            console.log("UserProfile: " + state);
        })
        $A.enqueueAction(user);
	},
	
    gssoH:function(component){
      	let sso = component.get("c.getSSO");
        sso.setCallback(this,function(response){
            let state = response.getReturnValue();
            component.set("v.sso", state);
            
        })
        
        $A.enqueueAction(sso);
    },
    
    getServiceUrlExt: function(component) {
        let ur = component.get("c.getUrlExterna");

        ur.setCallback(this, function(response) {
            let state = response.getReturnValue();
            component.set("v.urlServerExt", state);
        });

        $A.enqueueAction(ur);
    },

    getServiceUrlApp: function(component) {
        let ur = component.get("c.getUrlAppdocs");

        ur.setCallback(this, function(response) {
            let state = response.getReturnValue();
            component.set("v.urlAppDoctos", state);
        });

        $A.enqueueAction(ur);
    },

    getEncriptationT: function(component) {
        let ur = component.get("c.getEncriptationMode");

        ur.setCallback(this, function(response) {
            let state = response.getReturnValue();
            component.set("v.EncriptationType", state);
        });

        $A.enqueueAction(ur);
    },
    getWarningF : function(component, sourceCAID) {
		let a = component.get("c.CallbackGetWarningDocs");
		a.setParams({
			"sourceCAId":sourceCAID
		})

		a.setCallback(this, function(response){
			let state = response.getReturnValue();
			console.log('se hiso');
		})
		$A.enqueueAction(a);
    },
    
    gInstanceUrlH : function(component){
        let ur = component.get("c.getUrlInstance");
          ur.setCallback(this, function(response){
             let state  = response.getReturnValue();
              component.set("v.instanceUri", state + '/lightning/r/Opportunity_in_Credit_approval_CP__c/');
          });
          
          $A.enqueueAction(ur);
      },

    getKeyEnc: function(component) {
        let ur = component.get("c.getKeyEncriptation");

        ur.setCallback(this, function(response) {
            let state = response.getReturnValue();
            component.set("v.KeyEncriptation", state);
        });

        $A.enqueueAction(ur);
    },
    
    getDoctypess : function(component, sourceCAId){
        let doc = component.get("c.getLostiposDoc");
        doc.setParams({
            "cp":sourceCAId
        })
        doc.setCallback(this, function(response){
            let state = response.getReturnValue();
            component.set("v.tiposdeDoc", state);
            console.log(state);
        })
        
        $A.enqueueAction(doc);
    },
    
    subirDoc : function(component, docTyp, sourceOpId, sourceCAId, backUrl, urlserverExterna, urlAppDocs, KeyEncriptation, EncriptationType){
        let doc = component.get("c.newdocument");
        doc.setParams({
            "doctypes": docTyp.Doctypes__c,
            "sourceOpId":sourceOpId,
            "sourceCAId":sourceCAId,
            "backUrl":backUrl,
            "urlserverExterna":urlserverExterna,
            "urlAppDocs": urlAppDocs,
            "KeyEncriptation":KeyEncriptation,
            "EncriptationType":EncriptationType
        })
        
        doc.setCallback(this,function(response){
            let state = response.getReturnValue();
            window.open(state);
        })
        $A.enqueueAction(doc);
    },
    
    getOportunidades : function (component, sourceCAId) {
      let op = component.get("c.getListOpInCa");
      op.setParams({
          "cp": sourceCAId
      });
      
      op.setCallback(this, function (response) {
          
          let respuesta = response.getReturnValue();
          component.set("v.oportunitys", respuesta);
          
      })
      $A.enqueueAction(op);
    },

    getResponse: function(component, requestId, sourceCAId, urlServ) {
        var action = component.get("c.CallbackGetDocumentsInReq");
        action.setParams({
            "sServiceUrl": urlServ,
            "searchRequestId": requestId,
            "sourceCAId": sourceCAId
        });

        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('Estado: ' + state)
            if (component.isValid()) {
                // set the response(return Map<String,object>) to response attribute.      
                let respuesta = response.getReturnValue();
                
                if (respuesta.documentsList != null) {
                    component.set("v.response", respuesta);
                    let listadocum = respuesta.documentsList.document
                    component.set("v.ListaDocs", listadocum);
                    component.set('v.boltabla', true)
                    
                } else {
                    let nodata = component.get("c.showInfoToast");
                    //let retoggle = component.get("c.Retoggle");
                    let toggleText = component.find("tabla");
                    $A.util.addClass(toggleText, "hide");
                    $A.enqueueAction(nodata);
                    //let toggleText = component.find("tabla");
                    //$A.util.addClass(toggleText, "hide");
                   component.set('v.boltabla', false)
                }

            }
        });

        $A.enqueueAction(action);
    },

   

    getCaOpResponse : function (component, requestId, sourceCAId,sourceOpId , urlServ ) {
        
    },

    downDoc: function(component, docId, backUrl, urlserverExterna, urlAppDocs, EncriptationType, KeyEncriptation, cddate) {
        let tra = component.get("c.downloadDoctos");
        tra.setParams({
            "docId": docId.toString(),
            "backUrl": backUrl.toString(),
            "urlserverExterna":urlserverExterna,
            "urlAppDocs":urlAppDocs,
            "EncriptationType":EncriptationType,
            "KeyEncriptation":KeyEncriptation
        });
        tra.setCallback(this, function(response) {
            let respuesta = response.getReturnValue();
            
            console.log('respuesta: ' + respuesta);
            
            window.open(respuesta);
        });
        $A.enqueueAction(tra);

    },

   



    deletDoc: function(component, requestIdDoc, oraId, docUrl, docType, docId, nameDoc, urlserver) {
        let borra = component.get("c.deleteDocto");
        let erross; 

        borra.setParams({
            "requestId": requestIdDoc,
            "oraId": oraId,
            "url": docUrl,
            "docType": docType,
            "contentDocId": docId,
            "name": nameDoc,
            "urlserver":urlserver
        });
        borra.setCallback(this, function(response) {
            let respuesta = response.getReturnValue();
             erross = respuesta.includes("ERROR");
        });

        if (erross == true) {
            component.set("v.errores", "E");
        } else {
            component.set("v.errores", "S");

        }

        

        $A.enqueueAction(borra);
    },
     
     
})