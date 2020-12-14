/* eslint-disable @lwc/lwc/no-async-operation */
/**
 * @File Name          : takedownDocsSupplier.js
 * @Description        :
 * @Author             : Merari Contreras
 * @Group              :
 * @Last Modified By   : juandedios.hernandez@engeniumcapital.com
 * @Last Modified On   : 2/12/2019 10:38:08
 * @Modification Log   :
 * Ver       Date            Author      		    Modification
 * 1.0    11/4/2019   Merari Contreras            Initial Version
 **/
import { LightningElement, api, wire, track } from "lwc";
import getKey from "@salesforce/apex/DataAccessEncriptationkeysmdt.getEncriptationDocumentsV2";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
//import getSupplierInTKD from '@salesforce/apex/Data_Access_SuppliersInTakedown_cls.supplierInTKD';
import getGeneral from "@salesforce/apex/Data_Access_SuppliersInTakedown_cls.generalTKD";
//import getidSupplierInApp from '@salesforce/apex/Data_Access_SuppliersInTakedown_cls.idSupplierInApp';
import getUrl from "@salesforce/apex/MetadataUrls.getUrlDocs";
import { CryptoJS } from "c/criptojs";
import { getRecord } from "lightning/uiRecordApi";
import USER_ID from "@salesforce/user/Id";
import SSO_FIELD from "@salesforce/schema/User.EmployeeNumber";
import USERSNAME from "@salesforce/schema/User.Name";
import getToken from "@salesforce/apex/Takedown_WS_Tollgate_cls.getToken";
import requestToContent from "@salesforce/apex/TKD_ChecklistTolgate1Controller.requestToContent";
const FIELDS = [
  "Takedowns_Contingency_plan__c.CPL_rb_Opp__c",
  "Takedowns_Contingency_plan__c.Name",
  "Takedowns_Contingency_plan__c.TKD_ls_takedown_stage__c",
  "Takedowns_Contingency_plan__c.TKD_Suppilers_Documents__c"
];
import ID_FIELD from "@salesforce/schema/Takedowns_Contingency_plan__c.Id";
import SUPPILERSDOCS from "@salesforce/schema/Takedowns_Contingency_plan__c.TKD_Suppilers_Documents__c";
import { updateRecord } from "lightning/uiRecordApi";
import validateSuppDocsts from "@salesforce/apex/TKD_ChecklistTolgate1Controller.validateSuppDocs";
import { CurrentPageReference } from "lightning/navigation";
import { fireEvent } from "c/pubsub";

export default class TakedownDocsSupplier extends LightningElement {
  @api recordId;
  @api docshowModal;
  @track url;
  @track urlContent;
  @track datos;
  @track typeProcessId = "12";
  @track processName = "TAKEDOWN SUPPLIERS";
  @track userSSO;
  @track userName;
  @track key;
  @track error;
  @track errore;
  @track suppilersDocuments;
  @track progress = 0;
  @track isProgressing = false;

  @wire(CurrentPageReference) pageRef;

  @wire(getRecord, { recordId: USER_ID, fields: [SSO_FIELD, USERSNAME] })
  wireuser({ error, data }) {
    if (error) {
      alert("error al cargar ssso");
    } else if (data) {
      this.userSSO = data.fields.EmployeeNumber.value;
      console.log(`userSSO track Recor: ${this.userSSO}`);
      this.userName = data.fields.Name.value;
    }
  }

  @wire(getRecord, { recordId: "$recordId", fields: FIELDS })
  async wiredRecord({ error, data }) {
    if (error) {
      console.log("el error");
      console.log(error);
      let message = "Unknown error";
      if (Array.isArray(error.body)) {
        message = error.body.map(e => e.message).join(", ");
      } else if (typeof error.body.message === "string") {
        message = error.body.message;
      }
      this.dispatchEvent(
        new ShowToastEvent({
          title: "Error loading Takdown",
          message,
          variant: "error"
        })
      );
    } else if (data) {
      console.log("ladata");
      this.takedown = await data;
      this.takedownName = await this.takedown.fields.Name.value;
      console.log(`Takedown name: ${this.takedownName}`);
      this.suppilersDocuments = await this.takedown.fields
        .TKD_Suppilers_Documents__c.value;
      console.log(`suppilers documments: ${this.suppilersDocuments}`);

      await getKey()
        .then(result => {
          console.log("TRALLENDO KEY");
          this.key = result;
          console.log(this.key);
          this.error = undefined;
        })
        .catch(errKey => {
          this.error = errKey;
          this.key = undefined;
        });

      await getUrl()
        .then(result => {
          console.log("TRALLENDO URL mer");
          this.url = result;
          console.log(this.url);
          this.errore = undefined;
        })
        .catch(errorUrl => {
          this.errore = errorUrl;
          this.url = undefined;
        });

      console.log("OPEN URL OO");
      this.isProgressing = true;
      this._interval = await setInterval(() => {
        this.progress = this.progress === 100 ? 100 : this.progress + 1;
      }, await this.openUrl());
    }
  }

