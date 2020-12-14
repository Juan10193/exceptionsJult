import { LightningElement } from "lwc";
import { NavigationMixin } from 'lightning/navigation';
export default class DocsHelper extends NavigationMixin (LightningElement) {

    navigateNext(url) {
        this[NavigationMixin.Navigate]({
            type: 'standard__webPage',
            attributes: {
                url: url,
            }, 
        });
    }
  
}