import { LightningElement, api, wire } from 'lwc';
import getContacts from '@salesforce/apex/OpportunityController.getContacts';

export default class CaseStudyLwcThreeSecond extends LightningElement {
    @api recordId
    contactList;
    contactListEmpty;
    columnsList = [{ label: "Id", fieldName: "Id" },
    { label: "FirstName", fieldName: "FirstName" },
    { label: "LastName", fieldName: "LastName" },
    ]

    @wire(getContacts, { oppId: '$recordId' })
    getContactsData({ data, error }) {
        if (data) {
            this.contactList = data;
            this.contactListEmpty = this.contactList.length > 0 ? true : false;
            console.log('contact list : ', JSON.stringify(this.contactList));
        }
        if (error) {
            console.log('error : ', error);
        }
    }
}