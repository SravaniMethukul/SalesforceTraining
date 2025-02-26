import { LightningElement, api, wire, track } from 'lwc';
import CONTACT_OBJECT from '@salesforce/schema/Contact';
import ACCOUNT_ID from '@salesforce/schema/Contact.AccountId';
import ACCOUNT_BILLING_STREET from '@salesforce/schema/Account.BillingStreet';
import ACCOUNT_BILLING_CITY from '@salesforce/schema/Account.BillingCity';
import ACCOUNT_BILLING_STATE from '@salesforce/schema/Account.BillingState';
import { getRecord } from 'lightning/uiRecordApi';

export default class DiyRecordEditFormTwentyFour extends LightningElement {
    @api recordId;
    @track accountId;
    @track address = {};
    objectName = CONTACT_OBJECT;
    fieldsList = {
        AccountIdField: ACCOUNT_ID
    };

    handleChange(event) {
        this.accountId = event.target.value;
        console.log('account Id: ', this.accountId);
        if (this.accountId === '') {
            this.address = {};
        }
    }


    @wire(getRecord, { recordId: '$accountId', fields: [ACCOUNT_BILLING_STREET, ACCOUNT_BILLING_CITY, ACCOUNT_BILLING_STATE] })
    getRecordData({ data, error }) {
        if (data) {
            console.log('Account Object Record obtained: ', data.fields);
            this.address = {
                street: data.fields.BillingStreet.value ? data.fields.BillingStreet.value : '',
                city: data.fields.BillingCity.value ? data.fields.BillingCity.value : '',
                state: data.fields.BillingState.value ? data.fields.BillingState.value : ''
            };
            console.log('Address is: ', JSON.stringify(this.address));
        }
        if (error) {
            console.log('Error occured:  ', error);
        }
    }
}