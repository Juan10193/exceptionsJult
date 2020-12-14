/**
 * @File Name          : componenteDocsV2.js
 * @Description        : Content Para Takedown
 * @Author             : ChangeMeIn@UserSettingsUnder.SFDoc
 * @Group              :
 * @Last Modified By   : ChangeMeIn@UserSettingsUnder.SFDoc
 * @Last Modified On   : 07-29-2020
 * @Modification Log   :
 *==============================================================================
 * Ver         Date                     Author      		      Modification
 *==============================================================================
 * 1.0    19/8/2019 23:29:43   jhernandez@anivia.mx     Initial Version
 **/
import { LightningElement, api, wire, track } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { CryptoJS } from "c/criptojs";
import { loadScript, loadStyle } from "lightning/platformResourceLoader";
import main from "./componenteDocsV2.html";
import blank from "./blank.html";
import getEntiesInca from "@salesforce/apex/Data_Access_EntityMastInCApproval_cls.getEntitiesMasterByCAId";
import getKey from "@salesforce/apex/DataAccessEncriptationkeysmdt.getEncriptationDocumentsV2";
import getDocsIds from "@salesforce/apex/Data_Access_TKD_Doument_Exclusionmdt.getDocIds";
import getUrl from "@salesforce/apex/MetadataUrls.getUrlDocs";
import { getRecord } from "lightning/uiRecordApi";
import USER_ID from "@salesforce/user/Id";
import SSO_FIELD from "@salesforce/schema/User.EmployeeNumber";
import USERSNAME from "@salesforce/schema/User.Name";
import { translateProduct, getExclude } from "./componenteDocsV2Helper";
import getToken from "@salesforce/apex/Takedown_WS_Tollgate_cls.getToken";
import { refreshApex } from "@salesforce/apex";
import momentJs from '@salesforce/resourceUrl/momentJs';
import Animate from "@salesforce/resourceUrl/Animate";

const FIELDS = [
  "Takedowns_Contingency_plan__c.CPL_rb_Opp__c",
  "Takedowns_Contingency_plan__c.Name",
  "Takedowns_Contingency_plan__c.TKD_ls_takedown_stage__c",
  "Takedowns_Contingency_plan__c.CPL_ls_Product__c",
  "Takedowns_Contingency_plan__c.Financing_Needs__c",
  "Takedowns_Contingency_plan__c.CPL_ls_Deal_Category__c",
  "Takedowns_Contingency_plan__c.TKD_rb_Pricin_CA__r.ES3_rb_Credit_approval_CP__c",
  "Takedowns_Contingency_plan__c.Created_Date__c"
];
export default class ComponenteDocsV2 extends LightningElement {
  @track cAId;
  @api recordId;
  @track datos;
  @track key;
  @track url;
  @track urlContent;
  @track error;
  @track errore;
  @track userSSO;
  @track userName;
  @track takedown;
  @track opportunityId;
  @track takedownName;
  @track takedownStage;
  @track takedownProduct;
  @track takedownFinanceNeed;
  @track takedownDealCategory;
  @track section = main;
  @track typeProcessCode;
  @track fechaCreacion;

  @track wiredcontent;

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

