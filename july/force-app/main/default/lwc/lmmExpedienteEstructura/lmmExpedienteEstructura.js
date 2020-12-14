/**
 * @File Name          : lmmExpedienteEstructura.js
 * @Description        : 
 * @Author             : eduardo.amiens@outlook.com
 * @Group              : 
 * @Last Modified By   : eduardo.amiens@outlook.com
 * @Last Modified On   : 07-30-2020
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    19/5/2020   eduardo.amiens@outlook.com     Initial Version
**/

import { LightningElement, api, wire, track } from 'lwc'
import { ShowToastEvent } from 'lightning/platformShowToastEvent'
import { refreshApex } from '@salesforce/apex'
import { getRecord, deleteRecord } from 'lightning/uiRecordApi'
import { asignPickListValues } from './helperJS/helper'
import { NavigationMixin } from 'lightning/navigation'
import blank from './views/blank.html'
import mainpage from './lmmExpedienteEstructura.html'
import getEntidadesDeOportunidad from '@salesforce/apex/lmmExpedienteEstructuraController.getEntidadesDeOportunidad'
import searchEntities from '@salesforce/apex/lmmExpedienteEstructuraController.searchEntitiesInOracle'
import getEntitiesByEconomicGroup from '@salesforce/apex/lmmExpedienteEstructuraController.getEntitiesByEconomicGroup'
import AsignEntities from '@salesforce/apex/lmmExpedienteEstructuraController.AsignEntities'
import validateHits from '@salesforce/apex/lmmExpedienteEstructuraController.validateHits'
import getLMM_lm_RolPKValues from '@salesforce/apex/lmmExpedienteEstructuraController.getLMM_lm_RolPKValues'
import entityHitsOnProgress from '@salesforce/apex/lmmExpedienteEstructuraController.entityHitsOnProgress'
import getCreditBureauApprovalProcess from '@salesforce/apex/lmmExpedienteEstructuraController.getCreditBureauApprovalProcess'
import updateContactsFromEntity from '@salesforce/apex/lmmExpedienteEstructuraController.updateContactsFromEntity'


import constantes from './constantes'

export default class LmmExpedienteEstructura extends NavigationMixin(LightningElement) {
    @api recordId
    dataEntidadesDeOportunidad
    @track dataEntidadesEntityMasterWS
    @track showModalAddEntities = false
    @track deleteEntidadOportunidad = false
    //@track data
    @track selectedEntidadesEntityMasterWSRows = []
    @track section = mainpage

    @track disableValidateHitsButton = true
    @track objectInfo
    columnsSelectedEntities
    columnsSelectEntity = constantes.columnsSelectEntity

    @track valueEntityType = 'Search By Account'
    @track valueEconomicGroup
    @track valueEconomicGroupOption

    @track recordToDelete

    get valueEntityTypeOptions() {
        return [
            { label: 'Search By Account', value: 'Search By Account' },
            { label: 'Search By Group Name', value: 'Search By Group Name' }
        ];
    }

    get showSearchTable() {
        return this.valueEntityType === 'Search By Account' ? true : false;
    }

    async handleChangeEntityType(event) {
        this.section = blank
        this.valueEntityType = event.detail.value;
        if(this.valueEntityType === 'Search By Account' ){
            this.valueEconomicGroup = ''
        } else if(this.valueEntityType === 'Search By Group Name' 
        & (this.valueEconomicGroupOption === null 
        || this.valueEconomicGroupOption === undefined)){
            try{
                let entitiesByEconomicGroup = await getEntitiesByEconomicGroup({partyID : '0'})
                if(entitiesByEconomicGroup){
                    entitiesByEconomicGroup = JSON.parse(entitiesByEconomicGroup)
                    entitiesByEconomicGroup = entitiesByEconomicGroup.entityInfo.entities.entity
                    console.log('entitiesByEconomicGroup ' + JSON.stringify(entitiesByEconomicGroup))
                    this.valueEconomicGroupOption = entitiesByEconomicGroup.map(index =>{
                        return { label: index.oracleAccountName, value: index.partyID.toString() }
                    })
                    console.log('this.valueEconomicGroupOption ' + JSON.stringify(this.valueEconomicGroupOption))
                }
                
                if(entitiesByEconomicGroup !== null & entitiesByEconomicGroup !== undefined){
                    //entitiesByEconomicGroup.
                }
            }  catch(error){

            }         

        }
        this.section = mainpage
    }

