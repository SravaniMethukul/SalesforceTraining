import { LightningElement, wire, track } from 'lwc';
import getAccountList from '@salesforce/apex/AccountControllerClass.getAccountList';
import { getObjectInfo, getPicklistValues } from 'lightning/uiObjectInfoApi';
import { updateRecord } from 'lightning/uiRecordApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import RATING_FIELD from '@salesforce/schema/Account.Rating';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';

export default class DiyCustomDataTablePicklistNew extends LightningElement {
    @track accountData;
    @track data;
    @track picklistOptions = [];
    @track draftValues = [];
    lastSavedData = [];
    showSpinner = false;
    showBar = true;

    get recordTypeId() {
        return this.accountData?.defaultRecordTypeId || '';
    }

    columnslist = [
        { label: "Id", fieldName: "Id" },
        { label: "Name", fieldName: "Name", editable: true },
        {
            label: "Rating", fieldName: "Rating", wrapText: true, editable: true,
            type: 'picklistTemp',
            typeAttributes: {
                value: { fieldName: "Rating" },
                options: { fieldName: "picklistValues" },
                placeholder: 'Choose Rating',
                context: { fieldName: 'Id' }
            }
        },
    ];

    @wire(getObjectInfo, { objectApiName: ACCOUNT_OBJECT })
    accountObjectMetaData({ data, error }) {
        if (data) {
            this.accountData = data;
        }
        if (error) {
            console.error('Object Info Error: ', error);
        }
    }

    @wire(getPicklistValues, { recordTypeId: '$recordTypeId', fieldApiName: RATING_FIELD })
    accountRatingPicklist({ data, error }) {
        if (data) {
            this.picklistOptions = data.values.map(option => ({
                label: option.label,
                value: option.value
            }));
            console.log('Picklist options:', JSON.stringify(this.picklistOptions));
        }
        if (error) {
            console.error('Picklist Fetch Error:', error);
        }
    }

    @wire(getAccountList, { pickList: '$picklistOptions' })
    accountDataObtained(result) {
        this.accountData = result;
        if (result.data) {
            console.log('Fetched Account List:', result);
            this.data = result.data.map(rec => ({
                ...rec,
                picklistValues: this.picklistOptions
            }));
            console.log('Processed Account List:', JSON.stringify(this.data));
            this.lastSavedData = JSON.parse(JSON.stringify(this.data));

        } else if (result.error) {
            this.data = undefined;
            console.log('error occured: ', result.error.message);
        }
    }

    handleSelection() {

    }

    updateDraftValues(updateItem) {
        console.log('update item draft: ', JSON.stringify(updateItem));
        let draftValueChanged = false;
        let copyDraftValues = [...this.draftValues];
        //store changed value to do operations
        //on save. This will enable inline editing &
        //show standard cancel & save button
        copyDraftValues.forEach(item => {
            if (item.Id === updateItem.Id) {
                // eslint-disable-next-line guard-for-in
                for (let field in updateItem) {
                    item[field] = updateItem[field];
                }
                draftValueChanged = true;
            }
        });
        console.log('copy draft values: ', JSON.stringify(copyDraftValues));

        if (draftValueChanged) {
            this.draftValues = [...copyDraftValues];
        } else {
            this.draftValues = [...copyDraftValues, updateItem];
        }
        console.log('draft values after changed: ', JSON.stringify(this.draftValues));
    }

    handleCellChange(event) {
        let draftValues = event.detail.draftValues;
        console.log('draft values obtained: ', JSON.stringify(draftValues));
        //draft values obtained:  [{"Name":"updated Account 123 again","Id":"001dM00000WHMneQAH"}]
        draftValues.forEach(ele => {
            this.updateDraftValues(ele);
        })
    }

    handleSave() {
        this.showSpinner = true;
        this.saveDraftValues = this.draftValues;

        //create shallow copy of the saveDraftValues using slice()
        const recordInputs = this.saveDraftValues.slice().map(draft => {
            const fields = Object.assign({}, draft);
            return { fields };
        });

        const promises = recordInputs.map(recordInput => updateRecord(recordInput))
        Promise.all(promises)
            .then(res => {
                this.showToast('Success', 'Records Updated Successfully', 'success', 'dismissable');
                this.draftValues = [];
                this.refresh();
            })
            .catch(error => {
                console.log('error occured in save: ', error.message);
                this.showToast('Error', 'An Error Occured!!', 'error', 'dismissable');
            })
            .finally(() => {
                this.draftValues = [];
                this.showSpinner = false;
            })
    }

    handleCancel() {
        //remove draftValues & revert data changes
        this.data = JSON.parse(JSON.stringify(this.lastSavedData));
        this.draftValues = [];
    }

    showToast(title, message, variant, mode) {
        const evt = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant,
            mode: mode
        });
        this.dispatchEvent(evt);
    }

    // This function is used to refresh the table once data updated
    async refresh() {
        await refreshApex(this.accountData);
    }
}


