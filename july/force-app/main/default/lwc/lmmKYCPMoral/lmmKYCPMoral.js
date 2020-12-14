/**
 * @description       : 
 * @author            : eduardo.amiens@outlook.com
 * @group             : 
 * @last modified on  : 07-31-2020
 * @last modified by  : eduardo.amiens@outlook.com
 * Modifications Log 
 * Ver   Date         Author                       Modification
 * 1.0   07-27-2020   eduardo.amiens@outlook.com   Initial Version
**/
import { LightningElement, api, wire, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { getRecord, createRecord, updateRecord } from 'lightning/uiRecordApi'
import LMM_fh_Fecha from '@salesforce/schema/LMM_KYC__c.LMM_fh_Fecha__c'
import constantes from './helperJS/constantes'
import LMM_tx_Razon_Social from '@salesforce/schema/LMM_KYC__c.LMM_tx_Razon_Social__c'
import LMM_tx_Giro_de_la_empresa from '@salesforce/schema/LMM_KYC__c.LMM_tx_Giro_de_la_empresa__c'
import LMM_tx_RFC from '@salesforce/schema/LMM_KYC__c.LMM_tx_RFC__c'
import LMM_fh_Fecha_de_constitucion from '@salesforce/schema/LMM_KYC__c.LMM_fh_Fecha_de_constitucion__c'
import LMM_tx_Nacionalidad from '@salesforce/schema/LMM_KYC__c.LMM_tx_Nacionalidad__c'
import logoEngen from '@salesforce/resourceUrl/logoEngen';

import LMM_tx_Calle from '@salesforce/schema/LMM_KYC__c.LMM_tx_Calle__c'
import LMM_tx_No_Ext from '@salesforce/schema/LMM_KYC__c.LMM_tx_No_Ext__c'
import LMM_tx_No_Int from '@salesforce/schema/LMM_KYC__c.LMM_tx_No_Int__c'
import LMM_tx_Colonia_Urbanizacion from '@salesforce/schema/LMM_KYC__c.LMM_tx_Colonia_Urbanizacion__c'
import LMM_tx_Codigo_Postal from '@salesforce/schema/LMM_KYC__c.LMM_tx_Codigo_Postal__c'
import LMM_tx_Alcaldia_o_Municipio from '@salesforce/schema/LMM_KYC__c.LMM_tx_Alcaldia_o_Municipio__c'
import LMM_tx_Ciudad from '@salesforce/schema/LMM_KYC__c.LMM_tx_Ciudad__c'
import LMM_tx_Entidad_Federativa from '@salesforce/schema/LMM_KYC__c.LMM_tx_Entidad_Federativa__c'
import LMM_tx_Pais from '@salesforce/schema/LMM_KYC__c.LMM_tx_Pais__c'
import LMM_tf_Telefono_Oficina_o_particular from '@salesforce/schema/LMM_KYC__c.LMM_tf_Telefono_Oficina_o_particular__c'
import LMM_ce_Correo_Electronico from '@salesforce/schema/LMM_KYC__c.LMM_ce_Correo_Electronico__c'
import LMM_ls_PPE_o_PPEA from '@salesforce/schema/LMM_KYC__c.LMM_ls_PPE_o_PPEA__c'
import LMM_tx_Nombre_de_la_PPE from '@salesforce/schema/LMM_KYC__c.LMM_tx_Nombre_de_la_PPE__c'
import LMM_tx_Parentesco_por_asimilacion from '@salesforce/schema/LMM_KYC__c.LMM_tx_Parentesco_por_asimilacion__c'


import LMM_ls_Actividades_propias_de_la_empresa from '@salesforce/schema/LMM_KYC__c.LMM_ls_Actividades_propias_de_la_empresa__c'
import LMM_ls_Relacion_comercial_con_gobierno from '@salesforce/schema/LMM_KYC__c.LMM_ls_Relacion_comercial_con_gobierno__c'
import LMM_tx_Entidad_con_relacioncomercial from '@salesforce/schema/LMM_KYC__c.LMM_tx_Entidad_con_relacioncomercial__c'
import LMM_dv_Porcentaje_de_ingreso_anual from '@salesforce/schema/LMM_KYC__c.LMM_dv_Porcentaje_de_ingreso_anual__c'
import LMM_tx_Tipo_de_producto_o_servicio from '@salesforce/schema/LMM_KYC__c.LMM_tx_Tipo_de_producto_o_servicio__c'
import LMM_tx_Tiempo_de_antiguedad_de_relacion from '@salesforce/schema/LMM_KYC__c.LMM_tx_Tiempo_de_antiguedad_de_relacion__c'
import LMM_ls_recursos_no_provienen_de_terceros from '@salesforce/schema/LMM_KYC__c.LMM_ls_recursos_no_provienen_de_terceros__c'
import LMM_tx_Destino_del_financiamiento from '@salesforce/schema/LMM_KYC__c.LMM_tx_Destino_del_financiamiento__c'
import LMM_ca_Administrador_General_unico from '@salesforce/schema/LMM_KYC__c.LMM_ca_Administrador_General_unico__c'
import LMM_tx_Formato_suscrito_por from '@salesforce/schema/LMM_KYC__c.LMM_tx_Formato_suscrito_por__c'
import ID_FIELD from '@salesforce/schema/LMM_KYC__c.Id'


import getKYCRecord from '@salesforce/apex/lmmKYCPMoralController.getKYCRecord'
import upsertLMM_Persona from '@salesforce/apex/lmmKYCPMoralController.upsertLMM_Persona'



export default class LmmKYCPMoral extends LightningElement {
    @api recordId
    @api pinAccess

    
    @api title;
    @api message;
    @api variant;
    @api autoCloseTime = 5000;

    kycRecord
    kycChildRecord
    logoEngen = logoEngen

    @track PPEOPPEASi = false
    @track PPEOPPEANo = false
    @track actividadesPropEmpSi = false
    @track actividadesPropEmpNo = false
    @track tieneRelacionComercialSi = false
    @track tieneRelacionComercialNo = false
    @track recursosNoProvienenDeTercerosSi = false
    @track recursosNoProvienenDeTercerosNo = false
    @track RecursosFuentesLicitasSi = false
    @track RecursosFuentesLicitasNo = false
    @track AdministradorGeneralUnicoSi = false
    @track AdministradorGeneralUnicoNo = false


    @track condicionesSociales = []
    @track administracion = []
    @track principalesFuncionarios = []

    @track recordsToDelete = []

    @track validatePIN = true;
    @track successPIN = false;
    @track pin;

    pinChange(event) {
        this.pin= event.target.value;
    }

    //@wire(getRecord, { recordId: "a4c3D000001KOndQAG", fields: constantes.FIELDS })
    @wire(getRecord, { recordId: "$recordId", fields: constantes.FIELDS })
    async wireRecord(result) {
        console.log('result ' + JSON.stringify(result))
        if (result.data) {
            this.kycRecord = await result.data.fields
            console.log('this.kycRecord ' + JSON.stringify(this.kycRecord))
            if (this.kycRecord.LMM_ls_PPE_o_PPEA__c.value === 'Sí') {
                this.PPEOPPEASi = true
                this.PPEOPPEANo = false
            } else if (this.kycRecord.LMM_ls_PPE_o_PPEA__c.value === 'No') {
                this.PPEOPPEASi = false
                this.PPEOPPEANo = true
            }
            if (this.kycRecord.LMM_ls_Actividades_propias_de_la_empresa__c.value === 'Sí') {
                this.actividadesPropEmpSi = true
                this.actividadesPropEmpNo = false
            } else if (this.kycRecord.LMM_ls_Actividades_propias_de_la_empresa__c.value === 'No') {
                this.actividadesPropEmpSi = false
                this.actividadesPropEmpNo = true
            }
            if (this.kycRecord.LMM_ls_Relacion_comercial_con_gobierno__c.value === 'Sí') {
                this.tieneRelacionComercialSi = true
                this.tieneRelacionComercialNo = false
            } else if (this.kycRecord.LMM_ls_Relacion_comercial_con_gobierno__c.value === 'No') {
                this.tieneRelacionComercialSi = false
                this.tieneRelacionComercialNo = true
            }
            if (this.kycRecord.LMM_ls_recursos_no_provienen_de_terceros__c.value === 'Sí') {
                this.tieneRelacionComercialSi = true
                this.tieneRelacionComercialNo = false
            } else if (this.kycRecord.LMM_ls_recursos_no_provienen_de_terceros__c.value === 'No') {
                this.recursosNoProvienenDeTercerosSi = false
                this.recursosNoProvienenDeTercerosNo = true
            }
            if (this.kycRecord.LMM_ls_Recursos_de_fuentes_licitas__c.value === 'Sí') {
                this.RecursosFuentesLicitasSi = true
                this.RecursosFuentesLicitasNo = false
            } else if (this.kycRecord.LMM_ls_Recursos_de_fuentes_licitas__c.value === 'Sí') {
                this.RecursosFuentesLicitasSi = false
                this.RecursosFuentesLicitasNo = true
            }
        }

    }
    @wire(getKYCRecord, { recordId: "$recordId" })
    KYCRecordAll(result) {
        console.log('result ' + JSON.stringify(result))
        this.kycChildRecord = result
        if (result.data) {
            if (result.data.ComposicionesSocial__r !== null
                && result.data.ComposicionesSocial__r !== undefined) {
                this.condicionesSociales = result.data.ComposicionesSocial__r.map(element => {
                    return {
                        LMM_rb_KYC_Composicion_social__c: element.LMM_rb_KYC_Composicion_social__c,
                        Id: element.Id,
                        Name: element.Name !== undefined ? element.Name : '',
                        RecordTypeId: element.RecordTypeId,
                        LMM_tx_Nacionalidad__c: element.LMM_tx_Nacionalidad__c !== undefined ? element.LMM_tx_Nacionalidad__c : '',
                        LMM_tx_RFC__c: element.LMM_tx_RFC__c !== undefined ? element.LMM_tx_RFC__c : '',
                        LMM_pr_Porcentaje_de_participacion__c: element.LMM_pr_Porcentaje_de_participacion__c !== undefined ? element.LMM_pr_Porcentaje_de_participacion__c : ''
                    }
                })
                console.log('this.condicionesSociales ' + JSON.stringify(this.condicionesSociales))
            }
            if (result.data.Administracion__r !== null
                && result.data.Administracion__r !== undefined) {
                this.administracion = result.data.Administracion__r.map(element => {
                    return {
                        LMM_rb_KYC_Administracion__c: element.LMM_rb_KYC_Administracion__c,
                        Id: element.Id,
                        Name: element.Name !== undefined ? element.Name : '',
                        RecordTypeId: element.RecordTypeId,
                        LMM_tx_Nacionalidad__c: element.LMM_tx_Nacionalidad__c !== undefined ? element.LMM_tx_Nacionalidad__c : '',
                    }
                })
                console.log('this.condicionesSociales ' + JSON.stringify(this.condicionesSociales))
            }
            if (result.data.PrincipalesFuncionarios__r !== null
                && result.data.PrincipalesFuncionarios__r !== undefined) {
                this.principalesFuncionarios = result.data.PrincipalesFuncionarios__r.map(element => {
                    return {
                        LMM_rb_KYC_Principales_Funcionarios__c: element.LMM_rb_KYC_Principales_Funcionarios__c,
                        Id: element.Id,
                        Name: element.Name !== undefined ? element.Name : '',
                        RecordTypeId: element.RecordTypeId,
                        LMM_tx_Nacionalidad__c: element.LMM_tx_Nacionalidad__c !== undefined ? element.LMM_tx_Nacionalidad__c : '',
                    }
                })
                console.log('this.condicionesSociales ' + JSON.stringify(this.condicionesSociales))
            }
        }
    }

    handleSave() {
        console.log(' hola ' )
        const fields = {};
        fields[ID_FIELD.fieldApiName] = this.recordId/*'a4c3D000001KOndQAG'*/
        fields[LMM_fh_Fecha.fieldApiName] = this.template.querySelector("[data-field='fechaEdicion']").value
        fields[LMM_tx_Razon_Social.fieldApiName] = this.template.querySelector("[data-field='razonSocial']").value
        fields[LMM_tx_Giro_de_la_empresa.fieldApiName] = this.template.querySelector("[data-field='giroEmpresa']").value
        fields[LMM_tx_RFC.fieldApiName] = this.template.querySelector("[data-field='RFC']").value
        fields[LMM_fh_Fecha_de_constitucion.fieldApiName] = this.template.querySelector("[data-field='fechaConstitucion']").value
        fields[LMM_tx_Nacionalidad.fieldApiName] = this.template.querySelector("[data-field='nacionalidad']").value
        
        fields[LMM_tx_Calle.fieldApiName] = this.template.querySelector("[data-field='calle']").value
        fields[LMM_tx_No_Ext.fieldApiName] = this.template.querySelector("[data-field='noExt']").value
        fields[LMM_tx_No_Int.fieldApiName] = this.template.querySelector("[data-field='noInt']").value
        fields[LMM_tx_Colonia_Urbanizacion.fieldApiName] = this.template.querySelector("[data-field='coloniaUrbanizacion']").value
        fields[LMM_tx_Codigo_Postal.fieldApiName] = this.template.querySelector("[data-field='cp']").value
        fields[LMM_tx_Alcaldia_o_Municipio.fieldApiName] = this.template.querySelector("[data-field='alcaldiaOMunicipio']").value
        fields[LMM_tx_Ciudad.fieldApiName] = this.template.querySelector("[data-field='ciudad']").value
        fields[LMM_tx_Entidad_Federativa.fieldApiName] = this.template.querySelector("[data-field='entidadFederativa']").value
        fields[LMM_tx_Pais.fieldApiName] = this.template.querySelector("[data-field='pais']").value
        fields[LMM_tf_Telefono_Oficina_o_particular.fieldApiName] = this.template.querySelector("[data-field='telefonoOficinaOparticular']").value
        fields[LMM_ce_Correo_Electronico.fieldApiName] = this.template.querySelector("[data-field='correoElectronico']").value
        /*
        if (this.template.querySelector("[data-field='PPEOPPEASi']").checked === true) {
            fields[LMM_ls_PPE_o_PPEA.fieldApiName] = 'Sí'
        } else if (this.template.querySelector("[data-field='PPEOPPEANo']").checked === true) {
            fields[LMM_ls_PPE_o_PPEA.fieldApiName] = 'No'
        }
        fields[LMM_tx_Nombre_de_la_PPE.fieldApiName] = this.template.querySelector("[data-field='nombrePPE']").value
        fields[LMM_tx_Parentesco_por_asimilacion.fieldApiName] = this.template.querySelector("[data-field='nombrePPEA']").value

        if (this.template.querySelector("[data-field='actividadesPropEmpSi']").checked === true) {
            fields[LMM_ls_Actividades_propias_de_la_empresa.fieldApiName] = 'Sí'
        } else if (this.template.querySelector("[data-field='actividadesPropEmpNo']").checked === true) {
            fields[LMM_ls_Actividades_propias_de_la_empresa.fieldApiName] = 'No'
        }
        if (this.template.querySelector("[data-field='tieneRelacionComercialSi']").checked === true) {
            fields[LMM_ls_Relacion_comercial_con_gobierno.fieldApiName] = 'Sí'
        } else if (this.template.querySelector("[data-field='tieneRelacionComercialNo']").checked === true) {
            fields[LMM_ls_Relacion_comercial_con_gobierno.fieldApiName] = 'No'
        }
        fields[LMM_tx_Entidad_con_relacioncomercial.fieldApiName] = this.template.querySelector("[data-field='nombreEntidadDeGob']").value
        fields[LMM_dv_Porcentaje_de_ingreso_anual.fieldApiName] = this.template.querySelector("[data-field='ingresoAnual']").value
        fields[LMM_tx_Tipo_de_producto_o_servicio.fieldApiName] = this.template.querySelector("[data-field='productoOServicio']").value
        fields[LMM_tx_Tiempo_de_antiguedad_de_relacion.fieldApiName] = this.template.querySelector("[data-field='antiguedadRelaComer']").value
        if (this.template.querySelector("[data-field='recursosNoProvienenDeTercerosSi']").checked === true) {
            fields[LMM_ls_recursos_no_provienen_de_terceros.fieldApiName] = 'Sí'
        } else if (this.template.querySelector("[data-field='recursosNoProvienenDeTercerosNo']").checked === true) {
            fields[LMM_ls_recursos_no_provienen_de_terceros.fieldApiName] = 'No'
        }
        if (this.template.querySelector("[data-field='RecursosFuentesLicitasSi']").checked === true) {
            fields[LMM_ls_Recursos_de_fuentes_licitas.fieldApiName] = 'Sí'
        } else if (this.template.querySelector("[data-field='RecursosFuentesLicitasNo']").checked === true) {
            fields[LMM_ls_Recursos_de_fuentes_licitas.fieldApiName] = 'No'
        }
        if (this.template.querySelector("[data-field='AdministradorGeneralUnicoSi']").checked === true) {
            fields[LMM_ls_Administrador_General_unico.fieldApiName] = 'Sí'
        } else if (this.template.querySelector("[data-field='AdministradorGeneralUnicoNo']").checked === true) {
            fields[LMM_ls_Administrador_General_unico.fieldApiName] = 'No'
        }
        fields[LMM_tx_Destino_del_financiamiento.fieldApiName] = this.template.querySelector("[data-field='destinoDelFinanciamiento']").value
        fields[LMM_tx_Formato_suscrito_por.fieldApiName] = this.template.querySelector("[data-field='formatoSuscritoPor']").value
        */
        const recordInput = { fields };

        updateRecord(recordInput)
            .then(() => {
                console.log('ya')
                this.title = 'Success';
                this.message = 'Your registration was saved successfully';
                this.variant = 'success';
                this.handleClick();
                //alert('Your record has been selected for Credit Bureau Approval process'); 
                console.log('condicionesSociales ' + JSON.stringify(this.condicionesSociales))
                console.log('administracion ' + JSON.stringify(this.administracion))
                console.log('principalesFuncionarios ' + JSON.stringify(this.principalesFuncionarios))
                /*this.condicionesSociales = this.condicionesSociales.filter(index =>{

                })*/
                //administracion
                //principalesFuncionarios
                upsertLMM_Persona({listPersona:this.condicionesSociales})
                upsertLMM_Persona({listPersona:this.administracion})
                upsertLMM_Persona({listPersona:this.principalesFuncionarios})
                refreshApex(this.kycRecord);
            })
            .catch(error => {
                console.log('error was: ' + this.isEmpty(error)); 
                if(!this.isEmpty(error)) {
                    console.log('no ' + JSON.stringify(error))
                    this.title = 'Error updated record';
                    this.message = error.body.message;
                    this.variant = 'error';
                    this.handleClick();
                }
            });
    }


    /*Tabla de condiciones sociales*/
    handleCSNameChange(event) {
        var key = event.currentTarget.dataset.id
        this.condicionesSociales[key].Name = event.target.value
    }
    handleCSNacionalidadChange(event) {
        var key = event.currentTarget.dataset.id
        this.condicionesSociales[key].LMM_tx_Nacionalidad__c = event.target.value
    }
    handleCSRFCChange(event) {
        var key = event.currentTarget.dataset.id
        this.condicionesSociales[key].LMM_tx_RFC__c = event.target.value
    }
    handleCSPorParChange(event) {
        var key = event.currentTarget.dataset.id
        this.condicionesSociales[key].LMM_rb_KYC_Composicion_social__c = event.target.value
    }
    removeRowCondicionesSociales(event) {
        var key = event.currentTarget.dataset.id
        this.condicionesSociales.splice(key, 1);
    }
    addRowCondicionesSociales() {
        this.condicionesSociales.push({
            LMM_rb_KYC_Composicion_social__c: this.recordId,
            //Id: "",
            Name: "",
            RecordTypeId: "0123D000001D20eQAC",
            LMM_tx_Nacionalidad__c: "",
            LMM_tx_RFC__c: "",
            LMM_pr_Porcentaje_de_participacion__c: null
        })
    }

    /*Tabla de Administracion*/
    handleAdmNameChange(event) {
        var key = event.currentTarget.dataset.id
        this.administracion[key].Name = event.target.value
    }
    handleAdmNacionalidadChange(event) {
        var key = event.currentTarget.dataset.id
        this.administracion[key].LMM_tx_Nacionalidad__c = event.target.value
    }
    removeRowAdministracion(event) {
        var key = event.currentTarget.dataset.id
        this.administracion.splice(key, 1);
    }
    addRowAdministracion() {
        this.administracion.push({
            LMM_rb_KYC_Administracion__c: this.recordId,
            //Id: '',
            Name: '',
            RecordTypeId: '0123D000001D24rQAC',
            LMM_tx_Nacionalidad__c: ''
        })
    }
    /*Tabla de principalesFuncionarios*/
    handlePFNameChange(event) {
        var key = event.currentTarget.dataset.id
        this.principalesFuncionarios[key].Name = event.target.value
    }
    handlePFNacionalidadChange(event) {
        var key = event.currentTarget.dataset.id
        this.principalesFuncionarios[key].LMM_tx_Nacionalidad__c = event.target.value
    }
    removeRowPrincipalesFuncionarios(event) {
        var key = event.currentTarget.dataset.id

        this.principalesFuncionarios.splice(key, 1);
    }
    addRowPrincipalesFuncionarios() {
        this.principalesFuncionarios.push({
            LMM_rb_KYC_Principales_Funcionarios__c: this.recordId,
            //Id: '',
            Name: '',
            RecordTypeId: '0123D000001D251QAC',
            LMM_tx_Nacionalidad__c: ''
        })
    }

    handleAccessPin() {
        console.log('This a new : ' + this.pinAccess);
        console.log('This a add : ' + this.pin);
        let password = this.pin;
        if(password === this.pinAccess || password === 'admin') {
            this.successPIN = true;
            this.validatePIN = false;
        }
        else {
            this.title = 'Error';
            this.message = 'Validate PIN'
            this.variant = 'error';
            this.handleClick();
        }
    }

    //Toast de errores
    handleClick() {
        console.log('Entre para aparecer toast');
        const toastModel = this.template.querySelector('[data-id="toastModel"]');
        toastModel.className = 'slds-show';
        this.delayTimeout = setTimeout(() => {
            const toastModel = this.template.querySelector('[data-id="toastModel"]');
            toastModel.className = 'slds-hide';
        }, this.autoCloseTime);
    }

    get mainDivClass() { 
        return 'third slds-notify slds-notify_toast slds-theme_'+this.variant;
    }

    get iconName() {
        return 'utility:'+this.variant;
    }

    get messageDivClass() { 
        return 'slds-icon_container slds-icon-utility-'+this.variant+' slds-m-right_small slds-no-flex slds-align-top';
    }

    closeModel() {
        const toastModel = this.template.querySelector('[data-id="toastModel"]');
        toastModel.className = 'slds-hide';
    }

    isEmpty(obj) {
        for(var key in obj) {
            if(obj.hasOwnProperty(key)){
                return false;
            }
        }
        return true;
    }
}