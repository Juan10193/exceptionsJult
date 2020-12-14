import filesaver from "@salesforce/resourceUrl/filesaver"

let initFields = (fields) => {
    console.log('fields ' + JSON.stringify(fields))
    this.template.querySelector("[data-field='fechaEdicion']").value = fields.LMM_fh_Fecha__c.value
    this.template.querySelector("[data-field='nombreCompleto']").value = fields.LMM_tx_Nombre_Completo_sin_abreviaturas__c.value
    this.template.querySelector("[data-field='profesionOcupacion']").value = fields.LMM_tx_Profesion_u_Ocupacion__c.value
    this.template.querySelector("[data-field='RFC']").value = fields.LMM_tx_RFC__c.value
    this.template.querySelector("[data-field='CURP']").value = fields.LMM_tx_CURP__c.value
    this.template.querySelector("[data-field='fechaNacimiento']").value = fields.LMM_fh_Fecha_de_Nacimiento__c.value
    this.template.querySelector("[data-field='nacionalidad']").value = fields.LMM_tx_Nacionalidad__c.value
    if(fields.LMM_ls_Genero__c.value === 'Masculino'){
       this.template.querySelector("[data-field='generoM']").checked = true
       this.template.querySelector("[data-field='generoF']").checked = false
    } else if(fields.LMM_ls_Genero__c.value === 'Femenino'){
       this.template.querySelector("[data-field='generoM']").checked = false
       this.template.querySelector("[data-field='generoF']").checked = true
    }
}


export {initFields};