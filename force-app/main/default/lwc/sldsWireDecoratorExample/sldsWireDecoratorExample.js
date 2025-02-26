import { LightningElement, wire } from 'lwc';
import getHighRevenueAccountRecords from '@salesforce/apex/AccountRecordsRetrieve.getHighRevenueAccountRecords';
export default class SldsWireDecoratorExample extends LightningElement {
    accountsToDisplay = [];
    countOfRecords;

    handleCountValue(event) {
        let inputValue = event.target.value;
        if (inputValue === '')
            return
        this.countOfRecords = inputValue;
        console.log('value: ', this.countOfRecords);
    }

    @wire(getHighRevenueAccountRecords, { count: '$countOfRecords' })
    getAccountshandler(response) {
        //{error:...,data:...}
        //case 1: if data present then {error:undefind, data:...}
        //case 2:if no data then {error:..., data: undefined}
        const { data, error } = response;
        if (error) {
            console.log(error);
        }
        else {
            this.accountsToDisplay = data;
            console.log('account to display:', this.accountsToDisplay);
        }

    }
}