import { LightningElement, api, wire, track } from "lwc";
import pubsub from "c/pubsubsimple";
import getEnts from "@salesforce/apex/lmmAvalModalController.getEntidades";
import { DATAENTS } from "./lmmDatatableHelper";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { refreshApex } from "@salesforce/apex";

export default class LmmModalAvalesRPVPYME extends LightningElement {
  @api oppId;
  @api selected;
  wiredents;
  @track dataEnts = [];
  COLUMNSENTS = DATAENTS;
  @track selectedEnts;
  @track selectedRows;

  @wire(getEnts, { recordId: "$oppId" })
  ents(result) {
    this.wiredents = result;
    if (result.data) {
      console.log("Ents para Aval");
      console.log(result.data);
      if (result.data.length > 0) {
        this.dataEnts = result.data;
        console.log('en valaes seelected')
        console.log(this.selected);
        this.selectedEnts =this.selected;
      }
    } else if (result.error) {
      console.log("error wired ents aval");
      console.log(result.error);
    }
  }

  closeModal() {
    let message = {
      message: "modalclosed"
    };
    pubsub.fire("closeavaltmodal", message);
    console.log("evento de cerado de modal fired");
  }
  handleSave() {
    
      let message = {
        avales: this.selectedRows
      };
      pubsub.fire("saveavals", message);
      console.log("saveavals fired");
      this.closeModal();
  }

  selectRows(event) {
    this.selectedRows = event.detail.selectedRows;
    let selecteds =[];
    this.selectedRows.forEach(row => {
      selecteds.push(row.Id);
    });
    this.selectedEnts = selecteds;
    console.log(selecteds)
    console.log(this.selectedRows);
  }
}