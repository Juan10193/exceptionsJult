/**
 * @description       : 
 * @author            : eduardo.amiens@outlook.com
 * @group             : 
 * @last modified on  : 10-15-2020
 * @last modified by  : eduardo.amiens@outlook.com
 * Modifications Log 
 * Ver   Date         Author                       Modification
 * 1.0   10-15-2020   eduardo.amiens@outlook.com   Initial Version
**/
import { LightningElement, track, wire, api } from "lwc";
import { loadScript, loadStyle } from "lightning/platformResourceLoader";
import momentJs from "@salesforce/resourceUrl/momentJs";
import Animate from "@salesforce/resourceUrl/Animate";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

import { getRecord } from "lightning/uiRecordApi";
import userId from "@salesforce/user/Id";
const USERSSO = ["User.EmployeeNumber"];
const FIELDSOP = ["Opportunity.Name", "Opportunity.LMM_Linked_Eval__c"];

import blank from "./views/blank.html";
import mainpage from "./lmmLinkEvalToOpportunity.html";
import detailEval from "./views/evalDetail.html";
import getEntidadesOpp from "@salesforce/apex/LMM_LinkEvalToOpportunityController.getEntidadesdeLaOpportunidad";
import searchEntity from "@salesforce/apex/TKD_LinkEvaltoTakedownCallout_cls.searchEvalsInEntities";
import searchOps from "@salesforce/apex/TKD_LinkEvaltoTakedownCallout_cls.searchEvalsInOpportunityCallout";

import { getevalRecord } from "./linkEvalHelper";
import { searchEval } from "./cloneEvalHelper";
import { cloneEvalFromEnt } from "./cloneEvalHelper";
import { postComments } from "./cloneEvalHelper";
import { updateOPPWhitEval } from "./cloneEvalHelper";

import { columnsAssets } from "./assetsHelper";
import { columnsValuations } from "./assetsHelper";

export default class LmmLinkEvalToOpportunity extends LightningElement {
  @api recordId;
  @api evalType;
  @api evalTypeSecondOpt;
  @api evalTypeStatus;
  @api evalTypeSecondOptStatus;

  section = blank;
  sso;
  entityPartyId;
  entityName;
  listEntitys;
  opportunityName;
  evalrequestId;
  evalRecord;
  printPdfbutton = false;
  @track classremove = true;

  evalStatus;
  evalSumary;
  endDate;
  evalAssets;
  evalValuations;
  @track amounts = [];

  loadSearch;

  @track listOppEvalsProporsal;
  @track listEvalsEntitiesProporsals;
  @track evalEntRequest;

  @track activeSections = [
    "Eval Summary",
    "Endorsement comment",
    "Eval Assets",
    "Valuations"
  ];

  @track assetsColumns = columnsAssets;
  @track valuationsColummns = columnsValuations;

  @track error;
  renderedCallback() {
    Promise.all([loadScript(this, momentJs), loadStyle(this, Animate)]).then(
      () => {
        "scripts cargadinos";
      }
    );
  }

  render() {
    return this.section;
  }

  @wire(getRecord, { recordId: userId, fields: USERSSO })
  wiredUser({ error, data }) {
    if (error) {
      let message = "Unknown error";
      if (Array.isArray(error.body)) {
        message = error.body.map((e) => e.message).join(", ");
      } else if (typeof error.body.message === "string") {
        message = error.body.message;
      }
      this.dispatchEvent(
        new ShowToastEvent({
          title: "Error loading user sso",
          message,
          variant: "error"
        })
      );
    } else if (data) {
      this.sso = data.fields.EmployeeNumber.value;
      console.log("sso lmm opp eval: " + this.sso);
    }
  }

  @wire(getRecord, { recordId: "$recordId", fields: FIELDSOP })
  async wiredRecord({ error, data }) {
    if (error) {
      let message = "Unknown error";
      if (Array.isArray(error.body)) {
        message = error.body.map((e) => e.message).join(", ");
      } else if (typeof error.body.message === "string") {
        message = error.body.message;
      }
      this.dispatchEvent(
        new ShowToastEvent({
          title: "Error loading Opportunity record",
          message,
          variant: "error"
        })
      );
    } else if (data) {
      let entidades;
      getEntidadesOpp({ recordId: this.recordId })
        .then((res) => {
          let listOptions = [];
          res.forEach((entity) => {
            listOptions.push({
              label: entity.LMM_tx_Entity_Name__c,
              value: entity.LMM_pd_Entity_CP__r.EM_Party_ID__c
            });
          });
          entidades = listOptions;
          console.log(entidades);
          this.listEntitys = entidades;
        })
        .catch((err) => {
          console.log("error al cargar entidades");
          console.log(err);
          this.dispatchEvent(
            new ShowToastEvent({
              title: "Error loading Entities",
              message: err.message,
              variant: "error"
            })
          );
        });
      this.opportunityName = data.fields.Name.value;
      this.evalrequestId = await data.fields.LMM_Linked_Eval__c.value;
      console.log("nombre de la opp: " + this.opportunityName);
      try {
        let func = getevalRecord.bind(this);
        let resultado = await func();
        console.log(resultado);
      } catch (errorr) {
        console.log("error al llamar metodo");
        console.log(errorr);
      }
    }
  }

