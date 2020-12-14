/* eslint-disable no-alert */
/* eslint-disable no-console */
/**
 * @File Name          : tkd_linkLAtoTakedown.js
 * @Description        :
 * @Author             : juandedios.hernandez@engeniumcapital.com
 * @Group              :
 * @Last Modified By   : juandedios.hernandez@engeniumcapital.com
 * @Last Modified On   : 31/10/2019 15:38:37
 * @Modification Log   :
 * Ver       Date            Author      		    Modification
 * 1.0    15/10/2019   juandedios.hernandez@engeniumcapital.com     Initial Version
 **/
import { LightningElement, track, wire, api } from "lwc";

import blank from "./views/blank.html";
import mainpage from "./tkd_linkLAtoTakedown.html";

import { loadScript, loadStyle } from "lightning/platformResourceLoader";
import momentJs from "@salesforce/resourceUrl/momentJs";
import Animate from "@salesforce/resourceUrl/Animate";

import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { getRecord } from "lightning/uiRecordApi";
import { updateRecord } from "lightning/uiRecordApi";
import { createRecord } from "lightning/uiRecordApi";
import { deleteRecord } from "lightning/uiRecordApi";

import LAINTKD_OBJECT from "@salesforce/schema/Legal_Assessment_In_TD__c";
import ENTITYCAID_FIELD from "@salesforce/schema/Legal_Assessment_In_TD__c.Enitty_Master_In_CA_ID__c";
import ETITYCA_FIELD from "@salesforce/schema/Legal_Assessment_In_TD__c.TKD_Entity_Master_in_Credit_Approval__c";
import LAREQUESTID_FIELD from "@salesforce/schema/Legal_Assessment_In_TD__c.TKD_tx_RequestId__c";
import TAKEDOWNCP_FIELD from "@salesforce/schema/Legal_Assessment_In_TD__c.TKD_rb_Takedown_CP__c";
import unlockRecord from "@salesforce/apex/TKD_ChecklistTolgate1Controller.unlockForUpdate";
import lockRecord from "@salesforce/apex/TKD_ChecklistTolgate1Controller.lockForApproval";
import getEntitiesInca from "@salesforce/apex/TKD_LinkLAtoTakedownCallout_cls.getEntitiesInCa";
import getLASINTKD from "@salesforce/apex/TKD_LinkLAtoTakedownCallout_cls.fetchLASINTD";
import searchLAS from "@salesforce/apex/TKD_LinkLAtoTakedownCallout_cls.searchLAsInEntity";
import {
  getLegalByLegalId,
  actaConstitutiva,
  apoderados,
  bill
} from "./tkd_getLegal";

const FIELDS = [
  "Takedowns_Contingency_plan__c.TD_fm_Party_Id__c",
  "Takedowns_Contingency_plan__c.TKD_Legal_Assestment__c",
  "Takedowns_Contingency_plan__c.TKD_rb_Pricin_CA__r.ES3_rb_Credit_approval_CP__c",
  "Takedowns_Contingency_plan__c.TKD_ls_takedown_stage__c"
];

export default class Tkd_linkLAtoTakedown extends LightningElement {
  @api recordId;
  @track takedown;
  @track entityPartyId;
  @track cAId;
  @track legalAssestmentId;
  @track legalAssesment;
  @track acta;
  @track apoderado;
  @track bil;

  @track defaultTab;

  @track cargandoSearch;

  @track section = blank;
  @track listEntitys;
  @track listLAS;
  @track listLinkedLAS;
  @track flagSearchEnts;
  @track takedownStage;

  renderedCallback() {
    Promise.all([loadScript(this, momentJs), loadStyle(this, Animate)]).then(
      () => {
        console.log("Scripts cargadinos");
      }
    );
  }

  render() {
    return this.section;
  }

