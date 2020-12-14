import { LightningElement, api} from 'lwc';
import submitApproval from '@salesforce/apex/ButtonSuppliersApproval_cls.submitApproval';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class ButtonSuplierApproval extends LightningElement {
    @api recordId;

    submitSuppliers() {
        submitApproval({idSupplier : this.recordId}).then( response => {
            this.showErrorToast('Success','Submit Suppliers successfully', 'success');
        }).catch(error => {
            this.showErrorToast('Error', error.body.message, 'error');
        })

    }

    /* Created message error */
    showErrorToast(title ,message , error) {
        const evt = new ShowToastEvent({
            'title': title,
            'message': message,
            'variant': error,
            mode: 'dismissable'
        });
        this.dispatchEvent(evt);
    }
}