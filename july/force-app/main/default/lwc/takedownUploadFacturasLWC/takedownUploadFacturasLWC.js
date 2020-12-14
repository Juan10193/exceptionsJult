/**
 * @File Name          : takedownUploadFacturasLWC.js
 * @Description        : 
 * @Author             : eduardo.amiens@outlook.com
 * @Group              : 
 * @Last Modified By   : eduardo.amiens@outlook.com
 * @Last Modified On   : 07-15-2020
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      		      Modification
 *==============================================================================
 * 1.0    10/7/2019 0:00:21   jhernandez@anivia.mx     Initial Version
**/
import { LightningElement, api, wire, track } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import { fireEvent } from 'c/pubsub';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { loadStyle } from 'lightning/platformResourceLoader';
import Animate from '@salesforce/resourceUrl/Animate';
import insertInvoices from "@salesforce/apex/Takedown_Invoices_cls.insertInvoices"
import { getRecord } from 'lightning/uiRecordApi'
import constantes from './helperJS/constantes';

import getProfileCurrentUser from "@salesforce/apex/takedownTableDocumentsController_cls.getProfileCurrentUser"
import getTakedownVisibilityBlockAB from "@salesforce/apex/takedownTableDocumentsController_cls.getTakedownVisibilityBlockAB"


export default class TakedownUploadFacturasLWC extends LightningElement {
  @api recordId;
  @track disableUploadInvoices;

  @wire(CurrentPageReference) pageRef;

  @wire(getRecord, { recordId: "$recordId", fields: constantes.FIELDS })
  async wireRecord({ error, data }) {
    if (await data) {
      //obtiene el nombre del perfil del current user
      let currentProfileName = await getProfileCurrentUser()
      this.ButtonUnlockAndApproveShow = await getTakedownVisibilityBlockAB({ profileName: currentProfileName })
      //si tiene permisos para enviar a aprobar, se le bloquean los permisos para manipular invoices o ab
      if (this.ButtonUnlockAndApproveShow === false) {
        this.disableUploadInvoices = data.fields.TKD_ca_Block_invoices__c.value
      }
    } if (error) {
      console.log('error ' + error)
      console.log('error ' + JSON.stringify(error))
    }
  }

  get acceptedFormats() {
    return ['.pdf', '.xml'];
  }
  connectedCallback() {
    Promise.all([
      loadStyle(this, Animate)
    ]).then(() => { 'scripts cargadinos' });
  }

  handleUploadFinished(event) {
    // Get the list of uploaded files
    const uploadedFiles = event.detail.files;
    console.log(uploadedFiles);
    let contentfiles = [];
    for (let file of uploadedFiles) {
      contentfiles.push(file.documentId);
    }

    console.log('listaIDS CONTENT');
    console.log(contentfiles);

    insertInvoices({ recordId: this.recordId, contentDocumentIds: contentfiles })
      .then(result => {
        console.log('se insertaron los invoces de forma satisfactoria');
        fireEvent(this.pageRef, 'refreshtable');
        this.dispatchEvent(new ShowToastEvent({
          title: 'No. of files uploaded : ' + uploadedFiles.length,
          variant: 'info',
        }))
        eval("$A.get('e.force:refreshView').fire();");
      }).catch(errores => {
        let errorMessage = ''
        if (errores.body) {
          errores.body.pageErrors.forEach(element => {
            errorMessage += element.message + ' '
          });
        }
        console.log('errores ' + JSON.stringify(errores))
        this.dispatchEvent(
          new ShowToastEvent({
            title: "Error to insert invoices",
            message: errorMessage,
            variant: "error"
          })
        );
      })

  }

}