/* eslint-disable no-console */
/**
 * @File Name          : wk_EntityInCa_TableExposure_lwc.js
 * @Description        : 
 * @Author             : juandedios.hernandez@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : juandedios.hernandez@engeniumcapital.com
 * @Last Modified On   : 8/10/2019 14:28:11
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    3/9/2019   juandedios.hernandez@engeniumcapital.com     Initial Version
**/
import { LightningElement, api, track, wire } from 'lwc';
import getEntitiesECGroup from "@salesforce/apex/Wk_TableExporsurelwc_controller_cls.getEntitiesECGroup";
import COLUMNAS from "./fetchDataHelper"
import getExporsure from "@salesforce/apex/Wk_TableExporsurelwc_controller_cls.getExporsure"
//import addContracts from "./datatableOperations";
import saveContracts from "@salesforce/apex/Wk_TableExporsurelwc_controller_cls.saveContracts";
import getLinkedEntites from "@salesforce/apex/Wk_TableExporsurelwc_controller_cls.getLinkedEntities"
import deleteOne from "@salesforce/apex/Wk_TableExporsurelwc_controller_cls.deleteOnly"
import { refreshApex } from '@salesforce/apex';


const COLUMNS = COLUMNAS;

export default class Wk_EntityInCa_TableExposure_lwc extends LightningElement {
    @api creditApprovalId;
    @api economicGroupId;
    @track data = [];
    @track tablecols = COLUMNS.COLUMNAS;
    @track entitysInCa = [];
    @track error;

    @track openmodel = false;
    @track message;
    @track resultados;
    @track errores;
    
    @track contracts =[];
    @track linkEntities;

    _wireddata;
    _wiredlink;

        

   @wire(getEntitiesECGroup,{partyId: "$economicGroupId"})
    wiredRecord({ error, data}) {
        if ( error ) {
            let  message = "Unknown error";
            if (Array.isArray(error.body)) {
                message = error.body.map(e => e.message).join(", ");    
            } else if (typeof error.body.message === "string") {
                message = error.body.message;
            }

            this.error = message;
            this.entitysInCa = undefined;
        } else if (data) {
            console.log(data)
            let ents = JSON.parse(data);
            console.log('entttts');
            console.log(ents)
            this.entitysInCa =ents.entityInfo.entities.entity;
            this.error = undefined;
            console.log('entidades');
            console.log(this.entitysInCa);
        }
    }



    @wire(getLinkedEntites,{economicId:"$economicGroupId"})
   async wiredLinked(result){
       console.log('economiclwc');
        console.log(this.economicGroupId);
        if(this.economicGroupId !== ''){
            this._wiredlink = result;
            if(result.error){
                let  message = "Unknown error";
                if (Array.isArray(result.error.body)) {
                    message = result.error.body.map(e => e.message).join(", ");
                    console.log( result.error.body.map(e => e.message).join(", "))    
                } else if (typeof result.error.body.message === "string") {
                    message = result.error.body.message;
                    console.log(result.error.body.message)
                }
                this.error = message;
                this.linkEntities = undefined;
            }else if(result.data){
                
                console.log('esperando el JSON');
                await this.exposures();
                console.log('linkedents');
                let resultIds =result.data.map(({WK_contractNumber__c})=>WK_contractNumber__c);
                this.linkEntities = resultIds;
                
                console.log(this.linkEntities);
                this.error=undefined;

            }
        }
    }


    getSelectedRows(event) {
        let selectedRows = event.detail.selectedRows;
        
        let filterEnts = [...selectedRows].filter(({contractNumber})=>!this.linkEntities.includes(contractNumber));
        console.log('entsfiltrados');
        console.log(filterEnts);
        

        this.contracts = filterEnts;
        // eslint-disable-next-line no-console
        console.log('contraooooos');
        console.log( this.contracts);
    }

   async multyAddContracts (){
        // eslint-disable-next-line no-alert
        let alerta = confirm('Are you sure to add this contracts?');
        if(alerta === true){
         let {message, resultados, errores} = await this.addContracts();
         this.message = message;
         this.resultados = resultados;
         this.errores = errores;
         this.openmodal();
        }
    }