  @wire(getRecord, { recordId: "$recordId", fields: FIELDS })
  async wiredRecord({ error, data }) {
    if (error) {
      let message = "Unknown error";
      if (Array.isArray(error.body)) {
        message = error.body.map(e => e.message).join(", ");
      } else if (typeof error.body.message === "string") {
        message = error.body.message;
      }
      this.dispatchEvent(
        new ShowToastEvent({
          title: "Error loading takedown record",
          message,
          variant: "error"
        })
      );
    } else if (data) {
      this.takedown = data;
      this.entityPartyId = this.takedown.fields.TD_fm_Party_Id__c.value;
      this.legalAssestmentId = this.takedown.fields.TKD_Legal_Assestment__c.value;
      this.takedownStage = this.takedown.fields.TKD_ls_takedown_stage__c.value;
      console.log("CAID: ");
      try {
        this.cAId = this.takedown.fields.TKD_rb_Pricin_CA__r.value.fields.ES3_rb_Credit_approval_CP__c.value;
        console.log("CAID: ");
        console.log(this.cAId);
      } catch (erc) {
        console.log("Error al cargar pricing in ca");
        console.error(erc);
      }

      await this.getEntts()
        .then(re => {
          this.listEntitys = re;
          this.flagSearchEnts = true;
          console.log("lista de ents in ca");
          console.log(this.listEntitys);
        })
        .catch(er => {
          this.dispatchEvent(
            new ShowToastEvent({
              title: "Error to load Entities In CA",
              message: "" + er,
              variant: "error",
              mode: "sticky"
            })
          );
        });

      /*  console.log(`Takedown: ${this.takedown}, EntityPartyId: ${this.entityPartyId}, LAID: ${this.legalAssestmentId}`);
            if(this.legalAssestmentId){
                await getLegalByLegalId(this.legalAssestmentId)
                .then((result)=>{
                    this.legalAssesment = result;
                    this.acta = actaConstitutiva(this.legalAssesment.header.ndaType, this.legalAssesment);
                    this.apoderado = apoderados(this.legalAssesment.header.ndaType, this.legalAssesment);
                    this.bil = bill(this.legalAssesment.header.ndaType, this.legalAssesment);
                    this.section = legalDetail;
                })
                .catch(err=>{
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Error to load Legal In Entitie',
                            message: '' +  err,
                            variant: 'error',
                            mode:'sticky'
                        }),
                    );
                }) 
            }else{
                this.section = mainpage;
            } */

      this.getLinkedLas()
        .then(resLAS => {
          this.listLinkedLAS = resLAS;
          console.log("LINKED LAS");
          console.log(this.listLinkedLAS);
        })
        .catch(errLas => {
          this.dispatchEvent(
            new ShowToastEvent({
              title: "Error to load Linked LAS",
              message: "" + errLas,
              variant: "error",
              mode: "sticky"
            })
          );
        });
      this.defaultTab = "one";
      this.section = mainpage;
    }
  }

  getEntts() {
    return new Promise((resolve, reject) => {
      getEntitiesInca({ cAId: this.cAId })
        .then(result => {
          resolve(result);
        })
        .catch(error => {
          reject(new Error(JSON.stringify(error)));
        });
    });
  }

