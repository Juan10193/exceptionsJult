/* eslint-disable @lwc/lwc/no-async-operation */
/* eslint-disable no-console */
/**
 * @File Name          : tkd_checklistTollgate1.js
 * @Description        :
 * @Author             : juandedios.hernandez@engeniumcapital.com
 * @Group              :
 * @Last Modified By   : eduardo.villegas@engeniumcapital.com
 * @Last Modified On   : 14/1/2020 16:50:46
 * @Modification Log   :
 * Ver       Date            Author      		    Modification
 * 1.0    25/10/2019   juandedios.hernandez@engeniumcapital.com     Initial Version
 **/
import { LightningElement, track, api, wire } from "lwc";
import { loadScript, loadStyle } from "lightning/platformResourceLoader";
import momentJs from "@salesforce/resourceUrl/momentJs";
import Animate from "@salesforce/resourceUrl/Animate";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { CurrentPageReference } from "lightning/navigation";
import { fireEvent } from "c/pubsub";
import { getRecord } from "lightning/uiRecordApi";
import fetchLASINTD from "@salesforce/apex/TKD_ChecklistTolgate1Controller.fetchLasInTKD";
import getTakedownInvoices from "@salesforce/apex/TKD_ChecklistTolgate1Controller.getTakedownInvoices";
import getMasterEntity from "@salesforce/apex/TKD_ChecklistTolgate1Controller.getMasterEntity";
import getSupplierInApprovalStatus from "@salesforce/apex/TKD_ChecklistTolgate1Controller.getSupplierInApprovalStatus";
import USER_ID from "@salesforce/user/Id";
import EmployeeNumber from "@salesforce/schema/User.EmployeeNumber";
import USERSNAME from "@salesforce/schema/User.Name";
import requestToContent from "@salesforce/apex/TKD_ChecklistTolgate1Controller.requestToContent";
import { CryptoJS } from "c/criptojs";
import getKey from "@salesforce/apex/DataAccessEncriptationkeysmdt.getEncriptationDocumentsV2";
import getUrl from "@salesforce/apex/MetadataUrls.getUrlDocs";
import {
  getValidations,
  translateProduct,
  getExclude
} from "./hceklistTollgate1Helper";
const FIELDS = [
  "Takedowns_Contingency_plan__c.TKD_LinkedEval__c",
  "Takedowns_Contingency_plan__c.CPL_rb_Opp__c",
  "Takedowns_Contingency_plan__c.TKD_ls_takedown_stage__c",
  "Takedowns_Contingency_plan__c.CPL_ls_Product__c",
  "Takedowns_Contingency_plan__c.Name",
  "Takedowns_Contingency_plan__c.TKD_Tollgate_1_Val__c",
  "Takedowns_Contingency_plan__c.TKD_fm_Opportunity_expiration_date__c",
  "Takedowns_Contingency_plan__c.TKD_fm_Remaining_days_to_expiration_date__c",
  "Takedowns_Contingency_plan__c.Financing_Needs__c",
  "Takedowns_Contingency_plan__c.CPL_ls_Deal_Category__c",
  "Takedowns_Contingency_plan__c.TKD_rb_Pricin_CA__r.ES3_rb_Credit_approval_CP__c",
  "Takedowns_Contingency_plan__c.Created_Date__c"
];
const COLUMNSVAL = [
  { label: "ID", fieldName: "entidad" },
  { label: "MISSING DOCUMENT", fieldName: "typeDocumentName" }
];
import { updateRecord } from "lightning/uiRecordApi";
import ID_FIELD from "@salesforce/schema/Takedowns_Contingency_plan__c.Id";
import PRETOLLGATE1_FIELD from "@salesforce/schema/Takedowns_Contingency_plan__c.TKD_Pre_Tollgate_1_Docs__c";
import TOLLGATE1_FIELD from "@salesforce/schema/Takedowns_Contingency_plan__c.TKD_Tollgate_1_Val__c";
import PRETOLLGATE2_FIELD from "@salesforce/schema/Takedowns_Contingency_plan__c.TKD_Pre_Tollgate_2_Val__c";
import TOLLGATE2_FIELD from "@salesforce/schema/Takedowns_Contingency_plan__c.TKD_Tollgate_2_Val__c";
import tollgate2review from "@salesforce/schema/Takedowns_Contingency_plan__c.TKD_tollgate2_Review__c";
import unlockRecord from "@salesforce/apex/TKD_ChecklistTolgate1Controller.unlockForUpdate";
import lockRecord from "@salesforce/apex/TKD_ChecklistTolgate1Controller.lockForApproval";

export default class Tkd_checklistTollgate1 extends LightningElement {
  @api recordId;
  @wire(CurrentPageReference) pageRef;
  @track openmodel = false;
  @track takedown;
  @track takedownStage;
  @track takedownName;
  @track takedownProduct;
  @track cAId;

  @track linkedLegals;
  @track contieneEval;
  @track suppliersApproved;
  @track invoicesValidation;
  @track opportunityValid;

  @track activeSections = ["A", "B", "C"];
  @track userSSO;
  @track userName;
  @track culumnasVal = COLUMNSVAL;
  @track validations;
  @track processName;
  @track takedownT1Val;
  @track showTakdownT2Val = false;
  @track takedownFinanceNeed;
  @track takedownDealCategory;
  @track typeProcessCode;
  @track fechaCreacion;

  fieldstoreviewr2 = [tollgate2review];

  @track progress = 0;
  @track isProgressing = false;

  renderedCallback() {
    Promise.all([loadScript(this, momentJs), loadStyle(this, Animate)]).then(
      () => {
        console.log("Scripts cargadinos");
      }
    );
  }

