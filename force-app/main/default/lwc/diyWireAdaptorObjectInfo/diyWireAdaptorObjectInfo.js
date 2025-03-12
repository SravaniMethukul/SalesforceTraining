import { LightningElement, wire, api } from 'lwc';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';

export default class DiyWireAdaptorSixteen extends LightningElement {

    @api objectApiName;
    objectData;
    fieldCount;
    recordTypesCount;
    picklistCount;
    customFieldsCount;
    fieldApiNames;

    @wire(getObjectInfo, { objectApiName: '$objectApiName' })
    objectInfo({ data, error }) {
        if (data) {
            console.log('data obtained inside wire: ', data);
            this.objectData = data;
            this.fieldCount = Object.keys(this.objectData.fields).length;

            this.recordTypesCount = Object.keys(this.objectData.recordTypeInfos).length;
            console.log('Record Types : ', this.objectData.recordTypeInfos.length);

            const allFields = Object.keys(this.objectData.fields).filter((fieldkey) => this.objectData.fields[fieldkey].dataType === 'Picklist');
            //const picklistFields = allFields.filter((field) => field.dataType === 'Picklist')
            console.log('picklist fields: ', allFields);
            this.picklistCount = allFields.length;

            const customFields = Object.keys(this.objectData.fields).filter((fieldkey) => this.objectData.fields[fieldkey].custom === true);
            this.customFieldsCount = customFields.length;

            console.log('Custom fields received: ', JSON.stringify(this.customFields));

            const apiNames = Object.keys(this.objectData.fields).map((fieldkey) => this.objectData.fields[fieldkey].apiName);
            console.log("Field Api Names: ", apiNames);
            this.fieldApiNames = apiNames;


            console.log('fields obtained: ', JSON.stringify(Object.values(this.objectData.fields)));
            console.log('picklist fields obtained: ', JSON.stringify(Object.values(this.objectData.fields).filter((field) => field.dataType === 'Picklist')));

        }
        if (error) {
            console.log('error occured inside wire: ', error.message);
        }
    }

}