  @wire(getRecord, {
    recordId: USER_ID,
    fields: [SSO_FIELD,USERSNAME]
  })
  wireuser({ error, data }) {
    if (error) {
      console.log("error al cargar ssso");
    } else if (data) {
      this.userSSO = data.fields.EmployeeNumber.value;
      console.log(`SSO: ${this.userSSO}`);
      this.userName = data.fields.Name.value;
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
          title: "Error loading Takdown for checklist Tollgate #1",
          message,
          variant: "error"
        })
      );
    } else if (data) {
      this.section = blank;
      this.takedown = await data;
      this.opportunityId = await this.takedown.fields.CPL_rb_Opp__c.value;
      console.log(`opportunity ID CONTENT ${this.opportunityId}`);
      this.takedownName = await this.takedown.fields.Name.value;
      console.log(`Nombre del takedown ${this.takedownName}`);
      this.takedownStage = await this.takedown.fields.TKD_ls_takedown_stage__c
        .value;

      this.takedownProduct = await this.takedown.fields.CPL_ls_Product__c.value;
      this.takedownDealCategory = await this.takedown.fields
        .CPL_ls_Deal_Category__c.value;
      this.fechaCreacion= await this.takedown.fields.Created_Date__c.value;
      console.log(`fecha creacion : ${this.fechaCreacion}`);
      this.takedownFinanceNeed = await this.takedown.fields.Financing_Needs__c
        .value;
      console.log(
        `Stage del takedown ${this.takedownStage} deal: ${this.takedownDealCategory} finance: ${this.takedownFinanceNeed}`
      );
      this.cAId = await this.takedown.fields.TKD_rb_Pricin_CA__r.value.fields.ES3_rb_Credit_approval_CP__c.value;
      console.log(
        `Stage del CAID takedown`
      );
      console.log(this.cAId)
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
          console.log("TRALLENDO URL");
          this.url = result;
          console.log(this.url);
          this.errore = undefined;
        })
        .catch(errorUrl => {
          this.errore = errorUrl;
          this.url = undefined;
        });

      console.log("OPEN URL OO");
      try{
        await this.openUrl();
      }catch(e){
        console.log('error al open url')
        console.log(e)
      }finally{
        this.section = main;
      }
      
      this.section = main;
    }
  }

  /*  @wire(getKey) 
    async wiredKey(value){
        this.wiredcontent = value;
        const {data, error} = value;
        if (data) {
            this.key = data;
            this.error =undefined;
            await getUrl()
            .then(result =>{
                this.url = result;
                this.errore=undefined;
                this.openUrl();
            }).catch(errore =>{
                this.errore = errore;
                this.url = undefined;
                // eslint-disable-next-line no-console
                console.log('error in get url: ' + this.errore);
            })

        } else if (error){
            this.error = error;
            this.key = undefined;
            // eslint-disable-next-line no-console
            console.log('error in get key: ' + error);
        }
    } 
 */

  async openUrl() {
    let messageStructureArr = await this.getDatos();
    let messageStructure = messageStructureArr.map((val, index) => {
      if(val.TKD_txt_RFC__c){
        return {
          //identifier: this.takedownName,
          name: val.ES2_tx_Oracle_Account_Name__c.replace("  ", " "),
          rfc: val.TKD_txt_RFC__c.replace(/&/g, '_'),
          type: 2, //"PROCESS",
          person: val.ES2_tx_CostumerType__c === "ORGANIZATION" ? 1 : 0
          //customerType: val.ES2_tx_CostumerType__c==='ORGANIZATION'?1:val.ES2_tx_CostumerType__c===,
          //customerId: val.ES2_tx_Party_Id__c
        };
      }else{
        return {
          //identifier: this.takedownName,
          name: val.ES2_tx_Oracle_Account_Name__c.replace("  ", " "),
          rfc: val.TKD_txt_RFC__c,
          type: 2, //"PROCESS",
          person: val.ES2_tx_CostumerType__c === "ORGANIZATION" ? 1 : 0
          //customerType: val.ES2_tx_CostumerType__c==='ORGANIZATION'?1:val.ES2_tx_CostumerType__c===,
          //customerId: val.ES2_tx_Party_Id__c
        };
      }
     
    });
    console.log("ESTRUCTURA final");
    console.log(messageStructure);
    let proceso;
    let processName;
    let productTranslate = translateProduct(this.takedownProduct);
    let exclude;
    switch (this.takedownStage) {
      case "Converted":
        if (
          this.takedownDealCategory === "Release" ||
          this.takedownDealCategory === "Refi"
        ) {
          proceso = "13";
          processName = "TAKEDOWN REFI CONVERTED";
        }else if(this.takedownDealCategory ==="Workout Restructure" & (this.takedownProduct =='PRESTAMO-FIJA' ||  this.takedownProduct=='PRESTAMO-VAR') & this.forWOAlprocess()){
          proceso  = "TAKEDOWN_WORK_OUT_LOAN_CONVERTED";
          processName = "TAKEDOWN WORK OUT LOAN CONVERTED";
        }else if(this.takedownDealCategory ==="Workout Restructure" & (this.takedownProduct =='AFINAN-FIJA' ||  this.takedownProduct=='AFINAN-VAR') & this.forWOAlprocess()){
          proceso  = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_FINANCIERO_CONVERTED";
          processName = "TAKEDOWN WORKOUT ARRENDAMIENTO FINANCIERO CONVERTED";
        }else if(this.takedownDealCategory ==="Workout Restructure" & this.takedownProduct =='OPERFIN-FIJA' & this.forWOAlprocess()){
          proceso  = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_PURO_CONVERTED";
          processName = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_PURO_CONVERTED";
        }else if(this.takedownDealCategory ==="Not new origination" & (this.takedownProduct =='PRESTAMO-FIJA' ||  this.takedownProduct=='PRESTAMO-VAR') & this.forWOAlprocess()){
          proceso  = "ALIVIO_LOAN_CONVERTED";
          processName = "ALIVIO_LOAN_CONVERTED";
        }else if(this.takedownDealCategory ==="Not new origination" & (this.takedownProduct =='AFINAN-FIJA' ||  this.takedownProduct=='AFINAN-VAR') & this.forWOAlprocess()){
          proceso  = "ALIVIO_ARRENDAMIENTO_FINANCIERO_CONVERTED";
          processName = "ALIVIO_ARRENDAMIENTO_FINANCIERO_CONVERTED";
        }else if(this.takedownDealCategory ==="Not new origination" & this.takedownProduct =='OPERFIN-FIJA' & this.forWOAlprocess()){
          proceso  = "ALIVIO_ARRENDAMIENTO_PURO_CONVERTED";
          processName = "ALIVIO_ARRENDAMIENTO_PURO_CONVERTED";
        } else {
          switch (productTranslate) {
            case "TAKEDOWN LOAN CONVERTED":
              proceso = "1";
              processName = "TAKEDOWN LOAN CONVERTED";
              break;
            case "TAKEDOWN ARRENDAMIENTO FINANCIERO CONVERTED":
              proceso = "2";
              processName = "TAKEDOWN ARRENDAMIENTO FINANCIERO CONVERTED";

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
                processName = "TAKEDOWN REFI CONVERTED";
              } else {
                proceso = "3";
                processName = "TAKEDOWN ARRENDAMIENTO PURO CONVERTED";
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
              processName = "TAKEDOWN ARRENDAMIENTO FINANCIERO CONVERTED";
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
          processName = "TAKEDOWN RELEASE REFI TG1";
        }else if(this.takedownDealCategory ==="Workout Restructure" & (this.takedownProduct =='PRESTAMO-FIJA' ||  this.takedownProduct=='PRESTAMO-VAR') & this.forWOAlprocess()){
          proceso  = "TAKEDOWN_WORK_OUT_LOAN_TG1";
          processName = "TAKEDOWN_WORK_OUT_LOAN_TG1";
        }else if(this.takedownDealCategory ==="Workout Restructure" & (this.takedownProduct =='AFINAN-FIJA' ||  this.takedownProduct=='AFINAN-VAR') & this.forWOAlprocess()){
          proceso  = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_FINANCIERO_TG1";
          processName = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_FINANCIERO_TG1";
        }else if(this.takedownDealCategory ==="Workout Restructure" & this.takedownProduct =='OPERFIN-FIJA' & this.forWOAlprocess()){
          proceso  = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_PURO_TG1";
          processName = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_PURO_TG1";
        }else if(this.takedownDealCategory ==="Not new origination" & (this.takedownProduct =='PRESTAMO-FIJA' ||  this.takedownProduct=='PRESTAMO-VAR') & this.forWOAlprocess()){
          proceso  = "ALIVIO_LOAN_TG1";
          processName = "ALIVIO_LOAN_TG1";
        }else if(this.takedownDealCategory ==="Not new origination" & (this.takedownProduct =='AFINAN-FIJA' ||  this.takedownProduct=='AFINAN-VAR') & this.forWOAlprocess()){
          proceso  = "ALIVIO_ARRENDAMIENTO_FINANCIERO_TG1";
          processName = "ALIVIO_ARRENDAMIENTO_FINANCIERO_TG1";
        }else if(this.takedownDealCategory ==="Not new origination" & this.takedownProduct =='OPERFIN-FIJA' & this.forWOAlprocess()){
          proceso  = "ALIVIO_ARRENDAMIENTO_PURO_TG1";
          processName = "ALIVIO_ARRENDAMIENTO_PURO_TG1";
        }else {
          switch (productTranslate) {
            case "TAKEDOWN LOAN CONVERTED":
              proceso = "4";
              processName = "TAKEDOWN LOAN TG1";
              break;

            case "TAKEDOWN ARRENDAMIENTO FINANCIERO CONVERTED":
              proceso = "5";
              processName = "TAKEDOWN ARRENDAMIENTO FINANCIERO TG1";
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
              processName = "TAKEDOWN ARRENDAMIENTO PURO TG1";
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
              processName = "TAKEDOWN ARRENDAMIENTO FINANCIERO TG1";
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
          processName = "TAKEDOWN RELEASE REFI ISC";
        }else if(this.takedownDealCategory ==="Workout Restructure" & (this.takedownProduct =='PRESTAMO-FIJA' ||  this.takedownProduct=='PRESTAMO-VAR') & this.forWOAlprocess()){
          proceso  = "TAKEDOWN_WORK_OUT_LOAN_ISC";
          processName = "TAKEDOWN_WORK_OUT_LOAN_ISC";
        }else if(this.takedownDealCategory ==="Workout Restructure" & (this.takedownProduct =='AFINAN-FIJA' ||  this.takedownProduct=='AFINAN-VAR') & this.forWOAlprocess()){
          proceso  = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_FINANCIERO_ISC";
          processName = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_FINANCIERO_ISC";
        }else if(this.takedownDealCategory ==="Workout Restructure" & this.takedownProduct =='OPERFIN-FIJA' & this.forWOAlprocess()){
          proceso  = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_PURO_ISC";
          processName = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_PURO_ISC";
        }else if(this.takedownDealCategory ==="Not new origination" & (this.takedownProduct =='PRESTAMO-FIJA' ||  this.takedownProduct=='PRESTAMO-VAR') & this.forWOAlprocess()){
          proceso  = "ALIVIO_LOAN_ISC";
          processName = "ALIVIO_LOAN_ISC";
        }else if(this.takedownDealCategory ==="Not new origination" & (this.takedownProduct =='AFINAN-FIJA' ||  this.takedownProduct=='AFINAN-VAR') & this.forWOAlprocess()){
          proceso  = "ALIVIO_ARRENDAMIENTO_FINANCIERO_ISC";
          processName = "ALIVIO_ARRENDAMIENTO_FINANCIERO_ISC";
        }else if(this.takedownDealCategory ==="Not new origination" & this.takedownProduct =='OPERFIN-FIJA' & this.forWOAlprocess()){
          proceso  = "ALIVIO_ARRENDAMIENTO_PURO_ISC";
          processName = "ALIVIO_ARRENDAMIENTO_PURO_ISC";
        }else {
          switch (productTranslate) {
            case "TAKEDOWN LOAN CONVERTED":
              proceso = "8";
              processName = "TAKEDOWN LOAN ISC";
              break;

            case "TAKEDOWN ARRENDAMIENTO FINANCIERO CONVERTED":
              proceso = "9";
              processName = "TAKEDOWN ARRENDAMIENTO FINANCIERO ISC";
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
              processName = "TAKEDOWN ARRENDAMIENTO PURO ISC";
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
              processName = "TAKEDOWN ARRENDAMIENTO FINANCIERO ISC";
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
          processName = "TAKEDOWN RELEASE REFI ISC";
        }else if(this.takedownDealCategory ==="Workout Restructure" & (this.takedownProduct =='PRESTAMO-FIJA' ||  this.takedownProduct=='PRESTAMO-VAR') & this.forWOAlprocess()){
          proceso  = "TAKEDOWN_WORK_OUT_LOAN_ISC";
          processName = "TAKEDOWN_WORK_OUT_LOAN_ISC";
        }else if(this.takedownDealCategory ==="Workout Restructure" & (this.takedownProduct =='AFINAN-FIJA' ||  this.takedownProduct=='AFINAN-VAR') & this.forWOAlprocess()){
          proceso  = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_FINANCIERO_ISC";
          processName = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_FINANCIERO_ISC";
        }else if(this.takedownDealCategory ==="Workout Restructure" & this.takedownProduct =='OPERFIN-FIJA' & this.forWOAlprocess()){
          proceso  = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_PURO_ISC";
          processName = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_PURO_ISC";
        }else if(this.takedownDealCategory ==="Not new origination" & (this.takedownProduct =='PRESTAMO-FIJA' ||  this.takedownProduct=='PRESTAMO-VAR') & this.forWOAlprocess()){
          proceso  = "ALIVIO_LOAN_ISC";
          processName = "ALIVIO_LOAN_ISC";
        }else if(this.takedownDealCategory ==="Not new origination" & (this.takedownProduct =='AFINAN-FIJA' ||  this.takedownProduct=='AFINAN-VAR') & this.forWOAlprocess()){
          proceso  = "ALIVIO_ARRENDAMIENTO_FINANCIERO_ISC";
          processName = "ALIVIO_ARRENDAMIENTO_FINANCIERO_ISC";
        }else if(this.takedownDealCategory ==="Not new origination" & this.takedownProduct =='OPERFIN-FIJA' & this.forWOAlprocess()){
          proceso  = "ALIVIO_ARRENDAMIENTO_PURO_ISC";
          processName = "ALIVIO_ARRENDAMIENTO_PURO_ISC";
        } else {
          switch (productTranslate) {
            case "TAKEDOWN LOAN CONVERTED":
              proceso = "8";
              processName = "TAKEDOWN LOAN ISC";
              break;
            case "TAKEDOWN ARRENDAMIENTO FINANCIERO CONVERTED":
              proceso = "9";
              processName = "TAKEDOWN ARRENDAMIENTO FINANCIERO ISC";
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
              processName = "TAKEDOWN ARRENDAMIENTO PURO ISC";
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
              processName = "TAKEDOWN ARRENDAMIENTO FINANCIERO ISC";
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
          processName = "TAKEDOWN RELEASE REFI ISC";
        }else if(this.takedownDealCategory ==="Workout Restructure" & (this.takedownProduct =='PRESTAMO-FIJA' ||  this.takedownProduct=='PRESTAMO-VAR') & this.forWOAlprocess()){
          proceso  = "TAKEDOWN_WORK_OUT_LOAN_ISC";
          processName = "TAKEDOWN_WORK_OUT_LOAN_ISC";
        }else if(this.takedownDealCategory ==="Workout Restructure" & (this.takedownProduct =='AFINAN-FIJA' ||  this.takedownProduct=='AFINAN-VAR') & this.forWOAlprocess()){
          proceso  = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_FINANCIERO_ISC";
          processName = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_FINANCIERO_ISC";
        }else if(this.takedownDealCategory ==="Workout Restructure" & this.takedownProduct =='OPERFIN-FIJA' & this.forWOAlprocess()){
          proceso  = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_PURO_ISC";
          processName = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_PURO_ISC";
        }else if(this.takedownDealCategory ==="Not new origination" & (this.takedownProduct =='PRESTAMO-FIJA' ||  this.takedownProduct=='PRESTAMO-VAR') & this.forWOAlprocess()){
          proceso  = "ALIVIO_LOAN_ISC";
          processName = "ALIVIO_LOAN_ISC";
        }else if(this.takedownDealCategory ==="Not new origination" & (this.takedownProduct =='AFINAN-FIJA' ||  this.takedownProduct=='AFINAN-VAR') & this.forWOAlprocess()){
          proceso  = "ALIVIO_ARRENDAMIENTO_FINANCIERO_ISC";
          processName = "ALIVIO_ARRENDAMIENTO_FINANCIERO_ISC";
        }else if(this.takedownDealCategory ==="Not new origination" & this.takedownProduct =='OPERFIN-FIJA' & this.forWOAlprocess()){
          proceso  = "ALIVIO_ARRENDAMIENTO_PURO_ISC";
          processName = "ALIVIO_ARRENDAMIENTO_PURO_ISC";
        } else {
          switch (productTranslate) {
            case "TAKEDOWN LOAN CONVERTED":
              proceso = "8";
              processName = "TAKEDOWN LOAN ISC";
              break;
            case "TAKEDOWN ARRENDAMIENTO FINANCIERO CONVERTED":
              proceso = "9";
              processName = "TAKEDOWN ARRENDAMIENTO FINANCIERO ISC";
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
              processName = "TAKEDOWN ARRENDAMIENTO PURO ISC";
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
              processName = "TAKEDOWN ARRENDAMIENTO FINANCIERO ISC";
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
          processName = "TAKEDOWN RELEASE REFI ISC";
        }else if(this.takedownDealCategory ==="Workout Restructure" & (this.takedownProduct =='PRESTAMO-FIJA' ||  this.takedownProduct=='PRESTAMO-VAR') & this.forWOAlprocess()){
          proceso  = "TAKEDOWN_WORK_OUT_LOAN_ISC";
          processName = "TAKEDOWN_WORK_OUT_LOAN_ISC";
        }else if(this.takedownDealCategory ==="Workout Restructure" & (this.takedownProduct =='AFINAN-FIJA' ||  this.takedownProduct=='AFINAN-VAR') & this.forWOAlprocess()){
          proceso  = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_FINANCIERO_ISC";
          processName = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_FINANCIERO_ISC";
        }else if(this.takedownDealCategory ==="Workout Restructure" & this.takedownProduct =='OPERFIN-FIJA' & this.forWOAlprocess()){
          proceso  = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_PURO_ISC";
          processName = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_PURO_ISC";
        }else if(this.takedownDealCategory ==="Not new origination" & (this.takedownProduct =='PRESTAMO-FIJA' ||  this.takedownProduct=='PRESTAMO-VAR') & this.forWOAlprocess()){
          proceso  = "ALIVIO_LOAN_ISC";
          processName = "ALIVIO_LOAN_ISC";
        }else if(this.takedownDealCategory ==="Not new origination" & (this.takedownProduct =='AFINAN-FIJA' ||  this.takedownProduct=='AFINAN-VAR') & this.forWOAlprocess()){
          proceso  = "ALIVIO_ARRENDAMIENTO_FINANCIERO_ISC";
          processName = "ALIVIO_ARRENDAMIENTO_FINANCIERO_ISC";
        }else if(this.takedownDealCategory ==="Not new origination" & this.takedownProduct =='OPERFIN-FIJA' & this.forWOAlprocess()){
          proceso  = "ALIVIO_ARRENDAMIENTO_PURO_ISC";
          processName = "ALIVIO_ARRENDAMIENTO_PURO_ISC";
        } else {
          switch (productTranslate) {
            case "TAKEDOWN LOAN CONVERTED":
              proceso = "8";
              processName = "TAKEDOWN LOAN ISC";
              break;
            case "TAKEDOWN ARRENDAMIENTO FINANCIERO CONVERTED":
              proceso = "9";
              processName = "TAKEDOWN ARRENDAMIENTO FINANCIERO ISC";
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
              processName = "TAKEDOWN ARRENDAMIENTO PURO ISC";
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
              processName = "TAKEDOWN ARRENDAMIENTO FINANCIERO ISC";
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
          processName = "TAKEDOWN RELEASE REFI ISC";
        }else if(this.takedownDealCategory ==="Workout Restructure" & (this.takedownProduct =='PRESTAMO-FIJA' ||  this.takedownProduct=='PRESTAMO-VAR') & this.forWOAlprocess()){
          proceso  = "TAKEDOWN_WORK_OUT_LOAN_ISC";
          processName = "TAKEDOWN_WORK_OUT_LOAN_ISC";
        }else if(this.takedownDealCategory ==="Workout Restructure" & (this.takedownProduct =='AFINAN-FIJA' ||  this.takedownProduct=='AFINAN-VAR') & this.forWOAlprocess()){
          proceso  = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_FINANCIERO_ISC";
          processName = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_FINANCIERO_ISC";
        }else if(this.takedownDealCategory ==="Workout Restructure" & this.takedownProduct =='OPERFIN-FIJA' & this.forWOAlprocess()){
          proceso  = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_PURO_ISC";
          processName = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_PURO_ISC";
        }else if(this.takedownDealCategory ==="Not new origination" & (this.takedownProduct =='PRESTAMO-FIJA' ||  this.takedownProduct=='PRESTAMO-VAR') & this.forWOAlprocess()){
          proceso  = "ALIVIO_LOAN_ISC";
          processName = "ALIVIO_LOAN_ISC";
        }else if(this.takedownDealCategory ==="Not new origination" & (this.takedownProduct =='AFINAN-FIJA' ||  this.takedownProduct=='AFINAN-VAR') & this.forWOAlprocess()){
          proceso  = "ALIVIO_ARRENDAMIENTO_FINANCIERO_ISC";
          processName = "ALIVIO_ARRENDAMIENTO_FINANCIERO_ISC";
        }else if(this.takedownDealCategory ==="Not new origination" & this.takedownProduct =='OPERFIN-FIJA' & this.forWOAlprocess()){
          proceso  = "ALIVIO_ARRENDAMIENTO_PURO_ISC";
          processName = "ALIVIO_ARRENDAMIENTO_PURO_ISC";
        } else {
          switch (productTranslate) {
            case "TAKEDOWN LOAN CONVERTED":
              proceso = "8";
              processName = "TAKEDOWN LOAN ISC";
              break;
            case "TAKEDOWN ARRENDAMIENTO FINANCIERO CONVERTED":
              proceso = "9";
              processName = "TAKEDOWN ARRENDAMIENTO FINANCIERO ISC";
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
              processName = "TAKEDOWN ARRENDAMIENTO PURO ISC";
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
              processName = "TAKEDOWN ARRENDAMIENTO FINANCIERO ISC";
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
        case "Canceled":
          if (
            this.takedownDealCategory === "Release" ||
            this.takedownDealCategory === "Refi"
          ) {
            proceso = "11";
            processName = "TAKEDOWN RELEASE REFI ISC";
          }else if(this.takedownDealCategory ==="Workout Restructure" & (this.takedownProduct =='PRESTAMO-FIJA' ||  this.takedownProduct=='PRESTAMO-VAR') & this.forWOAlprocess()){
            proceso  = "TAKEDOWN_WORK_OUT_LOAN_ISC";
            processName = "TAKEDOWN_WORK_OUT_LOAN_ISC";
          }else if(this.takedownDealCategory ==="Workout Restructure" & (this.takedownProduct =='AFINAN-FIJA' ||  this.takedownProduct=='AFINAN-VAR') & this.forWOAlprocess()){
            proceso  = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_FINANCIERO_ISC";
            processName = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_FINANCIERO_ISC";
          }else if(this.takedownDealCategory ==="Workout Restructure" & this.takedownProduct =='OPERFIN-FIJA' & this.forWOAlprocess()){
            proceso  = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_PURO_ISC";
            processName = "TAKEDOWN_WORK_OUT_ARRENDAMIENTO_PURO_ISC";
          }else if(this.takedownDealCategory ==="Not new origination" & (this.takedownProduct =='PRESTAMO-FIJA' ||  this.takedownProduct=='PRESTAMO-VAR') & this.forWOAlprocess()){
            proceso  = "ALIVIO_LOAN_ISC";
            processName = "ALIVIO_LOAN_ISC";
          }else if(this.takedownDealCategory ==="Not new origination" & (this.takedownProduct =='AFINAN-FIJA' ||  this.takedownProduct=='AFINAN-VAR') & this.forWOAlprocess()){
            proceso  = "ALIVIO_ARRENDAMIENTO_FINANCIERO_ISC";
            processName = "ALIVIO_ARRENDAMIENTO_FINANCIERO_ISC";
          }else if(this.takedownDealCategory ==="Not new origination" & this.takedownProduct =='OPERFIN-FIJA' & this.forWOAlprocess()){
            proceso  = "ALIVIO_ARRENDAMIENTO_PURO_ISC";
            processName = "ALIVIO_ARRENDAMIENTO_PURO_ISC";
          } else {
            switch (productTranslate) {
              case "TAKEDOWN LOAN CONVERTED":
                proceso = "8";
                processName = "TAKEDOWN LOAN ISC";
                break;
              case "TAKEDOWN ARRENDAMIENTO FINANCIERO CONVERTED":
                proceso = "9";
                processName = "TAKEDOWN ARRENDAMIENTO FINANCIERO ISC";
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
                processName = "TAKEDOWN ARRENDAMIENTO PURO ISC";
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
                processName = "TAKEDOWN ARRENDAMIENTO FINANCIERO ISC";
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
        processName: processName,
        processFKId: this.takedownName,
        exclude: exclude,
        identifiers: messageStructure
      };
    }else{ 
      this.datos = {
      userId: this.userSSO,
      userName:  this.userName,
      //typeProcessId: proceso,
      processName: processName,
      typeProcessCode:proceso,
      processFKId: this.takedownName,
      //exclude: exclude,
      identifiers: messageStructure
    };

    }
   

    // eslint-disable-next-line no-console
    console.log("ke: " + JSON.stringify(this.datos));
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

    if(token){
      try{
        
        let key = JSON.parse(token);
        
        let encrypted = CryptoJS.AES.encrypt(
          JSON.stringify(this.datos),
          key.token
        );
        let encriptedString = encodeURIComponent(encrypted.toString());
    
        //window.location.replace(this.url + encriptedString);
        // eslint-disable-next-line @lwc/lwc/no-inner-html
        //this.template.querySelector('div').innerHTML='<object type="text/html" width="100%" height="300" data="' + this.url + encriptedString+ '" ></object>';
        /*  console.log(this.url);
            console.log(encriptedString);
            let evento = new CustomEvent('docsInfo',{
                detail:encriptedString
            });
            window.dispatchEvent(evento); */
    
        this.urlContent = this.url + encriptedString + "&id="+key.token;
        console.log(this.urlContent);
      }catch(ex){
        console.log('Error al parsear json')
        console.log(ex)
      }
    }
  }

  getDatos() {
    return new Promise((resolve, reject) => {
      getEntiesInca({ cAId: this.cAId })
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

  /*  @api sysId = '202';
    theIframe;

    get fullUrl() {

    return `https://ecoasdev01.engeniumcapital.mx:8789/wcmecapp/files/files-upload?manager=`;
    }

    @api isReloaded = false;


renderedCallback() {
    console.log('rendred callback called' + this.theIframe);
        if(this.theIframe===undefined){
            this.theIframe =  this.template.querySelector('iframe');
            this.theIframe.onload = ()=>{
                console.log('Onload called'+this.isReloaded);

                if(!this.isReloaded){
                    this.isReloaded = true;
                    this.theIframe.src = this.theIframe.src ;

                }
            }
        }   

    } */
}