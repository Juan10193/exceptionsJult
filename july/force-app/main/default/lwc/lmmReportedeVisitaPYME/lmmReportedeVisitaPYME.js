import { LightningElement, api, wire, track } from "lwc";
import pubsub from "c/pubsubsimple";
import getReportesOP from "@salesforce/apex/LMM_ReportedeVisitaPYME_Controller.getReportesByOpId";
import { refreshApex } from "@salesforce/apex";
import reporteView from "./lmmReportedeVisitaPYME.html";
import reporteEdit from "./lmmReportedeVisitaPYMEEdit.html";
import blank from "./blank.html";
import searchEntitysDelaOp from "@salesforce/apex/LMM_ReportedeVisitaLookUp.searchEntitysDelaOp";
import getEntidadesdeLaOpp from "@salesforce/apex/LMM_ReportedeVisitaPYME_Controller.getEntidadesdeLaOpp";
import getAvales from "@salesforce/apex/lmmAvalModalController.getAvales";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import {
  columnsFuncP,
  columnsPC,
  columnsAvales,
  columnsPCv,
  columnsFuncPV
} from "./datatblesHelper";
import { crearReporte } from "./lmmReportedeVisitaPYMEHelper";
import getAllContacts from "@salesforce/apex/LMM_ReportedeVisitaPYME_Controller.getAllcontacts";
import deleteContact from "@salesforce/apex/LMM_ReportedeVisitaPYME_Controller.deleteContact";
import upsertContact from "@salesforce/apex/LMM_ReportedeVisitaPYME_Controller.upsertContact"

export default class LmmReportedeVisitaPYME extends LightningElement {
  @api recordId;
  wiredReports;
  @track sipinner = false;
  @track viewMode = false;
  @track selectedAvales;
  @track reporteId;
  @track section = blank;
  @track lookupsFields = {};
  COLUMNSFUNCIP = columnsFuncP;
  COLUMNSFUNCIPv = columnsFuncPV;
  COLUMNSPCLIENTE = columnsPC;
  COLUMNSPCLIENTEV = columnsPCv;
  AVALES = columnsAvales;
  @track openModalContact;
  @track avals = [];
  @track pf = [];
  @track pc = [];
  @track ppv = [];
  @track pac = [];
  @track contactype;
  @track contactId;

  isMultiEntryCliente = false;
  isMultiEntryAval = true;
  maxSelectionSize = 10;
  @track clientN = null;
  @track clientId = null;
  @track dlName = null;
  @track dlId = null;
  @track initialSelectionNc = [
    /*  {
      id: "na",
      sObjectType: "na",
      icon: "standard:lightning_component",
      title: "Buscar En Entidades de la Oportunidad",
      subtitle: "Not a valid record"
    }*/
  ];

  @track initialSelectionDL = [];

  @track errors = {
    errorsclientName: [],
    errorsavales: [],
    errorsdepoLegal: []
  };

  connectedCallback() {
    this.regiser();
  }

  regiser() {
    console.log("event closed modal contact  registered ");
    pubsub.register(
      "closecontactmodal",
      this.handleEventContactModalClosed.bind(this)
    );
    pubsub.register("actualizarcontact", this.handleUpdateListContact.bind(this));
    pubsub.register("enviarcontact", this.handleSaveContacts.bind(this));
    pubsub.register("closeavaltmodal", this.handleCloseAvals.bind(this));
    pubsub.register("saveavals", this.handleSaveAvals.bind(this));
  }
  handleEventContactModalClosed(messageFromEvt) {
    console.log("event handled ", messageFromEvt);
    this.openModalContact = false;
  }

  render() {
    return this.section;
  }