  async handleSearch(event) {
    this.flagSearchEnts = false;
    let partyId = event.target.dataset.partyid;
    let entIncaId = event.target.dataset.entcaid;
    let urlEnt = event.target.dataset.enturl;
    console.log(
      `El party Id para buscar: ${partyId}, el url: ${urlEnt}, entcaid: ${entIncaId}`
    );
    this.cargandoSearch = true;
    let linkedNofilteredlas = [];
    try {
      linkedNofilteredlas = await this.getLinkedLas();
    } catch (errorcatch) {
      console.log('erro al cargar los legals linkeados en el search')
      console.log(errorcatch);
    }

    let listLaLinked = [];
    
    if(linkedNofilteredlas.length> 0){
      
      linkedNofilteredlas.forEach(la => {
        listLaLinked.push(Number(la.TKD_tx_RequestId__c))
      });
    }
    searchLAS({ partyId: partyId })
      .then(result => {
        console.log(`LASINENTITY: \n ${result}`);
        let request = JSON.parse(result);
        if (request.requests !== null & request.status.detail !== 'F') {
          let requests = request.requests.request;
          let lasNoflag = requests.filter(
            ({ header }) => header.requestType === "LEGAL ASSESSMENT"
          );

          let listLASall = lasNoflag.map((val, index) => {
            val.entIncaId = entIncaId;
            val.urlEnt = urlEnt;
            let status = val.header.requestStatus;
            let validThrough;
            let isVigent;
            if(val.legalAssessment.laHeader.generalInformation !== null){
            validThrough = moment(
              val.legalAssessment.laHeader.generalInformation.laGIValidThrough,
              "DD/MM/YYYY"
            );

            console.log('Validfecha:')
            console.log(validThrough);
            isVigent = validThrough.isSameOrAfter(
              moment(moment(), "DD/MM/YYYY").format()
            )
              ? true
              : false;
            console.log('is vigent: '  + isVigent)
            console.log(
              "momento " +
                moment(moment(), "DD/MM/YYYY").format() +
                " caducidad: " +
                validThrough
            );
            console.log('val.header.requestId: ' + val.header.requestId)
            if (status === "APPROVED" && isVigent === true && listLaLinked.includes(val.header.requestId)===false) {
              
              val.showAddFlag = true;
            } else {
              val.showAddFlag = false;
            }

            this.cargandoSearch = false;
            return val;
            }else{
              this.cargandoSearch = false;
              return val;
            }

          });
          this.listLAS =[listLASall.reduce((prev, current)=> {
            return (prev.header.requestId > current.header.requestId)&& prev.header.requestStatus==='APPROVED' ? prev : current
        })]
        }else if(request.requests === null & request.status.detail === 'F'){
            throw new Error ('Errror al consultar el servicio de Legal assesment');
        }else if(request.requests === null & request.status.detail !== 'F'){
            throw new Error ('No se encontraron legal assesments')
        }

        console.log(this.listLAS);
      })
      .catch(error => {
        this.cargandoSearch = false;
        console.log('Error detectable')
        console.log(error)
        this.dispatchEvent(
          new ShowToastEvent({
            title: "Error in the search of LAS of this entity",
            message: "" + error,
            variant: "error",
            mode: "sticky"
          })
        );
      });
  }

