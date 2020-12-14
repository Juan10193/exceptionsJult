import { LightningElement, api, track } from 'lwc';
import getUnresolved from "@salesforce/apex/Aml_Review_cls.unresolvedEntities";

export default class AmlReviewUnrItems extends LightningElement {
    @api detalle;
    @track unresolvedItemsIds=[];
    @track unresolvedEnts =[];
    @track unresolvedEntsJSON ={};
    @track error;
    connectedCallback(){
        console.log('unresolveditems');
        console.log(this.detalle);
        for(let item of this.detalle){
            if(item.hits ===true || item.crr==='HIGH' || item.AdverseMedia===true){
                this.unresolvedItemsIds.push(item.id);
                let entidad = {
                    Name:item.Name,
                    id:item.id,
                    partyId:item.PartyId,
                    hits:item.crr==='HIGH'?true:item.hits,
                    hitDescription:item.crr==='HIGH'?item.hitDescription===undefined?'HIGH CRR':item.hitDescription + ' HIGH CRR':item.AdverseMedia===true?item.hitDescription===undefined?'Adverse Media':item.hitDescription + ' Adverse Media':item.hitDescription,
                    entityType:item.entityType
                }
                this.unresolvedEnts.push(entidad);
            }
        }

        this.unresolvedEntsJSON.unresolveds = this.unresolvedEnts;
        this.unresolvedEntsJSON = JSON.stringify(this.unresolvedEntsJSON);
        console.log('unresolveditemsJSON');
        console.log(this.unresolvedEnts);
        console.log('lista de ids')
        console.log(this.unresolvedItemsIds);
        getUnresolved({Ids:this.unresolvedItemsIds, unresolvedEnts:this.unresolvedEntsJSON})
        .then(resultado => {
            console.log('resultadounresolved');
            console.log(resultado);
        }).catch(errores => {
            console.log('error unresolved');
            console.log(errores);
            this.error = errores;
            
          });

    }

    get unresolvedCount(){
        return this.unresolvedEnts.length;
    }

    @track openmodel = false;
    openmodal() {
        this.openmodel = true

    }
    closeModal() {
        this.openmodel = false
    } 
    saveMethod() {
        this.closeModal();
    }
}