  @wire(getReportesOP, { opportunityId: "$recordId" })
  reports(result) {
    this.wiredReports = result;
    if (result.data) {
      console.log("el result");
      console.log(result.data.length);
      if (result.data.length > 0) {
        console.log("Existe un reporte de visita");
        this.reporteId = this.wiredReports.data[0].Id;
        if (this.wiredReports.data[0].LMM_Nombre_del_cliente__r) {
          this.initialSelectionNc = [
            {
              id: this.wiredReports.data[0].LMM_Nombre_del_cliente__r.Id,
              sObjectType: "LMM_Entidad_de_oportunidad__c",
              icon: "standard:lightning_component",
              title: this.wiredReports.data[0].LMM_Nombre_del_cliente__r
                .LMM_tx_Entity_Name__c,
              subtitle:
                "Entidad " +
                this.wiredReports.data[0].LMM_Nombre_del_cliente__r
                  .LMM_tx_Entity_Name__c
            }
          ];

          this.clientId = `/${this.wiredReports.data[0].LMM_Nombre_del_cliente__r.Id}`;
          this.clientN = this.wiredReports.data[0].LMM_Nombre_del_cliente__r.LMM_tx_Entity_Name__c;
        }

        if (this.wiredReports.data[0].LMM_Depositario_Legal__r) {
          this.initialSelectionDL = [
            {
              id: this.wiredReports.data[0].LMM_Depositario_Legal__r.Id,
              sObjectType: "LMM_Entidad_de_oportunidad__c",
              icon: "standard:lightning_component",
              title: this.wiredReports.data[0].LMM_Depositario_Legal__r
                .LMM_tx_Entity_Name__c,
              subtitle:
                "Entidad " +
                this.wiredReports.data[0].LMM_Depositario_Legal__r
                  .LMM_tx_Entity_Name__c
            }
          ];

          this.dlName = this.wiredReports.data[0].LMM_Depositario_Legal__r.LMM_tx_Entity_Name__c;
          this.dlId = `/${this.wiredReports.data[0].LMM_Depositario_Legal__r.Id}`;
        }

        console.log("selectedNc");
        console.log(this.initialSelectionNc);

        getAvales({ recordId: this.recordId })
          .then((resultado) => {
            console.log("vales cargando");
            this.avals = resultado;
            let selectionAvls = [];
            this.avals.forEach((av) => {
              selectionAvls.push(av.Id);
            });
            this.selectedAvales = selectionAvls;
          })
          .catch((erro) => {
            console.log("Error al cargar avales");
            console.log(erro);
          });

        getAllContacts({ reporteId: this.reporteId }).then((resulcon) => {
          this.pf =[];
          this.pc=[];
          this.ppv=[];
          this.pac=[];
          this.pf = resulcon.filter(
            ({ LMM_Type_Reporte_Visita__c }) =>
              LMM_Type_Reporte_Visita__c === "Funcionario Principal"
          );
          this.pc = resulcon.filter(
            ({ LMM_Type_Reporte_Visita__c }) =>
              LMM_Type_Reporte_Visita__c === "Principal Cliente"
          );
          this.ppv = resulcon.filter(
            ({ LMM_Type_Reporte_Visita__c }) =>
              LMM_Type_Reporte_Visita__c === "Principal Proveedor"
          );
          this.pac = resulcon.filter(
            ({ LMM_Type_Reporte_Visita__c }) =>
              LMM_Type_Reporte_Visita__c === "Principal Acreedor"
          );
        });

        this.section = reporteView;
        this.viewMode = true;
      } else {
        console.log("no hay reporte de visita");
        this.section = reporteEdit;
        this.viewMode = false;
      }
    } else if (result.error) {
      console.log("error wired reports");
      console.log(result.error);
    }
  }

  handleCancelEdit() {
    this.pf = this.pf.filter(({ Id }) => Id !== null && Id !== undefined);
    this.pc = this.pc.filter(({ Id }) => Id !== null && Id !== undefined);
    this.ppv = this.ppv.filter(({ Id }) => Id !== null && Id !== undefined);
    this.pac = this.pac.filter(({ Id }) => Id !== null && Id !== undefined);
    this.viewMode = true;
    this.section = reporteView;
  }

  handlechange(event) {
    let valor = event.target.value;
    if (valor === "Igual al de Visita") {
      let inputs = this.template.querySelectorAll("lightning-input-field");
      inputs.forEach((input) => {
        if (input.fieldName === "LMM_Calle_DF__c") {
          let campo = this.template.querySelector(`[data-name="domvicita"]`);
          input.value = campo.value;
        } else if (input.fieldName === "LMM_Numero_DF__c") {
          let campo = this.template.querySelector(`[data-name="numdomv"]`);
          input.value = campo.value;
        } else if (input.fieldName === "LMM_Colonia_DF__c") {
          let campo = this.template.querySelector(`[data-name="coldmv"]`);
          input.value = campo.value;
        } else if (input.fieldName === "LMM_Ciudad_DF__c") {
          let campo = this.template.querySelector(`[data-name="ciudv"]`);
          input.value = campo.value;
        } else if (input.fieldName === "LMM_Estado_DF__c") {
          let campo = this.template.querySelector(`[data-name="estadodv"]`);
          input.value = campo.value;
        }
      });
    }
  }

  async handleSubmit(event) {
    event.preventDefault(); // stop the form from submitting
    this.sipinner = true;
    console.log("se detuvo");
    let fields = event.detail.fields;
    fields.LMM_Opportunity__c = this.recordId;
    fields.LMM_Nombre_del_cliente__c = this.lookupsFields.clientName;
    fields.LMM_Depositario_Legal__c = this.lookupsFields.depoLegal;
    console.log(
      `this.pf : ${this.pf}  this.pc : ${this.pc} this.ppv : ${this.ppv} this.pac : ${this.pac}`
    );
    console.log(this.pac);
    await crearReporte(
      fields,
      this.avals,
      this.pf,
      this.pc,
      this.ppv,
      this.pac,
      this.reporteId,
      this.recordId
    );
    //this.template.querySelector("lightning-record-edit-form").submit(fields);
    this.sipinner = false;
    this.section = reporteView;
    this.render();
    const toastEvent = new ShowToastEvent({
      title: "Succes",
      message: "Success",
      variant: "success"
    });
    this.dispatchEvent(toastEvent);
    return refreshApex(this.wiredReports);
  }