  async selectLA(event) {
    let requestId = event.target.dataset.reqid;
    let enttyIncaID = event.target.dataset.enttycaid;
    let takedowncpId = this.recordId;
    let confirmacion = confirm("Are you sure to select this Legal Assessment?");
    if (confirmacion) {
      await unlockRecord({ takedownId: this.recordId })
        .then(res => {
          console.log("SE desbloquio");
          this.section = blank;
          const fields = {};
          fields[ENTITYCAID_FIELD.fieldApiName] = enttyIncaID;
          fields[ETITYCA_FIELD.fieldApiName] = enttyIncaID;
          fields[LAREQUESTID_FIELD.fieldApiName] = requestId;
          fields[TAKEDOWNCP_FIELD.fieldApiName] = takedowncpId;
          
          const recordInput = { apiName: LAINTKD_OBJECT.objectApiName, fields };
          createRecord(recordInput)
            .then(async laintakedown => {
              if(this.takedownStage  && this.takedownStage!=='Converted' && this.takedownStage !=='In Signatures' && this.takedownStage !=='Closed'){
                console.log('las this')
                console.log(this.listLAS)

                this.listLAS = this.listLAS.map((val)=>{
                  console.log(val.header.requestId)
                  console.log(requestId)
                  if(val.header.requestId === Number(requestId)){
                    val.showAddFlag = false
                  }
                  return val;
                })
                lockRecord({ takedownId: this.recordId })
                .then(res => {
                  console.log("SE BLOQUEA EL REGISTRO");
                })
                .catch(error => {
                  console.log("ERROR AL INTENTAR BLOQUAR EL REG");
                  console.log(error);
                });
              }
              this.backtoSearchLAS();
              this.dispatchEvent(
                new ShowToastEvent({
                  title: "Success",
                  message: "Legal Assessment in Takedown:" + laintakedown.id,
                  variant: "success"
                })
              );
    
              await this.getLinkedLas()
                .then(resLAS => {
                  this.listLinkedLAS = resLAS;
                  console.log("LINKED LAS");
                  console.log(this.listLinkedLAS);
                })
                .catch(errLas => {
                  this.dispatchEvent(
                    new ShowToastEvent({
                      title: "Error to load Linked LAS",
                      message: "" + errLas,
                      variant: "error",
                      mode: "sticky"
                    })
                  );
                });
               
              this.defaultTab = "two";
              this.section = mainpage;

            })
            .catch(error => {
              let message;
              if (error.body.output) {
                message = JSON.stringify(
                  error.body.output.errors.map(messager => messager.message)
                );
                if (message.includes("duplicates value")) {
                  message =
                    "This legal Assessment form this entity Already has been Added";
                }
              } else {
                message = error.body.message;
              }
              this.dispatchEvent(
                new ShowToastEvent({
                  title: "Error on Link Legal Assessment to takedown",
                  message: message,
                  variant: "error",
                  mode: "sticky"
                })
              );
              this.section = mainpage;
              console.log("el error perro");
              console.log(error);
            });
          /* this.section = blank;
                const fields = {};
                fields[ID_FIELD.fieldApiName] = this.recordId;
                fields[LINKEDLEGAL_FIELD.fieldApiName] = requestId;
                const recordInput = { fields }
                await updateRecord(recordInput)
                .then(()=>{
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Success',
                            message: 'Legal Assessment: ' + requestId + ' has been linked to this takedown',
                            variant: 'success'
                        })
                    );
                }).catch(error =>{
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Error to linked Legal Assessment to this takedown',
                            message: error.body.message,
                            variant: 'error',
                            mode:'sticky'
                        })
                    );
                })
    
                this.legalAssestmentId = requestId;
                await getLegalByLegalId(this.legalAssestmentId)
                .then((result)=>{
                    console.log('laaaa');
                    console.log(this.legalAssesment);
                    this.legalAssesment = result;
                    this.acta = actaConstitutiva(this.legalAssesment.header.ndaType, this.legalAssesment);
                    this.apoderado = apoderados(this.legalAssesment.header.ndaType, this.legalAssesment);
                    this.bil = bill(this.legalAssesment.header.ndaType, this.legalAssesment);
                    this.section = legalDetail;
                })
                .catch(error=>{
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Error to load Legal In Entitie',
                            message: '' +  error,
                            variant: 'error',
                            mode:'sticky'
                        }),
                    );
                })
                
            } */
        })
        .catch(error => {
          console.log("ERROR AL QUERER DESBLOQUEAR EL REGISTRO");
          console.log(error);
        });
    }
  }

  backtoSearchLAS() {
    this.listLAS = undefined;
    this.flagSearchEnts = true;
  }

  getLinkedLas() {
    return new Promise((resolve, reject) => {
      getLASINTKD({ takedownId: this.recordId })
        .then(result => {
          resolve(result);
        })
        .catch(error => {
          reject(new Error(JSON.stringify(error)));
        });
    });
  }

  async detailLa(legalID) {
    await getLegalByLegalId(legalID)
      .then(result => {
        console.log("laaaa");
        this.legalAssesment = result;
        console.log(this.legalAssesment);
        this.acta = actaConstitutiva(
          this.legalAssesment.header.ndaType,
          this.legalAssesment
        );
        this.apoderado = apoderados(
          this.legalAssesment.header.ndaType,
          this.legalAssesment
        );
        this.bil = bill(
          this.legalAssesment.header.ndaType,
          this.legalAssesment
        );
      })
      .catch(error => {
        this.dispatchEvent(
          new ShowToastEvent({
            title: "Error to load Linked Legal",
            message: "" + error,
            variant: "error",
            mode: "sticky"
          })
        );
      });
  }

