/**
 * @description       : 
 * @author            : eduardo.amiens@outlook.com
 * @group             : 
 * @last modified on  : 11-11-2020
 * @last modified by  : eduardo.amiens@outlook.com
 * Modifications Log 
 * Ver   Date         Author                       Modification
 * 1.0   11-09-2020   eduardo.amiens@outlook.com   Initial Version
**/
//Juan de Dios
import { LightningElement, api, track, wire } from "lwc";
import { getRecord } from "lightning/uiRecordApi";
import blank from "./blank.html";
import main from "./cms.html";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
//import docsByprocess from "@salesforce/apex/CMS_Controller.documentsProcess";
import { getSObject, getExclude, callTollgate, updateValidatopmField } from "./cmsHelper";
import getMessageEstructure from "@salesforce/apex/Data_Access_cms_estructura.getMessageEstructure";
import getUserFields from "@salesforce/apex/CMS_Controller.getUserFields";
import getRecordNameById from "@salesforce/apex/CMS_Controller.getRecordNameById";
import getToken from "@salesforce/apex/LMM_WS_Tollgate_cls.getToken";
import getUrl from "@salesforce/apex/MetadataUrls.getUrlDocs";
import { CryptoJS } from "c/criptojs";
import validateTollgate from "@salesforce/apex/LMM_TolgateController.validateTollgate"


export default class Cms extends LightningElement {
  //Datos del Objeto y registro
  @api objectApiName;
  @api recordId;
  @track recordName;
  @api processName;
  @api isUnic;
  @api queryEstructure
  @api isJoinQuery;
  @api joinField;
  //Relacion objeto data
  @api estructura;
  @api validations;

  //Datos del Usuario
  @track userSSO;
  @track userName;
  //@track recordTypeName;

  //Campos que definen el proceso (Opcional)
  @track paramFields;

  //datos del registro
  @track registro;
  @track stageRegistro;
  @track mdtRecord;
  //exclusion de doctos
  @track docIdstoExclude;

  //estructura entidades
  @track estructur;

  //vista cargada
  @track section = main;

  //data a enviar a content
  @track datos;

  //url
  @track url;
  @track urlContent;


  connectedCallback() {
    console.log("El api name del objeto actual es: " + this.objectApiName);
    console.log("El recordId es: " + this.recordId);
    console.log("fieldsProcess: " + this.fieldsProcess);
    console.log("paramsdilefs");
    console.log(this.paramFields);

  }

  render() {
    return this.section;
  }

