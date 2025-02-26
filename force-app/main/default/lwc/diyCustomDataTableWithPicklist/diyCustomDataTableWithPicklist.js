import lightningDataTable from 'lightning/datatable';
import picklistTemplate from './picklistTemplate.html';
import { api, track } from 'lwc';

export default class DiyCustomDataTableWithPicklist extends lightningDataTable {
    @api typeAttributes;
    @track value;
    @track options;

    renderedCallback() {
        if (this.typeAttributes && !this.initialized) {
            this.initialized = true;
            console.log('Received typeAttributes:', JSON.stringify(this.typeAttributes));
            console.log('Options:', JSON.stringify(this.typeAttributes?.options));

            this.value = this.typeAttributes?.value;
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
            template: picklistTemplate,
            typeAttributes: ['value', 'options', 'context', 'placeholder'],
            standardCellLayout: true
        }
    };

    handlePicklistChange(event) {
        console.log('Forwarding picklistchange:', event.detail);
        this.dispatchEvent(new CustomEvent('picklistchange', {
            detail: event.detail, bubbles: true, composed: true
        }));
    }

}