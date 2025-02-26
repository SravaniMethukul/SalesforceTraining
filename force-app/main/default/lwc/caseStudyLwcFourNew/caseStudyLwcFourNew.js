/* eslint-disable no-undef */
import { LightningElement, api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import CASE_SUBJECT from '@salesforce/schema/Case.Subject';
import CASE_STATUS from '@salesforce/schema/Case.Status';
import CASE_PRIORITY from '@salesforce/schema/Case.Priority';
import CASE_ORIGIN from '@salesforce/schema/Case.Origin';
import CASE_DESCRIPTION from '@salesforce/schema/Case.Description';
import { createRecord, getFieldValue } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';

const fields = [CASE_SUBJECT, CASE_STATUS, CASE_PRIORITY, CASE_ORIGIN, CASE_DESCRIPTION];

export default class CaseStudyLwcFourNew extends NavigationMixin(LightningElement) {
    @api recordId;
    caseFieldValues;
    formOptions = {};
    newRecordId;
    isLoading = true;

    @wire(getRecord, { recordId: '$recordId', fields })
    caseRecordObtained({ data, error }) {
        if (data) {
            //this.caseRecordObtained = data;
            this.caseFieldValues = {
                // eslint-disable-next-line no-undef
                Subject: getFieldValue(data, CASE_SUBJECT),
                Status: getFieldValue(data, CASE_STATUS),
                Priority: getFieldValue(data, CASE_PRIORITY),
                Origin: getFieldValue(data, CASE_ORIGIN),
                Description: getFieldValue(data, CASE_DESCRIPTION),
            }
            this.formOptions = { ...this.caseFieldValues };
            this.isLoading = false;
        }
        if (error) {
            console.log('eror occured: ', error);
        }
    }

    handleChange(event) {
        const { name, value } = event.target;
        this.formOptions = { ...this.formOptions, [name]: value };
    }

    handleSuccess() {
        console.log('entered success');
        try {
            this[NavigationMixin.Navigate]({
                type: 'standard__recordPage',
                attributes: {
                    recordId: this.newRecordId,
                    objectApiName: 'Case',
                    actionName: 'view',
                },
            });
        }
        catch (Error) {
            console.log('error in save: ', Error);
        }
    }

    handleSave(event) {
        event.preventDefault();
        console.log('entered Save handler');
        console.log('field options: ', JSON.stringify(this.formOptions));

        if (Object.keys(this.formOptions).length > 0) {
            createRecord({ apiName: "Case", fields: this.formOptions })
                .then((res) => {
                    console.log('Res obtained: ', JSON.stringify(res));
                    console.log('record Id: ', res.id);
                    this.newRecordId = res.id;
                    this.dispatchEvent(new ShowToastEvent({
                        title: 'Case Created Successfully',
                        message: 'Case created with record Id: ' + res.id,
                        variant: 'success',
                    }));
                    this.handleSuccess();
                })
                .catch((err) => {
                    console.log('error occured: ', JSON.stringify(err));
                    this.dispatchEvent(new ShowToastEvent({
                        title: 'Case Created UnSuccessfully',
                        message: 'Failed with Error ' + (err.body ? err.body.message : err.message),
                        variant: 'error',
                    }))
                })
        }
    }

    errorHandler(event) {
        console.error("Error during submission:", event.detail);
        this.dispatchEvent(new ShowToastEvent({
            title: "Error",
            message: event.detail.message,
            variant: "error",
        }));
    }

}



