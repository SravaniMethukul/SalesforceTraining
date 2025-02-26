import { LightningElement, wire } from 'lwc';
import getAccountList from '@salesforce/apex/AccountControllerClass.getAccountList';
import { deleteRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';

export default class DiyDataTableWithDeleteAction extends LightningElement {
    accountList;
    recordIdObtained;
    columnsList = [
        { label: 'Id', fieldName: 'Id' },
        { label: 'Name', fieldName: 'Name' },
        { label: 'Rating', fieldName: 'Rating' },
        {
            type: 'button-icon',
            typeAttributes:
                { iconName: "action:delete" },
        }
    ];

    wiredAccountResponse;

    @wire(getAccountList)
    accountData(response) {
        this.wiredAccountResponse = response;
        if (response.data) {
            this.accountList = response.data;
            console.log('accounts: ', JSON.stringify(this.accountData));
        }
        if (response.error) {
            console.log('error', response.error);
        }
    }

    handleRowAction(event) {
        const rowObtained = event.detail.row;
        console.log('get row: ', JSON.stringify(rowObtained));
        this.recordIdObtained = rowObtained.Id
        console.log('record Id obtained: ', this.recordIdObtained);
        deleteRecord(this.recordIdObtained)
            .then((response) => {
                console.log('Inside delete: ', response);
                this.dispatchEvent(new ShowToastEvent({
                    title: 'Record Deleted Successfully',
                    message: 'Deleted Record Id: ' + this.recordIdObtained,
                    variant: 'success',
                }));
                refreshApex(this.wiredAccountResponse);
            })
            .catch(error => {
                console.log('error', error);
            })
    }


}