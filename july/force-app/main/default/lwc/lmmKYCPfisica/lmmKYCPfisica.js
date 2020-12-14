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
import { getRecord, createRecord, updateRecord } from 'lightning/uiRecordApi'
import constantes from './helperJS/constantes'
import Name from '@salesforce/schema/LMM_KYC__c.Name';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import logoEngen from '@salesforce/resourceUrl/logoEngen';

//import Name from '@salesforce/schema/LMM_KYC__c.Name'
import LMM_rb_Opportunity from '@salesforce/schema/LMM_KYC__c.LMM_rb_Opportunity__c'
import LMM_ls_Estatus from '@salesforce/schema/LMM_KYC__c.LMM_ls_Estatus__c'
import LMM_fh_Fecha from '@salesforce/schema/LMM_KYC__c.LMM_fh_Fecha__c'
import LMM_tx_Nombre_Completo_sin_abreviaturas from '@salesforce/schema/LMM_KYC__c.LMM_tx_Nombre_Completo_sin_abreviaturas__c'
import LMM_tx_Profesion_u_Ocupacion from '@salesforce/schema/LMM_KYC__c.LMM_tx_Profesion_u_Ocupacion__c'
import LMM_tx_RFC from '@salesforce/schema/LMM_KYC__c.LMM_tx_RFC__c'
import LMM_tx_CURP from '@salesforce/schema/LMM_KYC__c.LMM_tx_CURP__c'
import LMM_fh_Fecha_de_Nacimiento from '@salesforce/schema/LMM_KYC__c.LMM_fh_Fecha_de_Nacimiento__c'
import LMM_tx_Nacionalidad from '@salesforce/schema/LMM_KYC__c.LMM_tx_Nacionalidad__c'
import LMM_ls_Genero from '@salesforce/schema/LMM_KYC__c.LMM_ls_Genero__c'
import LMM_ls_Estado_Civil from '@salesforce/schema/LMM_KYC__c.LMM_ls_Estado_Civil__c'
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
import LMM_ls_Persona_Politicamente_Expuesta from '@salesforce/schema/LMM_KYC__c.LMM_ls_Persona_Politicamente_Expuesta__c'
import LMM_tx_Persona_Expuesta_Puesto from '@salesforce/schema/LMM_KYC__c.LMM_tx_Persona_Expuesta_Puesto__c'
import LMM_ls_PPE_por_Asimilacion from '@salesforce/schema/LMM_KYC__c.LMM_ls_PPE_por_Asimilacion__c'
import LMM_tx_Nombre_de_la_PPE from '@salesforce/schema/LMM_KYC__c.LMM_tx_Nombre_de_la_PPE__c'
import LMM_tx_Parentesco_por_asimilacion from '@salesforce/schema/LMM_KYC__c.LMM_tx_Parentesco_por_asimilacion__c'
import LMM_ls_Actividades_de_su_empleo_u_ocu from '@salesforce/schema/LMM_KYC__c.LMM_ls_Actividades_de_su_empleo_u_ocu__c'
import LMM_ls_Relacion_comercial_con_gobierno from '@salesforce/schema/LMM_KYC__c.LMM_ls_Relacion_comercial_con_gobierno__c'
import LMM_tx_Entidad_con_relacioncomercial from '@salesforce/schema/LMM_KYC__c.LMM_tx_Entidad_con_relacioncomercial__c'
import LMM_dv_Porcentaje_de_ingreso_anual from '@salesforce/schema/LMM_KYC__c.LMM_dv_Porcentaje_de_ingreso_anual__c'
import LMM_ls_Recursos_de_fuentes_licitas from '@salesforce/schema/LMM_KYC__c.LMM_ls_Recursos_de_fuentes_licitas__c'
import LMM_tx_Formato_suscrito_por from '@salesforce/schema/LMM_KYC__c.LMM_tx_Formato_suscrito_por__c'
import LMM_ca_Actua_en_representacion from '@salesforce/schema/LMM_KYC__c.LMM_ca_Actua_en_representacion__c'
import LMM_tx_Escritura_Publica from '@salesforce/schema/LMM_KYC__c.LMM_tx_Escritura_Publica__c'
import LMM_fh_De_Fecha from '@salesforce/schema/LMM_KYC__c.LMM_fh_De_Fecha__c'
import LMM_tx_Ante_El_Notario from '@salesforce/schema/LMM_KYC__c.LMM_tx_Ante_El_Notario__c'
import LMM_tx_Con_Numero from '@salesforce/schema/LMM_KYC__c.LMM_tx_Con_Numero__c'
import LMM_tx_De_La_Ciudad_De from '@salesforce/schema/LMM_KYC__c.LMM_tx_De_La_Ciudad_De__c'
import LMM_tx_Inscripcion_En_El_R_P_C from '@salesforce/schema/LMM_KYC__c.LMM_tx_Inscripcion_En_El_R_P_C__c'
import ID_FIELD from '@salesforce/schema/LMM_KYC__c.Id'

