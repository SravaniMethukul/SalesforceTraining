import { LightningElement, wire } from 'lwc';
import SAMPLECHANNEL from '@salesforce/messageChannel/SimpleMessageChannel__c';
import { APPLICATION_SCOPE, publish, subscribe, unsubscribe, MessageContext } from 'lightning/messageService';

export default class DemoPublishMessageChannel extends LightningElement {
    message;

    @wire(MessageContext)
    context;

    handleChange(event) {
        this.message = event.target.value;
    }

    handleClick() {
        console.log('publish');
        const msg = {
            lmsData: {
                value: this.message,
            }
        };

        publish(this.context, SAMPLECHANNEL, msg);

    }

}