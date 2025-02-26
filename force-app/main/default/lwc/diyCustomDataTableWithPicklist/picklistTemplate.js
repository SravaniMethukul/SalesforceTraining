import { LightningElement, api } from 'lwc';

export default class picklistTemplate extends LightningElement {
    @api value;
    @api context;
    @api options;

    connectedCallback() {
        console.log('Picklist Received Value:', this.value);
        console.log('Picklist Options:', JSON.stringify(this.options));
    }

    handleChange(event) {
        const selectedValue = event.detail.value;
        console.log('Picklist change event fired with value:', selectedValue);
        this.dispatchEvent(new CustomEvent('picklistchange', {
            detail: { value: selectedValue, context: this.context }
        }));
    }
}