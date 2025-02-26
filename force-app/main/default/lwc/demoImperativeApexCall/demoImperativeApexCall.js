import { LightningElement, wire } from 'lwc';
import getAccountList from '@salesforce/apex/AccountControllerClass.getAccountList';
import { deleteRecord } from 'lightning/uiRecordApi';
//import insertContact from '@salesforce/apex/contactController.insertContact';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';

export default class DemoImperativeApexCall extends LightningElement {
    accountList;
    wiredAccountResponse;

    /*handleClick() {
       getAccountList({ rating: 'Hot' })
            .then(response => {
                console.log(response);
                this.accountList = response;
            })
            .catch(error => {
                console.log('error occured: ', error.message);
            })
   }*/

    @wire(getAccountList, { rating: 'Hot' })
    getAccountdata(response) {
        this.wiredAccountResponse = response;
        if (response.data) {
            this.accountList = response.data;
        }
        if (response.error) {
            console.log('error occured: ', response.error);
        }
    }

    handleDelete(event) {
        console.log(event.target.name);
        const recId = event.target.name;
        deleteRecord(recId)
            .then(response => {
                console.log(response);
                this.dispatchEvent(new ShowToastEvent({
                    title: 'Record Deleted Successfully',
                    message: 'Deleted Record Id: ' + recId,
                    variant: 'success',
                }));
                refreshApex(this.wiredAccountResponse);
            })
            .catch(error => {
                console.log('error: ', error);
            })

    }

    /*handleDelete(event) {
        console.log(event.target.name);
        const recId = event.target.name;
        deleteRecord(recId); //send recordId for deleteRecord(recId)
        .then(response => {
            this.dispatchEvent(new ShowToastEvent({
                title: 'Record Deleted Successfully',
                message: 'Deleted Record Id: ' + recId,
                variant: 'success',
            }));
        })
            .catch(error => {
                console.log('error: ', error);
            })

    }*/


    /*lastName;
    mobilePhone;

    handleChange(event) {
        const { name, value } = event.target;
        console.log('target details: ', event.target);

        if (name === "lastname") {
            this.lastName = value;
        }
        if (name === "phone") {
            this.mobilePhone = value;
        }
        console.log('lastname details: ', this.lastName);
        console.log('phone details: ', this.mobilePhone);
    }

    handleCreate() {
        insertContact({ lastName: this.lastName, Mobile: this.mobilePhone })
            .then(response => {
                this.dispatchEvent(new ShowToastEvent({
                    title: 'Insert Record',
                    message: 'Record created succesfully: ' + response,
                    variant: 'success',
                }));
            })
            .catch(error => {
                console.log('error occured: ', error);
                this.dispatchEvent(new ShowToastEvent({
                    title: 'Insert Record',
                    message: 'unable to create record',
                    variant: 'error',
                }));
            })
    }*/
}