import { LightningElement, wire } from 'lwc';
import getAccounts from '@salesforce/apex/ApexForAccount.getAccounts';
import getContacts from '@salesforce/apex/ApexForContact.getContacts';
import ModalComponent from 'c/lwcModalForDataTable';
import { deleteRecord } from 'lightning/uiRecordApi';
import { refreshApex } from '@salesforce/apex';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class LwcDataTableComponent extends LightningElement {
    contactsData;
    accountsObtained;
    isLoading = false;
    columnslist = [
        { label: 'Id', fieldName: 'Id' },
        { label: 'Name', fieldName: 'Name' },
        {
            label: 'Related Contacts',
            type: 'button',
            typeAttributes: {
                variant: 'brand',
                label: 'View',
                name: 'contact_details',
            }
        },
        {
            label: 'Delete Account',
            type: 'button-icon',
            typeAttributes: {
                iconName: 'utility:delete',
                name: 'delete',
                variant: 'border-filled',
            }
        },
    ];


    @wire(getAccounts)
    accountsData(response) {
        if (response.data) {
            this.wiredAccounts = response;
            this.accountsObtained = response.data;
        }
        if (response.error) {
            console.log('error occured: ', response.error);
        }
    }

    async handleContactDetails(accountId) {
        try {
            const contacts = await getContacts({ accountId });
            //this.contactsData = contacts;
            console.log('contact data: ', JSON.stringify(contacts));
            await ModalComponent.open({
                size: 'small',
                description: 'Modal for Related Contacts',
                contactInfo: contacts,
            });
        } catch (error) {
            console.log('Error occurred:', JSON.stringify(error));
        }
    }

    handleDelete(accountId) {
        deleteRecord(accountId)
            .then((response) => {
                console.log('Inside delete: ', response);
                this.dispatchEvent(new ShowToastEvent({
                    title: 'Record Deleted Successfully',
                    message: 'Deleted Record Id: ' + accountId,
                    variant: 'success',
                }));
                refreshApex(this.wiredAccounts);
                this.isLoading = false;
            })
            .catch(error => {
                this.isLoading = false;
                this.dispatchEvent(new ShowToastEvent({
                    title: 'Error',
                    message: 'An error occurred while deleting the record.' + error.message,
                    variant: 'error',
                }));
            })
    }

    handleActions(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;
        console.log('account row: ', JSON.stringify(row));
        const accountSelectedId = row.Id;
        console.log('account id: ', accountSelectedId);
        console.log('action name: ', actionName);
        if (actionName === 'contact_details') {
            this.handleContactDetails(accountSelectedId);
        }
        else if (actionName === 'delete') {
            this.isLoading = true;
            this.handleDelete(accountSelectedId);
        }
    }
}