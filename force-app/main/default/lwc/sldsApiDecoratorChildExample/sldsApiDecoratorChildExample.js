import { LightningElement, api } from 'lwc';

export default class SldsApiDecoratorChildExample extends LightningElement {
    @api childProperty1 = '';
    _childProperty2 = '';  // Private variable

    @api
    get childProperty2() {
        return this._childProperty2;
    }

    set childProperty2(value) {
        console.log('Setting childProperty2: ', value);
        this._childProperty2 = value;  // Modify the private variable
    }

    @api callChildMethod() {
        console.log('Resetting childProperty2');
        this._childProperty2 = ''; // Reset the private variable
    }

    sendToParent() {
        let val = this.template.querySelector('lightning-input').value;
        let evt = new CustomEvent('send', { detail: val });
        this.dispatchEvent(evt);
    }
}