  handleEditRepo() {
    this.viewMode = false;
    this.section = reporteEdit;
  }

  handleSuccess(event) {
    console.log("se creo el registro con exito");
    return refreshApex(this.wiredReports);
  }

  handleSearch(event) {
    console.log("handlesearch");
    let lookupid = event.target.dataset.id;
    event.detail.opportunityId = this.recordId;
    if (lookupid === "avales") {
      getEntidadesdeLaOpp(event.detail)
        .then((results) => {
          console.log("los rtesults");
          console.log(results);
          this.template
            .querySelector(`[data-id="${lookupid}"]`)
            .setSearchResults(results);
          if (results.length === 0) {
            this.resultados = false;
          } else {
            this.resultados = true;
          }
        })
        .catch((error) => {
          this.notifyUser(
            "Lookup Error",
            "An error occured while searching with the lookup field.",
            "error"
          );
          // eslint-disable-next-line no-console
          console.error("Lookup error", JSON.stringify(error));
          this.errors = [error];
        });
    } else {
      searchEntitysDelaOp(event.detail)
        .then((results) => {
          console.log("los rtesults");
          console.log(results);
          this.template
            .querySelector(`[data-id="${lookupid}"]`)
            .setSearchResults(results);
          if (results.length === 0) {
            this.resultados = false;
          } else {
            this.resultados = true;
          }
        })
        .catch((error) => {
          this.notifyUser(
            "Lookup Error",
            "An error occured while searching with the lookup field.",
            "error"
          );
          // eslint-disable-next-line no-console
          console.error("Lookup error", JSON.stringify(error));
          this.errors = [error];
        });
    }
  }

  handleSelectionChange(event) {
    console.log("andleselectionchange");
    let lookupid = event.target.dataset.id;
    let isMultiEntry = event.target.isMultiEntry;
    console.log(isMultiEntry);
    this.checkForErrors(lookupid, isMultiEntry);
  }

  checkForErrors(lookupid, isMultiEntry) {
    console.log("lookupid: " + lookupid + " frae: " + "errors" + lookupid);
    console.log("carga errors");
    this.errors[`errors${lookupid}`] = [];
    console.log(this.errors[`errors${lookupid}`]);
    const selection = this.template
      .querySelector(`[data-id="${lookupid}"]`)
      .getSelection();
    console.log("LA SELECCION" + lookupid);
    console.log(selection);
    // Custom validation rule
    if (isMultiEntry & (selection.length > this.maxSelectionSize)) {
      this.errors[`errors${lookupid}`].push({
        message: `You may only select up to ${this.maxSelectionSize} items.`
      });
    }
    // Enforcing required field
    if (selection.length === 0) {
      this.errors[`errors${lookupid}`].push({
        message: "Please make a selection."
      });
      console.log("los errores");
      console.log(this.errors[`errors${lookupid}`]);
      console.log(this.errors);
    }

    if ((selection.length > 0) & (selection.length < 2)) {
      this.lookupsFields[lookupid] = selection[0].id;
      console.log(lookupid + ": " + this.lookupsFields[lookupid]);
    } else if (selection.length > 1) {
      this.lookupsFields[lookupid] = selection;
      console.log(lookupid + ": " + this.lookupsFields[lookupid]);
    }
  }

  notifyUser(title, message, variant) {
    if (this.notifyViaAlerts) {
      // Notify via alert
      // eslint-disable-next-line no-alert
      alert(`${title}\n${message}`);
    } else {
      // Notify via toast
      /* const toastEvent = new ShowToastEvent({ title, message, variant });
        this.dispatchEvent(toastEvent); */
      console.log(message);
    }
  }

  newContactType(event) {
    this.contactype = event.target.dataset.tipo;
    console.log("TIPO: " + this.contactype);
    this.openModalContact = true;
  }

