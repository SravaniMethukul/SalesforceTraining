import { LightningElement } from 'lwc';
import getFetchRelatedContactRecord from '@salesforce/apex/ContactRetrieveFromAccount.getFetchRelatedContactRecord';

export default class SldsWireDecExampleFromN extends LightningElement {
    selectedAccount;
    contactsRecords = [];
    error;

    get isNoAccountSelected() {
        return !this.selectedAccount;
    }

    handleAccountChange(event) {
        this.selectedAccount = event.target.value;
        console.log('value:', this.selectedAccount);
        console.log('type:', typeof this.selectedAccount);
    }

    /*@wire(getFetchRelatedContactRecord, { accId: '$selectedAccount' })
 
    getContactHandler(response) {
        const { data, error } = response;
        if (data) {
            console.log('Fetched contacts:', data);
            this.contactsRecords = data;
            this.error = undefined;
            console.log('contact records:', this.contactsRecords);
        }
        else {
            console.error('Error fetching contacts:', error);
            console.log(error);
            this.contactsRecords = [];
        }
    }*/

    fetchContacts() {
        // Ensure selectedAccount is valid before calling Apex
        if (this.selectedAccount) {
            getFetchRelatedContactRecord({ accId: this.selectedAccount })
                .then((result) => {
                    console.log('Fetched contacts:', result);  // Log the result
                    // Ensure the result is an array before assigning
                    this.contactsRecords = Array.isArray(result) ? result : [];
                    console.log('Fetched contacts:', result);
                    this.error = undefined;
                })
                .catch((error) => {
                    console.error('Error fetching contacts:', error);
                    this.error = error.body ? error.body.message : error.message;
                    this.contactsRecords = [];
                });
        } else {
            console.error('Account ID is missing or invalid');
            this.error = 'Account ID is missing or invalid';
            this.contactsRecords = [];  // Ensure empty array when no account is selected
        }
    }


    //imperative call
    /*connectedCallback() {
        getFetchRelatedContactRecord({ accId: this.accountId }).then(response => {
            console.log('Response using imperative approach', response);
            this.contactsRecords = response;
        })
            .catch(error => {
                console.log(error);
            })
    }*/
}