  handleSelect(event) {
    this.entityPartyId = event.detail.value;
    console.log(this.entityPartyId);
    this.entityName = event.detail.label;
    console.log(this.entityName);
  }

  async handleSearch() {
    this.loadSearch = true;
    await this.filterEvalsInOps()
      .then(result => {
        this.listOppEvalsProporsal = result;
        console.log("list evals opp proporsal");
        console.log(this.listOppEvalsProporsal);
      })
      .catch(error => {
        /*  this.dispatchEvent(
           new ShowToastEvent({
             title: "Error to load Evals In Opportunitys",
             message: "" + error,
             variant: "error",
             mode: "sticky"
           })
         ); */
        console.error(error);
      });

    this.filterEvalsInEntity()
      .then(resultado => {
        console.log("list evals ents proposal");
        console.log(resultado);
        this.listEvalsEntitiesProporsals = resultado;
      })
      .catch(err => {
        console.log(err);
        /* this.dispatchEvent(
          new ShowToastEvent({
            title: "Error to load Evals In Entities",
            message: "" + err,
            variant: "error",
            mode: "sticky"
          })
        ); */
      });
    this.loadSearch = false;
  }

  filterEvalsInOps() {
    return new Promise((resolve, reject) => {
      if (this.recordId) {
        searchOps({ opportunityId: this.recordId.slice(0, -3) })
          .then(result => {
            let jsonEvalsInOpps = JSON.parse(result);
            console.log("json del evalin op");
            console.log(jsonEvalsInOpps);
            if (jsonEvalsInOpps.requests !== null) {
                let listevals = jsonEvalsInOpps.requests.request;
                console.log('listevals ' + JSON.stringify(listevals))
                let evalFirstCondition = []
                if (this.evalTypeStatus !== 'ALL') {
                  evalFirstCondition = listevals.filter(evall =>
                    evall.header.ndaType === this.evalType && evall.header.requestStatus === this.evalTypeStatus
                  )
                } else {
                  evalFirstCondition = listevals.filter(evall =>
                    evall.header.ndaType === this.evalTypeSecondOpt
                  )
                }
                console.log('evalFirstCondition ' + JSON.stringify(evalFirstCondition))
                let evalSecondCondition = []
                if (this.evalTypeSecondOptStatus !== 'ALL') {
                  evalSecondCondition = listevals.filter(evall =>
                    evall.header.ndaType === this.evalTypeSecondOpt && evall.header.requestStatus === this.evalTypeSecondOptStatus
                  )
                } else {
                  evalSecondCondition = listevals.filter(evall =>
                    evall.header.ndaType === this.evalTypeSecondOpt
                  )
                }
                console.log('evalSecondCondition ' + JSON.stringify(evalSecondCondition))
                let finalArray = [...evalFirstCondition, ...evalSecondCondition]
                console.log('finalArray ' + JSON.stringify(finalArray))
                resolve(finalArray);
              
            } else {
              if (jsonEvalsInOpps.status.detail !== "S") {
                throw Error(
                  "Error al consultar el Servicio de Evals En Opportunidades"
                );
              } else {
                throw Error("No se encontraron Evals En Opportunidades");
              }
            }
          })
          .catch(error => {
            reject(new Error(error));
          });
      }
    });
  }

