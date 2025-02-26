import { LightningElement, wire } from 'lwc';
import { getObjectInfo, getPicklistValues } from 'lightning/uiObjectInfoApi';
import ACCOUNT_INDUSTRY from '@salesforce/schema/Account.Industry';

export default class DiyWireAdaptorsTwentyOne extends LightningElement {

    recordTypesObtained;
    recordTypeIdToPass;
    recordTypeoptions;
    industryOptions;

    handleChange(event) {
        this.recordTypeIdToPass = event.target.value;
    }

    @wire(getObjectInfo, { objectApiName: 'Account' })
    objectData({ data, error }) {
        if (data) {
            console.log('object data obtained: ', data.recordTypeInfos);

            this.recordTypesObtained = Object.values(data.recordTypeInfos);
            console.log('record Ids: ', JSON.stringify(this.recordTypesObtained));
            /*[{"available":true,"defaultRecordTypeMapping":false,"master":true,"name":"Master","recordTypeId":"012000000000000AAA"},
            {"available":true,"defaultRecordTypeMapping":false,"master":false,"name":"Organization","recordTypeId":"012dM000001l6NzQAI"},
            {"available":true,"defaultRecordTypeMapping":true,"master":false,"name":"Individual","recordTypeId":"012dM000001l7jpQAA"}]*/

            this.recordTypeoptions = this.recordTypesObtained.map(({ name, recordTypeId }) => ({
                label: name,
                value: recordTypeId,
            }));
            console.log('record Ids options obtained: ', JSON.stringify(this.recordTypeoptions));
            /*[{"label":"Master","value":"012000000000000AAA"},{"label":"Organization","value":"012dM000001l6NzQAI"},{"label":"Individual","value":"012dM000001l7jpQAA"}]*/

            this.recordTypesObtained = Object.keys(data.recordTypeInfos);
            console.log('record Ids keys: ', JSON.stringify(this.recordTypesObtained));
            //["012000000000000AAA","012dM000001l6NzQAI","012dM000001l7jpQAA"]
        }
        if (error) {
            console.log('error occured: ', error.message);
        }
    }

    @wire(getPicklistValues, { recordTypeId: '$recordTypeIdToPass', fieldApiName: ACCOUNT_INDUSTRY })
    getPicklistData({ data, error }) {
        console.log('entered picklist values');
        if (data) {
            console.log('picklist data obtained: ', JSON.stringify(data.values));
            this.industryOptions = data.values.map(({ label, value }) => ({
                label: label,
                value: value,
            }));
            console.log('picklist data obtained: ', JSON.stringify(this.industryOptions));
        }
        if (error) {
            console.log('error occurred: ', error.message);
        }
    }
}