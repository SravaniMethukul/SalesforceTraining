import { LightningElement, api } from 'lwc';
import updateAnnualRevenue from '@salesforce/apex/AccountControllerClass.updateAnnualRevenue';
import { notifyRecordUpdateAvailable } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { RefreshEvent } from 'lightning/refresh';

export default class DemoRefreshPageWithAura extends LightningElement {
    @api recordId;
    revenue;
    async handleClick() {
        console.log('record Id: ', this.recordId);

        //this.revenue = parseFloat(this.template.querySelector('.AnnualRevenue').value);
        await updateAnnualRevenue({ recId: this.recordId })
            .then(response => {
                console.log('updated: ', response);

                //custom event
                /*this.dispatchEvent(new CustomEvent(
                    'refreshaccount', { detail: 'refresh Account' }
                ));*/
                this.dispatchEvent(new ShowToastEvent({
                    title: 'Updated Annual revenue for record',
                    message: `Updated Record : ${this.recordId}`,
                    variant: 'success',
                }));

            })
            .catch(error => {
                console.log('error occured: ', error);
            })
        const success = await notifyRecordUpdateAvailable([{ recordId: this.recordId }]);
        console.log('success obtained: ', success);
        //this.dispatchEvent(new RefreshEvent());
    }

}