  @wire(getRecord, { recordId: "$recordId", fields: FIELDS })
  wiredRecord({ error, data }) {
    if (error) {
      let message = "Unknown error";
      if (Array.isArray(error.body)) {
        message = error.body.map(e => e.message).join(", ");
      } else if (typeof error.body.message === "string") {
        message = error.body.message;
      }
      this.dispatchEvent(
        new ShowToastEvent({
          title: "Error loading Takdown for checklist",
          message,
          variant: "error"
        })
      );
    } else if (data) {
      this.takedown = data;
      this.takedownStage = this.takedown.fields.TKD_ls_takedown_stage__c.value;
      this.takedownName = this.takedown.fields.Name.value;
      this.takedownProduct = this.takedown.fields.CPL_ls_Product__c.value;
      console.log("valores " + JSON.stringify(this.takedown));
      this.takedownDealCategory = this.takedown.fields.CPL_ls_Deal_Category__c.value;
      this.fechaCreacion= this.takedown.fields.Created_Date__c.value;
      console.log(`fecha creacion : ${this.fechaCreacion}`);
      this.takedownFinanceNeed = this.takedown.fields.Financing_Needs__c.value;
      this.contieneEval =
        this.takedown.fields.TKD_LinkedEval__c.value !== null ? true : false;
      this.takedownT1Val = this.takedown.fields.TKD_Tollgate_1_Val__c.value;
      this.cAId =  this.takedown.fields.TKD_rb_Pricin_CA__r.value.fields.ES3_rb_Credit_approval_CP__c.value;
      console.log(
        `tollgate del CAID takedown`
      );
      console.log(this.cAId)
    }
  }
  @wire(getKey)
  async wiredKey({ error, data }) {
    if (data) {
      this.key = data;
      this.error = undefined;
      await getUrl()
        .then(result => {
          this.url = result;
          this.errore = undefined;
        })
        .catch(errore => {
          this.errore = errore;
          this.url = undefined;
          // eslint-disable-next-line no-console
          console.log("error in get url: " + this.errore);
        });
    } else if (error) {
      this.error = error;
      this.key = undefined;
      // eslint-disable-next-line no-console
      console.log("error in get key: " + error);
    }
  }
  @wire(getRecord, { recordId: USER_ID, fields: [EmployeeNumber, USERSNAME] })
  wireuser({ error, data }) {
    if (error) {
      this.dispatchEvent(
        new ShowToastEvent({
          title: "Error al cargar sso",
          message: "" + JSON.stringify(error),
          variant: "error"
        })
      );
    } else if (data) {
      this.userSSO = data.fields.EmployeeNumber.value;
      console.log(`SSO: ${this.userSSO}`);
      this.userName = data.fields.Name.value;
    }
  }

  openmodal() {
    this.openmodel = true;
    fetchLASINTD({ takedownId: this.recordId })
      .then(result => {
        this.linkedLegals = result.length > 0 ? true : false;
        console.log("Linked Legals");
        console.log(this.linkedLegals);
      })
      .catch(error => {
        console.log("Error loading Linked Legals ");
        console.log(error);
        this.dispatchEvent(
          new ShowToastEvent({
            title: "Error loading Linked Legals ",
            message: "" + JSON.stringify(error),
            variant: "error"
          })
        );
      });
    getTakedownInvoices({ takedownId: this.recordId })
      .then(result => {
        console.log("takedown Invoices " + JSON.stringify(result));
        if (result.length > 0) {
          let documentsWithoutValidation = result.filter(
            ({ TKD_ls_SAT_Status__c, TKD_ls_Eng_Status__c }) => {
              return (
                (TKD_ls_SAT_Status__c !== "action:approval") &
                (TKD_ls_SAT_Status__c !== "action:close") &
                (TKD_ls_Eng_Status__c !== "action:approval") &
                (TKD_ls_Eng_Status__c !== "action:close")
              );
            }
          );
          this.invoicesValidation =
            documentsWithoutValidation.length > 0 ? false : true;
        } else {
          this.invoicesValidation = false;
        }
      })
      .catch(error => {
        console.log("Error loading takedown Invoices");
        console.log(error);
        this.dispatchEvent(
          new ShowToastEvent({
            title: "Error loading takedown Invoices",
            message: "" + JSON.stringify(error),
            variant: "error"
          })
        );
      });
    getSupplierInApprovalStatus({ takedownId: this.recordId })
      .then(result => {
        console.log("Approval Status " + JSON.stringify(result));
        if (result.length > 0) {
          let suppliersNotApproved = result.filter(
            sa => sa.tkd_ls_Stage__c !== "APPROVED"
          );
          console.log(
            "suppliersNotApproved " + JSON.stringify(suppliersNotApproved)
          );
          if (suppliersNotApproved.length > 0) {
            this.suppliersApproved = false;
          } else {
            this.suppliersApproved = true;
          }
        } else {
          this.suppliersApproved = false;
        }
        console.log("this.suppliersApproved " + this.suppliersApproved);
      })
      .catch(error => {
        console.log("Error Approval Status");
        console.log(error);
        this.dispatchEvent(
          new ShowToastEvent({
            title: "Error loading approval status",
            message: "" + JSON.stringify(error),
            variant: "error"
          })
        );
      });
    //valida fecha this.takedown
    try {
      let expirationDate = moment(
        this.takedown.fields.TKD_fm_Opportunity_expiration_date__c.value
      );
      let today = new Date();
      let todayDate = moment(moment(), "YYYY-MM-DD").format();
      console.log("validando op expiration date: " + expirationDate);
      if (expirationDate.isSameOrAfter(todayDate)) {
        console.log("ES VIGENTE");
        this.opportunityValid = true;
      } else {
        console.log("Expiro");
        this.opportunityValid = false;
      }
    } catch (error) {
      console.log("error");
    }
    this.getContent();
  }
  closeModal() {
    this.openmodel = false;
  }
  saveMethod() {}