  async openUrl() {
    let messageStructureArr = await this.getDatos();
    let messageStructure = messageStructureArr.map((val, index) => {
      return {
        //identifier: val.Id,
        name: val.Name,
        rfc: val.TKD_tx_Vat_Registration_Num__c,
        type: 1, //"SUPPILERS",
        //customerType:"ORGANIZATION",
        //customerId:val.Id,
        person: 1
      };
    });

    // creacion de metodo para obtener id

    // fin de creacion de metodo para obtener id

    this.datos = {
      userId: this.userSSO,
      userName:  this.userName,
      typeProcessId: this.typeProcessId,
      processName: this.processName,
      processFKId: this.takedownName,
      identifiers: messageStructure
    };

    // eslint-disable-next-line no-console

    console.log(`JSON RM:  ${JSON.stringify(this.datos)}`);
    let token;
    try{
      token = await getToken();
    }catch(errortoken){
      console.log('error al consultar token');
      this.dispatchEvent(
        new ShowToastEvent({
          title: "Error to get token content",
          message: errortoken,
          variant: "error"
        })
      );
    }
    let key = JSON.parse(token);

    let encrypted = CryptoJS.AES.encrypt(
      JSON.stringify(this.datos),
       key.token
    );
    let encriptedString = encodeURIComponent(encrypted.toString());
    this.urlContent = this.url + encriptedString + "&id="+key.token;
    console.log(`this.urlContent ${this.urlContent}`);

    try {
      this.validateSuppilerDocs(JSON.stringify(this.datos));
    } catch (errcatch) {
      console.log(`Eroor: ${errcatch}`);
    }
  }

  getDatos() {
    console.log(`this.recordId:  ${this.recordId}`);
    return new Promise((resolve, reject) => {
      getGeneral({ paramRecordId: this.recordId })
        .then(result => {
          console.log(result);
          resolve(result);
        })
        .catch(error => {
          console.log(error);
          reject(new Error(JSON.stringify(error)));
        });
    });
  }

  async validateSuppilerDocs(encriptedData) {
    let jStolgate = await requestToContent({ encritpData: encriptedData });
    let tolgate = JSON.parse(jStolgate);
    console.log("TOLGATE SUPPILERS");
    console.log(tolgate);

    if ((tolgate.identifiers !== undefined) & (tolgate.identifiers !== null)) {
      let contentValues = tolgate.identifiers.map(val => {
        val.processFiles.forEach(file => {
          file.entidad = val.name;
        });

        return val.processFiles;
      });

      let contentDocs = [];

      contentValues.forEach(row => {
        row.forEach(col => {
          contentDocs.push(col);
        });
      });

      let requiredVilations = contentDocs.filter(
        ({ required, isValid }) => (required === 1) & (isValid === 0)
      );
      console.log("DOCUMENTOS FALTANTES PARA SUPPILERS");
      console.log(requiredVilations);

      if (requiredVilations.length === 0 && this.suppilersDocuments === false) {
        /*  const fields = {};
                    fields[ID_FIELD.fieldApiName] = this.recordId;
                    fields[SUPPILERSDOCS.fieldApiName] = true;
                    const recordInput = { fields };
                    updateRecord(recordInput)
                    .catch(errupdate=>{
                        console.log(errupdate);
                    }) */
        validateSuppDocsts({ recordId: this.recordId, validation: true }).catch(
          errupdate => {
            console.log(errupdate);
          }
        );
      } else if (
        requiredVilations.length > 0 &&
        this.suppilersDocuments === true
      ) {
        /* const fields = {};
                    fields[ID_FIELD.fieldApiName] = this.recordId;
                    fields[SUPPILERSDOCS.fieldApiName] = false;
                    const recordInput = { fields };
                    updateRecord(recordInput)
                    .catch(errupdate=>{
                        console.log(errupdate);
                    }) */
        validateSuppDocsts({
          recordId: this.recordId,
          validation: false
        }).catch(errupdate => {
          console.log(errupdate);
        });
      }
    } else {
      throw Error(
        "Error al Consultar el tolgate Para validación de Documentos"
      );
    }
  }

  closeModal() {
    // to close modal window set 'docshowModal' tarck value as false
    this.docshowModal = false;
    const closemodalEvent = new CustomEvent("closedocsmodal");
    this.dispatchEvent(closemodalEvent);

    console.log("se dispara el evento");
    fireEvent(this.pageRef, "validasup", {detail:'fired validation suppliers'});
  }

  get computedLabel() {
    return this.isProgressing
      ? "Validating Documents" + this.progress + "%"
      : "Starting";
  }
}