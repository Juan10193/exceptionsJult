import { LightningElement, api, track, wire } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import getEntities from "@salesforce/apex/Aml_Review_cls.getEntities";
import { refreshApex } from '@salesforce/apex';

export default class DatatableBasic extends LightningElement {
  @api recordId;
  @api showDetalles;
  @api detalle;
  @track entidades;
  @track error;

  wiredEntitiesResult;

  @wire(getEntities,{caId:'$recordId'})
  wireEnts(result){
    this.wiredEntitiesResult = result;
    if(result.data){
      console.log('wiredents para');
      console.log(this.wiredEntitiesResult.data);
      
      let arrayEnts = [];
        for (let ent of this.wiredEntitiesResult.data) {
            let restado =ent.ES2_fm_Entity__c.replace('<a href="','');
            restado = restado.replace('</a>','');
            restado = restado.replace('" target="_blank"','');
            let valoresUrl= restado.split('>');
          arrayEnts.push({
            Name: ent.ES2_fm_Entity__c,
            Role: ent.ES2_ms_Role__c,
            UrLink: valoresUrl[0],
            Obligor: ent.ES2_ms_Role__c.includes("Obligor"),
            Guarantor: ent.ES2_ms_Role__c.includes("Guarantor"),
            RDE: ent.ES2_ms_Role__c.includes("Risk Decision Entity"),
            BO: ent.ES2_ms_Role__c.includes("Beneficial Owner"),
            Depositary: ent.ES2_ms_Role__c.includes("Legal Depositary"),
            EntityType: ent.ES2_tx_CostumerType__c,
            AdverseMedia:ent.ES2_chk_Adverse_Media__c,
            PartyId:ent.ES2_tx_Party_Id__c,
            id: ent.Id
          });
        }
        this.entidades = arrayEnts;
        this.sentFromStructure();
        this.error = null;
    }else if(result.error){
      this.error =result.error;
      this.entidades=undefined;
    }
    
  }

  sentFromStructure() {
    this.dispatchEvent(new CustomEvent('sentfromstructure', {detail:{listaEnt:this.entidades}}));
  }

       
}