import { LightningElement, api, wire, track} from 'lwc';
import getsServiceUrl from "@salesforce/apex/ES3_DocSInRequestCalloutClass.getUrl";
import pushHits from "@salesforce/apex/Aml_Review_cls.showHits";
import changeAdverse from "@salesforce/apex/Aml_Review_cls.adverseMedia";

export default class Aml_Review_Details extends LightningElement {

    @api  Entity;
    sServiceUrl
    @track hits;
    @track error;
    @track entidades=[];

connectedCallback(){
   //get url del servicio
getsServiceUrl()
  .then(data =>{
    console.log('entidad financiera');
    console.log(this.Entity);
    
    this.sServiceUrl = data;
    console.log('data');
    console.log(this.sServiceUrl);
    
    let partysId = [];
    for(let pId of this.Entity){
        partysId.push(Number(pId.PartyId));
    }
    console.log('partys');
    console.log(partysId);
    console.log(this.sServiceUrl);
    pushHits({partyIds:partysId, sServiceURL:this.sServiceUrl})
    .then(resultado => {
        console.log('ressssult');
        console.log(resultado);
        this.hits = resultado;
        for(let hit of this.hits.amlHits){
            for(let ent of this.Entity){
                if(hit.partyId === Number(ent.PartyId)){
                    let entidad = ent;
                    entidad.country =hit.country;
                    entidad.state = hit.state;
                    entidad.hits = hit.hits ==='true'?true:false;
                    entidad.industry =hit.sicCodeDescription;
                    entidad.crr = hit.crr;
                    entidad.hitDescription =hit.hitDescription;
                    entidad.EntityType=hit.entityType;
                    entidad.whachlist = hit.hits ==='true'?'Yes':'No';
                    this.entidades.push(entidad);
                }
            }
        }
        console.log('entidad final');
        console.log(this.entidades);
        this.sentFromDetails();
    })
    .catch(errores => {
        console.log('errorlel');
        console.log(errores);
        this.error = errores;
        this.hits = undefined;
      });
  }).catch(error=>{
    console.log('errorlel2');
    console.log(error);
    this.error = error;
    this.sServiceUrl = undefined;
  })
}

search(event){
    console.log('event search');
    let nameNoFormated= event.target.dataset.entity;
    let nameSubs1 = nameNoFormated.replace('<a href="','');
    let nameSubs2 = nameSubs1.replace('</a>','');
    let nameSubs3 = nameSubs2.replace('" target="_blank"','');
    let nameSplited = nameSubs3.split('>');
    let name = nameSplited[1];
    console.log(name);
    let busqueda =window.open('https://www.google.com/search?q='+name + '&tbm=nws','_blank',"toolbar=yes,scrollbars=yes,resizable=yes,top=800,left=800,width=800,height=800");   
}

sentFromDetails() {
    this.dispatchEvent(new CustomEvent('sentfromdetails', {detail:{listaEnt:this.entidades}}));
  }

adverse(event) {
    console.log('event adverse');
    let entityId= event.target.dataset.entity;
    

    
   
    changeAdverse({entId:entityId}).
    then(resultado =>{
        console.log('resultado adverse');
        console.log(resultado);
        this.dispatchEvent(new CustomEvent('adversement'));
    }).catch(errores => {
        console.log('erroradverse');
        console.log(errores);
        this.error = errores;
      });

    
    }
    
}