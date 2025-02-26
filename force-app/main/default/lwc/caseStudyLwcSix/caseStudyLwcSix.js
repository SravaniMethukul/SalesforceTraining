import { LightningElement, wire } from 'lwc';
import getAllAccounts from '@salesforce/apex/AccountControllerTwo.getAllAccounts';

export default class CaseStudyLwcSix extends LightningElement {
    accountList;
    inputValue;
    searchAccounts;
    searchAccountsLength;
    displayStart = false;

    @wire(getAllAccounts, { inputValue: '$inputValue' })
    getAccounts({ data, error }) {
        if (data) {
            if (this.inputValue !== '') {
                this.searchAccounts = data;
                console.log('search accounts: ', this.searchAccounts);
                this.searchAccountsLength = this.searchAccounts.length > 0 ? this.searchAccountsLength = true : this.displayStart = true;
                console.log('data : ', JSON.stringify(data));
            }
            else {
                this.searchAccounts = [];
                this.displayStart = false;
            }
        }
        if (error) {
            console.log('error: ', error);
        }
    }

    handleSearch(event) {
        //this.inputvalue = this.refs.searchInput.value;
        this.inputValue = event.detail.value;
        console.log('input value: ', this.inputValue);
        /*if (this.inputValue) {
            /* this.searchAccounts = this.accountList.filter((acc) => `${acc.Name}`.toLowerCase().includes(this.inputValue));
             console.log('search accounts: ', JSON.stringify(this.searchAccounts));
             this.searchAccountsLength = this.searchAccounts.length > 0 ? this.searchAccountsLength = true : this.this.displayStart = true;
             console.log('search account length: ', this.searchAccountsLength);

    }
        else if(this.inputValue === '') {
    this.searchAccounts = [];
}*/
    }
}