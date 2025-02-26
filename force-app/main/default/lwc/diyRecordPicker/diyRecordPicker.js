import { LightningElement } from 'lwc';

export default class DiyRecordPicker extends LightningElement {
    contactIdObtained;
    matchingInfo = {
        primaryField: { fieldPath: 'Name' },
        additionalFields: [{ fieldPath: 'Account.Name' }],
    };

    displayInfo = {
        primaryField: 'Name',
        additionalFields: ['Account.Name']
    };

    handleChange(event) {
        this.contactIdObtained = event.detail;
        console.log('contact Id obtained: ', this.contactIdObtained.recordId);
    }

}