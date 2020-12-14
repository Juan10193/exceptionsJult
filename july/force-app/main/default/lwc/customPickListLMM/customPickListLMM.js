/**
 * @File Name          : customPickListLMM.js
 * @Description        : 
 * @Author             : eduardo.amiens@outlook.com
 * @Group              : 
 * @Last Modified By   : eduardo.amiens@outlook.com
 * @Last Modified On   : 1/6/2020 12:25:49
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    30/4/2020   eduardo.amiens@outlook.com     Initial Version
**/
import { LightningElement, track, api, wire} from 'lwc'
import { getRecord } from 'lightning/uiRecordApi'
import blank from './views/blank.html'
import mainpage from './customPickListLMM.html'
import getRequestByPartyID from '@salesforce/apex/customPickListLMMController.getRequestByPartyID'
import getRequestByRequestID from '@salesforce/apex/customPickListLMMController.getRequestByRequestID'
import LMM_tx_RequestId from '@salesforce/schema/LMM_Entidad_de_oportunidad__c.LMM_tx_RequestId__c'
import LMM_tl_Bil_Comentarios from '@salesforce/schema/LMM_Entidad_de_oportunidad__c.LMM_tl_Bil_Comentarios__c'
import LMM_fh_Bil_Fecha_Revision from '@salesforce/schema/LMM_Entidad_de_oportunidad__c.LMM_fh_Bil_Fecha_Revision__c'
import LMM_ls_Bil_Incidencias from '@salesforce/schema/LMM_Entidad_de_oportunidad__c.LMM_ls_Bil_Incidencias__c'
import ID_FIELD from '@salesforce/schema/LMM_Entidad_de_oportunidad__c.Id'
import { ShowToastEvent } from 'lightning/platformShowToastEvent'
import { updateRecord } from 'lightning/uiRecordApi'
import constantes from './helperJS/constantes'

export default class CustomPickListLMM extends LightningElement {
    @api recordId

    @track LMM_Entidad_de_oportunidad
    @track section = mainpage

    selected = []
    columnsApoderados = constantes.columnsApoderados

    @api titleModal = ''
    @api acceptButtonName = ''
    @api sizeModal = ''
    @api cancelButtonName = ''
    
    @track openModal = false
    @track valueRequestOptions = []
    @track valueRequest

    @track incidencia
    @track incidenciaWS
    @track requestId
    @track fechaRevision
    @track comentarios

    @track apoderadosData
    
    @track showLA = false

