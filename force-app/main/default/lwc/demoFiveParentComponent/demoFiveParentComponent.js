import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import ACCOUNT_NAME from '@salesforce/schema/Account.Name';
import ACCOUNT_INDUSTRY from '@salesforce/schema/Account.Industry';
import ANNUAL_REVENUE from '@salesforce/schema/Account.AnnualRevenue';
import CONTACT_ACCOUNT from '@salesforce/schema/Contact.AccountId';

export default class DemoFiveParentComponent extends LightningElement {
    objectname = ACCOUNT_OBJECT;
    fieldslist = [ACCOUNT_NAME, ACCOUNT_INDUSTRY, ANNUAL_REVENUE];
    fields = [CONTACT_ACCOUNT];

    @api objectApiName;
    @api recordId;

    updateHandler(event) {
        //console.log(event.detail.id);
        // alert(event.detail.id);
        const toast = new ShowToastEvent({
            title: "Record Created",
            message: "Record created with id: " + event.detail.id,
            variant: "success",
        });
        this.dispatchEvent(toast);
    }
}