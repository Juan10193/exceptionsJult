/**
 * @File Name          : takedownPricingVSPricingDetail.js
 * @Description        : 
 * @Author             : eduardo.villegas@engeniumcapital.com
 * @Group              : 
 * @Last Modified By   : eduardo.villegas@engeniumcapital.com
 * @Last Modified On   : 26/9/2019 15:40:10
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    26/9/2019   eduardo.villegas@engeniumcapital.com     Initial Version
**/
import { LightningElement, wire, track, api } from "lwc";

export default class TakedownPricingVSPricingDetail extends LightningElement {
    @api wrapperdata;
    @api selecteddata;

    tests(){
        console.log(JSON.stringify(this.wrapperdata));
        console.log(JSON.stringify(this.selecteddata));
    }
}