  filterEvalsInEntity() {
    console.log("Lo estamos llamando morro");
    console.log(this.entityPartyId);
    return new Promise((resolve, reject) => {
      console.log(this.entityPartyId);
      if (this.entityPartyId !== null) {
        searchEntity({ partyId: this.entityPartyId })
          .then(result => {
            let jsonEvalsInEntitys = JSON.parse(result);
            console.log('jsonEvalsInEntitys')
            console.log(jsonEvalsInEntitys)
            if (jsonEvalsInEntitys.requests !== null) {
              let listevals = jsonEvalsInEntitys.requests.request;
              console.log('init ' + JSON.stringify(listevals))
              let evalsProporsal = listevals.filter(
                ({ header }) => header.requestType === 'EVAL');
              console.log('evalsProporsal ' + JSON.stringify(evalsProporsal))
              let evalFirstCondition = []
              if (this.evalTypeStatus !== 'ALL') {
                evalFirstCondition = evalsProporsal.filter(({ header }) =>
                  header.ndaType === this.evalType && header.requestStatus === this.evalTypeStatus
                )
              } else {
                evalFirstCondition = evalsProporsal.filter(({ header }) =>
                  header.ndaType === this.evalType
                )
              }
              console.log('evalFirstCondition ' + JSON.stringify(evalFirstCondition))
              let evalSecondCondition = []
              if (this.evalTypeSecondOptStatus !== 'ALL') {
                evalSecondCondition = evalsProporsal.filter(({ header }) =>
                  header.ndaType === this.evalTypeSecondOpt && header.requestStatus === this.evalTypeSecondOptStatus
                )
              } else {
                evalSecondCondition = evalsProporsal.filter(({ header }) =>
                  header.ndaType === this.evalTypeSecondOpt
                )
              }
              console.log('evalSecondCondition ' + JSON.stringify(evalSecondCondition))
              let finalArray = [...evalFirstCondition, ...evalSecondCondition]
              console.log('finalArray ' + JSON.stringify(finalArray))
              resolve(finalArray);
            } else if (
              jsonEvalsInEntitys.requests == null &&
              jsonEvalsInEntitys.status.detail !== "S"
            ) {
              throw Error(
                "Error al consultar el Servicio de Evals En Entidades"
              );
            } else if (
              jsonEvalsInEntitys.requests == null &&
              jsonEvalsInEntitys.status.detail == "S"
            ) {
              throw Error("No se encontraron Evals En Entidades");
            }
          })
          .catch(error => {
            reject(new Error(error));
          });
      } else {
        reject(new Error('Error PartyID for search entity evals'))
      }
    });
  }

  async cloneEvalEnt(event) {
    let requestId = event.target.dataset.reqid;
    let confirmClone = confirm("Areyou Sure to Link this Eval: " + requestId);

    if (confirmClone) {
      this.loadSearch = true;
      this.classremove = true;
      await searchEval(this.sso, "SF", requestId)
        .then(result => {
          console.log("eval de entidad");
          console.log(result);
          this.evalEntRequest = result;
          this.evalrequestId = requestId;
        })
        .catch(error => {
          console.log("prueba del error");
          console.log(error);
          this.dispatchEvent(
            new ShowToastEvent({
              title: "Error in the search of the Eval of this entity",
              message: "" + error,
              variant: "error",
              mode: "sticky"
            })
          );
        });

      let dateMoment = moment(
        moment(),
        "yyyy-MM-dd'T'HH:mm:ss.000-00:00"
      ).format();

      /*await cloneEvalFromEnt(this.evalEntRequest, dateMoment, this.sso, false, this.entityPartyId, this.entityName)
        .then(async result => {
          console.log("mainresult");
          console.log(result);
          let resultObject = JSON.parse(result);
          this.evalrequestId = await resultObject.requestId;
          console.log('prepost comments')
          console.log('comments requestId: ' + this.evalrequestId)
          await postComments(dateMoment, this.sso, this.opportunityName, this.evalrequestId)
          .then(async resultc=>{
             console.log("resultcomments")
             await console.log(resultc);
          }).catch(async erro=>{
            console.log('erro post comments')
            await console.log(erro)
          })
          console.log('after post comments')
        })
        .catch(error => {
          this.dispatchEvent(
            new ShowToastEvent({
              title: "Error durante el clonado del Eval",
              message: "" + error,
              variant: "error",
              mode: "sticky"
            })
          );
        });*/



      await updateOPPWhitEval(this.recordId, this.evalrequestId)
        .then(async () => {
          this.dispatchEvent(
            new ShowToastEvent({
              title: "Success",
              message: "Eval linked to Opportunity",
              variant: "success"
            })
          );

          let func = getevalRecord.bind(this);
          let resultado = await func();
          console.log(resultado);

          this.section = detailEval;
        })
        .catch(error => {
          console.log("elerror");

          console.log(error);
          this.dispatchEvent(
            new ShowToastEvent({
              title: "error al  ligar el Eval a la Oportunidad",
              message: "" + error,
              variant: "error",
              mode: "sticky"
            })
          );
        });

      this.loadSearch = false;
    }
  }


