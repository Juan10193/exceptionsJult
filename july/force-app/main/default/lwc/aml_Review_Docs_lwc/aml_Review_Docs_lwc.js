import { LightningElement, api, track, wire } from "lwc";
import { NavigationMixin } from "lightning/navigation";
import { getRecord } from "lightning/uiRecordApi";
import { refreshApex } from "@salesforce/apex";
import RECORD_TYPE_FIELD from "@salesforce/schema/Credit_approval_CP__c.RecordTypeId";
import getDocs from "@salesforce/apex/Aml_Review_cls.getAMLDocts";
import downloadDoctos from "@salesforce/apex/ES3_DocSInRequestCalloutClass.downloadDoctos";
import deleteDocto from "@salesforce/apex/ES3_DocSInRequestCalloutClass.deleteDocto";
import getsServiceUrl from "@salesforce/apex/ES3_DocSInRequestCalloutClass.getUrl";
import getUrlExterna from "@salesforce/apex/ES3_DocSInRequestCalloutClass.getUrlExterna";
import getUrlAppdocs from "@salesforce/apex/ES3_DocSInRequestCalloutClass.getUrlAppdocs";
import getDoctypes from "@salesforce/apex/Aml_Review_cls.getDoctypes";
import getlistOps from "@salesforce/apex/ES3_DocSInRequestCalloutClass.getListOpInCa";
import getKeyEncriptation from "@salesforce/apex/ES3_DocSInRequestCalloutClass.getKeyEncriptation";
import getEncriptationType from "@salesforce/apex/ES3_DocSInRequestCalloutClass.getEncriptationMode";
import newdocument from "@salesforce/apex/ES3_DocSInRequestCalloutClass.newdocument";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