    @wire(getRecord, { recordId: '$recordId', fields: [LMM_tl_Bil_Comentarios, LMM_fh_Bil_Fecha_Revision, LMM_ls_Bil_Incidencias, LMM_tx_RequestId, 'LMM_Entidad_de_oportunidad__c.LMM_pd_Entity_CP__r.EM_Party_ID__c'] })
    propertyOrFunction(result){
        if(result.data){
            console.log('checa el valor ' + this.requestId)
            console.log('result.data ' + JSON.stringify(result.data))
            this.LMM_Entidad_de_oportunidad = result.data 
            console.log('result.data ' + JSON.stringify(result.data))  
            this.incidencia = this.LMM_Entidad_de_oportunidad.fields.LMM_ls_Bil_Incidencias__c.value
            this.incidenciaWS = this.LMM_Entidad_de_oportunidad.fields.LMM_ls_Bil_Incidencias__c.value === 'action:priority' ? 'Y' :this.LMM_Entidad_de_oportunidad.fields.LMM_ls_Bil_Incidencias__c.value === null ? '' : this.LMM_Entidad_de_oportunidad.fields.LMM_ls_Bil_Incidencias__c.value === undefined ? '' : 'N' 
            this.requestId = this.LMM_Entidad_de_oportunidad.fields.LMM_tx_RequestId__c.value
            this.fechaRevision = this.LMM_Entidad_de_oportunidad.fields.LMM_fh_Bil_Fecha_Revision__c.value
            this.comentarios = this.LMM_Entidad_de_oportunidad.fields.LMM_tl_Bil_Comentarios__c.value
            console.log('checa el valor2 ' + this.requestId)
        } else if(result.error) {
            console.log('An error has ' + JSON.stringify(result))
        }
    }
    async handleOpenModal(){
        this.section = blank
        console.log('ssss ' + JSON.stringify(this.template.querySelectorAll('.slds-has-focus')))
        console.log('OpenModal')
        this.openModal = true
        if(await this.LMM_Entidad_de_oportunidad.fields.LMM_pd_Entity_CP__r.value.fields.EM_Party_ID__c.value !== null && this.LMM_Entidad_de_oportunidad.fields.LMM_pd_Entity_CP__r.value.fields.EM_Party_ID__c.value !== undefined){
            try{
                console.log('1')
                let responseRequest = await getRequestByPartyID({partyID : this.LMM_Entidad_de_oportunidad.fields.LMM_pd_Entity_CP__r.value.fields.EM_Party_ID__c.value})
                
                if(responseRequest){
                    console.log('responseRequest ' + responseRequest)
                    responseRequest = JSON.parse(responseRequest)
                    responseRequest = responseRequest.requests.request
                    console.log('responseRequest ' + JSON.stringify(responseRequest))
                    this.valueRequestOptions = responseRequest.filter(element => (element.header.requestType === 'LEGAL ASSESSMENT' && element.header.requestStatus === 'APPROVED')).map(index =>{
                            return {
                                label: index.header.requestId, value: index.header.requestId                             
                            }                    
                    })
                    console.log('this.valueRequestOptions ' + JSON.stringify(this.valueRequestOptions))
                } else {
                    this.valueRequestOptions = []
                }
            }catch(error){
                console.log('Error ' + error)
            }
            
        }   
        console.log('this.requestId ' + this.requestId)
        if(this.requestId){
            await this.searchLAByRequestID(this.requestId)
        }
        this.showLA = this.valueRequestOptions.length > 0 ? true : false 
        this.section = mainpage     
    }
    handleCloseModal(){
            this.incidencia = this.LMM_Entidad_de_oportunidad.fields.LMM_ls_Bil_Incidencias__c.value
            this.incidenciaWS = this.LMM_Entidad_de_oportunidad.fields.LMM_ls_Bil_Incidencias__c.value === 'action:priority' ? 'Y' :this.LMM_Entidad_de_oportunidad.fields.LMM_ls_Bil_Incidencias__c.value === null ? '' : this.LMM_Entidad_de_oportunidad.fields.LMM_ls_Bil_Incidencias__c.value === undefined ? '' : 'N' 
            this.requestId = this.LMM_Entidad_de_oportunidad.fields.LMM_tx_RequestId__c.value
            this.comentarios = this.LMM_Entidad_de_oportunidad.fields.LMM_tl_Bil_Comentarios__c.value
            this.valueRequest = null
        this.openModal = false
    }