  async getContent() {
    let messageStructureArr = await this.getDatos();
    let messageStructure = messageStructureArr.map((val, index) => {
      return {
        identifier: this.takedownName,
        name: val.ES2_tx_Oracle_Account_Name__c.replace("  ", " "),
        rfc: val.TKD_txt_RFC__c,
        type: 2, //"PROCESS",
        person: val.ES2_tx_CostumerType__c === "ORGANIZATION" ? 1 : 0,
        customerType: val.ES2_tx_CostumerType__c,
        customerId: val.ES2_tx_Party_Id__c
      };
    });
    console.log("ESTRUCTURA final");
    console.log(messageStructure);
    let proceso;
    let productTranslate = translateProduct(this.takedownProduct);
    let exclude;
    switch (this.takedownStage) {
      case "Converted":
        if (
          this.takedownDealCategory === "Release" ||
          this.takedownDealCategory === "Refi"
        ) {
          proceso = "13";
          this.processName = "TAKEDOWN REFI CONVERTED";
        }else if(this.takedownDealCategory ==="Workout Restructure" & (this.takedownProduct =='PRESTAMO-FIJA' ||  this.takedownProduct=='PRESTAMO-VAR') & this.forWOAlprocess()){
          proceso = "TAKEDOWN_WORK_OUT_LOAN_CONVERTED";
          this.processName = "TAKEDOWN_WORK_OUT_LOAN_CONVERTED";
        }else if(this.takedownDealCategory ==="Workout Restructure" & (this.takedownProduct =='AFINAN-FIJA' ||  this.takedownProduct=='AFINAN-VAR') & this.forWOAlprocess()){
          proceso = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_FINANCIERO_CONVERTED";
          this.processName = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_FINANCIERO_CONVERTED";
        }else if(this.takedownDealCategory ==="Workout Restructure" & this.takedownProduct =='OPERFIN-FIJA' & this.forWOAlprocess()){
          proceso = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_PURO_CONVERTED";
          this.processName = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_PURO_CONVERTED";
        }else if(this.takedownDealCategory ==="Not new origination" & (this.takedownProduct =='PRESTAMO-FIJA' ||  this.takedownProduct=='PRESTAMO-VAR') & this.forWOAlprocess()){
          proceso = "ALIVIO_LOAN_CONVERTED";
          this.processName = "ALIVIO_LOAN_CONVERTED";
        }else if(this.takedownDealCategory ==="Not new origination" & (this.takedownProduct =='AFINAN-FIJA' ||  this.takedownProduct=='AFINAN-VAR') & this.forWOAlprocess()){
          proceso = "ALIVIO_ARRENDAMIENTO_FINANCIERO_CONVERTED";
          this.processName = "ALIVIO_ARRENDAMIENTO_FINANCIERO_CONVERTED";
        }else if(this.takedownDealCategory ==="Not new origination" & this.takedownProduct =='OPERFIN-FIJA' & this.forWOAlprocess()){
          proceso = "ALIVIO_ARRENDAMIENTO_PURO_CONVERTED";
          this.processName = "ALIVIO_ARRENDAMIENTO_PURO_CONVERTED";
        } else {
          switch (productTranslate) {
            case "TAKEDOWN LOAN CONVERTED":
              proceso = "1";
              this.processName = "TAKEDOWN LOAN CONVERTED";
              break;
            case "TAKEDOWN ARRENDAMIENTO FINANCIERO CONVERTED":
              proceso = "2";
              this.processName = "TAKEDOWN ARRENDAMIENTO FINANCIERO CONVERTED";

              try {
                exclude = await getExclude(
                  this.takedownProduct,
                  this.takedownFinanceNeed,
                  this.takedownDealCategory
                );
              } catch (error) {
                console.log(error);
              }
              break;
            case "TAKEDOWN ARRENDAMIENTO PURO CONVERTED":
              if (
                this.takedownDealCategory === "Release" ||
                this.takedownDealCategory === "Refi"
              ) {
                proceso = "13";
                this.processName = "TAKEDOWN REFI CONVERTED";
              } else {
                proceso = "3";
                this.processName = "TAKEDOWN ARRENDAMIENTO PURO CONVERTED";
              }
              try {
                exclude = await getExclude(
                  this.takedownProduct,
                  this.takedownFinanceNeed,
                  this.takedownDealCategory
                );
              } catch (error) {
                console.log(error);
              }
              break;
            case "TAKEDOWN ARRENDAMIENTO FINANCIERO PROGRESS":
              proceso = "2";
              this.processName = "TAKEDOWN ARRENDAMIENTO FINANCIERO CONVERTED";
              try {
                exclude = await getExclude(
                  this.takedownProduct,
                  this.takedownFinanceNeed,
                  this.takedownDealCategory
                );
              } catch (error) {
                console.log(error);
              }
              break;
            default:
              break;
          }
        }
        break;
      case "Tollgate 1":
        if (
          this.takedownDealCategory === "Release" ||
          this.takedownDealCategory === "Refi"
        ) {
          proceso = "7";
          this.processName = "TAKEDOWN RELEASE REFI TG1";
        }else if(this.takedownDealCategory ==="Workout Restructure" & (this.takedownProduct =='PRESTAMO-FIJA' ||  this.takedownProduct=='PRESTAMO-VAR') & this.forWOAlprocess()){
          proceso = "TAKEDOWN_WORK_OUT_LOAN_TG1";
          this.processName = "TAKEDOWN_WORK_OUT_LOAN_TG1";
        }else if(this.takedownDealCategory ==="Workout Restructure" & (this.takedownProduct =='AFINAN-FIJA' ||  this.takedownProduct=='AFINAN-VAR') & this.forWOAlprocess()){
          proceso = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_FINANCIERO_TG1";
          this.processName = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_FINANCIERO_TG1";
        }else if(this.takedownDealCategory ==="Workout Restructure" & this.takedownProduct =='OPERFIN-FIJA' & this.forWOAlprocess()){
          proceso = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_PURO_TG1";
          this.processName = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_PURO_TG1";
        }else if(this.takedownDealCategory ==="Not new origination" & (this.takedownProduct =='PRESTAMO-FIJA' ||  this.takedownProduct=='PRESTAMO-VAR') & this.forWOAlprocess()){
          proceso = "ALIVIO_LOAN_TG1";
          this.processName = "ALIVIO_LOAN_TG1";
        }else if(this.takedownDealCategory ==="Not new origination" & (this.takedownProduct =='AFINAN-FIJA' ||  this.takedownProduct=='AFINAN-VAR') & this.forWOAlprocess()){
          proceso = "ALIVIO_ARRENDAMIENTO_FINANCIERO_TG1";
          this.processName = "ALIVIO_ARRENDAMIENTO_FINANCIERO_TG1";
        }else if(this.takedownDealCategory ==="Not new origination" & this.takedownProduct =='OPERFIN-FIJA' & this.forWOAlprocess()){
          proceso = "ALIVIO_ARRENDAMIENTO_PURO_TG1";
          this.processName = "ALIVIO_ARRENDAMIENTO_PURO_TG1";
        } else {
          switch (productTranslate) {
            case "TAKEDOWN LOAN CONVERTED":
              proceso = "4";
              this.processName = "TAKEDOWN LOAN TG1";
              break;

            case "TAKEDOWN ARRENDAMIENTO FINANCIERO CONVERTED":
              proceso = "5";
              this.processName = "TAKEDOWN ARRENDAMIENTO FINANCIERO TG1";
              try {
                exclude = await getExclude(
                  this.takedownProduct,
                  this.takedownFinanceNeed,
                  this.takedownDealCategory
                );
              } catch (error) {
                console.log(error);
              }
              break;

            case "TAKEDOWN ARRENDAMIENTO PURO CONVERTED":
              proceso = "6";
              this.processName = "TAKEDOWN ARRENDAMIENTO PURO TG1";
              try {
                exclude = await getExclude(
                  this.takedownProduct,
                  this.takedownFinanceNeed,
                  this.takedownDealCategory
                );
              } catch (error) {
                console.log(error);
              }
              break;

            case "TAKEDOWN ARRENDAMIENTO FINANCIERO PROGRESS":
              proceso = "5";
              this.processName = "TAKEDOWN ARRENDAMIENTO FINANCIERO TG1";
              try {
                exclude = await getExclude(
                  this.takedownProduct,
                  this.takedownFinanceNeed,
                  this.takedownDealCategory
                );
              } catch (error) {
                console.log(error);
              }
              break;

            default:
              break;
          }
        }
        break;
      case "In Signatures":
        if (
          this.takedownDealCategory === "Release" ||
          this.takedownDealCategory === "Refi"
        ) {
          proceso = "11";
          this.processName = "TAKEDOWN RELEASE REFI ISC";
        }else if(this.takedownDealCategory ==="Workout Restructure" & (this.takedownProduct =='PRESTAMO-FIJA' ||  this.takedownProduct=='PRESTAMO-VAR') & this.forWOAlprocess()){
          proceso = "TAKEDOWN_WORK_OUT_LOAN_ISC";
          this.processName = "TAKEDOWN_WORK_OUT_LOAN_ISC";
        }else if(this.takedownDealCategory ==="Workout Restructure" & (this.takedownProduct =='AFINAN-FIJA' ||  this.takedownProduct=='AFINAN-VAR') & this.forWOAlprocess()){
          proceso = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_FINANCIERO_ISC";
          this.processName = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_FINANCIERO_ISC";
        }else if(this.takedownDealCategory ==="Workout Restructure" & this.takedownProduct =='OPERFIN-FIJA' & this.forWOAlprocess()){
          proceso = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_PURO_ISC";
          this.processName = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_PURO_ISC";
        }else if(this.takedownDealCategory ==="Not new origination" & (this.takedownProduct =='PRESTAMO-FIJA' ||  this.takedownProduct=='PRESTAMO-VAR') & this.forWOAlprocess()){
          proceso = "ALIVIO_LOAN_ISC";
          this.processName = "ALIVIO_LOAN_ISC";
        }else if(this.takedownDealCategory ==="Not new origination" & (this.takedownProduct =='AFINAN-FIJA' ||  this.takedownProduct=='AFINAN-VAR') & this.forWOAlprocess()){
          proceso = "ALIVIO_ARRENDAMIENTO_FINANCIERO_ISC";
          this.processName = "ALIVIO_ARRENDAMIENTO_FINANCIERO_ISC";
        }else if(this.takedownDealCategory ==="Not new origination" & this.takedownProduct =='OPERFIN-FIJA' & this.forWOAlprocess()){
          proceso = "ALIVIO_ARRENDAMIENTO_PURO_ISC";
          this.processName = "ALIVIO_ARRENDAMIENTO_PURO_ISC";
        } else {
          switch (productTranslate) {
            case "TAKEDOWN LOAN CONVERTED":
              proceso = "8";
              this.processName = "TAKEDOWN LOAN ISC";
              break;

            case "TAKEDOWN ARRENDAMIENTO FINANCIERO CONVERTED":
              proceso = "9";
              this.processName = "TAKEDOWN ARRENDAMIENTO FINANCIERO ISC";
              try {
                console.log("product:" + this.takedownProduct);
                console.log("financeneeds:" + this.takedownFinanceNeed);
                console.log(
                  "takedownDealCategory:" + this.takedownDealCategory
                );
                exclude = await getExclude(
                  this.takedownProduct,
                  this.takedownFinanceNeed,
                  this.takedownDealCategory
                );
              } catch (error) {
                console.log(error);
              }
              break;

            case "TAKEDOWN ARRENDAMIENTO PURO CONVERTED":
              proceso = "10";
              this.processName = "TAKEDOWN ARRENDAMIENTO PURO ISC";
              try {
                exclude = await getExclude(
                  this.takedownProduct,
                  this.takedownFinanceNeed,
                  this.takedownDealCategory
                );
              } catch (error) {
                console.log(error);
              }
              break;
            case "TAKEDOWN ARRENDAMIENTO FINANCIERO PROGRESS":
              proceso = "9";
              this.processName = "TAKEDOWN ARRENDAMIENTO FINANCIERO ISC";
              try {
                exclude = await getExclude(
                  this.takedownProduct,
                  this.takedownFinanceNeed,
                  this.takedownDealCategory
                );
              } catch (error) {
                console.log(error);
              }
              break;

            default:
              break;
          }
        }
        break;
      case "Tollgate 2":
        if (
          this.takedownDealCategory === "Release" ||
          this.takedownDealCategory === "Refi"
        ) {
          proceso = "11";
          this.processName = "TAKEDOWN RELEASE REFI ISC";
        }else if(this.takedownDealCategory ==="Workout Restructure" & (this.takedownProduct =='PRESTAMO-FIJA' ||  this.takedownProduct=='PRESTAMO-VAR') & this.forWOAlprocess()){
          proceso = "TAKEDOWN_WORK_OUT_LOAN_ISC";
          this.processName = "TAKEDOWN_WORK_OUT_LOAN_ISC";
        }else if(this.takedownDealCategory ==="Workout Restructure" & (this.takedownProduct =='AFINAN-FIJA' ||  this.takedownProduct=='AFINAN-VAR') & this.forWOAlprocess()){
          proceso = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_FINANCIERO_ISC";
          this.processName = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_FINANCIERO_ISC";
        }else if(this.takedownDealCategory ==="Workout Restructure" & this.takedownProduct =='OPERFIN-FIJA' & this.forWOAlprocess()){
          proceso = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_PURO_ISC";
          this.processName = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_PURO_ISC";
        }else if(this.takedownDealCategory ==="Not new origination" & (this.takedownProduct =='PRESTAMO-FIJA' ||  this.takedownProduct=='PRESTAMO-VAR') & this.forWOAlprocess()){
          proceso = "ALIVIO_LOAN_ISC";
          this.processName = "ALIVIO_LOAN_ISC";
        }else if(this.takedownDealCategory ==="Not new origination" & (this.takedownProduct =='AFINAN-FIJA' ||  this.takedownProduct=='AFINAN-VAR') & this.forWOAlprocess()){
          proceso = "ALIVIO_ARRENDAMIENTO_FINANCIERO_ISC";
          this.processName = "ALIVIO_ARRENDAMIENTO_FINANCIERO_ISC";
        }else if(this.takedownDealCategory ==="Not new origination" & this.takedownProduct =='OPERFIN-FIJA' & this.forWOAlprocess()){
          proceso = "ALIVIO_ARRENDAMIENTO_PURO_ISC";
          this.processName = "ALIVIO_ARRENDAMIENTO_PURO_ISC";
        } else {
          switch (productTranslate) {
            case "TAKEDOWN LOAN CONVERTED":
              proceso = "8";
              this.processName = "TAKEDOWN LOAN ISC";
              break;
            case "TAKEDOWN ARRENDAMIENTO FINANCIERO CONVERTED":
              proceso = "9";
              this.processName = "TAKEDOWN ARRENDAMIENTO FINANCIERO ISC";
              try {
                exclude = await getExclude(
                  this.takedownProduct,
                  this.takedownFinanceNeed,
                  this.takedownDealCategory
                );
              } catch (error) {
                console.log(error);
              }
              break;
            case "TAKEDOWN ARRENDAMIENTO PURO CONVERTED":
              proceso = "10";
              this.processName = "TAKEDOWN ARRENDAMIENTO PURO ISC";
              try {
                exclude = await getExclude(
                  this.takedownProduct,
                  this.takedownFinanceNeed,
                  this.takedownDealCategory
                );
              } catch (error) {
                console.log(error);
              }
              break;
            case "TAKEDOWN ARRENDAMIENTO FINANCIERO PROGRESS":
              proceso = "9";
              this.processName = "TAKEDOWN ARRENDAMIENTO FINANCIERO ISC";
              try {
                exclude = await getExclude(
                  this.takedownProduct,
                  this.takedownFinanceNeed,
                  this.takedownDealCategory
                );
              } catch (error) {
                console.log(error);
              }
              break;

            default:
              break;
          }
        }
        break;
      case "Registry":
        if (
          this.takedownDealCategory === "Release" ||
          this.takedownDealCategory === "Refi"
        ) {
          proceso = "11";
          this.processName = "TAKEDOWN RELEASE REFI ISC";
        }else if(this.takedownDealCategory ==="Workout Restructure" & (this.takedownProduct =='PRESTAMO-FIJA' ||  this.takedownProduct=='PRESTAMO-VAR') & this.forWOAlprocess()){
          proceso = "TAKEDOWN_WORK_OUT_LOAN_ISC";
          this.processName = "TAKEDOWN_WORK_OUT_LOAN_ISC";
        }else if(this.takedownDealCategory ==="Workout Restructure" & (this.takedownProduct =='AFINAN-FIJA' ||  this.takedownProduct=='AFINAN-VAR') & this.forWOAlprocess()){
          proceso = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_FINANCIERO_ISC";
          this.processName = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_FINANCIERO_ISC";
        }else if(this.takedownDealCategory ==="Workout Restructure" & this.takedownProduct =='OPERFIN-FIJA' & this.forWOAlprocess()){
          proceso = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_PURO_ISC";
          this.processName = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_PURO_ISC";
        }else if(this.takedownDealCategory ==="Not new origination" & (this.takedownProduct =='PRESTAMO-FIJA' ||  this.takedownProduct=='PRESTAMO-VAR') & this.forWOAlprocess()){
          proceso = "ALIVIO_LOAN_ISC";
          this.processName = "ALIVIO_LOAN_ISC";
        }else if(this.takedownDealCategory ==="Not new origination" & (this.takedownProduct =='AFINAN-FIJA' ||  this.takedownProduct=='AFINAN-VAR') & this.forWOAlprocess()){
          proceso = "ALIVIO_ARRENDAMIENTO_FINANCIERO_ISC";
          this.processName = "ALIVIO_ARRENDAMIENTO_FINANCIERO_ISC";
        }else if(this.takedownDealCategory ==="Not new origination" & this.takedownProduct =='OPERFIN-FIJA' & this.forWOAlprocess()){
          proceso = "ALIVIO_ARRENDAMIENTO_PURO_ISC";
          this.processName = "ALIVIO_ARRENDAMIENTO_PURO_ISC";
        } else {
          switch (productTranslate) {
            case "TAKEDOWN LOAN CONVERTED":
              proceso = "8";
              this.processName = "TAKEDOWN LOAN ISC";
              break;
            case "TAKEDOWN ARRENDAMIENTO FINANCIERO CONVERTED":
              proceso = "9";
              this.processName = "TAKEDOWN ARRENDAMIENTO FINANCIERO ISC";
              try {
                exclude = await getExclude(
                  this.takedownProduct,
                  this.takedownFinanceNeed,
                  this.takedownDealCategory
                );
              } catch (error) {
                console.log(error);
              }
              break;
            case "TAKEDOWN ARRENDAMIENTO PURO CONVERTED":
              proceso = "10";
              this.processName = "TAKEDOWN ARRENDAMIENTO PURO ISC";
              try {
                exclude = await getExclude(
                  this.takedownProduct,
                  this.takedownFinanceNeed,
                  this.takedownDealCategory
                );
              } catch (error) {
                console.log(error);
              }
              break;
            case "TAKEDOWN ARRENDAMIENTO FINANCIERO PROGRESS":
              proceso = "9";
              this.processName = "TAKEDOWN ARRENDAMIENTO FINANCIERO ISC";
              try {
                exclude = await getExclude(
                  this.takedownProduct,
                  this.takedownFinanceNeed,
                  this.takedownDealCategory
                );
              } catch (error) {
                console.log(error);
              }
              break;

            default:
              break;
          }
        }
        break;
      case "Funded":
        if (
          this.takedownDealCategory === "Release" ||
          this.takedownDealCategory === "Refi"
        ) {
          proceso = "11";
          this.processName = "TAKEDOWN RELEASE REFI ISC";
        }else if(this.takedownDealCategory ==="Workout Restructure" & (this.takedownProduct =='PRESTAMO-FIJA' ||  this.takedownProduct=='PRESTAMO-VAR') & this.forWOAlprocess()){
          proceso = "TAKEDOWN_WORK_OUT_LOAN_ISC";
          this.processName = "TAKEDOWN_WORK_OUT_LOAN_ISC";
        }else if(this.takedownDealCategory ==="Workout Restructure" & (this.takedownProduct =='AFINAN-FIJA' ||  this.takedownProduct=='AFINAN-VAR') & this.forWOAlprocess()){
          proceso = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_FINANCIERO_ISC";
          this.processName = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_FINANCIERO_ISC";
        }else if(this.takedownDealCategory ==="Workout Restructure" & this.takedownProduct =='OPERFIN-FIJA' & this.forWOAlprocess()){
          proceso = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_PURO_ISC";
          this.processName = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_PURO_ISC";
        }else if(this.takedownDealCategory ==="Not new origination" & (this.takedownProduct =='PRESTAMO-FIJA' ||  this.takedownProduct=='PRESTAMO-VAR') & this.forWOAlprocess()){
          proceso = "ALIVIO_LOAN_ISC";
          this.processName = "ALIVIO_LOAN_ISC";
        }else if(this.takedownDealCategory ==="Not new origination" & (this.takedownProduct =='AFINAN-FIJA' ||  this.takedownProduct=='AFINAN-VAR') & this.forWOAlprocess()){
          proceso = "ALIVIO_ARRENDAMIENTO_FINANCIERO_ISC";
          this.processName = "ALIVIO_ARRENDAMIENTO_FINANCIERO_ISC";
        }else if(this.takedownDealCategory ==="Not new origination" & this.takedownProduct =='OPERFIN-FIJA' & this.forWOAlprocess()){
          proceso = "ALIVIO_ARRENDAMIENTO_PURO_ISC";
          this.processName = "ALIVIO_ARRENDAMIENTO_PURO_ISC";
        } else {
          switch (productTranslate) {
            case "TAKEDOWN LOAN CONVERTED":
              proceso = "8";
              this.processName = "TAKEDOWN LOAN ISC";
              break;
            case "TAKEDOWN ARRENDAMIENTO FINANCIERO CONVERTED":
              proceso = "9";
              this.processName = "TAKEDOWN ARRENDAMIENTO FINANCIERO ISC";
              try {
                exclude = await getExclude(
                  this.takedownProduct,
                  this.takedownFinanceNeed,
                  this.takedownDealCategory
                );
              } catch (error) {
                console.log(error);
              }
              break;
            case "TAKEDOWN ARRENDAMIENTO PURO CONVERTED":
              proceso = "10";
              this.processName = "TAKEDOWN ARRENDAMIENTO PURO ISC";
              try {
                exclude = await getExclude(
                  this.takedownProduct,
                  this.takedownFinanceNeed,
                  this.takedownDealCategory
                );
              } catch (error) {
                console.log(error);
              }
              break;
            case "TAKEDOWN ARRENDAMIENTO FINANCIERO PROGRESS":
              proceso = "9";
              this.processName = "TAKEDOWN ARRENDAMIENTO FINANCIERO ISC";
              try {
                exclude = await getExclude(
                  this.takedownProduct,
                  this.takedownFinanceNeed,
                  this.takedownDealCategory
                );
              } catch (error) {
                console.log(error);
              }
              break;

            default:
              break;
          }
        }
        break;
      case "Closed":
        if (
          this.takedownDealCategory === "Release" ||
          this.takedownDealCategory === "Refi"
        ) {
          proceso = "11";
          this.processName = "TAKEDOWN RELEASE REFI ISC";
        }else if(this.takedownDealCategory ==="Workout Restructure" & (this.takedownProduct =='PRESTAMO-FIJA' ||  this.takedownProduct=='PRESTAMO-VAR') & this.forWOAlprocess()){
          proceso = "TAKEDOWN_WORK_OUT_LOAN_ISC";
          this.processName = "TAKEDOWN_WORK_OUT_LOAN_ISC";
        }else if(this.takedownDealCategory ==="Workout Restructure" & (this.takedownProduct =='AFINAN-FIJA' ||  this.takedownProduct=='AFINAN-VAR') & this.forWOAlprocess()){
          proceso = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_FINANCIERO_ISC";
          this.processName = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_FINANCIERO_ISC";
        }else if(this.takedownDealCategory ==="Workout Restructure" & this.takedownProduct =='OPERFIN-FIJA' & this.forWOAlprocess()){
          proceso = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_PURO_ISC";
          this.processName = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_PURO_ISC";
        }else if(this.takedownDealCategory ==="Not new origination" & (this.takedownProduct =='PRESTAMO-FIJA' ||  this.takedownProduct=='PRESTAMO-VAR') & this.forWOAlprocess()){
          proceso = "ALIVIO_LOAN_ISC";
          this.processName = "ALIVIO_LOAN_ISC";
        }else if(this.takedownDealCategory ==="Not new origination" & (this.takedownProduct =='AFINAN-FIJA' ||  this.takedownProduct=='AFINAN-VAR') & this.forWOAlprocess()){
          proceso = "ALIVIO_ARRENDAMIENTO_FINANCIERO_ISC";
          this.processName = "ALIVIO_ARRENDAMIENTO_FINANCIERO_ISC";
        }else if(this.takedownDealCategory ==="Not new origination" & this.takedownProduct =='OPERFIN-FIJA' & this.forWOAlprocess()){
          proceso = "ALIVIO_ARRENDAMIENTO_PURO_ISC";
          this.processName = "ALIVIO_ARRENDAMIENTO_PURO_ISC";
        } else {
          switch (productTranslate) {
            case "TAKEDOWN LOAN CONVERTED":
              proceso = "8";
              this.processName = "TAKEDOWN LOAN ISC";
              break;
            case "TAKEDOWN ARRENDAMIENTO FINANCIERO CONVERTED":
              proceso = "9";
              this.processName = "TAKEDOWN ARRENDAMIENTO FINANCIERO ISC";
              try {
                exclude = await getExclude(
                  this.takedownProduct,
                  this.takedownFinanceNeed,
                  this.takedownDealCategory
                );
              } catch (error) {
                console.log(error);
              }
              break;
            case "TAKEDOWN ARRENDAMIENTO PURO CONVERTED":
              proceso = "10";
              this.processName = "TAKEDOWN ARRENDAMIENTO PURO ISC";
              try {
                exclude = await getExclude(
                  this.takedownProduct,
                  this.takedownFinanceNeed,
                  this.takedownDealCategory
                );
              } catch (error) {
                console.log(error);
              }
              break;
            case "TAKEDOWN ARRENDAMIENTO FINANCIERO PROGRESS":
              proceso = "9";
              this.processName = "TAKEDOWN ARRENDAMIENTO FINANCIERO ISC";
              try {
                exclude = await getExclude(
                  this.takedownProduct,
                  this.takedownFinanceNeed,
                  this.takedownDealCategory
                );
              } catch (error) {
                console.log(error);
              }
              break;

            default:
              break;
          }
        }
        break;
      default:
        break;
    }
    if(this.takedownDealCategory !=="Workout Restructure" & this.takedownDealCategory !=="Not new origination" || 
    ((this.takedownDealCategory =="Workout Restructure" || this.takedownDealCategory =="Not new origination") & this.forWOAlprocess() ==false) ){
      this.datos = {
        userId: this.userSSO,
        userName:  this.userName,
        typeProcessId: proceso,
        processName: this.processName,
        processFKId: this.takedownName,
        exclude: exclude,
        identifiers: messageStructure
      };
    }else{
      this.datos = {
        userId: this.userSSO,
        userName:  this.userName,
        //typeProcessId: proceso,
        processName: this.processName,
        typeProcessCode:proceso,
        processFKId: this.takedownName,
        //exclude: exclude,
        identifiers: messageStructure
      };
    }
    

    // eslint-disable-next-line no-console
    console.log("ke: " + JSON.stringify(this.datos));

    /*let encrypted = CryptoJS.AES.encrypt(
      JSON.stringify(this.datos),
      this.key.EncriptationKey__c
    );
    let encriptedString = encodeURIComponent(encrypted.toString());*/

    requestToContent({ encritpData: JSON.stringify(this.datos) })
      .then(result => {
        console.log(result);
        getValidations(this.takedownProduct, JSON.parse(result))
          .then(async resVal => {
            console.log("VALIDACIONES PARA FRONT");
            console.log(resVal);
            if (resVal.length > 0) {
              this.validations = resVal.sort(this.compare);
              console.log("RHIS VALIDATIONS");
              console.log(this.validations);
              fireEvent(this.pageRef, "approvalValidations", this.validations);
            } else {
              this._interval = await setInterval(() => {
                this.isProgressing =true;
                this.progress = this.progress === 100 ? 100 : this.progress + 1;
              }, await this.successValidation());
            }
          })
          .catch(errorVal => {
            console.log("error al traer validaciones al front");
            console.log(errorVal);
          });
      })
      .catch(error => {
        console.log("Error to request content " + JSON.stringify(error));
        console.log(error);
        this.dispatchEvent(
          new ShowToastEvent({
            title: "Error to request content",
            message: "" + JSON.stringify(error),
            variant: "error"
          })
        );
      });
  }