export default class Aml_Review_Docs_lwc extends NavigationMixin(
  LightningElement
) {
  @api recordId;
  sServiceUrl;
  urlExterna;
  urlAppdoctos;
  keyencriptation;
  encriptationType;
  @track listaOpportunitys;
  listadeOps;
  recordtypeId;
  @track sourceOpId;
  @track error;
  @track istruerror;
  wiredlistaDoc;
  @track listaAttachments;
  @track modalDocs;
  @track doctypes;
  @track urlOpen;

  /*  //get doctypes
      @wire(getDoctypes, {recordId:"$recordId", recordTypeId:"$recordtypeId"})
      wiredDoctypes({error, data}) {
          if (data) {
            this.doctypes = data;
            this.error = undefined;
            this.getDoctos();
          }else if (error) {
              this.error = error.body.message;
              
              this.istruerror = true;
              this.doctypes = undefined;
          }
      }*/

  // get EncriptationType
  @wire(getEncriptationType)
  wiredEncriptationType({ error, data }) {
    if (data) {
      this.encriptationType = data;
      this.error = undefined;
    } else if (error) {
      this.error = error.body.message;
      this.encriptationType = undefined;
    }
  }
  // get KeyEncriptation

  @wire(getKeyEncriptation)
  wiredKeyEncriptation({ error, data }) {
    if (data) {
      this.keyencriptation = data;
      this.error = undefined;
    } else if (error) {
      this.error = error.body.message;
      this.keyencriptation = undefined;
    }
  }

  // get record typeId
  @wire(getRecord, { recordId: "$recordId", fields: [RECORD_TYPE_FIELD] })
  record({ error, data }) {
    if (data) {
      this.recordtypeId = data.fields.RecordTypeId.value;
      this.error = undefined;
    } else if (error) {
      this.error = error.body.message;
      this.recordtypeId = undefined;
    }
  }

  get options() {
    getlistOps({ cp: this.recordId })
      .then(result => {
        this.listadeOps = result;
        let listaOps = [];
        for (let item of result) {
          listaOps.push({
            label: item.ES3_fm_Opportunity_Name__c,
            value: item.Id
          });
        }
        this.listaOpportunitys = listaOps;
      })
      .catch(error => {
        this.error = error;
      });
    return this.listaOpportunitys;
  }

  handleOpchange(event) {
    this.sourceOpId = event.detail.value;
  }

  //get url del servicio
  @wire(getsServiceUrl)
  wireSUrl({ error, data }) {
    if (data) {
      this.sServiceUrl = data;
      this.error = undefined;
    } else if (error) {
      this.error = error.body.message;
      this.sServiceUrl = undefined;
    }
  }

  //get url externa
  @wire(getUrlExterna)
  wiredUrlExterna({ error, data }) {
    if (data) {
      this.urlExterna = data;
      this.error = undefined;
    } else if (error) {
      this.error = error.body.message;
      this.urlExterna = undefined;
    }
  }

  //get url app documents
  @wire(getUrlAppdocs)
  wiredUrlAppdocs({ error, data }) {
    if (data) {
      this.urlAppdoctos = data;
      this.error = undefined;
    } else if (error) {
      this.error = error.body.message;
      this.urlAppdoctos = undefined;
    }
  }

  addDocumment() {
    newdocument({
      doctypes: this.doctypes,
      sourceOpId: this.sourceOpId,
      sourceCAId: this.recordId,
      backUrl: window.location.toString(),
      urlserverExterna: this.urlExterna,
      urlAppDocs: this.urlAppdoctos,
      KeyEncriptation: this.keyencriptation,
      EncriptationType: this.encriptationType
    })
      .then(result => {
        console.log("doctyoes");
        console.log(this.doctypes);
        this.urlOpen = result;
        this[NavigationMixin.Navigate]({
          type: "standard__webPage",
          attributes: {
            url: this.urlOpen.toString()
          }
        });
      })
      .catch(error => {
        this.error = error.body.message;
        this.urlOpen = undefined;
        console.log(this.error);
      });
    return console.log("se abrio la pagina");
  }

  downloadDocumment(event) {
    let docId = event.target.title;
    downloadDoctos({
      docId: docId,
      backUrl: window.location.toString(),
      urlserverExterna: this.urlExterna,
      urlAppDocs: this.urlAppdoctos,
      EncriptationType: this.encriptationType,
      KeyEncriptation: this.keyencriptation
    })
      .then(result => {
        this.urlOpen = result;
        this[NavigationMixin.Navigate]({
          type: "standard__webPage",
          attributes: {
            url: this.urlOpen.toString()
          }
        });
      })
      .catch(error => {
        this.error = error.body.message;
        this.urlOpen = undefined;
      });
  }

  deleteDocumment(event) {
    let contentDocId = event.target.dataset.contentdocid;
    let oraId = event.target.dataset.oraid;
    let name = event.target.dataset.name;
    let doctype = event.target.dataset.doctype;
    let url = event.target.dataset.url;
    let confirmacion = confirm("Are you sure to delete this document?");
    if (confirmacion === true) {
      deleteDocto({
        requestId: "999999999",
        oraId: oraId,
        url: url,
        docType: doctype,
        contentDocId: contentDocId,
        name: name,
        urlserver: this.sServiceUrl
      })
        .then(result => {
          let showWarning = new ShowToastEvent({
            title: "Success!!",
            message: "Document has been deleted",
            variant: "success"
          });

          dispatchEvent(showWarning);
          this.error = undefined;
          return refreshApex(this.wiredlistaDoc);
        })
        .catch(error => {
          this.error = error.body.message;
          console.log("error");
          console.log(this.error);
        });
    }
  }

  @wire(getDocs, {
    sServiceUrl: "$sServiceUrl",
    searchRequestId: "999999999",
    sourceCAId: "$recordId"
  })
  wiredDocs(result) {
    this.wiredlistaDoc = result;
    if (result.data) {
      getDoctypes({ recordId: this.recordId, recordTypeId: this.recordtypeId })
        .then(resultado => {
          this.doctypes = resultado;
          let listaDoctos = [];
          let tiposdeDoc = resultado;
          if (JSON.parse(result.data).documentsList) {
            for (let doc of JSON.parse(result.data).documentsList.document) {
              if (tiposdeDoc.includes(doc.type)) {
                listaDoctos.push(doc);
              }
            }
          }
          this.listaAttachments = listaDoctos;
          this.error = undefined;
        })
        .catch(errores => {
          this.error = errores.body.message;
          this.istruerror = true;
          this.doctypes = undefined;
        });
    } else if (result.error) {
      this.error = result.error.body.message;
      this.listaAttachments = undefined;
    }
  }
}