  @wire(getRecord, { recordId: "$recordId", fields: "$fieldsProcess" })
  async wiredRecord({ error, data }) {
    if (error) {
      console.log("error al traer el wire record");
      console.log(error);
      let message = "Unknown error";
      if (Array.isArray(error.body)) {
        message = error.body.map((e) => e.message).join(", ");
      } else if (typeof error.body.message === "string") {
        message = error.body.message;
      }
      this.dispatchEvent(
        new ShowToastEvent({
          title: `Error loading ${this.objectApiName}`,
          message,
          variant: "error"
        })
      );
    } else if (data) {
      this.section = blank;
      this.registro = await data;
      console.log('EL REGISTRO')
      console.log(this.registro);
      // let apexRecord = getSObject(this.registro);
      console.log(this.isUnic);
      /*  let query;
       try {
         query = await docsByprocess({
           objeto: apexRecord,
           processName: this.processName,
           recordTypeName:this.registro.fields.RecordType_Name__c.value,
           isUnic: this.isUnic
         });
       } catch (error) {
         console.log(error);
       } */

      // console.log("mdtrecord before parse");
      // console.log(query)
      // this.mdtRecord = JSON.parse(query)[0];
      // console.log("mdtrecord");
      // console.log(this.mdtRecord);
      // this.docIdstoExclude = getExclude(this.mdtRecord);
      console.log('la estructura ' + this.estructura)
      if (this.estructura !== null && this.estructura !== undefined && this.estructura.length > 0) {
        console.log("estructura");
        console.log(this.estructura);
        console.log(JSON.parse(this.estructura));
        let estructura = JSON.parse(this.estructura);
        let msgestructura = await getMessageEstructure({
          quey: this.queryEstructure,
          recordId: this.recordId,
          isJoinQuery: this.isJoinQuery,
          joinField: this.joinField,
          sobjectName: this.objectApiName
        });
        console.log("Estructura de entidades");
        console.log(msgestructura);
        let msgestructuraObj = JSON.parse(msgestructura);
        if (msgestructuraObj !== null) {
          let msgestructuraObjContent = msgestructuraObj.map((val) => {
            let claves = Object.keys(val);
            claves.forEach((el) => {
              if (val[el] === "ORGANIZATION") {
                val[el] = 1;
              } else if (val[el] === "INDIVIDUAL") {
                val[el] = 0;
              }

              if (el === estructura.name) {
                val.name = val[el];
              }

              if (el === estructura.rfc) {
                val.rfc = val[el];
              }

              if (el === estructura.person) {
                val.person = val[el];
              }
              val.type = 2;
              delete val.el;
            });

            return {
              name: val.name,
              rfc: val.rfc,
              type: val.type,
              person: val.person
            };
          });

          console.log(msgestructuraObjContent);
          this.estructur = msgestructuraObjContent;
        }
      } else {
        this.estructur = []
      }
      let usuario = await getUserFields();
      let us = JSON.parse(usuario);
      let recorddef = await getRecordNameById({
        recordId: this.recordId,
        apiName: this.registro.apiName
      });
      console.log("recorddef");
      console.log(recorddef);
      this.recordName = recorddef.Name;
      let tipodeProceso = "";
      if (!this.processName) {
        let fields = this.paramFields;
        let partialtext = "";
        fields.forEach(field => {
          partialtext += this.registro.fields[`${field}`].value + "_";
        });
        tipodeProceso = partialtext.slice(0, -1);
        tipodeProceso = tipodeProceso.replace(/ /g, "_");
      } else {
        tipodeProceso = this.processName;
      }

      try {
        console.log('mira ' + this.estructur)
        this.datos = {
          userId: us.EmployeeNumber,
          userName: us.Name,
          //typeProcessId: this.mdtRecord.Process_ID__c,
          //processName: this.mdtRecord.CMS_Process__c,
          typeProcessCode: tipodeProceso,
          processFKId: this.recordId,
          //excludes: this.docIdstoExclude,
          identifiers: this.estructur
        };
        console.log("MENSAJE CMS: " + JSON.stringify(this.datos));
      } catch (error) {
        console.log('ERROR AL CREAR MENSAJE CMS')
        console.log(error);
      }

      let token;
      try {
        token = await getToken();
      } catch (errortoken) {
        console.log("error al consultar token");
        this.dispatchEvent(
          new ShowToastEvent({
            title: "Error to get token content",
            message: errortoken,
            variant: "error"
          })
        );

        this.section = main;
      }

      if (token) {
        let key = JSON.parse(token);

        let encrypted = CryptoJS.AES.encrypt(
          JSON.stringify(this.datos),
          key.token
        );


        try {
          let tollgates = await callTollgate(JSON.stringify(this.datos));
          console.log('Tollgates');
          console.group(tollgates)
          if (this.validations !== "") {
            let validaciones = JSON.parse(this.validations);
            console.log('Validaciones JSON');
            console.log(validaciones);
            console.log('CAMPO STAGE');
            this.stageRegistro = this.registro.fields[`${validaciones.stageField}`].value;
            console.log(this.stageRegistro);
            if (tollgates.length < 1) {
              validaciones.stageFullDocs.forEach(stage => {
                if (this.stageRegistro === stage.stage) {
                  updateValidatopmField(this.recordId, this.objectApiName, stage.fieldtoUpdate);
                }
              });
            }
          }
          if (tollgates.length < 1) {
            if (this.processName === "LOWER_MIDDLERT_MARKET") {
              try {
                await validateTollgate({ recordId: this.recordId });
              } catch (errorValidate) {
                console.log('Error al validar doctos');
                console.log(errorValidate);
              }
            }

          }
        } catch (errorTollgate) {
          console.log('error al llamar tolgates');
          console.log(errorTollgate);
        }
        let encriptedString = encodeURIComponent(encrypted.toString());
        this.url = await getUrl();
        this.urlContent = this.url + encriptedString + "&id=" + key.token;
        console.log('URL CONTENT')
        console.log(this.urlContent);
        this.section = main;
      }

    }
  }

  @api get fieldsProcess() {
    let fields = [];
    if (this.paramFields) {
      this.paramFields.forEach((field) => {
        field = `${this.objectApiName}.${field}`;
        fields.push(field);
      });
    }

    return fields;
  }

  set fieldsProcess(value) {
    this.paramFields = value.split(",");
  }
}