  getDatos() {
    return new Promise((resolve, reject) => {
      getMasterEntity({ cAId: this.cAId})
        .then(result => {
          console.log("ENTIDADES EN EL CA");
          console.log(result);
          let entidadesset = []
          result.forEach(ent => {
            if(!entidadesset.some(en=>en.ES2_tx_Party_Id__c ===ent.ES2_tx_Party_Id__c)){
              entidadesset.push(ent);
            }
          });
          resolve(entidadesset);
        })
        .catch(error => {
          console.log("ERROR AL TRAER ENTIDADES PARA EL TOLGATE");
          console.log(error);
          reject(new Error(JSON.stringify(error)));
        });
    });
  }

  compare(a, b) {
    const genreA = a.typeDocumentName.toUpperCase();
    const genreB = b.typeDocumentName.toUpperCase();

    let comparison = 0;
    if (genreA > genreB) {
      comparison = 1;
    } else if (genreA < genreB) {
      comparison = -1;
    }
    return comparison;
  }

  async successValidation() {
    if (this.takedownStage === "Converted") {
      this.validations = undefined;
      const fields = {};
      fields[ID_FIELD.fieldApiName] = this.recordId;
      fields[PRETOLLGATE1_FIELD.fieldApiName] = true;
      const recordInput = { fields };

      updateRecord(recordInput)
        .then(() => {
          this.dispatchEvent(
            new ShowToastEvent({
              title: "Success",
              message: "Takedown Pretollgate 1 Pass Verification of Documents",
              variant: "success"
            })
          );
        })
        .catch(error => {
          this.dispatchEvent(
            new ShowToastEvent({
              title: "Error In save Documents Verification For Pretollgate 1",
              message: error.body.message,
              variant: "error"
            })
          );
        });
    }

    if (this.takedownStage === "Tollgate 1") {
      this.validations = undefined;
      await unlockRecord({ takedownId: this.recordId })
        .then(res => {
          console.log("SE desbloquio");
        })
        .catch(error => {
          console.log("ERROR AL QUERER DESBLOQUEAR EL REGISTRO");
          console.log(error);
        });

      const fields = {};
      fields[ID_FIELD.fieldApiName] = this.recordId;
      fields[TOLLGATE1_FIELD.fieldApiName] = true;
      const recordInput = { fields };
      console.log("EJECIT");
      await updateRecord(recordInput)
        .then(() => {
          console.log("SE COMIENZA A CTUALIZAR");
          this.dispatchEvent(
            new ShowToastEvent({
              title: "Success",
              message: "Takedown Tollgate 1 Pass Verification of Documents",
              variant: "success"
            })
          );
        })
        .catch(error => {
          console.log(error);
          this.dispatchEvent(
            new ShowToastEvent({
              title: "Error In save Verification For Tollgate 1",
              message: error.body.message,
              variant: "error"
            })
          );
        });

      lockRecord({ takedownId: this.recordId })
        .then(res => {
          console.log("SE BLOQUEA EL REGISTRO");
        })
        .catch(error => {
          console.log("ERROR AL INTENTAR BLOQUAR EL REG");
          console.log(error);
        });
    }

    if (this.takedownStage === "In Signatures") {
      this.validations = undefined;
      const fields = {};
      fields[ID_FIELD.fieldApiName] = this.recordId;
      fields[PRETOLLGATE2_FIELD.fieldApiName] = true;
      const recordInput = { fields };
      await unlockRecord({ takedownId: this.recordId })
        .then(res => {
          console.log("SE desbloquio");
        })
        .catch(error => {
          console.log("ERROR AL QUERER DESBLOQUEAR EL REGISTRO");
          console.log(error);
        });
      updateRecord(recordInput)
        .then(() => {
          this.dispatchEvent(
            new ShowToastEvent({
              title: "Success",
              message: "Takedown Pretollgate 2 Pass Verification of Documents",
              variant: "success"
            })
          );
        })
        .catch(error => {
          this.dispatchEvent(
            new ShowToastEvent({
              title: "Error In save Documents Verification For Pretollgate 2",
              message: error.body.message,
              variant: "error"
            })
          );
        });
    }

    if (this.takedownStage === "Tollgate 2") {
      this.showTakdownT2Val = true;
      this.validations = undefined;
      await unlockRecord({ takedownId: this.recordId })
        .then(res => {
          console.log("SE desbloquio");
        })
        .catch(error => {
          console.log("ERROR AL QUERER DESBLOQUEAR EL REGISTRO");
          console.log(error);
        });

      const fields = {};
      fields[ID_FIELD.fieldApiName] = this.recordId;
      fields[TOLLGATE2_FIELD.fieldApiName] = true;
      const recordInput = { fields };
      console.log("EJECIT");
      await updateRecord(recordInput)
        .then(() => {
          console.log("SE COMIENZA A CTUALIZAR");
          this.dispatchEvent(
            new ShowToastEvent({
              title: "Success",
              message: "Takedown Tollgate 2 Pass Verification of Documents",
              variant: "success"
            })
          );
        })
        .catch(error => {
          console.log(error);
          this.dispatchEvent(
            new ShowToastEvent({
              title: "Error In save Verification For Tollgate 2",
              message: error.body.message,
              variant: "error"
            })
          );
        });

      lockRecord({ takedownId: this.recordId })
        .then(res => {
          console.log("SE BLOQUEA EL REGISTRO");
        })
        .catch(error => {
          console.log("ERROR AL INTENTAR BLOQUAR EL REG");
          console.log(error);
        });
    }
    if (this.takedownStage === "Registry") {
      this.showTakdownT2Val = true;
      this.validations = undefined;
      await unlockRecord({ takedownId: this.recordId })
        .then(res => {
          console.log("SE desbloquio");
        })
        .catch(error => {
          console.log("ERROR AL QUERER DESBLOQUEAR EL REGISTRO");
          console.log(error);
        });

      const fields = {};
      fields[ID_FIELD.fieldApiName] = this.recordId;
      fields[TOLLGATE2_FIELD.fieldApiName] = true;
      const recordInput = { fields };
      console.log("EJECIT");
      await updateRecord(recordInput)
        .then(() => {
          console.log("SE COMIENZA A CTUALIZAR");
          this.dispatchEvent(
            new ShowToastEvent({
              title: "Success",
              message: "Takedown Registry Pass Verification of Documents",
              variant: "success"
            })
          );
        })
        .catch(error => {
          console.log(error);
          this.dispatchEvent(
            new ShowToastEvent({
              title: "Error In save Verification For Registry",
              message: error.body.message,
              variant: "error"
            })
          );
        });
    }
    if (this.takedownStage === "Funded") {
      this.showTakdownT2Val = true;
      this.validations = undefined;
      await unlockRecord({ takedownId: this.recordId })
        .then(res => {
          console.log("SE desbloquio");
        })
        .catch(error => {
          console.log("ERROR AL QUERER DESBLOQUEAR EL REGISTRO");
          console.log(error);
        });

      const fields = {};
      fields[ID_FIELD.fieldApiName] = this.recordId;
      fields[TOLLGATE2_FIELD.fieldApiName] = true;
      const recordInput = { fields };
      console.log("EJECIT");
      await updateRecord(recordInput)
        .then(() => {
          console.log("SE COMIENZA A CTUALIZAR");
          this.dispatchEvent(
            new ShowToastEvent({
              title: "Success",
              message: "Takedown Funded Pass Verification of Documents",
              variant: "success"
            })
          );
        })
        .catch(error => {
          console.log(error);
          this.dispatchEvent(
            new ShowToastEvent({
              title: "Error In save Verification For Funded",
              message: error.body.message,
              variant: "error"
            })
          );
        });

      lockRecord({ takedownId: this.recordId })
        .then(res => {
          console.log("SE BLOQUEA EL REGISTRO");
        })
        .catch(error => {
          console.log("ERROR AL INTENTAR BLOQUAR EL REG");
          console.log(error);
        });
    }
  }

