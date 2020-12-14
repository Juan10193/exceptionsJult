/* eslint-disable no-console */
/* eslint-disable no-alert */
/**
 * @File Name          : tkd_LinkEvalToTakedown.js
 * @Description        :
 * @Author             : juandedios.hernandez@engeniumcapital.com
 * @Group              :
 * @Last Modified By   : juandedios.hernandez@engeniumcapital.com
 * @Last Modified On   : 28/11/2019 13:01:03
 * @Modification Log   :
 * Ver       Date            Author      		    Modification
 * 1.0    2/10/2019   juandedios.hernandez@engeniumcapital.com     Initial Version
 **/
import { LightningElement, track, wire, api } from "lwc";
import blank from "./views/blank.html";
import mainpage from "./tkd_LinkEvalToTakedown.html";
import detailEval from "./views/tkd_EvalDetail.html";
import imprimePDF from "@salesforce/apex/Takedown_EvalPrintPDF.printPdf"

import { loadScript, loadStyle } from "lightning/platformResourceLoader";
import momentJs from "@salesforce/resourceUrl/momentJs";
import Animate from "@salesforce/resourceUrl/Animate";

import searchOps from "@salesforce/apex/TKD_LinkEvaltoTakedownCallout_cls.searchEvalsInOpportunityCallout";
import searchEntity from "@salesforce/apex/TKD_LinkEvaltoTakedownCallout_cls.searchEvalsInEntities";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { getRecord } from "lightning/uiRecordApi";

import userId from "@salesforce/user/Id";

import { searchEval } from "./cloneEvalHelper";
import { cloneEvalFromEnt } from "./cloneEvalHelper";
import {postComments} from "./cloneEvalHelper";
import { updateTakedownWhitEval } from "./cloneEvalHelper";

const FIELDS = [
  "Takedowns_Contingency_plan__c.CPL_rb_Opp__c",
  "Takedowns_Contingency_plan__c.TD_fm_Party_Id__c",
  "Takedowns_Contingency_plan__c.TKD_LinkedEval__c",
  "Takedowns_Contingency_plan__c.CPL_rb_Entity_Name_CP__r.Name",
  "Takedowns_Contingency_plan__c.Name"
];
const USERSSO = ["User.EmployeeNumber"];

import { columnsAssets } from "./assetsHelper";
import { columnsValuations } from "./assetsHelper";

export default class Tkd_LinkEvalToTakedown extends LightningElement {
  @api recordId;
  @track classremove = true;
  @track opportunity;
  @track takedown;
  @track takedownName;
  @track entityPartyId;
  @track entityName;
  @track sso;
  @track userName;
  @track printPdfbutton = false;

  @track loadSearch;

  @track activeSections = [
    "Eval Summary",
    "Endorsement comment",
    "Eval Assets",
    "Valuations"
  ];

  @track listOppEvalsProporsal;
  @track listEvalsEntitiesProporsals;

  @track evalEntRequest;
  @track evalrequestId;

  @track evalRecord;
  @track endDate;
  @track evalStatus;
  @track evalSumary;
  @track evalAssets;
  @track evalValuations;

  @track section = blank;
  @track error;

  @track assetsColumns = columnsAssets;
  @track valuationsColummns = columnsValuations;