    handleRowAction (event){
        const action = event.detail.action;
        const contract = event.detail.row.contractNumber;
        switch (action.name) {
            case 'deleteOnly':
                console.log('deleteOnly')
                console.log(contract);
                this.deleteOnly(contract);
                break;
            case 'deleteAll':
                console.log('deleteAll')
                break;
            default:
                console.log('fail to detect action');   
        }       
    }

    deleteOnly(contractNumber){
       
        
            let alerta = confirm('Are you sure to delete this Contract?');

            if(alerta === true){
                deleteOne({contractNumber:contractNumber})
                .then(result=>{
                    // eslint-disable-next-line no-alert
                    alert('contract number: ' + contractNumber + ' has been deleted');
                    this.error=undefined;
                    
                    return refreshApex(this._wiredlink);
                }).catch(error=>{
                    // eslint-disable-next-line no-alert
                    alert('You can´t delete a contract that does´nt linked to an Entity')
                })
            }else{
                console.log('No contracts deleted');
            }
       
    }

    exposures(){
        console.log('Economic group id: ' + this.economicGroupId);
        return new Promise((resolve,reject)=>{
            getExporsure({economicGId:this.economicGroupId})
            .then(result=>{
                let resultado = JSON.parse(result);
                this.data = resultado.contracts.contract;
                this.error = undefined;
                console.log('JOSN Cargado');
                resolve(console.log(this.data));
            }).catch(error=>{
                /* let  message = "Unknown error";
                console.log('hay un error que hay que arreglar');
                if (Array.isArray(error.body)) {
                    console.log('el error es un array');
                    message = error.body.map(e => e.message).join(", ");    
                } else if (typeof error.body.message === "string") {
                    console.log('el error no es array');
                    message = error.body.message;
                } */
                
                this.error = error;
                this.data = undefined;
                console.log('error de la tabala')
                reject(console.log(error));
            })

        });
    }

    openmodal() {
        this.openmodel = true
    }
    closeModal() {
        this.openmodel = false
    } 
    saveMethod() {
        alert('save method invoked');
        this.closeModal();
    }

    get traeErrors(){
        let status;
        if(this.errores.length > 0){
            status = true;
        }else if(this.errores.length ===0){
            status =false;
        }
        return status;
    }

    addContracts(){
        if(this.contracts.length>0){
            
            console.log('contracts');
            console.log(this.contracts);
            return new Promise(resolve=>{
                let contratos = [];
                for(let cont of this.contracts){
                
                    for(let ent of this.entitysInCa){
                        if(ent.oracleAccountName === cont.partyName ){
                            cont.entityMasterCreditApproval = ent.partyId;
                            console.log('cont');
                            cont.economicGroupId =parseInt(cont.economicGroupId);
                            cont.contractOec = parseFloat(cont.contractOec);
                            cont.exposure = parseFloat(cont.exposure);
                            cont.openItemsAr =parseFloat(cont.openItemsAr);
                            cont.daysDueAr = parseInt(cont.daysDueAr);
                            cont.openItemsDlq = parseInt(cont.openItemsDlq);
                            cont.daysDueDlq = parseInt(cont.daysDueDlq);
                            cont.nbv = parseInt(cont.nbv);
                            console.log(cont);
                            contratos.push(cont);
                        }
                    }
                }
                console.log(this.contracts.length)
                console.log(contratos);
                let aroma = contratos;
                console.log('aroma');
                
                console.log(aroma[0]);
                saveContracts({contracts:aroma})
                    .then(result =>{
                        console.log(result);
                        if(result.errors.length ===0){
                            // eslint-disable-next-line no-alert
                            let message='All contracts has been added sucessful:';
                            let resultados =result.results
                            let errores = result.errors;
                             let messages = ({message:message, resultados:resultados, errores:errores});
                            resolve(
                                messages
                            )
                        // eslint-disable-next-line no-else-return
                        }else{
                            // eslint-disable-next-line no-alert
                            let message= 'The next contracts has been added succesfull:'; 
                            let resultados =result.results;
                            let errores = result.errors;
                            let messages = ({message:message, resultados:resultados, errores:errores});
                            resolve(
                                messages
                            )
                        }        
                    })
                    .catch(error =>{
                        console.log('errorcustoM: ' + JSON.stringify(error));
                        
                    })

                
            });
        }
    }

}