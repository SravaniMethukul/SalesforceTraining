import { LightningElement, wire, track } from 'lwc';
//import getContactRecords from '@salesforce/apex/practiceApexForInterview.getContactRecords';
import getAccounts from '@salesforce/apex/practiceApexForInterview.getAccounts';

export default class PracticeLwcForInterview extends LightningElement {

    @track accountData;
    rowsSelected;
    rowActionSelected;
    columnsList = [
        { label: 'Id', fieldName: 'Id' },
        { label: 'Name', fieldName: 'Name' },
        {
            type: 'action',
            typeAttributes: {

                rowActions: [{
                    label: 'Show Details',
                    name: 'show_details',
                    iconName: 'utility:preview'
                }]
            }
        }
    ];

    @wire(getAccounts)
    accountDataObtained({ data, error }) {
        if (data) {
            this.accountData = data;
        }
        if (error) {
            console.log(error);
        }
    }

    hanldeRowSelected(event) {
        this.rowsSelected = event.detail.selectedRows;
        console.log('selected rows in practice', this.rowsSelected);
    }

    handleRowAction(event) {
        this.rowActionSelected = event.detail.row;
        console.log('selected rows action in practice', this.rowActionSelected);
    }
    /*contactsObtained;

    @wire(getContactRecords)
    contactData({ data, error }) {
        if (data) {
            this.contactsObtained = data;
        }
        if (error) {
            console.log('error' + error.getMessage());
        }
    }*/

    /* @track accountOptions;
     accountObtained;
     val;
 
     @wire(getAccounts)
     accountsData({ data, error }) {
         if (data) {
             this.accountObtained = data;
             console.log('account data from practice', JSON.stringify(this.accountObtained));
             this.accountOptions = this.accountObtained.map(ele => {
                 return {
                     label: ele.Name,
                     value: ele.Id
                 }
             });
             console.log('account options from practice', JSON.stringify(this.accountOptions));
         }
         if (error) {
             console.log(error);
         }
     }
 
     handleChange(event) {
         this.val = event.target.value;
         console.log(this.val);
     }*/

}