  @track amounts = [];

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
        message = error.body.map(e => e.message).join(", ");
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
    }
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
      this.takedown = await data;
      console.log('el takedown para el eval: ')
      console.log(this.takedown)
      this.takedownName = await this.takedown.fields.Name.value;
      this.opportunity = await this.takedown.fields.CPL_rb_Opp__c.value;
      this.entityPartyId = await this.takedown.fields.TD_fm_Party_Id__c.value; //es el party Id Del Customer
      this.entityName = await this.takedown.fields.CPL_rb_Entity_Name_CP__r.displayValue;
      this.evalrequestId = await this.takedown.fields.TKD_LinkedEval__c.value;
      this.getevalRecord();
    }
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
        console.log(error);
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
      if (this.opportunity) {
        searchOps({ opportunityId: this.opportunity.slice(0, -3) })
          .then(result => {
            let jsonEvalsInOpps = JSON.parse(result);
            console.log("json del evalin op");
            console.log(jsonEvalsInOpps);
            if (jsonEvalsInOpps.requests !== null) {
              let listEvals = jsonEvalsInOpps.requests.request;
              let evalsProporsal = listEvals.filter(
                evall => evall.eval.evalHeader.evEvalType === "Proposal"
              );

              resolve(evalsProporsal);
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
    return new Promise((resolve, reject) => {
      console.log(this.entityPartyId);
      if (this.entityPartyId !== null) {
        searchEntity({ partyId: this.entityPartyId })
          .then(result => {
            let jsonEvalsInEntitys = JSON.parse(result);
            if (jsonEvalsInEntitys.requests !== null) {
              let listevals = jsonEvalsInEntitys.requests.request;
              let evalsProporsal = listevals.filter(
                ({ header }) => header.ndaType === "Proposal"
              );
              resolve(evalsProporsal);
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
      }else{
        reject(new Error('Error PartyID for search entity evals'))
      }
    });
  }

  async cloneEvalEnt(event) {
    let requestId = event.target.dataset.reqid;
    let confirmClone = confirm("Areyou Sure to Clone this Eval: " + requestId);

    if (confirmClone) {
      this.loadSearch = true;
      this.classremove = true;
      await searchEval(this.sso, "SF", requestId)
        .then(result => {
          console.log("eval de entidad");
          console.log(result);
          this.evalEntRequest = result;
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

      await cloneEvalFromEnt(this.evalEntRequest, dateMoment, this.sso, false, this.entityPartyId, this.entityName)
        .then(async result => {
          console.log("mainresult");
          console.log(result);
          let resultObject = JSON.parse(result);
          this.evalrequestId = await resultObject.requestId;
          console.log('prepost comments')
          console.log('comments requestId: ' + this.evalrequestId)
          await postComments(dateMoment, this.sso, this.takedownName, this.evalrequestId)
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
        });

       
       
      await updateTakedownWhitEval(this.recordId, this.evalrequestId)
        .then(() => {
          this.dispatchEvent(
            new ShowToastEvent({
              title: "Success",
              message: "Eval linked to takedown",
              variant: "success"
            })
          );

          this.getevalRecord();

          this.section = detailEval;
        })
        .catch(error => {
          console.log("elerror");

          console.log(error);
          this.dispatchEvent(
            new ShowToastEvent({
              title: "error al  ligar el Eval al takedown",
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
    let confirmClone = confirm("Areyou Sure to Clone this Eval: " + requestId);

    if (confirmClone) {
      this.loadSearch = true;
      this.classremove = true;
      await searchEval(this.sso, "SF", requestId)
        .then(result => {
          console.log("eval de opp");
          console.log(result);
          this.evalEntRequest = result;
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
      await cloneEvalFromEnt(this.evalEntRequest, dateMoment, this.sso, true, this.entityPartyId, this.entityName )
        .then(async result => {
          console.log("mainresult");
          console.log(result);
          let resultObject = JSON.parse(result);
          this.evalrequestId = await resultObject.requestId;
          console.log('prepost comments')
          await postComments(dateMoment, this.sso, this.takedownName, this.evalrequestId)
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
        });
      await updateTakedownWhitEval(this.recordId, this.evalrequestId)
        .then(() => {
          this.dispatchEvent(
            new ShowToastEvent({
              title: "Success",
              message: "Eval linked to takedown",
              variant: "success"
            })
          );

          this.getevalRecord();

          this.section = detailEval;
        })
        .catch(error => {
          console.log("elerror");

          console.log(error);
          this.dispatchEvent(
            new ShowToastEvent({
              title: "error al  ligar el Eval al takedown",
              message: "" + error,
              variant: "error",
              mode: "sticky"
            })
          );
        });

      this.loadSearch = false;
    }
  }

  async getevalRecord() {
    this.section = blank;
    if ((this.evalrequestId !== null) & (this.evalrequestId !== undefined)) {
      await searchEval(this.sso, "SF", this.evalrequestId)
        .then(result => {
          console.log("el evallll");
          console.log(result);
          this.evalRecord = result;
          this.printPdfbutton = true;
          this.evalStatus = result.requests.request[0].header.requestStatus;
          this.evalSumary = this.evalRecord.requests.request[0].eval.evalHeader;
          if (
            result.requests.request[0].header !== null &&
            result.requests.request[0].header !== undefined
          ) {
            this.endDate = result.requests.request[0].header.endDate;
          }
          if (
            (result.requests.request[0].eval.evalDetail !== null) &
            (result.requests.request[0].eval.evalDetail !== undefined)
          ) {
            this.evalAssets = this.evalRecord.requests.request[0].eval.evalDetail.evAssets.evAsset;
            console.log("los evals asset");
            console.log(this.evalAssets);
            if (this.evalAssets.length > 0) {
              try {
                let arrvalu = [...this.evalAssets].filter(
                  ({ evAssetValuations }) => evAssetValuations
                );
                console.log("ARRvalu");
                console.log(arrvalu);
                let assetVal = [...arrvalu].map(
                  ({ evAssetValuations }) => evAssetValuations
                );

                console.log("LA VALUCAION");
                console.log(assetVal);
                this.evalValuations = [];
                assetVal.forEach(val => {
                  val.evValuation.forEach(valuacion => {
                    this.evalValuations.push(valuacion);
                  });
                });
                /* assetVal.map(
                  ({ evValuation }) => evValuation
                )[0]; */
                console.log("assetVal");
                console.log(this.evalValuations);

                let totalcost = this.evalSumary.evEquipmentAmountTax;
                console.log("evaltotalcost: " + totalcost);
                this.evalAssets.forEach(assetb => {
                  this.evalValuations.forEach(valuationb => {
                    if (valuationb.evValAssetId === assetb.evAssetAssetId) {
                      let amount = {
                        fmv: valuationb.evValFmvAmount!==undefined? valuationb.evValFmvAmount * assetb.evAssetQuantity: 0 * assetb.evAssetQuantity,
                        nrv: valuationb.evValNrvAmount!==undefined? valuationb.evValNrvAmount * assetb.evAssetQuantity: 0 * assetb.evAssetQuantity,
                        olv: valuationb.evValOlvAmount!== undefined? valuationb.evValOlvAmount  * assetb.evAssetQuantity: 0 * assetb.evAssetQuantity,
                        rv: valuationb.evValRvAmount!==undefined? valuationb.evValRvAmount * assetb.evAssetQuantity: 0 * assetb.evAssetQuantity,
                        months: valuationb.evValTermMonths,
                        assetid: valuationb.evValAssetId,
                        insurance: valuationb.evValInsurancePrima
                      };
                      this.amounts.push(amount);
                    }
                  });
                });

                let elementos = [];

                this.amounts.forEach(el => {
                  let am = this.amounts.filter(
                    ({ months }) => months === el.months
                  );
                  let estru = {
                    fmv: 0,
                    nrv: 0,
                    olv: 0,
                    rv: 0,
                    months: el.months,
                    insurance: 0
                  };
                  am.forEach(co => {
                    estru.fmv = estru.fmv += co.fmv;
                    estru.nrv = estru.nrv += co.nrv;
                    estru.olv = estru.olv += co.olv;
                    estru.rv = estru.rv += co.rv;
                    estru.insurance = estru.insurance += co.insurance;
                    estru.months =
                      estru.months === co.months ? estru.months : co.months;
                    if (!elementos.includes(estru)) {
                      elementos.push(estru);
                    }
                  });
                });

                elementos.forEach(elem => {
                  elem.fmvPer = (elem.fmv * 100) / totalcost;
                  elem.nrvPer = (elem.nrv * 100) / totalcost;
                  elem.olvPer = (elem.olv * 100) / totalcost;
                  elem.rvPer = (elem.rv * 100) / totalcost;
                });

                let filteredList = [
                  ...new Set(elementos.map(JSON.stringify))
                ].map(JSON.parse);
                console.log(filteredList);
                this.amounts = filteredList;
                console.log("this amounts");
                console.log(this.amounts);
              } catch (error) {
                console.log(
                  "Error al cargar valuations: " + JSON.stringify(error)
                );
              }
            }
          }
          console.log("assets");
          console.log(this.evalAssets);
          if ((result !== null) & (result !== undefined)) {
            console.log("detail");
            this.section = detailEval;
          }
        })
        .catch(error => {
          this.dispatchEvent(
            new ShowToastEvent({
              title: "error al  consultar el eval ligado",
              message: "" + error,
              variant: "error",
              mode: "sticky"
            })
          );
        });
    } else {
      console.log("mainpage");
      this.section = mainpage;
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

  async printPDF(){
    let jsonReq = JSON.stringify(this.evalRecord);
    console.log('REQ');
    console.log(jsonReq);
    try{
      await imprimePDF({jsonRequest:jsonReq,sSSO:this.sso});
      this.dispatchEvent(
        new ShowToastEvent({
          title: "PDF PRINT SUCCESS",
          message: "Exito al Enviar PDF",
          variant: "success",
          mode: "sticky"
        })
      );
    }catch(error){
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
      await updateTakedownWhitEval(this.recordId, "")
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
              title: "error on delete Eval in takedown",
              message: "The record for this takedown is Bloqued for approval",
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