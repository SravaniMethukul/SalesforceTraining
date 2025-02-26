import { LightningElement, api, wire, track } from 'lwc';
import ACCOUNT_NAME from '@salesforce/schema/Account.Name';
import ACCOUNT_INDUSTRY from '@salesforce/schema/Account.Industry';
import ACCOUNT_ANNUALREVENUE from '@salesforce/schema/Account.AnnualRevenue';
import { getRecord, getFieldValue, getRecordUi } from 'lightning/uiRecordApi';
import { getObjectInfo, getPicklistValues, getPicklistValuesByRecordType } from 'lightning/uiObjectInfoApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import CONTACT_OBJECT from '@salesforce/schema/Contact';

const fields = [ACCOUNT_NAME, ACCOUNT_INDUSTRY, ACCOUNT_ANNUALREVENUE];
const objectApiNames = [ACCOUNT_OBJECT, CONTACT_OBJECT];

export default class DemoEightComponent extends LightningElement {

    recordTypeId;
    @track industryOptions;
    value = 'Technology';
    //1. get recordTypeId
    //2. get Picklist Info

    @wire(getObjectInfo, { objectApiName: 'Account' })
    getObjectData({ data, error }) {
        console.log("Inside Object Data method");
        console.log('data obtained for object: ', data);
        if (data) {
            this.recordTypeId = data.defaultRecordTypeId;
            console.log('record type Id: ', this.recordTypeId);
        }
        if (error) {
            console.log('error occured: ', error.message);
        }
    }

    @wire(getPicklistValues, { recordTypeId: '$recordTypeId', fieldApiName: ACCOUNT_INDUSTRY })
    getPicklistData({ data, error }) {
        console.log("Inside picklist Data method");
        console.log('picklist data obtained for object: ', data);
        if (data) {
            console.log('picklist data obtained for object: ', data.values);
            this.industryOptions = data.values.map((d) => {
                return { label: d.label, value: d.value }
            });
            console.log('Industry values: ', JSON.stringify(this.industryOptions));
        }
        if (error) {
            console.log('error occured: ', error.message);
        }
    }

    handleChange(event) {
        this.value = event.detail.value;
    }

    @wire(getObjectInfo, { objectApiName: 'Account' })
    objectInfoProp;

    @wire(getPicklistValuesByRecordType, { recordTypeId: '$objectInfoProp.data.defaultRecordTypeId', objectApiName: 'Account' })
    picklistHandler;

    handleClick(event) {
        console.log('values for picklist obtained: ', this.picklistHandler.data);
    }

    /*objectInfo;

    @wire(getObjectInfos, { objectApiNames: ['Account', 'Contact'] })
    objectInfoHandler({ data, error }) {
        if (data) {
            console.log('Insider Wire');
            console.log('data object obtained: ', data);
            this.objectInfo = data;
        }
        if (error) {
            console.log('error object obtained: ', error.message);
        }
    }*/


    //getRecordUi
    /*@wire(getRecordUi, { recordIds: ['001dM00002CMVhyQAH', '003dM00000AiDqEQAV'], layoutTypes: ['Full'], modes: ['View'] })
    recordsInfo;

    handleClick(event) {
        console.log('record Info: ', this.recordsInfo.data.records["001dM00002CMVhyQAH"].fields.Name.value);
    }*/

    //getFieldValue
    //@api recordId;
    //accountInfoForContact;
    //@wire(getRecord, { recordId: '$recordId', fields: fields })
    /*@wire(getRecord, { recordId: '$recordId', fields })
    getAccountRecord({ data, error }) {
        if (data) {
            console.log('data obtained: ', data);
            this.accountInfoForContact = data;
        }
        if (error) {
            console.log('error obtained: ', error.message);
        }
    }

    get AccountName() {
        return getFieldValue(this.accountInfoForContact, ACCOUNT_NAME);
    }

    get AccountIndustry() {
        return getFieldValue(this.accountInfoForContact, ACCOUNT_INDUSTRY);
    }

    get AccountRevenue() {
        return getFieldValue(this.accountInfoForContact, ACCOUNT_ANNUALREVENUE);
    }*/

}