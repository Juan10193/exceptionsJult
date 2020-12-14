/**
 * @File Name          : approvalRejects.js
 * @Description        : 
 * @Author             : eduardo.amiens@outlook.com
 * @Group              : 
 * @Last Modified By   : eduardo.amiens@outlook.com
 * @Last Modified On   : 07-16-2020
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    23/6/2020   eduardo.amiens@outlook.com     Initial Version
**/
import { LightningElement, track, api, wire } from "lwc";
import getRejects from "@salesforce/apex/ApprovalRejects_controller.getRejects";
import saveRejects from "@salesforce/apex/ApprovalRejects_controller.saveRejects";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { CurrentPageReference } from "lightning/navigation";
import { fireEvent } from "c/pubsub";

export default class ApprovalRejects extends LightningElement {
  @api recordId;
  @api objectApiName;

  @track typeexpanded = {
    expaned: false,
    class:
      "slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click"
  };
  @track subtypeexpanded = {
    expaned: false,
    class:
      "slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click"
  };

  @track rejects;

  @track rejectTypes;
  @track rejectSubtypes;
  // SELECTED TYPES
  @track selectedTypes = [];
  //SELECTED SUBTYPES
  @track selectedSubtypes = [];

  @wire(CurrentPageReference) pageRef;

  async connectedCallback() {
    console.log('objectapi approval: ' + this.objectApiName);
    try {
      this.rejects = await getRejects({ sobjectName: this.objectApiName });
      console.log(this.rejects);
    } catch (error) {
      console.log(this.rejects);
      console.log("Error al traer rejects");
      console.log(error);
      this.dispatchEvent(
        new ShowToastEvent({
          title: 'Sorry',
          message: 'Error al traer rejects ' + error,
          variant: 'error'
        })
      );

    }

    let rejectTypesRep = this.rejects.map(({ Error_Type__c }) => {
      return Error_Type__c;
    });

    let uniquetypes = new Set(rejectTypesRep);
    let uniquetypes2 = [...uniquetypes];

    this.rejectTypes = uniquetypes2.map(type => {
      return {
        type: type,
        selected: false,
        subtypes: []
      };
    });

    this.rejectTypes.sort((a, b) => (a.type > b.type) ? 1 : -1);
    console.log("rejectTypes");
    console.log(this.rejectTypes);

  }

  
  selectVal(event) {
    let targetIndex = event.target.dataset.index;
    console.log('Index :' + targetIndex);
    if (this.rejectTypes[targetIndex].selected === false) {
      this.rejectTypes[targetIndex].selected = true;
      this.selectedTypes.push(this.rejectTypes[targetIndex].type);      
      let rejectSubtypesRep = this.rejects.filter(({ Error_Type__c }) =>
        this.selectedTypes.includes(Error_Type__c)
      );
      let uniqueSubtypes = new Set(rejectSubtypesRep);
      let categories = [...uniqueSubtypes];
      console.log('categories ' + JSON.stringify(categories))
      console.log('this.rejectSubtypes ' + JSON.stringify(this.rejectSubtypes))
      let selectedValues = this.rejectSubtypes 
      console.log('this.selectedTypes ' + JSON.stringify(this.selectedTypes))
      this.rejectSubtypes = this.selectedTypes.map(type => {
        let tipo = {
          type: type,
          subtypes: []
        };
        categories.forEach(cat => {          
          if (cat.Error_Type__c === type) {
            console.log('tipo ' + JSON.stringify(tipo))
            console.log('cat ' + JSON.stringify(cat))
            console.log('type ' + JSON.stringify(type))
            let isSelected = false
            if(selectedValues){
              let findSomeThing = selectedValues.filter(findex => findex.type === type)
              console.log('findSomeThing ' + JSON.stringify(findSomeThing) )
              if(findSomeThing !== undefined && findSomeThing !== null && findSomeThing.length > 0){
                let findSelected = findSomeThing[0].subtypes.filter(sindex => sindex.subtype === cat.Subtype_Error__c)
                console.log('findSelected ' + JSON.stringify(findSelected) )
                if(findSelected !== undefined && findSelected !== null && findSelected.length > 0){

                  isSelected = findSelected[0].selected 
                }
              }
            }
            let subtype = {
              subtype: cat.Subtype_Error__c,
              type: type,
              selected: isSelected
            };
            console.log('subtype ' + JSON.stringify(subtype))
            tipo.subtypes.push(subtype);
          }
        });
        tipo.subtypes.sort((a, b) => (a.subtype > b.subtype) ? 1 : -1);
        return tipo;
      });
      console.log('this.rejectSubtypes1 ' + JSON.stringify(this.rejectSubtypes))

      console.log("rejectSubtypes sub");
      console.log(this.rejectSubtypes);
    } else {
      console.log('horale')
      console.log('this.rejectTypes' + JSON.stringify(this.rejectTypes));
      let subs = this.rejectTypes[targetIndex].type;

      console.log('suuubs')
      console.log(subs)
      this.selectedTypes.splice(targetIndex, 1);
     // this.selectedTypes = this.removeItemFromArr(this.selectedTypes,this.rejectTypes[targetIndex].type)

      console.log('this.selectedTypes ' + JSON.stringify(this.selectedTypes));

      let filterselected = this.selectedSubtypes.filter(({ type }) => type !== subs)
      console.log('filterselected ' + JSON.stringify(filterselected))
      this.selectedSubtypes = filterselected;
      console.log('this.rejectTypes[targetIndex] ' + JSON.stringify(this.rejectTypes[targetIndex]))

      this.rejectTypes[targetIndex].selected = false;
      
      let restSubtipes = [
        ...this.rejectSubtypes.filter(
          ({ type }) => type !== this.rejectTypes[targetIndex].type
        )
      ];      
      //console.log(restSubtipes)
      this.rejectSubtypes = restSubtipes;

    }
    console.log('--diferencia')
    console.log('this.rejectSubtypes ' + JSON.stringify(this.rejectSubtypes))
    console.log('this.rejectTypes ' + JSON.stringify(this.rejectTypes))
  }