  async cloneEvalOpp(event) {
    let requestId = event.target.dataset.requestid;
    let confirmClone = confirm("Areyou Sure to Link this Eval: " + requestId);

    if (confirmClone) {
      this.loadSearch = true;
      this.classremove = true;
      await searchEval(this.sso, "SF", requestId)
        .then(result => {
          console.log("eval de opp");
          console.log(result);
          this.evalEntRequest = result;
          this.evalrequestId = requestId;
        })
        .catch(error => {
          console.log("prueba del error");
          console.log(error);
          this.dispatchEvent(
            new ShowToastEvent({
              title: "Error in the search of the Eval of this Opportunity",
              message: "" + error,
              variant: "error",
              mode: "sticky"
            })
          );
        });

      let dateMoment = moment(
        moment(),
        "yyyy-MM-dd'T'HH:mm:ss.000-00:00"
      ).format();
      /*await cloneEvalFromEnt(this.evalEntRequest, dateMoment, this.sso, true, this.entityPartyId, this.entityName )
        .then(async result => {
          console.log("mainresult");
          console.log(result);
          let resultObject = JSON.parse(result);
          this.evalrequestId = await resultObject.requestId;
          console.log('prepost comments')
          await postComments(dateMoment, this.sso, this.opportunityName, this.evalrequestId)
          .then(async resultc=>{
             console.log("resultcomments")
             await console.log(resultc);
          }).catch(async erro=>{
            console.log('erro post comments')
            await console.log(erro)
          })
          console.log('after post comments')
        })
        .catch(error => {
          this.dispatchEvent(
            new ShowToastEvent({
              title: "Error durante el clonado del Eval",
              message: "" + error,
              variant: "error",
              mode: "sticky"
            })
          );
        });*/
      await updateOPPWhitEval(this.recordId, this.evalrequestId)
        .then(async () => {
          this.dispatchEvent(
            new ShowToastEvent({
              title: "Success",
              message: "Eval linked to Opportunity",
              variant: "success"
            })
          );

          let func = getevalRecord.bind(this);
          let resultado = await func();
          console.log(resultado);

          this.section = detailEval;
        })
        .catch(error => {
          console.log("elerror");

          console.log(error);
          this.dispatchEvent(
            new ShowToastEvent({
              title: "error al  ligar el Eval a la Oportunidad",
              message: "" + error,
              variant: "error",
              mode: "sticky"
            })
          );
        });

      this.loadSearch = false;
    }
  }

  get urlEval() {
    let url =
      "/one/one.app#/alohaRedirect/apex/ES4_ReadPage_EVAL?requestId=" +
      this.evalrequestId +
      "&TakedownId=" +
      this.recordId +
      "&from=Takedown";
    return url;
  }

  previewEvalTable(event) {
    event.preventDefault();
    let requestId = event.target.dataset.requestid;
    let url =
      "/one/one.app#/alohaRedirect/apex/ES4_ReadPage_EVAL?requestId=" +
      requestId +
      "&TakedownId=" +
      this.recordId +
      "&from=Takedown";
    window.open(url);
  }

  assetRowAction(event) {
    let actionName = event.detail.action.name;
    let row = event.detail.row;

    if (actionName === "VIEW") {
      let url =
        "/one/one.app#/alohaRedirect/apex/ES4_EVAL_ViewAssets?requestId=" +
        row.evAssetRequestId;
      console.log(url);
      window.open(url);
    }

    if (actionName === "VIEWVAL") {
      let url =
        "/one/one.app#/alohaRedirect/apex/ES4_EVAL_ViewValuation?requestId=" +
        row.evValValuationId;
      console.log(url);
      window.open(url);
    }
  }

  async printPDF() {
    let jsonReq = JSON.stringify(this.evalRecord);
    console.log('REQ');
    console.log(jsonReq);
    try {
      await imprimePDF({ jsonRequest: jsonReq, sSSO: this.sso });
      this.dispatchEvent(
        new ShowToastEvent({
          title: "PDF PRINT SUCCESS",
          message: "Exito al Enviar PDF",
          variant: "success",
          mode: "sticky"
        })
      );
    } catch (error) {
      this.dispatchEvent(
        new ShowToastEvent({
          title: "PDF PRINT ERROR",
          message: "" + error,
          variant: "error",
          mode: "sticky"
        })
      );
    }

  }

  async removeEval() {
    let a = confirm("Are you sure to remove this eval:" + this.evalrequestId);
    if (a) {
      this.loadSearch = true;
      this.classremove = false;
      await updateOPPWhitEval(this.recordId, "")
        .then(() => {
          this.dispatchEvent(
            new ShowToastEvent({
              title: "Success",
              message: "Eval removed success",
              variant: "success"
            })
          );

          this.evalRecord = undefined;
          this.evalStatus = undefined;
          this.evalSumary = undefined;
          this.evalAssets = undefined;
          this.evalValuations = undefined;
          this.loadSearch = false;
        })
        .catch(async error => {
          console.log("error al borrar eval");
          console.log(error);
          this.dispatchEvent(
            new ShowToastEvent({
              title: "error on delete Eval in Opportunity",
              message: "The record for this Oppotunity is Bloqued for approval",
              variant: "error",
              mode: "sticky"
            })
          );
          this.classremove = true;
          await this.getevalRecord();
          this.section = detailEval;
          this.loadSearch = false;
        });
    }
  }

  get classAcordion() {
    return this.classremove
      ? "example-accordion animated slideInLeft"
      : "example-accordion animated rotateOutUpLeft";
  }

}