  handleSuccessreview(event) {
    lockRecord({ takedownId: this.recordId });
    const evt = new ShowToastEvent({
      title: "Saved",
      message: "Record ID: " + event.detail.id + "has been changed",
      variant: "success"
    });
    this.dispatchEvent(evt);
  }

  handlesubmitreview(event) {
    const fields = event.detail.fields;
    event.preventDefault();
    unlockRecord({ takedownId: this.recordId });
    this.template.querySelector("lightning-record-edit-form").submit(fields);
  }

  errorreview(event) {
    lockRecord({ takedownId: this.recordId });
    const evt = new ShowToastEvent({
      title: "Error",
      message: "Error to save your choice",
      variant: "error"
    });
    this.dispatchEvent(evt);
  }

  get nameButton() {
    return `Checklist ${this.takedownStage}`;
  }

  get buttonVisbile() {
    return true;
  }

  get computedLabel() {
    return this.isProgressing
      ? "Validating Documents" + this.progress + "%"
      : "Starting";
  }
  forWOAlprocess(){ 
    let momentoFecha = moment(this.fechaCreacion , 'YYYY/MM/DD').format('DD/MM/YYYY')
    console.log('MomentoFecha' + momentoFecha );
    let momentoFechareg = moment(momentoFecha,'DD/MM/YYYY');
    if(momentoFechareg.isSame(moment('24/06/2020','DD/MM/YYYY')) || momentoFechareg.isAfter(moment('24/06/2020','DD/MM/YYYY'))){
      console.log('La fecha de creacion del takedown es despues del 24/06/2020');
      return true;
    }else{
      console.log('La fecha de creacion del takedown es antes del 24/06/2020');
      return false;
    }
  }
}