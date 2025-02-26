import { LightningElement, api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import getRelatedContactRecords from '@salesforce/apex/ContactRetreive.getRelatedContactRecords';
import { refreshApex } from '@salesforce/apex';


export default class CaseStudyLwcThree extends LightningElement {
    @api recordId;
    contactList;
    wiredContacts;

    // Wire the Account record to detect changes
    @wire(getRecord, { recordId: '$recordId', fields: ['Account.LastModifiedDate'] })
    accountRecord;

    @wire(getRelatedContactRecords, { accId: '$recordId' })
    getAccountContactData(response) {
        if (response.data) {
            this.wiredContacts = response;
            this.contactList = response.data;
            console.log('contact list : ', this.contactList);
            console.log('contact list : ', JSON.stringify(this.contactList));
        }
        if (response.error) {
            console.log('error occured: ', response.error);
        }
    }

    @wire(getRecord, { recordId: '$recordId', fields: ['Account.LastModifiedDate'] })
    wiredAccountRecord({ data }) {
        if (data) {
            refreshApex(this.wiredContacts);
        }
    }
}