  async removeLa(event) {
    let laID = event.target.dataset.laintdid;
    let confirmacion = confirm("Are you sure to remove this Legal Assessment?");

    if (confirmacion) {
      this.section = blank;
      await deleteRecord(laID)
        .then(result => {
          window.console.log("result ====> " + result);
          this.backtoSearchLAS();
          this.dispatchEvent(
            new ShowToastEvent({
              title: "Success!!",
              message: "LA in Takedown Deleted Successfully!!",
              variant: "success"
            })
          );
        })
        .catch(error => {
          console.log("el error delete");
          console.log(error);
          this.dispatchEvent(
            new ShowToastEvent({
              title: "Error to try delete This LA in Takedown!!",
              message: JSON.stringify(error),
              variant: "error"
            })
          );
        });
      /* const fields = {};
            fields[ID_FIELD.fieldApiName] = this.recordId;
            fields[LINKEDLEGAL_FIELD.fieldApiName] = '';
            const recordInput = { fields }
            await updateRecord(recordInput)
            .then(()=>{
                this.legalAssestmentId = null;
                this.legalAssesment = null;
                console.log('la selected');
                console.log(this.legalAssesment);
                this.section = mainpage;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'This Legal Assessment: has been removed from this takedown',
                        variant: 'success'
                    })
                );
            }).catch(error =>{
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error to remove Legal Assessment to this takedown',
                        message: error.body.message,
                        variant: 'error',
                        mode:'sticky'
                    })
                );
            }) */

      await this.getLinkedLas()
        .then(resLAS => {
          this.listLinkedLAS = resLAS;
          console.log("LINKED LAS");
          console.log(this.listLinkedLAS);
          this.defaultTab = "two";
          this.section = mainpage;
        })
        .catch(errLas => {
          this.dispatchEvent(
            new ShowToastEvent({
              title: "Error to load Linked LAS",
              message: "" + errLas,
              variant: "error",
              mode: "sticky"
            })
          );
        });
    }
  }

  get urlLa() {
    let url;
    if (this.legalAssesment.header.ndaType === "Moral") {
      url =
        "/one/one.app#/alohaRedirect/apex/ES5_ReadPage_Legal_Assessment_PM?requestId=" +
        this.legalAssestmentId;
    }
    if (this.legalAssesment.header.ndaType === "Extranjera") {
      url =
        "/one/one.app#/alohaRedirect/apex/ES5_ReadPage_Legal_Assessment_PME?requestId=" +
        this.legalAssestmentId;
    }
    if (this.legalAssesment.header.ndaType === "Fisica") {
      url =
        "/one/one.app#/alohaRedirect/apex/ES5_ReadPage_Legal_Assessment_PF?requestId=" +
        this.legalAssestmentId;
    }

    return url;
  }

  viewApo() {
    let url;
    if (this.legalAssesment.header.ndaType === "Moral") {
      url =
        "/one/one.app#/alohaRedirect/apex/ES5_ReadPage_Legal_Assessment_PM?requestId=" +
        this.legalAssestmentId +
        "#BIL";
    }
    if (this.legalAssesment.header.ndaType === "Extranjera") {
      url =
        "/one/one.app#/alohaRedirect/apex/ES5_ReadPage_Legal_Assessment_PME?requestId=" +
        this.legalAssestmentId +
        "#BIL";
    }
    if (this.legalAssesment.header.ndaType === "Fisica") {
      url =
        "/one/one.app#/alohaRedirect/apex/ES5_ReadPage_Legal_Assessment_PF?requestId=" +
        this.legalAssestmentId +
        "#BIL";
    }

    window.open(url);
  }

  @track openmodel = false;
  async openmodal(event) {
    let laID = event.target.dataset.lareqid;
    this.legalAssestmentId = laID;
    this.section = blank;
    await this.detailLa(laID);
    this.section = mainpage;
    this.defaultTab = "two";
    this.openmodel = true;
  }
  closeModal() {
    this.openmodel = false;
  }
}