import getAccountList from '@salesforce/apex/AccountControllerClass.getAccountList';
import { LightningElement, wire } from 'lwc';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import RATING_FIELD from '@salesforce/schema/Account.Rating';

export default class DiyCustomDataTableWithPicklistTwo extends LightningElement {

    accountList;
    /*picklistOptions = [{ label: 'Hot', value: 'Hot' },
    { label: 'Warm', value: 'Warm' },
    { label: 'Cold', value: 'Cold' }
    ];*/
    picklistOptions = [];
    columnslist = [
        { label: "Id", fieldName: "Id" },
        { label: "Name", fieldName: "Name" },
        {
            label: "Rating", fieldName: "Rating",
            type: 'picklistTemp',
            typeAttributes: {
                value: { fieldName: "Rating" },
                //options: this.picklistOptions,
                options: { fieldName: "picklistValues" },
                placeholder: 'Choose Rating',
                context: { fieldName: 'Id' }
            }
        },
    ];

    @wire(getObjectInfo, { objectApiName: ACCOUNT_OBJECT })
    accountObjectMetaData;

    @wire(getPicklistValues, { recordTypeId: '$accountObjectMetaData.data.defaultRecordTypeId', fieldApiname: RATING_FIELD })
    accountRatingPicklist({ data, error }) {
        if (data) {
            this.picklistOptions = data.values;
            this.fetchAccounts();
        }
        if (error) {
            console.log('error: ', error);
        }
    }

    fetchAccounts() {
        getAccountList()
            .then((result) => {
                let options = [];
                // eslint-disable-next-line guard-for-in, vars-on-top
                for (var key in this.picklistOptions) {
                    options.push({
                        label: this.picklistOptions[key].label,
                        value: this.picklistOptions[key].value
                    });
                }

                this.accountList = result.map((rec) => {
                    return {
                        ...rec,
                        'picklistValues': options
                    }
                })

            })
            .catch((error) => {
                console.log('error: ', error);
            })
    }

    /* @wire(getAccountList)
     accountData({ data, error }) {
         if (data) {
             this.accountList = data;
             /*this.accountList = data.map(acc => ({
                 ...acc, Rating: acc.Rating ? acc.Rating : '',
                 picklistValues: this.picklistOptions
             }));
             this.accountList = data.map(acc => ({
                 ...acc,
                 Rating: acc.Rating ? acc.Rating : '',  // Ensure there's a value for Rating
                 picklistValues: [...this.picklistOptions] // Default to picklistOptions if no data
             }));
             console.log('Accounts data for picklist : ', JSON.stringify(this.accountList));
         }
         if (error) {
             console.log('error: ', error);
         }
     }*/

    handlePicklistChange(event) {
        const { value, context } = event.detail;

        // Update the corresponding record in accountList
        this.accountList = this.accountList.map(acc =>
            (acc.Id === context ? { ...acc, Rating: value } : acc)
        );

        console.log('Updated accountList:', JSON.stringify(this.accountList));
    }

}