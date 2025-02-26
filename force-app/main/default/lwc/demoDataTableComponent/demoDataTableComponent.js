import { LightningElement, wire, track } from 'lwc';
import getAccountList from '@salesforce/apex/AccountControllerClass.getAccountList';
import { updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';

export default class DemoDataTableComponent extends LightningElement {

    saveDraftValues;
    @track modifiedArray;

    columnsList = [{ label: 'Id', fieldName: 'Id' },
    { label: 'Name', fieldName: 'Name', editable: true },
    { label: 'Rating', fieldName: 'Rating', editable: true },
    { label: 'AnnualRevenue', fieldName: 'AnnualRevenue' },
    {
        type: 'action',
        typeAttributes: {
            rowActions: [
                { label: 'Show Details', name: 'show_details', iconName: 'utility:preview' },
                { label: 'Remove Details', name: 'remove_details', iconName: 'utility:close' },
            ]
        }
    }
    ];

    accountsList;
    accList;
    wiredAccountsRecords;
    //datatable
    // columns, data(Records), key-field
    //@wire(getAccountList)
    //accountsList;

    @wire(getAccountList)
    getAccountListHandler(response) {
        this.wiredAccountsRecords = response;
        if (response.data) {
            console.log('data: ', JSON.stringify(response.data));
            this.accountsList = response.data;
            this.accList = this.accountsList.slice(0, 3);
            console.log('account list: ', JSON.stringify(this.accList));
        }
        if (response.error) {
            console.log('error occured: ', response.error);
        }
    }

    handleClick() {
        const rows = this.template.querySelector('lightning-datatable').getSelectedRows();
        console.log("rows obtained: ", JSON.stringify(rows));
    }

    handleRowSelection(event) {
        const rows = event.detail.selectedRows;
        console.log('rows from rowselection: ', JSON.stringify(rows));
    }

    handleRowAction(event) {
        console.log(JSON.stringify(event.detail));
        console.log(JSON.stringify(event.detail.row));
    }

    //To update data back to apex
    //1. write an apex
    //2. uiRecordApi, updateRecord
    handleSave(event) {
        console.log('draft values: ', event.detail);
        this.saveDraftValues = event.detail.draftValues;
        this.saveDraftValues = JSON.stringify(this.saveDraftValues);
        console.log('draft values after json.stringify: ', this.saveDraftValues);
        //convert the proxy into array of objects using JSON.parse()
        this.saveDraftValues = JSON.parse(this.saveDraftValues);
        console.log('draft values after parse: ', this.saveDraftValues);

        //fields : {name: 'abc', revenue:30000}
        const v = this.saveDraftValues.map((rec) => {
            return { fields: rec };
        });

        /*this.saveDraftValues = this.saveDraftValues.slice().map((rec) => {
            const r = Object.assign({}, rec);
            return { fields: r };
        })*/

        console.log('v values: ', JSON.stringify(v));
        const responseReturned = v.map(recordInput => updateRecord(recordInput));
        //promise.all used to wait untill all records are updated
        Promise.all(responseReturned)
            .then(res => {
                this.dispatchEvent(new ShowToastEvent({
                    title: 'Updated Records',
                    message: 'Records Updated Succesfully',
                    variant: 'success',
                }))

                this.saveDraftValues = [];
                refreshApex(this.wiredAccountsRecords);
            })
            .catch(error => {
                console.log('error: ', this.error);
            });
    }
}