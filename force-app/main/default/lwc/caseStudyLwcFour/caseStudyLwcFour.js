import { LightningElement, api, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { createRecord } from 'lightning/uiRecordApi';
import { getRecord } from 'lightning/uiRecordApi';
import { NavigationMixin } from 'lightning/navigation';

export default class CaseStudyLwcFour extends NavigationMixin(LightningElement) {
    @api recordId;
    caseDataObtained;
    defaultcaseFields;
    fields = ['Case.Subject', 'Case.Status', 'Case.Priority', 'Case.Origin', 'Case.Description'];

    @wire(getRecord, { recordId: '$recordId', fields: '$fields' })
    caseData({ data, error }) {
        if (data) {
            this.caseDataObtained = data;
            console.log('Case Data Obtained: ', JSON.stringify(this.caseDataObtained));
            /* this.defaultcaseFields = {
                 'Subject': this.caseDataObtained.fields.Subject.value,
                 'Status': this.caseDataObtained.fields.Status.value,
                 'Priority': this.caseDataObtained.fields.Priority.value,
                 'Origin': this.caseDataObtained.fields.Origin.value,
                 'Description': this.caseDataObtained.fields.Description.value,
             }
             console.log('Case fields Obtained: ', JSON.stringify(this.caseFields));*/
        }
        if (error) {
            console.log('error occured: ', error);
        }
    }

    // eslint-disable-next-line no-dupe-class-members
    /* get caseFields() {
         if (this.wiredCase?.data) {
             return {
                 Subject: getFieldValue(this.wiredCase.data, 'Case.Subject'),
                 Status: getFieldValue(this.wiredCase.data, 'Case.Status'),
                 Priority: getFieldValue(this.wiredCase.data, 'Case.Priority'),
                 Origin: getFieldValue(this.wiredCase.data, 'Case.Origin'),
                 Description: getFieldValue(this.wiredCase.data, 'Case.Description'),
             };
         }
         return {};
     }*/

    handleSuccess(event) {
        const newRecordId = event.detail.id;
        console.log(`New Record Id: ${newRecordId}`);
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success',
                message: `Case cloned successfully New Case: ${newRecordId}`,
                variant: 'success',
            }))
        this[NavigationMixin.Navigate]({
            type: 'standard_RecordPage',
            attributes: {
                recordId: newRecordId,
                objectApiName: 'Case',
                actionName: 'view',
            }
        });
    }

    handleError(event) {
        console.log('Error Occured: ', event.detail);
        this.dispatchEvent(new ShowToastEvent({
            title: 'Error Creating case',
            message: 'Case Cannot be cloned' + event.detail,
            variant: 'error',
        }))
    }

    /*@wire(getRecord, { recordId: '$recordId', fields: '$fields' })
    caseData({ data, error }) {
        if (data) {
            this.caseDataObtained = data;
            console.log('Case Data Obtained: ', JSON.stringify(this.caseDataObtained));
        }
        if (error) {
            console.log('error occured: ', error);
        }
    }*/

    cloneCase() {
        if (this.caseDataObtained) {
            const caseFields = {
                'Subject': this.caseDataObtained.fields.Subject.value,
                'Status': this.caseDataObtained.fields.Status.value,
                'Priority': this.caseDataObtained.fields.Priority.value,
                'Origin': this.caseDataObtained.fields.Origin.value,
                'Description': this.caseDataObtained.fields.Description.value,
            }

            createRecord({ apiName: 'Case', fields: caseFields })
                .then((res) => {
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Success',
                            message: `Case cloned successfully New Case: ${res.id}`,
                            variant: 'success',
                        }))
                })
                .catch((error) => {
                    console.log('Error Occured: ', error);
                    this.dispatchEvent(new ShowToastEvent({
                        title: 'Error Creating case',
                        message: 'Case Cannot be cloned' + error.body.message,
                        variant: 'error',
                    }))
                })
        }
    }

}