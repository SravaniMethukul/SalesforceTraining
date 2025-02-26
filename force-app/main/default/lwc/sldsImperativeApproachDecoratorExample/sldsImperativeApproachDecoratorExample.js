import { LightningElement } from 'lwc';
import getHighRevenueAccountRecords from '@salesforce/apex/AccountRecordsRetrieve.getHighRevenueAccountRecords';

export default class SldsImperativeApproachDecoratorExample extends LightningElement {
    accountsToDisplay = [];
    countOfRecords;

    handleCountValue(event) {
        let inputValue = event.target.value;
        if (inputValue === '')
            return
        this.countOfRecords = inputValue;
        console.log('value: ', this.countOfRecords);
        getHighRevenueAccountRecords({ count: this.countOfRecords }).then((response) => {
            this.accountsToDisplay = response;
            console.log('accountsToDisplay:', this.accountsToDisplay);
        })
            .catch((error) => {
                console.log('error:', error.getMessage());
            })


    }

    /*connectedCallback() {
        getHighRevenueAccountRecords({ count: this.countOfRecords }).then(response => {
            console.log('Response using imperative approach', response);
            this.accountsToDisplay = response;
            console.log('Account Records:', this.accountsToDisplay);
        })
            .catch(error => {
                console.log(error);
            })


    }*/
}