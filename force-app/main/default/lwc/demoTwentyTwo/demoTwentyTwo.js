import { LightningElement, wire } from 'lwc';
import getAccountList from '@salesforce/apex/AccountControllerClass.getAccountList';
import { getObjectInfo, getPicklistValues } from 'lightning/uiObjectInfoApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import ACCOUNT_RATING from '@salesforce/schema/Account.Rating';

export default class DemoTwentyTwo extends LightningElement {
    rating;
    masterRecordTypeId;
    accountRecordTypeIds;
    ratingOptions;
    /*ratingOptions = [{
        label: 'Hot',
        value: 'Hot',
    },
    {
        label: 'Warm',
        value: 'Warm',
    },
    {
        label: 'Cold',
        value: 'Cold',
    }];*/

    handleChange(event) {
        this.rating = event.target.value;
    }

    @wire(getAccountList, { rating: '$rating' })
    getAccountData;

    @wire(getObjectInfo, { objectApiName: ACCOUNT_OBJECT })
    getObjectData({ data, error }) {
        if (data) {
            this.accountRecordTypeIds = data.recordTypeInfos;
            this.masterRecordTypeId = Object.values(this.accountRecordTypeIds).find(
                (rec) => rec.master === true).recordTypeId;
            console.log('Account object details obtained: ', data);
            console.log('master recordTypeId values details obtained: ', this.masterRecordTypeId);
        }
        if (error) {
            console.log('error occured for account object: ', error);
        }
    }

    @wire(getPicklistValues, { recordTypeId: '$masterRecordTypeId', fieldApiName: ACCOUNT_RATING })
    getPicklistData({ data, error }) {
        if (data) {
            console.log('Picklist values details obtained: ', data);
            this.ratingOptions = data.values.map((e) => ({
                label: e.label,
                value: e.value,
            }));
            console.log('rating options: ', JSON.stringify(this.ratingOptions));
        }
        if (error) {
            console.log('error occured for picklist values: ', error);
        }
    }

    
    //accounts;
    //call apex method

    /* @wire(getAccountList)
     getAccountRecords({ data, error }) {
         if (data) {
             console.log('data obtained: ', data);
             this.accounts = data;
         }
         if (error) {
             console.log('error obtained: ', error.message);
         }
     }*/
}