export default class LmmKYCPfisica extends LightningElement { 
    @api recordId
    @api pinAccess

    @api title;
    @api message;
    @api variant;
    @api autoCloseTime = 5000;

    kycRecord
    logoEngen = logoEngen
    @track generoM
    @track generoF
    @track estadoCivilC = false
    @track estadoCivilS = false
    @track ppExpuestaSi = false
    @track ppExpuestaNo = false
    @track ppExpuestaAsimilacionSi = false
    @track ppExpuestaAsimilacionNo = false
    @track actividadesPropEmpSi = false
    @track actividadesPropEmpNo = false
    @track tieneRelacionComercialSi = false
    @track tieneRelacionComercialNo = false
    @track RecursosFuentesLicitasSi = false
    @track RecursosFuentesLicitasNo = false

    @track validatePIN = true;
    @track successPIN = false;
    @track pin;

    pinChange(event) {
        this.pin= event.target.value;
    }

    //@wire(getRecord, { recordId: "a4c3D000001KOndQAG", fields: constantes.FIELDS })
    @wire(getRecord, { recordId: '$recordId', fields: constantes.FIELDS })
    async wireRecord(result) {
        console.log('recordId ' + this.recordId)
        console.log('result ' + JSON.stringify(result))
        if (result.data) {
            this.kycRecord = await result.data.fields
            if (await this.kycRecord.LMM_ls_Genero__c.value === 'Masculino') {
                this.generoM = true
                this.generoF = false
            } else if (this.kycRecord.LMM_ls_Genero__c.value === 'Femenino') {
                this.generoM = false
                this.generoF = true
            }
            if (this.kycRecord.LMM_ls_Estado_Civil__c.value === 'Casado') {
                this.estadoCivilC = true
                this.estadoCivilS = false
            } else if (this.kycRecord.LMM_ls_Estado_Civil__c.value === 'Soltero') {
                this.estadoCivilC = false
                this.estadoCivilS = true
            }
            if (this.kycRecord.LMM_ls_Persona_Politicamente_Expuesta__c.value === 'Sí') {
                this.ppExpuestaSi = true
                this.ppExpuestaNo = false
            } else if (this.kycRecord.LMM_ls_Persona_Politicamente_Expuesta__c.value === 'No') {
                this.ppExpuestaSi = false
                this.ppExpuestaNo = true
            }
            if (this.kycRecord.LMM_ls_PPE_por_Asimilacion__c.value === 'Sí') {
                this.ppExpuestaAsimilacionSi = true
                this.ppExpuestaAsimilacionNo = false
            } else if (this.kycRecord.LMM_ls_PPE_por_Asimilacion__c.value === 'No') {
                this.ppExpuestaAsimilacionSi = false
                this.ppExpuestaAsimilacionNo = true
            }
            if (this.kycRecord.LMM_ls_Actividades_de_su_empleo_u_ocu__c.value === 'Sí') {
                this.actividadesPropEmpSi = true
                this.actividadesPropEmpNo = false
            } else if (this.kycRecord.LMM_ls_Actividades_de_su_empleo_u_ocu__c.value === 'No') {
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
            if(this.kycRecord.LMM_ls_Recursos_de_fuentes_licitas__c.value === 'Sí') {
                this.RecursosFuentesLicitasSi = true
                this.RecursosFuentesLicitasNo = false
            } else if(this.kycRecord.LMM_ls_Recursos_de_fuentes_licitas__c.value === 'Sí') {
                this.RecursosFuentesLicitasSi = false
                this.RecursosFuentesLicitasNo = true
            }
            
        } else if (result.error) {
            console.log('error ' + JSON.stringify(error))
        }
    }
    handleUncheck() {
        if (this.template.querySelector("[data-field='acutaEnRepresentacion']").checked === true) {
            this.template.querySelector("[data-field='acutaEnRepresentacion']").checked = false
        } else {
            this.template.querySelector("[data-field='acutaEnRepresentacion']").checked = true
        }

    }


    handleSave() {
        console.log(' hola ' + this.template.querySelector("[data-field='nombreCompleto']").value)
        const fields = {};
        fields[ID_FIELD.fieldApiName] = this.recordId//'a4c3D000001KOndQAG'
        fields[LMM_fh_Fecha.fieldApiName] = this.template.querySelector("[data-field='fechaEdicion']").value
        fields[LMM_tx_Nombre_Completo_sin_abreviaturas.fieldApiName] = this.template.querySelector("[data-field='nombreCompleto']").value
        fields[LMM_tx_Profesion_u_Ocupacion.fieldApiName] = this.template.querySelector("[data-field='profesionOcupacion']").value
        fields[LMM_tx_RFC.fieldApiName] = this.template.querySelector("[data-field='RFC']").value
        fields[LMM_tx_CURP.fieldApiName] = this.template.querySelector("[data-field='CURP']").value
        fields[LMM_fh_Fecha_de_Nacimiento.fieldApiName] = this.template.querySelector("[data-field='fechaNacimiento']").value
        fields[LMM_tx_Nacionalidad.fieldApiName] = this.template.querySelector("[data-field='nacionalidad']").value
        if (this.template.querySelector("[data-field='generoM']").checked === true) {
            fields[LMM_ls_Genero.fieldApiName] = 'Masculino'
        } else if (this.template.querySelector("[data-field='generoF']").checked === true) {
            fields[LMM_ls_Genero.fieldApiName] = 'Femenino'
        }
        if (this.template.querySelector("[data-field='estadoCivilC']").checked === true) {
            fields[LMM_ls_Estado_Civil.fieldApiName] = 'Casado'
        } else if (this.template.querySelector("[data-field='estadoCivilS']").checked === true) {
            fields[LMM_ls_Estado_Civil.fieldApiName] = 'Soltero'
        }
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

        if (this.template.querySelector("[data-field='ppExpuestaSi']").checked === true) {
            fields[LMM_ls_Persona_Politicamente_Expuesta.fieldApiName] = 'Sí'
        } else if (this.template.querySelector("[data-field='ppExpuestaNo']").checked === true) {
            fields[LMM_ls_Persona_Politicamente_Expuesta.fieldApiName] = 'No'
        }
        fields[LMM_tx_Persona_Expuesta_Puesto.fieldApiName] = this.template.querySelector("[data-field='ppExpuestaPuesto']").value
        if (this.template.querySelector("[data-field='ppExpuestaAsimilacionSi']").checked === true) {
            fields[LMM_ls_PPE_por_Asimilacion.fieldApiName] = 'Sí'
        } else if (this.template.querySelector("[data-field='ppExpuestaAsimilacionNo']").checked === true) {
            fields[LMM_ls_PPE_por_Asimilacion.fieldApiName] = 'No'
        }
        fields[LMM_tx_Nombre_de_la_PPE.fieldApiName] = this.template.querySelector("[data-field='nombrePPE']").value
        fields[LMM_tx_Parentesco_por_asimilacion.fieldApiName] = this.template.querySelector("[data-field='parentescoPorAsimilacion']").value
        if (this.template.querySelector("[data-field='actividadesPropEmpSi']").checked === true) {
            fields[LMM_ls_Actividades_de_su_empleo_u_ocu.fieldApiName] = 'Sí'
        } else if (this.template.querySelector("[data-field='actividadesPropEmpNo']").checked === true) {
            fields[LMM_ls_Actividades_de_su_empleo_u_ocu.fieldApiName] = 'No'
        }
        if (this.template.querySelector("[data-field='tieneRelacionComercialSi']").checked === true) {
            fields[LMM_ls_Relacion_comercial_con_gobierno.fieldApiName] = 'Sí'
        } else if (this.template.querySelector("[data-field='tieneRelacionComercialNo']").checked === true) {
            fields[LMM_ls_Relacion_comercial_con_gobierno.fieldApiName] = 'No'
        }
        fields[LMM_tx_Entidad_con_relacioncomercial.fieldApiName] = this.template.querySelector("[data-field='nombreEntidadDeGob']").value
        fields[LMM_dv_Porcentaje_de_ingreso_anual.fieldApiName] = this.template.querySelector("[data-field='ingresoAnual']").value
        
        if (this.template.querySelector("[data-field='RecursosFuentesLicitasSi']").checked === true) {
            fields[LMM_ls_Recursos_de_fuentes_licitas.fieldApiName]  = 'Sí'
        } else if (this.template.querySelector("[data-field='RecursosFuentesLicitasNo']").checked === true) {
            fields[LMM_ls_Recursos_de_fuentes_licitas.fieldApiName]  = 'No'
        }
        
        
        fields[LMM_tx_Formato_suscrito_por.fieldApiName] = this.template.querySelector("[data-field='suscritoPor']").value
        fields[LMM_ca_Actua_en_representacion.fieldApiName] = this.template.querySelector("[data-field='acutaEnRepresentacion']").checked
        fields[LMM_tx_Escritura_Publica.fieldApiName] = this.template.querySelector("[data-field='escrituraPNum']").value
        fields[LMM_fh_De_Fecha.fieldApiName] = this.template.querySelector("[data-field='deFecha']").value
        fields[LMM_tx_Ante_El_Notario.fieldApiName] = this.template.querySelector("[data-field='anteNotario']").value
        fields[LMM_tx_Con_Numero.fieldApiName] = this.template.querySelector("[data-field='conNumero']").value
        fields[LMM_tx_De_La_Ciudad_De.fieldApiName] = this.template.querySelector("[data-field='deLaCiudadDe']").value
        //fields[LMM_tx_Inscripcion_En_El_R_P_C.fieldApiName] = this.template.querySelector("[data-field='inscripRPC']").value

        const recordInput = { fields };

        updateRecord(recordInput)
            .then(() => {
                console.log('ya')
                this.title = 'Success';
                this.message = 'Your registration was saved successfully';
                this.variant = 'success';
                this.handleClick();
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