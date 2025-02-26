import LightningModal from 'lightning/modal';
import { api, wire, track } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import { getObjectInfo, getPicklistValues } from 'lightning/uiObjectInfoApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import MODE_OF_PAY_FIELD from '@salesforce/schema/Receipt__c.Mode_Of_pay__c';

export default class ModelForCaseStudy extends LightningModal {
    @api content;

    @track formOptions = {};
    @track payModeOptions = [];
    defaultRecordTypeId;

    @wire(getObjectInfo, { objectApiName: 'Receipt__c' })
    getObjectInfo({ data, error }) {
        if (data) {
            this.defaultRecordTypeId = data.defaultRecordTypeId;
        } else if (error) {
            console.error('Error fetching object info:', error);
        }
    }

    @wire(getPicklistValues, { recordTypeId: '$defaultRecordTypeId', fieldApiName: MODE_OF_PAY_FIELD })
    getPicklistValues({ data, error }) {
        if (data) {
            this.payModeOptions = data.values.map(option => ({
                label: option.label,
                value: option.value
            }));
        } else if (error) {
            console.error('Error fetching picklist values:', error);
        }
    }

    handleChange(event) {
        const { name, value } = event.target;
        this.formOptions[name] = value;
    }

    handleSave() {
        const fields = { ...this.formOptions, Contact__c: this.content };
        const recordInput = { apiName: 'Receipt__c', fields };

        createRecord(recordInput)
            .then(response => {
                const resId = response.id;
                console.log('record Id: ', resId);
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Receipt created successfully! ID: ' + response.id,
                        variant: 'success',
                    })
                );
                this.formOptions = {};
                //pass record Id to parent while closing modal
                this.close({ recordId: resId });
            })
            .catch(error => {
                console.error('Error saving record:', error);
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error',
                        message: error.body.message,
                        variant: 'error',
                    })
                );
            });
    }

    handleCancel() {
        this.close();
    }
}