    async handleChangeEconomicGroup(event) {
        this.section = blank
        console.log('event ' + JSON.stringify(event.detail))
        this.valueEconomicGroup = event.detail.value;
        console.log('valueEconomicGroup ' + JSON.stringify(this.valueEconomicGroup))
        if(this.valueEconomicGroup){            
            try {
                let response = await getEntitiesByEconomicGroup({partyID : this.valueEconomicGroup})
                if (response) {
                    response = JSON.parse(response)
                    console.log('response ' + JSON.stringify(response))
                    if (response.entityInfo.entities !== null & response.entityInfo.entities !== undefined) {
                        if (response.entityInfo.entities.entity.length > 0 & response.entityInfo.entities.entity !== null & response.entityInfo.entities.entity !== undefined) {
                            this.dataEntidadesEntityMasterWS = response.entityInfo.entities.entity
                        } else {
                            this.dispatchEvent(
                                new ShowToastEvent({
                                    title: 'Sorry',
                                    message: 'No entities found',
                                    variant: 'warning'
                                }),
                            );
                        }

                    } else {
                        this.dispatchEvent(
                            new ShowToastEvent({
                                title: 'Sorry',
                                message: 'No entities found',
                                variant: 'warning'
                            }),
                        );
                    }

                }
            } catch (error) {
                console.log('error' + JSON.stringify(error))
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error loading resourse',
                        message: error,
                        variant: 'error',
                    }),
                );
            }
        }
        this.section = mainpage
    }

    @wire(getRecord, { recordId: "$recordId", fields: constantes.FIELDS })
    wireGetRecord


    @wire(getEntidadesDeOportunidad, { idOportunidad: "$recordId" })
    async wireEntidadesDeOportunidad(result) {
        this.section = blank
        if (await result.data) {
            
            console.log('dat' + JSON.stringify(result.data))
            this.dataEntidadesDeOportunidad = result
            console.log('dataEntidadesDeOportunidad ' + JSON.stringify(this.dataEntidadesDeOportunidad))
            if (this.dataEntidadesDeOportunidad.data !== null & this.dataEntidadesDeOportunidad.data.length > 0 & this.dataEntidadesDeOportunidad.data !== undefined) {
                this.disableValidateHitsButton = false
            }
            this.columnsSelectedEntities = asignPickListValues(constantes.columnsSelectedEntities, await getLMM_lm_RolPKValues())
        } else if (result.error) {
            console.log('error' + JSON.stringify(result.error));
        }
        this.section = mainpage
    }
    asignValuesFromMultipickList() {
        let newMap
        if (this.columnsSelectEntity.data)
            if (this.columnsSelectEntity.data.values)
                newMap = this.columnsSelectEntity.data.values.map(index => index.value)
        console.log('newMap ' + JSON.stringify(newMap))
    }
    getSelectedRows(event) {
        this.selectedEntidadesEntityMasterWSRows = event.detail.selectedRows;
    }
    async handleOpenModalAddEntities() {
        this.section = blank
        let sfAccountID
        this.showModalAddEntities = true
        console.log('this.wireGetRecord ' + JSON.stringify(this.wireGetRecord))
        //Valida si tiene cuenta
        if (this.wireGetRecord.data.fields.AccountId.value) {
            if (this.wireGetRecord.data.fields.Account.value.fields.ACC_rb_Top_Parent_Account__c.value) {
                sfAccountID = this.wireGetRecord.data.fields.Account.value.fields.ACC_rb_Top_Parent_Account__c.value
            } else {
                sfAccountID = this.wireGetRecord.data.fields.AccountId.value
            }
            try {
                let response = await searchEntities({ sfAccountID: sfAccountID })
                if (response) {
                    response = JSON.parse(response)
                    console.log('response ' + JSON.stringify(response))
                    if (response.entityInfo.entities !== null & response.entityInfo.entities !== undefined) {
                        if (response.entityInfo.entities.entity.length > 0 & response.entityInfo.entities.entity !== null & response.entityInfo.entities.entity !== undefined) {
                            this.dataEntidadesEntityMasterWS = response.entityInfo.entities.entity
                        } else {
                            this.dispatchEvent(
                                new ShowToastEvent({
                                    title: 'Sorry',
                                    message: 'No entities found',
                                    variant: 'warning'
                                }),
                            );
                        }

                    } else {
                        this.dispatchEvent(
                            new ShowToastEvent({
                                title: 'Sorry',
                                message: 'No entities found',
                                variant: 'warning'
                            }),
                        );
                    }

                }
            } catch (error) {
                console.log('error' + JSON.stringify(error))
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error loading resourse',
                        message: error,
                        variant: 'error',
                    }),
                );
            }
        } else {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Sorry',
                    message: 'No account assigned',
                    variant: 'warning'
                }),
            );
        }
        //this.template.querySelector("c-modal-question").makeModalLarge();
        this.section = mainpage
    }
    handleCloseModals() {
        this.showModalAddEntities = false
        this.deleteEntidadOportunidad = false
    }
    async handleAddEntities() {
        this.section = blank
        console.log('this.selectedEntidadesEntityMasterWSRows ' + JSON.stringify(this.selectedEntidadesEntityMasterWSRows))
        if (this.selectedEntidadesEntityMasterWSRows.length > 0) {
            let finalData = this.selectedEntidadesEntityMasterWSRows.map(entity => {
                let economicGroupId = ''
                if(entity.economicGroupId !== null && entity.economicGroupId !== '' && entity.economicGroupId !== undefined){
                    economicGroupId = entity.economicGroupId.toString();
                } else if(this.valueEconomicGroup !== null && this.valueEconomicGroup !== '' && this.valueEconomicGroup !== undefined){
                    economicGroupId = this.valueEconomicGroup
                } 
                return {
                    partyID: entity.partyID !== null ? entity.partyID.toString() : '',
                    economicGroupId: economicGroupId,
                    topParentId: entity.topParentId,
                    rfc: entity.rfc,
                    entityName: entity.oracleAccountName,
                    taxRegime: entity.taxRegime,
                    customerType: entity.customerType,                    
                    oracleAccountNumber: entity.oracleAccountNumber, //CustomerNumber
                    supplierFlag: entity.supplierFlag,
                    orRating: entity.rating.orRating,
                    mraId: entity.rating.mraId
                }

            })
            console.log('finalData ' + JSON.stringify(finalData))
            if (this.dataEntidadesDeOportunidad.data.length > 0)
                finalData = finalData.filter(selectedItem => !this.dataEntidadesDeOportunidad.data.some(selectedItem2 => selectedItem2.LMM_pd_Entity_CP__r.CPI_tx_RFC_TIN__c === selectedItem.rfc))
            console.log('finalData ' + JSON.stringify(finalData))

            try {
                let errorUpsert = await AsignEntities({ listEntityMasterResponse: finalData, opportunityID: this.wireGetRecord.data.fields.Id.value })
                if(errorUpsert){
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Some records could not be inserted:',
                            message: errorUpsert,
                            variant: 'error',
                        }),
                    );
                } else {
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Success',
                            message: 'The records has been added',
                            variant: 'success',
                        }),
                    );
                    let listPartyId = finalData.map(index => index.partyID)
                    console.log('listPartyId ' + JSON.stringify(listPartyId))
                    updateContactsFromEntity({listPartyId : listPartyId})
                }               
                

                
            } catch (error) {
                console.log('Ocurrio un error ' + JSON.stringify(error))
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error loading resourse',
                        message: error,
                        variant: 'error',
                    }),
                );
            }
        }
        this.section = mainpage
    }
    async addContactsToEntities(){
        
    }

    async handleValidateHits() {
        this.section = blank
        let listIds = []
        await this.dataEntidadesDeOportunidad.data.forEach(par => {
            listIds.push(par.Id)
        })
        
        if(await entityHitsOnProgress({ entidadOportunidadIds : listIds })){
            let listRequest = await this.dataEntidadesDeOportunidad.data.map(par => {
                return {
                    entidadDeOportunidadID: par.Id,
                    request: JSON.stringify({
                            parametros: {
                                parametro: {
                                    rfc: par.LMM_pd_Entity_CP__r.CPI_tx_RFC_TIN__c,
                                    name: par.LMM_pd_Entity_CP__r.Name
                                }
                            }
                    })                
                }
            })
            console.log('ner ' + JSON.stringify(listRequest))
            try {
                await listRequest.forEach(element => {
                    validateHits({ EntidadDeOportunidadHits: element })
                })
                
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'The validation was successful',
                        variant: 'success',
                    }),
                );
                
            } catch (error) {
                console.log('error ' + JSON.stringify(error))
            }
        }        
        this.section = mainpage
    }

    handleRowAction(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;
        switch (actionName) {
            case 'show_entity_cp':
                this.rowActionShowEntityCP(row);
                break;
            case 'show_entity_detail':
                this.rowActionShowEntityDetail(row);
                break;
            case 'delete':
                this.recordToDelete = row
                this.deleteEntidadOportunidad = true
                break;
            default:
        }
    }

    
    rowActionShowEntityCP(row){
        console.log('rowActionShowEntityCP ' + JSON.stringify(row))
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: row.LMM_pd_Entity_CP__c,
                objectApiName: 'Entity_CP__c', 
                actionName: 'view'
            }
        });
    }
    rowActionShowEntityDetail(row){
        console.log('rowActionShowEntityDetail ' + JSON.stringify(row))
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: row.Id,
                objectApiName: 'LMM_Entidad_de_oportunidad__c', 
                actionName: 'view'
            }
        });
    }
    rowActionDelete(){
        console.log('rowActionDelere ' + JSON.stringify(this.recordToDelete))
        try{
            deleteRecord(this.recordToDelete.Id)
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Record deleted',
                    variant: 'success'
                })
            );
        }catch(error){
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error',
                    message: 'An error has occurred while trying to delete the record',
                    variant: 'error'
                })
            );
        }
        this.deleteEntidadOportunidad = false
        
    }
    
    handleMessage(event) {
        //Message is coming in event.detail.payload
        // eslint-disable-next-line no-console
        console.log('this.payload ' + JSON.stringify(event.detail.payload));
        refreshApex(this.dataEntidadesDeOportunidad);
    }
    handleError(event) {
        //Error is coming in the event.detail.error
        console.log('Error PushTopic ' + JSON.stringify(event.detail.error))
    }
    render() {
        return this.section
    }
    async handleAPCB(){
        console.log('this.recordId '+ this.recordId)
        let apporvalProcessCB = await getCreditBureauApprovalProcess({oppId : this.recordId})
        console.log('apporvalProcessCB ' + JSON.stringify(apporvalProcessCB))
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: apporvalProcessCB.Id,
                objectApiName: 'LMM_Credit_Bureau_Approval_Process__c', 
                actionName: 'view'
            }
        });
    }
}