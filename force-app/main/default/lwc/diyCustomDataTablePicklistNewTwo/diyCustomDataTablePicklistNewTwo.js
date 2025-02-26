import lightningDataTable from 'lightning/datatable';
import picklistTemplate from './picklistTemplate.html';
import staticPicklistTemplate from './staticPicklistTemplate';
import { api, track } from 'lwc';

export default class DiyCustomDataTablePicklistNewTwo extends lightningDataTable {
    @api typeAttributes;
    @track value;
    @track options;

    renderedCallback() {
        if (this.typeAttributes) {
            console.log('Received typeAttributes:', JSON.stringify(this.typeAttributes));
            console.log('Options:', JSON.stringify(this.typeAttributes?.options));

            /*this.value = (this.typeAttributes !== null && this.typeAttributes !== undefined) 
             ? this.typeAttributes.value 
             : undefined;*/
            // chaining operator (?.)
            this.value = this.typeAttributes?.value;
            /*this.options = this.typeAttributes 
            ? (this.typeAttributes.options !== undefined && this.typeAttributes.options !== null 
                ? this.typeAttributes.options 
                : []) 
             : [];*/
            this.options = this.typeAttributes?.options || [];
        }
    }

    get picklistOptions() {
        return this.typeAttributes?.options || [];
    }

    get picklistValue() {
        return this.typeAttributes?.value;
    }

    static customTypes = {
        picklistTemp: {
            template: staticPicklistTemplate,
            editTemplate: picklistTemplate,
            typeAttributes: ['value', 'options', 'context', 'placeholder'],
            standardCellLayout: true
        }
    };


}