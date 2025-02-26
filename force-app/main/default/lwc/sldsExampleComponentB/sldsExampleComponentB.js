import { LightningElement, wire } from 'lwc';
import { subscribe, MessageContext } from 'lightning/messageService';
import COMPONENT_COMMUNICATION_CHANNEL from '@salesforce/messageChannel/ComponentCommunicationChannel__c';

export default class SldsExampleComponentB extends LightningElement {
    @wire(MessageContext)
    messageContext;

    subscription = null;
    receivedMessage = 'No message Received yet';
    connectedCallback() {
        console.log('Subscription: ', this.subscription);
        try {
            console.log('Entered component B');
            if (this.subscription) {
                this.subscription = subscribe(this.messageContext,
                    COMPONENT_COMMUNICATION_CHANNEL, (payload) => this.handleMessage(payload));
            }
        }
        catch (error) {
            console.log(error.message);
        }
    }

    handleMessage(payload) {
        console.log('Received Payload:', payload);
        this.receivedMessage = payload ? payload.message : '';
    }

}