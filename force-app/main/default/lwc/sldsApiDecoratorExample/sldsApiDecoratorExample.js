import { LightningElement } from 'lwc';

export default class SldsApiDecoratorExample extends LightningElement {
    handleSetValueClick() {
        const inputValue = this.template.querySelector('lightning-input').value;

        // Directly modify childProperty2 using the setter method in child
        this.template
            .querySelector('c-slds-api-decorator-child-example')
            .childProperty2 = inputValue;  // This will call the setter in child
    }

    callChildMethod() {
        // Call the child method to reset the property
        this.template
            .querySelector('c-slds-api-decorator-child-example')
            .callChildMethod();
    }

    childMessage = 'No message Added';

    storeMessage(event) {
        console.log(event.detail)
        this.childMessage = event.detail;
    }
}
