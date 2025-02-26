import { LightningElement, wire } from 'lwc';
import { publish, MessageContext } from 'lightning/messageService';
import COMPONENT_COMMUNICATION_CHANNEL from '@salesforce/messageChannel/ComponentCommunicationChannel__c';

export default class SldsExampleComponentA extends LightningElement {
    inputMessage = '';
    @wire(MessageContext)
    messageContext;

    handleClick() {
        console.log('entered click method');
        const msgInput = this.template.querySelector('lightning-input').value;
        console.log('msgInput:', msgInput);
        const payload = { message: msgInput };
        console.log('payload:', payload.message);
        publish(this.messageContext, COMPONENT_COMMUNICATION_CHANNEL, payload);

    }
}