    async handleUpdate() {
        if(this.requestId){
            this.openModal = false
            const fields = {};
            fields[ID_FIELD.fieldApiName] = this.recordId
            fields[LMM_ls_Bil_Incidencias.fieldApiName] = this.incidencia
            if(this.fechaRevision){
                const d = new Date(this.fechaRevision)
            }        
            fields[LMM_tx_RequestId.fieldApiName] = this.requestId
            fields[LMM_tl_Bil_Comentarios.fieldApiName] = this.comentarios
            const recordInput = { fields };
            console.log('recordInput ' + JSON.stringify(recordInput))
            try{
                await updateRecord(recordInput)
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success!!',
                        message: 'The LegalAssessment has been updated ',
                        variant: 'success',
                    })
                );
            }catch(error){
                console.log('error ' + JSON.stringify(error))
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'An error has been occurred during update',
                        message: error,
                        variant: 'error',
                    })
                );
            }
        } else {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Sorry',
                    message: 'It can\'t save without bill information ',
                    variant: 'warning',
                })
            );
        }
        
    }
    async handleChange(e){
        this.section = blank
        console.log('e.detail.value ' + e.detail.value)
        this.valueRequest = e.detail.value;
        if(this.valueRequest !== null && this.valueRequest !== undefined){
            await this.searchLAByRequestID(this.valueRequest)
        }
        this.section = mainpage
    }
    async searchLAByRequestID(requestId){
        try{
            let response = await getRequestByRequestID({requestId:requestId})
            if(response){
                response = JSON.parse(response)
                console.log('responseRequest ' + JSON.stringify(response))
                response = response.requests.request[0].legalAssessment
                let tipoPersona = response.laHeader.laTipo
                console.log('tipoPersona ' + tipoPersona)
                console.log('legalAssessment ' + JSON.stringify(response))
                let noBillInfo = false
                let noApoderadosInfo = false
                this.requestId      = requestId
                switch(tipoPersona) {
                    case 'Moral':
                        console.log('Es persona moral ')
                        if(response.laDetail.moral.bil){
                            //this.requestId      = this.valueRequest
                            this.incidencia     = response.laDetail.moral.bil.laBIncidencias === 'Y' ? 'action:close' : 'action:approval'                            
                            this.incidenciaWS   = response.laDetail.moral.bil.laBIncidencias
                            this.fechaRevision  = response.laDetail.moral.bil.laBFechaRevision
                            this.comentarios    = response.laDetail.moral.bil.laBComentarios
                        } else{
                            noBillInfo = true
                        }
                        if(response.laDetail.moral.apoderados){
                            this.apoderadosData = response.laDetail.moral.apoderados.apoderado
                        } else{
                            noApoderadosInfo = true
                        }
                      break;
                    case 'Fisica':
                        console.log('Es persona Fisica ')
                        if(response.laDetail.fisica.bil){
                            this.incidencia     = response.laDetail.fisica.bil.laBIncidencias === 'Y' ? 'action:close' : 'action:approval'                            
                            this.incidenciaWS   = response.laDetail.fisica.bil.laBIncidencias
                            this.fechaRevision  = response.laDetail.fisica.bil.laBFechaRevision
                            this.comentarios    = response.laDetail.fisica.bil.laBComentarios
                        } else {
                            noBillInfo = true
                        } 
                        if(response.laDetail.fisica.apoderados){
                            this.apoderadosData = response.laDetail.fisica.apoderados.apoderado
                        } else {
                            noApoderadosInfo = true
                        }
                        
                      break;
                    case 'Extranjera':
                        console.log('Es persona Extranjera ')
                        if(response.laDetail.moralExtranjera.apoderados){
                            //this.requestId      = this.valueRequest
                            this.incidencia     = response.laDetail.moralExtranjera.bil.laBIncidencias === 'Y' ? 'action:close' : 'action:approval'                            
                            this.incidenciaWS   = response.laDetail.moralExtranjera.bil.laBIncidencias
                            this.fechaRevision  = response.laDetail.moralExtranjera.bil.laBFechaRevision
                            this.comentarios    = response.laDetail.moralExtranjera.bil.laBComentarios
                        } else {
                            noBillInfo = true
                        }
                        if(response.laDetail.moralExtranjera.apoderados){
                            this.apoderadosData = response.laDetail.moralExtranjera.apoderados.apoderado
                        } else {
                            noApoderadosInfo = true
                        }
                      break;
                    default :
                        console.log('No se sabe que tipo de persona es, que mal ')
                  }
                if(noBillInfo){
                    this.incidencia     = ''
                    this.incidenciaWS   = ''
                    this.fechaRevision  = ''
                    this.comentarios    = ''
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Sorry',
                            message: 'There is no bill information',
                            variant: 'warning',
                        })
                    );
                }
                if(noApoderadosInfo){
                    this.apoderadosData = []
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Sorry',
                            message: 'There is no apoderados information',
                            variant: 'warning',
                        })
                    );
                }
            }
        }catch(error){
            console.log('An error has ocurred ' + error)
        }
    }
    render() {
        return this.section
    }
}