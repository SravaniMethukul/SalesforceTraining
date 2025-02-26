import { LightningElement, wire } from 'lwc';
import SAMPLECHANNEL from '@salesforce/messageChannel/SimpleMessageChannel__c';
import { APPLICATION_SCOPE, publish, subscribe, unsubscribe, MessageContext } from 'lightning/messageService';

export default class DemoSubscribeMessageChannel extends LightningElement {
    messageReceived;

    @wire(MessageContext)
    context;

    connectedCallback() {
        this.subscribeMessage();
    }

    subscribeMessage() {
        //context, channel reference, listener, subscriberoptions: object(scope-APPLICATION_SCOPE -i am going to subscribe to this channel from application level)
        subscribe(this.context, SAMPLECHANNEL, (message) => { this.handleIncomingMessage(message) }, { scope: APPLICATION_SCOPE });

    }

    handleIncomingMessage(message) {
        this.messageReceived = message.lmsData.value ? message.lmsData.value : 'No message';
    }
}