  selectValSubType(event) {
    let typeIndex = event.target.dataset.typeindex;
    let subtypeIndex = event.target.dataset.index;
    console.log("typeIndex: " + typeIndex);
    console.log("subtype");
    console.log(subtypeIndex);
    if (
      this.rejectSubtypes[typeIndex].subtypes[subtypeIndex].selected === false
    ) {
      console.log("ENMTTRA");
      this.rejectSubtypes[typeIndex].subtypes[subtypeIndex].selected = true;
      this.selectedSubtypes.push(
        this.rejectSubtypes[typeIndex].subtypes[subtypeIndex]
      );
      console.log('selected subs')
      console.log(this.selectedSubtypes)
    } else {
      this.rejectSubtypes[typeIndex].subtypes[subtypeIndex].selected = false;
      let subtype = this.rejectSubtypes[typeIndex].subtypes[subtypeIndex];
      this.selectedSubtypes.splice(
        this.selectedSubtypes.indexOf(subtype),
        this.selectedSubtypes.indexOf(subtype) + 1
      );
    }
  }

  @api
  saverejects() {
    console.log('funciona')
    let rejects = [];
    if (this.selectedSubtypes.length > 0) {
      this.selectedSubtypes.forEach(subtype => {
        let Approval_Process_Reject__c = {
          Error_Type__c: subtype.type,
          Subtype_Error__c: subtype.subtype,
          Process_Type__c: this.objectApiName
        };

        Approval_Process_Reject__c[this.objectApiName] = this.recordId;
        rejects.push(Approval_Process_Reject__c);
      });
    } else {
      const event = new ShowToastEvent({
        title: "Warning!",
        message: "Select a subtype",
        variant: "warning"
      });
      this.dispatchEvent(event);
    }

    console.log("rere");
    console.log(rejects);

    if (rejects.length > 0) {
      try {
        saveRejects({ rejects: rejects });
        console.log('PASAMOS PARSE')
        fireEvent(this.pageRef, "saverejects", { detail: rejects });
      } catch (error) {
        console.log("error al salvar rejects");
        console.log(error);
        const event = new ShowToastEvent({
          title: "Failed!",
          message: "Failed on save reject",
          variant: "warning"
        });
        this.dispatchEvent(event);
      }
    }
  }

  get selectedTypesLength() {
    if (this.selectedTypes.length > 0) {
      return true;
    }

    return false;
  }

  expandetype() {
    console.log("EXPAMDEDTYPE");
    if (this.typeexpanded.expaned === true) {
      this.typeexpanded = {
        expaned: false,
        class: "slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click"
      };
    } else {
      this.typeexpanded = {
        expaned: true,
        class:
          "slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click slds-is-open"
      };
    }
  }

  expandesubtype() {
    console.log("expandedsubtype");
    if (this.subtypeexpanded.expaned === true) {
      this.subtypeexpanded = {
        expaned: false,
        class: "slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click"
      };
    } else {
      this.subtypeexpanded = {
        expaned: true,
        class:
          "slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click slds-is-open"
      };
    }
  }
}