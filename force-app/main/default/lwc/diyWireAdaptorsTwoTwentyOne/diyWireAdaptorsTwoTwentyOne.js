import { LightningElement, wire } from 'lwc';
import { updateRecord } from 'lightning/uiRecordApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import ACCOUNT_RECORDTYPEID from '@salesforce/schema/Account.RecordTypeId';
import ACCOUNT_INDUSTRY from '@salesforce/schema/Account.Industry';
import ACCOUNT_REVENUE from '@salesforce/schema/Account.AnnualRevenue';
import ACCOUNT_NAME from '@salesforce/schema/Account.Name';
import { getPicklistValues, getObjectInfo } from 'lightning/uiObjectInfoApi';
import { getRecord } from 'lightning/uiRecordApi';

export default class DiyWireAdaptorsTwoTwentyOne extends LightningElement {

    industryOptions;
    recordTypeIdToPass;
    accounts;
    picklistValues;
    formOptions = {};
    recordTypeIdsObtained;
    selectedRecordId;
    accountInfo;
    masterRecordTypeId;
    showRecordPicker = true;
    //@track defaultRecordId = '001dM00000UYIvhQAH';

    matchingInfo = {
        primaryField: { fieldPath: 'Name' },
    };

    displayInfo = {
        primaryField: 'Name',
    };

    handleRecordIdChange(event) {
        this.selectedRecordId = event.detail.recordId;
        console.log('Account Id obtained: ', this.selectedRecordId);
        this.formOptions.Id = this.selectedRecordId;
        console.log('value after removed: ', event.detail);
        if (event.detail.recordId === null) {
            this.handleClear();
        }
    }

    handleChange(event) {
        const { name, value } = event.target;
        this.formOptions[name] = value;
        console.log('form options: ', JSON.stringify(this.formOptions));
    }

    handleUpdate() {
        updateRecord({ fields: this.formOptions })
            .then(response => {
                console.log('Updated record: ', response);
                this.clearInputs();
            })
            .catch((error) => {
                console.error('Error updating record: ', error);
            });
    }

    @wire(getRecord, { recordId: '$selectedRecordId', fields: [ACCOUNT_RECORDTYPEID, ACCOUNT_NAME, ACCOUNT_INDUSTRY, ACCOUNT_REVENUE] })
    getRecordData({ data, error }) {
        if (data) {
            this.accountInfo = data.fields;
            console.log('record data obtained: ', JSON.stringify(this.accountInfo));
            this.recordTypeIdToPass = data.fields.RecordTypeId.value;
            if (this.recordTypeIdToPass === null) {
                this.recordTypeIdToPass = this.masterRecordTypeId;
            }
            console.log('record Type Id data obtained: ', JSON.stringify(this.recordTypeIdToPass));
            this.template.querySelector(".Name").value = this.accountInfo.Name.value;
            this.template.querySelector(".Industry").value = this.accountInfo.Industry.value ? this.accountInfo.Industry.value : '';
            this.template.querySelector(".AnnualRevenue").value = this.accountInfo.AnnualRevenue.value ? this.accountInfo.AnnualRevenue.value : 0;
        }
        if (error) {
            console.log('error message obtained: ', error.message);
        }
    }

    @wire(getPicklistValues, { recordTypeId: '$recordTypeIdToPass', fieldApiName: ACCOUNT_INDUSTRY })
    getPicklistData({ data, error }) {
        if (data) {
            console.log('entered the getpicklist view function');
            this.picklistValues = data;
            console.log('picklist values obtained: ', this.picklistValues);
            this.picklistValues = this.picklistValues.values.map((rec) => ({
                label: rec.label,
                value: rec.value,
            }));
            console.log('picklist values obtained: ', JSON.stringify(this.picklistValues));
        }
        else if (error) {
            console.error('Error retrieving object info:', error);
        }
    }

    @wire(getObjectInfo, { objectApiName: ACCOUNT_OBJECT })
    getAccountData({ data, error }) {
        if (data) {
            console.log('objectInfo Obtained: ', data);
            this.masterRecordTypeId = Object.values(data.recordTypeInfos).find(
                (rec) => rec.master === true).recordTypeId;
            console.log('masterRecordTypeId Obtained: ', this.masterRecordTypeId);
        }
        if (error) {
            console.error('Error retrieving object info:', error);
        }
    }


    clearInputs() {
        try {
            const inputsToClear = this.template.querySelectorAll('lightning-input , lightning-combobox');
            inputsToClear.forEach((inp) => {
                inp.value = '';
            })
            /*this.template.querySelector('lightning-record-picker').clear();
            this.refs.recordPicker.value = null;
            this.selectedRecordId = null;
            this.defaultRecordId = '';
            this.formOptions = {};
            this.selectedRecordId = null;*/

            this.selectedRecordId = null;
            this.formOptions = {};

            // Force Re-render of lightning-record-picker
            this.showRecordPicker = false;
            // eslint-disable-next-line @lwc/lwc/no-async-operation
            setTimeout(() => {
                this.showRecordPicker = true;
            }, 0);
        }
        catch (error) {
            console.error();
        }
    }

    handleClear() {
        this.clearInputs();
    }
}