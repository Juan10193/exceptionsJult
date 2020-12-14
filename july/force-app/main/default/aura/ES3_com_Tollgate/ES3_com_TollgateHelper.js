({
	hsendToAML : function (component, sourceCAId, nameButton) {
		//asignamos el metodo apex validateConditions a una variable
		let action = component.get("c.validateConditions");
		
		//Seteamos los parametors del metodo
		action.setParams({
			"sourceCAId": sourceCAId,
			"nameButton": nameButton
		})

		//Ejecutamos el metodo pormedio de un callback
		action.setCallback(this, function(response){
			//asignamos la respuesta que trae la ejecución del metodo a una variable
			let state = response.getReturnValue();
			console.log('error: ' + state);
			
			//Pedimos confirmación para enviar a AML
			let alerta = confirm('Are you sure to send to AML?');
			if(alerta == true){
				//Assignamos el metodo tollgateDocs a una variable
				let tollgate = component.get("c.tollgateDocsAml");
				
				//Seteamos los parametros del metodo
				tollgate.setParams({
					"sourceCAId": sourceCAId
					
				})
				
				//Ejecutamos el metodo tollgateDocs por medio de un callback
				tollgate.setCallback(this, function(response){
					//Asignamos la respuesta de la ejecución a una variable
					let tollgatestate =response.getReturnValue();
					console.log('stateDoctos--->:' + JSON.stringify(tollgatestate));
					//Asignamos todas las llaves del objecto en un arreglo
					let keys= [];
					for(var k in tollgatestate)keys.push(k +'\n');
					//imprimimos en consola los documentos faltantes
					console.log('keysss: ' + keys)

					//Si el arreglo contiene algun elemento se muestra la alerta
					if(keys.length!=0){
						var keysA = keys.toString();
						var alertakeys = keysA.replace(/,/g, '');
						var a = confirm('¿Esta seguro de enviar con los siguientes documentos faltantes?:\n' + alertakeys);
						
						//Si el usuario desea continuar continuamos el flujo para enviar a AML
						if(a==true){
							if(state.length>=1){
								let alerta = state.toString();
								let error = alerta.replace(',','');
							
								var toastEvent = $A.get("e.force:showToast");
								toastEvent.setParams({
									title:'Error Message',
									message:error,
									messageTemplate:'Mode is pester ,duration is 5sec and Message is overrriden',
									duration:' 5000',
									key:'info_alt',
									type:'warning',
									mode:'pester'
								});
								toastEvent.fire();
							}else{
								let executeActions = component.get("c.executeAccions");
								executeActions.setParams({
									"sourceCAId":sourceCAId,
									"nameButton":nameButton
								})

								executeActions.setCallback(this, function(response){
									let acciones = response.getReturnValue();
									console.log(acciones);
									if(acciones.length>=1){
										let alerta = acciones.toString();
										let error = alerta.replace(',','');

										var toastEvent = $A.get("e.force:showToast");
										toastEvent.setParams({
											title:'Error Message',
											message:error,
											messageTemplate:'Mode is pester ,duration is 5sec and Message is overrriden',
											duration:' 5000',
											key:'info_alt',
											type:'warning',
											mode:'pester'
										});
										toastEvent.fire();
									}else{
										$A.get("e.force:refreshView").fire();
									}

								});
								$A.enqueueAction(executeActions);
							}
                            
                            
						}	

					}else{
								let executeActions = component.get("c.executeAccions");
								executeActions.setParams({
									"sourceCAId":sourceCAId,
									"nameButton":nameButton
								})

								executeActions.setCallback(this, function(response){
									let acciones = response.getReturnValue();
									console.log(acciones);
									if(acciones.length>=1){
										let alerta = acciones.toString();
										let error = alerta.replace(',','');

										var toastEvent = $A.get("e.force:showToast");
										toastEvent.setParams({
											title:'Error Message',
											message:error,
											messageTemplate:'Mode is pester ,duration is 5sec and Message is overrriden',
											duration:' 5000',
											key:'info_alt',
											type:'warning',
											mode:'pester'
										});
										toastEvent.fire();
									}else{
										$A.get("e.force:refreshView").fire();
									}

								});
								$A.enqueueAction(executeActions);
							}
				   
				});
				$A.enqueueAction(tollgate);
			}

		});

		$A.enqueueAction(action);
	},

	hWithdrawnAML : function (component, sourceCAId, nameButton) {
		//asignamos el metodo apex validateConditions a una variable
		let action = component.get("c.validateConditions");
		
		//Seteamos los parametors del metodo
		action.setParams({
			"sourceCAId": sourceCAId,
			"nameButton": nameButton
		})

		//Ejecutamos el metodo pormedio de un callback
		action.setCallback(this, function(response){
			//asignamos la respuesta que trae la ejecución del metodo a una variable
			let state = response.getReturnValue();
			console.log('error: ' + state);
			
			//Pedimos confirmación para enviar a Risk
			var alerta = confirm('Are you sure to change to Withdrawn AML?');
			if(alerta == true){
				if(state.length>=1){
					let alerta = state.toString();
					let error = alerta.replace(/,/g, '');

					var toastEvent = $A.get("e.force:showToast");
					toastEvent.setParams({
						title:'Error Message',
						message:error,
						messageTemplate:'Mode is pester ,duration is 5sec and Message is overrriden',
						duration:' 5000',
						key:'info_alt',
						type:'warning',
						mode:'pester'
					})
					toastEvent.fire();
				}else{
					let executeActions = component.get("c.executeAccions");
					executeActions.setParams({
						"sourceCAId":sourceCAId,
						"nameButton":nameButton
					})

					executeActions.setCallback(this, function(response){
					let acciones = response.getReturnValue();
					console.log(acciones);
					if(acciones.length>=1){
						let alerta = acciones.toString();
						let error = alerta.replace(',','');

						var toastEvent = $A.get("e.force:showToast");
						toastEvent.setParams({
							title:'Error Message',
							message:error,
							messageTemplate:'Mode is pester ,duration is 5sec and Message is overrriden',
							duration:' 5000',
							key:'info_alt',
							type:'warning',
							mode:'pester'
						});
						toastEvent.fire();
					}else{
						$A.get("e.force:refreshView").fire();
					}

					});
					$A.enqueueAction(executeActions)		
				}
			}
		});	
		$A.enqueueAction(action);
	},


	hsendToRISK : function (component, sourceCAId, nameButton) {
		//asignamos el metodo apex validateConditions a una variable
		let action = component.get("c.validateConditions");
		
		//Seteamos los parametors del metodo
		action.setParams({
			"sourceCAId": sourceCAId,
			"nameButton": nameButton
		})

		//Ejecutamos el metodo pormedio de un callback
		action.setCallback(this, function(response){
			//asignamos la respuesta que trae la ejecución del metodo a una variable
			let state = response.getReturnValue();
			console.log('error: ' + state);
			
			//Pedimos confirmación para enviar a Risk
			var alerta = confirm('Are you sure to send to Risk?');
			if(alerta == true){
				//Assignamos el metodo tollgateDocs a una variable
				let tollgate = component.get("c.tollgateDocs");
				
				//Seteamos los parametros del metodo
				tollgate.setParams({
					"sourceCAId": sourceCAId
					
				})
				
				//Ejecutamos el metodo tollgateDocs por medio de un callback
				tollgate.setCallback(this, function(response){
					//Asignamos la respuesta de la ejecución a una variable
					let tollgatestate =response.getReturnValue();
					console.log('stateDoctos--->:' + tollgatestate);
					//Asignamos todas las llaves del objecto en un arreglo
					let keys= [];
					for(var k in tollgatestate)keys.push(k+'\n');
					//imprimimos en consola los documentos faltantes
					console.log('keysss: ' + keys)

					//Si el arreglo contiene algun elemento se muestra la alerta
					if(keys.length!=0){
						
						var keysA = keys.toString();
						var alertakeys = keysA.replace(/,/g, '');
						var a = confirm('¿Esta seguro de enviar con los siguientes documentos faltantes?:\n' + alertakeys);
						
						//Si el usuario desea continuar continuamos el flujo para enviar a RISK
						if(a==true){
							if(state.length>=1){
								let alerta = state.toString();
								let error = alerta.replace(',','');
							
								var toastEvent = $A.get("e.force:showToast");
								toastEvent.setParams({
									title:'Error Message',
									message:error,
									messageTemplate:'Mode is pester ,duration is 5sec and Message is overrriden',
									duration:' 5000',
									key:'info_alt',
									type:'warning',
									mode:'pester'
								});
								toastEvent.fire();
							}else{
								let executeActions = component.get("c.executeAccions");
								executeActions.setParams({
									"sourceCAId":sourceCAId,
									"nameButton":nameButton
								})

								executeActions.setCallback(this, function(response){
									let acciones = response.getReturnValue();
									console.log(acciones);
									if(acciones.length>=1){
										let alerta = acciones.toString();
										let error = alerta.replace(',','');

										var toastEvent = $A.get("e.force:showToast");
										toastEvent.setParams({
											title:'Error Message',
											message:error,
											messageTemplate:'Mode is pester ,duration is 5sec and Message is overrriden',
											duration:' 5000',
											key:'info_alt',
											type:'warning',
											mode:'pester'
										});
										toastEvent.fire();
									}else{
										$A.get("e.force:refreshView").fire();
									}

								});
								$A.enqueueAction(executeActions);
							}
						}	

					}
				   
				});
				$A.enqueueAction(tollgate);
			}

		});

		$A.enqueueAction(action);
	},

	hWithdrawnRISK : function (component, sourceCAId, nameButton) {
		//asignamos el metodo apex validateConditions a una variable
		let action = component.get("c.validateConditions");
		
		//Seteamos los parametors del metodo
		action.setParams({
			"sourceCAId": sourceCAId,
			"nameButton": nameButton
		})

		//Ejecutamos el metodo pormedio de un callback
		action.setCallback(this, function(response){
			//asignamos la respuesta que trae la ejecución del metodo a una variable
			let state = response.getReturnValue();
			console.log('error: ' + state);
			
			//Pedimos confirmación para enviar a Risk
			var alerta = confirm('Are you sure to change to Withdrawn Risk?');
			if(alerta == true){
				if(state.length>=1){
					let alerta = state.toString();
					let error = alerta.replace(/,/g, '');

					var toastEvent = $A.get("e.force:showToast");
					toastEvent.setParams({
						title:'Error Message',
						message:error,
						messageTemplate:'Mode is pester ,duration is 5sec and Message is overrriden',
						duration:' 5000',
						key:'info_alt',
						type:'warning',
						mode:'pester'
					})
					toastEvent.fire();
				}else{
					let executeActions = component.get("c.executeAccions");
					executeActions.setParams({
						"sourceCAId":sourceCAId,
						"nameButton":nameButton
					})

					executeActions.setCallback(this, function(response){
					let acciones = response.getReturnValue();
					console.log(acciones);
					if(acciones.length>=1){
						let alerta = acciones.toString();
						let error = alerta.replace(',','');

						var toastEvent = $A.get("e.force:showToast");
						toastEvent.setParams({
							title:'Error Message',
							message:error,
							messageTemplate:'Mode is pester ,duration is 5sec and Message is overrriden',
							duration:' 5000',
							key:'info_alt',
							type:'warning',
							mode:'pester'
						});
						toastEvent.fire();
					}else{
						$A.get("e.force:refreshView").fire();
					}

					});
					$A.enqueueAction(executeActions)		
				}
			}
		});	
		$A.enqueueAction(action);
	},

	honHoldRisk : function (component, sourceCAId, nameButton) {
		//asignamos el metodo apex validateConditions a una variable
		let action = component.get("c.validateConditions");
		
		//Seteamos los parametors del metodo
		action.setParams({
			"sourceCAId": sourceCAId,
			"nameButton": nameButton
		})

		//Ejecutamos el metodo pormedio de un callback
		action.setCallback(this, function(response){
			//asignamos la respuesta que trae la ejecución del metodo a una variable
			let state = response.getReturnValue();
			console.log('error: ' + state);
			
			//Pedimos confirmación para enviar a Risk
			var alerta = confirm('Are you sure to change to On Hold Risk?');
			if(alerta == true){
				if(state.length>=1){
					let alerta = state.toString();
					let error = alerta.replace(',','');

					var toastEvent = $A.get("e.force:showToast");
					toastEvent.setParams({
						title:'Error Message',
						message:error,
						messageTemplate:'Mode is pester ,duration is 5sec and Message is overrriden',
						duration:' 5000',
						key:'info_alt',
						type:'warning',
						mode:'pester'
					})
					toastEvent.fire();
				}else{
					let executeActions = component.get("c.executeAccions");
					executeActions.setParams({
						"sourceCAId":sourceCAId,
						"nameButton":nameButton
					})

					executeActions.setCallback(this, function(response){
					let acciones = response.getReturnValue();
					console.log(acciones);
					if(acciones.length>=1){
						let alerta = acciones.toString();
						let error = alerta.replace(',','');

						var toastEvent = $A.get("e.force:showToast");
						toastEvent.setParams({
							title:'Error Message',
							message:error,
							messageTemplate:'Mode is pester ,duration is 5sec and Message is overrriden',
							duration:' 5000',
							key:'info_alt',
							type:'warning',
							mode:'pester'
						});
						toastEvent.fire();
					}else{
						$A.get("e.force:refreshView").fire();
					}

					});
					$A.enqueueAction(executeActions)		
				}
			}
		});	
		$A.enqueueAction(action);
	},

	hdeclineRisk : function (component, sourceCAId, nameButton) {
		//asignamos el metodo apex validateConditions a una variable
		let action = component.get("c.validateConditions");
		
		//Seteamos los parametors del metodo
		action.setParams({
			"sourceCAId": sourceCAId,
			"nameButton": nameButton
		})

		//Ejecutamos el metodo pormedio de un callback
		action.setCallback(this, function(response){
			//asignamos la respuesta que trae la ejecución del metodo a una variable
			let state = response.getReturnValue();
			console.log('error: ' + state);
			
			//Pedimos confirmación para enviar a Risk
			var alerta = confirm('Are you sure to change to Decline Risk?');
			if(alerta == true){
				if(state.length>=1){
					let alerta = state.toString();
					let error = alerta.replace(/,/g, '');

					var toastEvent = $A.get("e.force:showToast");
					toastEvent.setParams({
						title:'Error Message',
						message:error,
						messageTemplate:'Mode is pester ,duration is 5sec and Message is overrriden',
						duration:' 5000',
						key:'info_alt',
						type:'warning',
						mode:'pester'
					})
					toastEvent.fire();
				}else{
					let executeActions = component.get("c.executeAccions");
					executeActions.setParams({
						"sourceCAId":sourceCAId,
						"nameButton":nameButton
					})

					executeActions.setCallback(this, function(response){
					let acciones = response.getReturnValue();
					console.log(acciones);
					if(acciones.length>=1){
						let alerta = acciones.toString();
						let error = alerta.replace(',','');

						var toastEvent = $A.get("e.force:showToast");
						toastEvent.setParams({
							title:'Error Message',
							message:error,
							messageTemplate:'Mode is pester ,duration is 5sec and Message is overrriden',
							duration:' 5000',
							key:'info_alt',
							type:'warning',
							mode:'pester'
						});
						toastEvent.fire();
					}else{
						$A.get("e.force:refreshView").fire();
					}

					});
					$A.enqueueAction(executeActions)		
				}
			}
		});	
		$A.enqueueAction(action);
	},

	hreworkRisk : function (component, sourceCAId, nameButton) {
		//asignamos el metodo apex validateConditions a una variable
		let action = component.get("c.validateConditions");
		
		//Seteamos los parametors del metodo
		action.setParams({
			"sourceCAId": sourceCAId,
			"nameButton": nameButton
		})

		//Ejecutamos el metodo pormedio de un callback
		action.setCallback(this, function(response){
			//asignamos la respuesta que trae la ejecución del metodo a una variable
			let state = response.getReturnValue();
			console.log('error: ' + state);
			
			//Pedimos confirmación para enviar a Risk
			var alerta = confirm('Are you sure to change to Rework Risk?');
			if(alerta == true){
				if(state.length>=1){
					let alerta = state.toString();
					let error = alerta.replace(',','');

					var toastEvent = $A.get("e.force:showToast");
					toastEvent.setParams({
						title:'Error Message',
						message:error,
						messageTemplate:'Mode is pester ,duration is 5sec and Message is overrriden',
						duration:' 5000',
						key:'info_alt',
						type:'warning',
						mode:'pester'
					})
					toastEvent.fire();
				}else{
					let executeActions = component.get("c.executeAccions");
					executeActions.setParams({
						"sourceCAId":sourceCAId,
						"nameButton":nameButton
					})

					executeActions.setCallback(this, function(response){
					let acciones = response.getReturnValue();
					console.log(acciones);
					if(acciones.length>=1){
						let alerta = acciones.toString();
						let error = alerta.replace(',','');

						var toastEvent = $A.get("e.force:showToast");
						toastEvent.setParams({
							title:'Error Message',
							message:error,
							messageTemplate:'Mode is pester ,duration is 5sec and Message is overrriden',
							duration:' 5000',
							key:'info_alt',
							type:'warning',
							mode:'pester'
						});
						toastEvent.fire();
					}else{
						$A.get("e.force:refreshView").fire();
					}

					});
					$A.enqueueAction(executeActions)		
				}
			}
		});	
		$A.enqueueAction(action);
	},
	
	hreworkForEntRisk : function (component, sourceCAId, nameButton) {
		//asignamos el metodo apex validateConditions a una variable
		let action = component.get("c.validateConditions");
		
		//Seteamos los parametors del metodo
		action.setParams({
			"sourceCAId": sourceCAId,
			"nameButton": nameButton
		})

		//Ejecutamos el metodo pormedio de un callback
		action.setCallback(this, function(response){
			//asignamos la respuesta que trae la ejecución del metodo a una variable
			let state = response.getReturnValue();
			console.log('error: ' + state);
			
			//Pedimos confirmación para enviar a Risk
			var alerta = confirm('Are you sure to change to Rework For Entities Risk?');
			if(alerta == true){
				if(state.length>=1){
					let alerta = state.toString();
					let error = alerta.replace(',','');

					var toastEvent = $A.get("e.force:showToast");
					toastEvent.setParams({
						title:'Error Message',
						message:error,
						messageTemplate:'Mode is pester ,duration is 5sec and Message is overrriden',
						duration:' 5000',
						key:'info_alt',
						type:'warning',
						mode:'pester'
					})
					toastEvent.fire();
				}else{
					let executeActions = component.get("c.executeAccions");
					executeActions.setParams({
						"sourceCAId":sourceCAId,
						"nameButton":nameButton
					})

					executeActions.setCallback(this, function(response){
					let acciones = response.getReturnValue();
					console.log(acciones);
					if(acciones.length>=1){
						let alerta = acciones.toString();
						let error = alerta.replace(',','');

						var toastEvent = $A.get("e.force:showToast");
						toastEvent.setParams({
							title:'Error Message',
							message:error,
							messageTemplate:'Mode is pester ,duration is 5sec and Message is overrriden',
							duration:' 5000',
							key:'info_alt',
							type:'warning',
							mode:'pester'
						});
						toastEvent.fire();
					}else{
						$A.get("e.force:refreshView").fire();
					}

					});
					$A.enqueueAction(executeActions)		
				}
			}
		});	
		$A.enqueueAction(action);
	},

	
	hbacktoInProcessRisk : function (component, sourceCAId, nameButton) {
		//asignamos el metodo apex validateConditions a una variable
		let action = component.get("c.validateConditions");
		
		//Seteamos los parametors del metodo
		action.setParams({
			"sourceCAId": sourceCAId,
			"nameButton": nameButton
		})

		//Ejecutamos el metodo pormedio de un callback
		action.setCallback(this, function(response){
			//asignamos la respuesta que trae la ejecución del metodo a una variable
			let state = response.getReturnValue();
			console.log('error: ' + state);
			
			//Pedimos confirmación para enviar a Risk
			var alerta = confirm('Are you sure change to Back to in Process Risk?');
			if(alerta == true){
				if(state.length>=1){
					let alerta = state.toString();
					let error = alerta.replace(',','');

					var toastEvent = $A.get("e.force:showToast");
					toastEvent.setParams({
						title:'Error Message',
						message:error,
						messageTemplate:'Mode is pester ,duration is 5sec and Message is overrriden',
						duration:' 5000',
						key:'info_alt',
						type:'warning',
						mode:'pester'
					})
					toastEvent.fire();
				}else{
					let executeActions = component.get("c.executeAccions");
					executeActions.setParams({
						"sourceCAId":sourceCAId,
						"nameButton":nameButton
					})

					executeActions.setCallback(this, function(response){
					let acciones = response.getReturnValue();
					console.log(acciones);
					if(acciones.length>=1){
						let alerta = acciones.toString();
						let error = alerta.replace(',','');

						var toastEvent = $A.get("e.force:showToast");
						toastEvent.setParams({
							title:'Error Message',
							message:error,
							messageTemplate:'Mode is pester ,duration is 5sec and Message is overrriden',
							duration:' 5000',
							key:'info_alt',
							type:'warning',
							mode:'pester'
						});
						toastEvent.fire();
					}else{
						$A.get("e.force:refreshView").fire();
					}

					});
					$A.enqueueAction(executeActions)		
				}
			}
		});	
		$A.enqueueAction(action);
	},

	hacceptToReviewRisk : function (component, sourceCAId, nameButton) {
		//asignamos el metodo apex validateConditions a una variable
		let action = component.get("c.validateConditions");
		
		//Seteamos los parametors del metodo
		action.setParams({
			"sourceCAId": sourceCAId,
			"nameButton": nameButton
		})

		//Ejecutamos el metodo pormedio de un callback
		action.setCallback(this, function(response){
			//asignamos la respuesta que trae la ejecución del metodo a una variable
			let state = response.getReturnValue();
			console.log('error: ' + state);
			
			//Pedimos confirmación para enviar a Risk
			var alerta = confirm('Are you sure to Accept to review Risk?');
			if(alerta == true){
				if(state.length>=1){
					let alerta = state.toString();
					let error = alerta.replace(',','');

					var toastEvent = $A.get("e.force:showToast");
					toastEvent.setParams({
						title:'Error Message',
						message:error,
						messageTemplate:'Mode is pester ,duration is 5sec and Message is overrriden',
						duration:' 5000',
						key:'info_alt',
						type:'warning',
						mode:'pester'
					})
					toastEvent.fire();
				}else{
					let executeActions = component.get("c.executeAccions");
					executeActions.setParams({
						"sourceCAId":sourceCAId,
						"nameButton":nameButton
					})

					executeActions.setCallback(this, function(response){
					let acciones = response.getReturnValue();
					console.log(acciones);
					if(acciones.length>=1){
						let alerta = acciones.toString();
						let error = alerta.replace(',','');

						var toastEvent = $A.get("e.force:showToast");
						toastEvent.setParams({
							title:'Error Message',
							message:error,
							messageTemplate:'Mode is pester ,duration is 5sec and Message is overrriden',
							duration:' 5000',
							key:'info_alt',
							type:'warning',
							mode:'pester'
						});
						toastEvent.fire();
					}else{
						$A.get("e.force:refreshView").fire();
					}

					});
					$A.enqueueAction(executeActions)		
				}
			}
		});	
		$A.enqueueAction(action);
	},

	hreworkAML : function (component, sourceCAId, nameButton) {
		//asignamos el metodo apex validateConditions a una variable
		let action = component.get("c.validateConditions");
		
		//Seteamos los parametors del metodo
		action.setParams({
			"sourceCAId": sourceCAId,
			"nameButton": nameButton
		})

		//Ejecutamos el metodo pormedio de un callback
		action.setCallback(this, function(response){
			//asignamos la respuesta que trae la ejecución del metodo a una variable
			let state = response.getReturnValue();
			console.log('error: ' + state);
			
			//Pedimos confirmación para enviar a Risk
			var alerta = confirm('Are you sure to change to Rework AML?');
			if(alerta == true){
				if(state.length>=1){
					let alerta = state.toString();
					let error = alerta.replace(',','');

					var toastEvent = $A.get("e.force:showToast");
					toastEvent.setParams({
						title:'Error Message',
						message:error,
						messageTemplate:'Mode is pester ,duration is 5sec and Message is overrriden',
						duration:' 5000',
						key:'info_alt',
						type:'warning',
						mode:'pester'
					})
					toastEvent.fire();
				}else{
					let executeActions = component.get("c.executeAccions");
					executeActions.setParams({
						"sourceCAId":sourceCAId,
						"nameButton":nameButton
					})

					executeActions.setCallback(this, function(response){
					let acciones = response.getReturnValue();
					console.log(acciones);
					if(acciones.length>=1){
						let alerta = acciones.toString();
						let error = alerta.replace(',','');

						var toastEvent = $A.get("e.force:showToast");
						toastEvent.setParams({
							title:'Error Message',
							message:error,
							messageTemplate:'Mode is pester ,duration is 5sec and Message is overrriden',
							duration:' 5000',
							key:'info_alt',
							type:'warning',
							mode:'pester'
						});
						toastEvent.fire();
					}else{
						$A.get("e.force:refreshView").fire();
					}

					});
					$A.enqueueAction(executeActions)		
				}
			}
		});	
		$A.enqueueAction(action);
	},
	
	hreworkForEntAML : function (component, sourceCAId, nameButton) {
		//asignamos el metodo apex validateConditions a una variable
		let action = component.get("c.validateConditions");
		
		//Seteamos los parametors del metodo
		action.setParams({
			"sourceCAId": sourceCAId,
			"nameButton": nameButton
		})

		//Ejecutamos el metodo pormedio de un callback
		action.setCallback(this, function(response){
			//asignamos la respuesta que trae la ejecución del metodo a una variable
			let state = response.getReturnValue();
			console.log('error: ' + state);
			
			//Pedimos confirmación para enviar a Risk
			var alerta = confirm('Are you sure to change to Rework For Entities?');
			if(alerta == true){
				if(state.length>=1){
					let alerta = state.toString();
					let error = alerta.replace(',','');

					var toastEvent = $A.get("e.force:showToast");
					toastEvent.setParams({
						title:'Error Message',
						message:error,
						messageTemplate:'Mode is pester ,duration is 5sec and Message is overrriden',
						duration:' 5000',
						key:'info_alt',
						type:'warning',
						mode:'pester'
					})
					toastEvent.fire();
				}else{
					let executeActions = component.get("c.executeAccions");
					executeActions.setParams({
						"sourceCAId":sourceCAId,
						"nameButton":nameButton
					})

					executeActions.setCallback(this, function(response){
					let acciones = response.getReturnValue();
					console.log(acciones);
					if(acciones.length>=1){
						let alerta = acciones.toString();
						let error = alerta.replace(',','');

						var toastEvent = $A.get("e.force:showToast");
						toastEvent.setParams({
							title:'Error Message',
							message:error,
							messageTemplate:'Mode is pester ,duration is 5sec and Message is overrriden',
							duration:' 5000',
							key:'info_alt',
							type:'warning',
							mode:'pester'
						});
						toastEvent.fire();
					}else{
						$A.get("e.force:refreshView").fire();
					}

					});
					$A.enqueueAction(executeActions)		
				}
			}
		});	
		$A.enqueueAction(action);
	},
	
	honHoldAML : function (component, sourceCAId, nameButton) {
		//asignamos el metodo apex validateConditions a una variable
		let action = component.get("c.validateConditions");
		
		//Seteamos los parametors del metodo
		action.setParams({
			"sourceCAId": sourceCAId,
			"nameButton": nameButton
		})

		//Ejecutamos el metodo pormedio de un callback
		action.setCallback(this, function(response){
			//asignamos la respuesta que trae la ejecución del metodo a una variable
			let state = response.getReturnValue();
			console.log('error: ' + state);
			
			//Pedimos confirmación para enviar a Risk
			var alerta = confirm('Are you sure to change to On Hold AML?');
			if(alerta == true){
				if(state.length>=1){
					let alerta = state.toString();
					let error = alerta.replace(',','');

					var toastEvent = $A.get("e.force:showToast");
					toastEvent.setParams({
						title:'Error Message',
						message:error,
						messageTemplate:'Mode is pester ,duration is 5sec and Message is overrriden',
						duration:' 5000',
						key:'info_alt',
						type:'warning',
						mode:'pester'
					})
					toastEvent.fire();
				}else{
					let executeActions = component.get("c.executeAccions");
					executeActions.setParams({
						"sourceCAId":sourceCAId,
						"nameButton":nameButton
					})

					executeActions.setCallback(this, function(response){
					let acciones = response.getReturnValue();
					console.log(acciones);
					if(acciones.length>=1){
						let alerta = acciones.toString();
						let error = alerta.replace(',','');

						var toastEvent = $A.get("e.force:showToast");
						toastEvent.setParams({
							title:'Error Message',
							message:error,
							messageTemplate:'Mode is pester ,duration is 5sec and Message is overrriden',
							duration:' 5000',
							key:'info_alt',
							type:'warning',
							mode:'pester'
						});
						toastEvent.fire();
					}else{
						$A.get("e.force:refreshView").fire();
					}

					});
					$A.enqueueAction(executeActions)		
				}
			}
		});	
		$A.enqueueAction(action);
	},

	hdeclineAML : function (component, sourceCAId, nameButton) {
		//asignamos el metodo apex validateConditions a una variable
		let action = component.get("c.validateConditions");
		
		//Seteamos los parametors del metodo
		action.setParams({
			"sourceCAId": sourceCAId,
			"nameButton": nameButton
		})

		//Ejecutamos el metodo pormedio de un callback
		action.setCallback(this, function(response){
			//asignamos la respuesta que trae la ejecución del metodo a una variable
			let state = response.getReturnValue();
			console.log('error: ' + state);
			
			//Pedimos confirmación para enviar a Risk
			var alerta = confirm('Are you sure to change to Declines AML?');
			if(alerta == true){
				if(state.length>=1){
					let alerta = state.toString();
					let error = alerta.replace(',','');

					var toastEvent = $A.get("e.force:showToast");
					toastEvent.setParams({
						title:'Error Message',
						message:error,
						messageTemplate:'Mode is pester ,duration is 5sec and Message is overrriden',
						duration:' 5000',
						key:'info_alt',
						type:'warning',
						mode:'pester'
					})
					toastEvent.fire();
				}else{
					let executeActions = component.get("c.executeAccions");
					executeActions.setParams({
						"sourceCAId":sourceCAId,
						"nameButton":nameButton
					})

					executeActions.setCallback(this, function(response){
					let acciones = response.getReturnValue();
					console.log(acciones);
					if(acciones.length>=1){
						let alerta = acciones.toString();
						let error = alerta.replace(',','');

						var toastEvent = $A.get("e.force:showToast");
						toastEvent.setParams({
							title:'Error Message',
							message:error,
							messageTemplate:'Mode is pester ,duration is 5sec and Message is overrriden',
							duration:' 5000',
							key:'info_alt',
							type:'warning',
							mode:'pester'
						});
						toastEvent.fire();
					}else{
						$A.get("e.force:refreshView").fire();
					}

					});
					$A.enqueueAction(executeActions)		
				}
			}
		});	
		$A.enqueueAction(action);
	},

	hbacktoInProcessAML : function (component, sourceCAId, nameButton) {
		//asignamos el metodo apex validateConditions a una variable
		let action = component.get("c.validateConditions");
		
		//Seteamos los parametors del metodo
		action.setParams({
			"sourceCAId": sourceCAId,
			"nameButton": nameButton
		})

		//Ejecutamos el metodo pormedio de un callback
		action.setCallback(this, function(response){
			//asignamos la respuesta que trae la ejecución del metodo a una variable
			let state = response.getReturnValue();
			console.log('error: ' + state);
			
			//Pedimos confirmación para enviar a Risk
			var alerta = confirm('Are you sure change to Back to in Process AML?');
			if(alerta == true){
				if(state.length>=1){
					let alerta = state.toString();
					let error = alerta.replace(',','');

					var toastEvent = $A.get("e.force:showToast");
					toastEvent.setParams({
						title:'Error Message',
						message:error,
						messageTemplate:'Mode is pester ,duration is 5sec and Message is overrriden',
						duration:' 5000',
						key:'info_alt',
						type:'warning',
						mode:'pester'
					})
					toastEvent.fire();
				}else{
					let executeActions = component.get("c.executeAccions");
					executeActions.setParams({
						"sourceCAId":sourceCAId,
						"nameButton":nameButton
					})

					executeActions.setCallback(this, function(response){
					let acciones = response.getReturnValue();
					console.log(acciones);
					if(acciones.length>=1){
						let alerta = acciones.toString();
						let error = alerta.replace(',','');

						var toastEvent = $A.get("e.force:showToast");
						toastEvent.setParams({
							title:'Error Message',
							message:error,
							messageTemplate:'Mode is pester ,duration is 5sec and Message is overrriden',
							duration:' 5000',
							key:'info_alt',
							type:'warning',
							mode:'pester'
						});
						toastEvent.fire();
					}else{
						$A.get("e.force:refreshView").fire();
					}

					});
					$A.enqueueAction(executeActions)		
				}
			}
		});	
		$A.enqueueAction(action);
	},

	happroveAMLWithConditions : function (component, sourceCAId, nameButton) {
		//asignamos el metodo apex validateConditions a una variable
		let action = component.get("c.validateConditions");
		
		//Seteamos los parametors del metodo
		action.setParams({
			"sourceCAId": sourceCAId,
			"nameButton": nameButton
		})

		//Ejecutamos el metodo pormedio de un callback
		action.setCallback(this, function(response){
			//asignamos la respuesta que trae la ejecución del metodo a una variable
			let state = response.getReturnValue();
			console.log('error: ' + state);
			
			//Pedimos confirmación para enviar a Risk
			var alerta = confirm('Are you sure to Approve AML With conditions?');
			if(alerta == true){
				if(state.length>=1){
					let alerta = state.toString();
					let error = alerta.replace(',','');

					var toastEvent = $A.get("e.force:showToast");
					toastEvent.setParams({
						title:'Error Message',
						message:error,
						messageTemplate:'Mode is pester ,duration is 5sec and Message is overrriden',
						duration:' 5000',
						key:'info_alt',
						type:'warning',
						mode:'pester'
					})
					toastEvent.fire();
				}else{
					let executeActions = component.get("c.executeAccions");
					executeActions.setParams({
						"sourceCAId":sourceCAId,
						"nameButton":nameButton
					})

					executeActions.setCallback(this, function(response){
					let acciones = response.getReturnValue();
					console.log(acciones);
					if(acciones.length>=1){
						let alerta = acciones.toString();
						let error = alerta.replace(',','');

						var toastEvent = $A.get("e.force:showToast");
						toastEvent.setParams({
							title:'Error Message',
							message:error,
							messageTemplate:'Mode is pester ,duration is 5sec and Message is overrriden',
							duration:' 5000',
							key:'info_alt',
							type:'warning',
							mode:'pester'
						});
						toastEvent.fire();
					}else{
						$A.get("e.force:refreshView").fire();
					}

					});
					$A.enqueueAction(executeActions)		
				}
			}
		});	
		$A.enqueueAction(action);
	},

	happroveAML : function (component, sourceCAId, nameButton) {
		//asignamos el metodo apex validateConditions a una variable
		let action = component.get("c.validateConditions");
		
		//Seteamos los parametors del metodo
		action.setParams({
			"sourceCAId": sourceCAId,
			"nameButton": nameButton
		})

		//Ejecutamos el metodo pormedio de un callback
		action.setCallback(this, function(response){
			//asignamos la respuesta que trae la ejecución del metodo a una variable
			let state = response.getReturnValue();
			console.log('error: ' + state);
			
			//Pedimos confirmación para enviar a Risk
			var alerta = confirm('Are you sure to Approve AML?');
			if(alerta == true){
				if(state.length>=1){
					let alerta = state.toString();
					let error = alerta.replace(',','');

					var toastEvent = $A.get("e.force:showToast");
					toastEvent.setParams({
						title:'Error Message',
						message:error,
						messageTemplate:'Mode is pester ,duration is 5sec and Message is overrriden',
						duration:' 5000',
						key:'info_alt',
						type:'warning',
						mode:'pester'
					})
					toastEvent.fire();
				}else{
					let executeActions = component.get("c.executeAccions");
					executeActions.setParams({
						"sourceCAId":sourceCAId,
						"nameButton":nameButton
					})

					executeActions.setCallback(this, function(response){
					let acciones = response.getReturnValue();
					console.log(acciones);
					if(acciones.length>=1){
						let alerta = acciones.toString();
						let error = alerta.replace(',','');

						var toastEvent = $A.get("e.force:showToast");
						toastEvent.setParams({
							title:'Error Message',
							message:error,
							messageTemplate:'Mode is pester ,duration is 5sec and Message is overrriden',
							duration:' 5000',
							key:'info_alt',
							type:'warning',
							mode:'pester'
						});
						toastEvent.fire();
					}else{
						$A.get("e.force:refreshView").fire();
					}

					});
					$A.enqueueAction(executeActions)		
				}
			}
		});	
		$A.enqueueAction(action);
	},

	hacceptToReviewAML : function (component, sourceCAId, nameButton) {
		//asignamos el metodo apex validateConditions a una variable
		let action = component.get("c.validateConditions");
		
		//Seteamos los parametors del metodo
		action.setParams({
			"sourceCAId": sourceCAId,
			"nameButton": nameButton
		})

		//Ejecutamos el metodo pormedio de un callback
		action.setCallback(this, function(response){
			//asignamos la respuesta que trae la ejecución del metodo a una variable
			let state = response.getReturnValue();
			console.log('error: ' + state);
			
			//Pedimos confirmación para enviar a Risk
			var alerta = confirm('Are you sure to Accept to review AML?');
			if(alerta == true){
				if(state.length>=1){
					let alerta = state.toString();
					let error = alerta.replace(',','');

					var toastEvent = $A.get("e.force:showToast");
					toastEvent.setParams({
						title:'Error Message',
						message:error,
						messageTemplate:'Mode is pester ,duration is 5sec and Message is overrriden',
						duration:' 5000',
						key:'info_alt',
						type:'warning',
						mode:'pester'
					})
					toastEvent.fire();
				}else{
					let executeActions = component.get("c.executeAccions");
					executeActions.setParams({
						"sourceCAId":sourceCAId,
						"nameButton":nameButton
					})

					executeActions.setCallback(this, function(response){
					let acciones = response.getReturnValue();
					console.log(acciones);
					if(acciones.length>=1){
						let alerta = acciones.toString();
						let error = alerta.replace(',','');

						var toastEvent = $A.get("e.force:showToast");
						toastEvent.setParams({
							title:'Error Message',
							message:error,
							messageTemplate:'Mode is pester ,duration is 5sec and Message is overrriden',
							duration:' 5000',
							key:'info_alt',
							type:'warning',
							mode:'pester'
						});
						toastEvent.fire();
					}else{
						$A.get("e.force:refreshView").fire();
					}

					});
					$A.enqueueAction(executeActions)		
				}
			}
		});	
		$A.enqueueAction(action);
	},

	hsubmitForAproval : function (component, sourceCAId, nameButton) {
		//asignamos el metodo apex validateConditions a una variable
		let action = component.get("c.validateConditions");
		
		//Seteamos los parametors del metodo
		action.setParams({
			"sourceCAId": sourceCAId,
			"nameButton": nameButton
		})

		//Ejecutamos el metodo pormedio de un callback
		action.setCallback(this, function(response){
			//asignamos la respuesta que trae la ejecución del metodo a una variable
			let state = response.getReturnValue();
			console.log('error: ' + state);
			
			//Pedimos confirmación para enviar a AML
			var alerta = confirm('Are you sure to submit for Approval?');
			if(alerta == true){
				//Assignamos el metodo tollgateDocs a una variable
				let tollgate = component.get("c.tollgateDocs");
				
				//Seteamos los parametros del metodo
				tollgate.setParams({
					"sourceCAId": sourceCAId
					
				})
				
				//Ejecutamos el metodo tollgateDocs por medio de un callback
				tollgate.setCallback(this, function(response){
					//Asignamos la respuesta de la ejecución a una variable
					let tollgatestate =response.getReturnValue();
					console.log('stateDoctos--->:' + tollgatestate);
					//Asignamos todas las llaves del objecto en un arreglo
					let keys= [];
					for(var k in tollgatestate)keys.push(k+'\n');
					//imprimimos en consola los documentos faltantes
					console.log('keysss: ' + keys)

					//Si el arreglo contiene algun elemento se muestra la alerta
					if(keys.length!=0){
						
						var keysA = keys.toString();
						var alertakeys = keysA.replace(/,/g, '');
						//var a = confirm('¿Esta seguro de enviar con los siguientes documentos faltantes?:\n' + alertakeys);
						
						//Si el usuario desea continuar continuamos el flujo para enviar a RISK
						if(alertakeys.includes('Write Up')){
							var toastEvent = $A.get("e.force:showToast");
								toastEvent.setParams({
									title:'Error Message',
									message:'Write Up document is missing',
									messageTemplate:'Mode is pester ,duration is 5sec and Message is overrriden',
									duration:' 5000',
									key:'info_alt',
									type:'warning',
									mode:'pester'
								});
								toastEvent.fire();
							
						}
							if(state.length>=1){
								let alerta = state.toString();
								let error = alerta.replace(/,/g, '');
							
								var toastEvent = $A.get("e.force:showToast");
								toastEvent.setParams({
									title:'Error Message',
									message:error,
									messageTemplate:'Mode is pester ,duration is 5sec and Message is overrriden',
									duration:' 5000',
									key:'info_alt',
									type:'warning',
									mode:'pester'
								});
								toastEvent.fire();
							}else if(alertakeys.includes('Write Up') == false && state.length==0){
								let executeActions = component.get("c.executeAccions");
								executeActions.setParams({
									"sourceCAId":sourceCAId,
									"nameButton":nameButton
								})

								executeActions.setCallback(this, function(response){
									let acciones = response.getReturnValue();
									console.log(acciones);
									if(acciones.length>=1){
										let alerta = acciones.toString();
										let error = alerta.replace(',','');

										var toastEvent = $A.get("e.force:showToast");
										toastEvent.setParams({
											title:'Error Message',
											message:error,
											messageTemplate:'Mode is pester ,duration is 5sec and Message is overrriden',
											duration:' 5000',
											key:'info_alt',
											type:'warning',
											mode:'pester'
										});
										toastEvent.fire();
									}else{
										$A.get("e.force:refreshView").fire();
									}

								});
								$A.enqueueAction(executeActions);
							}
							

					}
				   
				});
				$A.enqueueAction(tollgate);
			}

		});

		$A.enqueueAction(action);
	},
    
    hrecargarx2 : function (component, CAId, jsonParameters) {
        setTimeout(() => {
            if(jsonParameters){
            if(jsonParameters.ettyinCA=="yes"){
            let a = component.get('c.reloadpage');
            a.setParams({
            "CAId":CAId
        })
        
        a.setCallback(this, function(response){
            let estado = response.getReturnValue();
            console.log('ESTADOCALLBACKURL: ' + estado);
            var urlEvent = $A.get("e.force:navigateToURL");
            urlEvent.setParams({
                "isredirect":false,
                "url": estado+'/view'
            });
            
            
            urlEvent.fire();
            
            
        });
        
        $A.enqueueAction(a);
       
    }
}
 
 }, 2000);
         if(jsonParameters){
            console.log('losparametros de la segunda cuadrea: ' + jsonParameters.refresh2);
            if(jsonParameters.refresh2=="yes"){
                console.log('antesdel timeout');
                setTimeout(() => {
                console.log('dentrodel timeout');
                let a = component.get('c.reloadpage');
                a.setParams({
                    "CAId":CAId
                })
                
                a.setCallback(this, function(response){
                    let estado = response.getReturnValue();
                    console.log('ESTADOCALLBACKURL: ' + estado);
                    var urlEvent = $A.get("e.force:navigateToURL");
                    urlEvent.setParams({
                        "isredirect":false,
                        "url": estado+'/view'
                    });
                    
                    
                    urlEvent.fire();
                    
                    
                });
                $A.get("e.force:refreshView").fire();
                
                $A.enqueueAction(a);
                
                $A.get("e.force:refreshView").fire();
                $A.enqueueAction(a);
            },2000);
            }
        }
    }
})