  async handleSaveContacts(message) {
    console.log("Contactos a guardar");
    console.log(message);
    if(message.Id!== null && message.Id!==undefined){
      try{ 
        message.sobjectType='Contact';
        await  upsertContact({con:message});
        getAllContacts({ reporteId: this.reporteId }).then((resulcon) => {
          this.pf = resulcon.filter(
            ({ LMM_Type_Reporte_Visita__c }) =>
              LMM_Type_Reporte_Visita__c === "Funcionario Principal"
          );
          this.pc = resulcon.filter(
            ({ LMM_Type_Reporte_Visita__c }) =>
              LMM_Type_Reporte_Visita__c === "Principal Cliente"
          );
          this.ppv = resulcon.filter(
            ({ LMM_Type_Reporte_Visita__c }) =>
              LMM_Type_Reporte_Visita__c === "Principal Proveedor"
          );
          this.pac = resulcon.filter(
            ({ LMM_Type_Reporte_Visita__c }) =>
              LMM_Type_Reporte_Visita__c === "Principal Acreedor"
          );
        })
      }catch(erc){
        console.log('Error al actualizar contacto');
        console.log(erc);
      }

     
    
    }else{
      let tipoDeContacto = message;
      switch (message.LMM_Type_Reporte_Visita__c) {
        case "Funcionario Principal":
          this.pf = [...this.pf, tipoDeContacto];
          break;
        case "Principal Cliente":
          this.pc = [...this.pc, tipoDeContacto];
          break;
        case "Principal Proveedor":
          this.ppv = [...this.ppv, tipoDeContacto];
          break;
        case "Principal Acreedor":
          this.pac = [...this.pac, tipoDeContacto];
          break;
        default:
          break;
      }
    }

   
  }

  handleRowAction(event) {
    const actionName = event.detail.action.name;
    const row = event.detail.row;
    switch (actionName) {
      case "delete":
        this.deleteRow(row);
        break;

      case "edit":
        this.editRow(row);
        break;
      default:
        break;
    }
  }

  async deleteRow(row) {
    let confirmacion = confirm("Seguro que quiere eliminar este contacto?");
    if (confirmacion === true) {
      const {
        LMM_Nombre_del_Contacto__c,
        LMM_RPYME_Name__c,
        LMM_Type_Reporte_Visita__c,
        Id
      } = row;
      let tipoContactData;
      let rowProper;
      switch (LMM_Type_Reporte_Visita__c) {
        case "Funcionario Principal":
          tipoContactData = "pf";
          rowProper = "LMM_RPYME_Name__c";
          break;
        case "Principal Cliente":
          tipoContactData = "pc";
          rowProper = "LMM_RPYME_Name__c";
          break;
        case "Principal Proveedor":
          tipoContactData = "ppv";
          rowProper = "LMM_RPYME_Name__c";
          break;
        case "Principal Acreedor":
          tipoContactData = "pac";
          rowProper = "LMM_RPYME_Name__c";
          break;
        default:
          break;
      }

      if (Id !== null && Id !== undefined) {
        row.sobjectType = "Contact";
        try {
          await deleteContact({ con: row });
        } catch (errcn) {
          console.log("Error al eliminar contacto");
          console.log(errcn);
        }
      }

      if (rowProper === "LMM_RPYME_Name__c") {
        const index = this.findRowIndexByName(
          LMM_RPYME_Name__c,
          tipoContactData,
          rowProper
        );
        if (index !== -1) {
          this[tipoContactData] = this[tipoContactData]
            .slice(0, index)
            .concat(this[tipoContactData].slice(index + 1));
        }
      } else {
        const index = this.findRowIndexByName(
          LMM_Nombre_del_Contacto__c,
          tipoContactData,
          rowProper
        );
        if (index !== -1) {
          this[tipoContactData] = this[tipoContactData]
            .slice(0, index)
            .concat(this[tipoContactData].slice(index + 1));
        }
      }
    }
  }

  async editRow(row) {
    const {
      LMM_Nombre_del_Contacto__c,
      LMM_RPYME_Name__c,
      LMM_Type_Reporte_Visita__c,
      Id
    } = row;
    if(Id !==null && Id !== undefined){
      this.contactId = Id;
      this.contactype=LMM_Type_Reporte_Visita__c;
      this.openModalContact = true;
      
    }
  }

  findRowIndexByName(Nombre_del_Contacto, tipoContactData, rowProper) {
    let ret = -1;
    this[tipoContactData].some((row, index) => {
      if (row[rowProper] === Nombre_del_Contacto) {
        ret = index;
        console.log("el index: " + ret);
        return true;
      }
      return false;
    });
    return ret;
  }

  @track openAvalmodal = false;
  newAval() {
    let selectionAvls = [];
    this.avals.forEach((av) => {
      selectionAvls.push(av.Id);
    });
    this.selectedAvales = [...selectionAvls];
    console.log("Avales seleccionados");
    console.log(this.selectedAvales);
    this.openAvalmodal = true;
  }

  handleCloseAvals() {
    this.openAvalmodal = false;
  }
  handleSaveAvals(message) {
    console.log("AVALES THISAVALES");
    console.log(message.avales);
    this.avals = message.avales;
  }

  handleUpdateListContact(message){
    console.log('Se actualizaron los contactos');
    return refreshApex(this.wiredReports);
  }
}