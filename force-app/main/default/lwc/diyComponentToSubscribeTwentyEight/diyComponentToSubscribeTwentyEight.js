import { LightningElement, wire } from 'lwc';
import CHANNEL from '@salesforce/messageChannel/messageChannelForDataTable__c';
import { publish, subscribe, APPLICATION_SCOPE, MessageContext } from 'lightning/messageService';

export default class DiyComponentToSubscribeTwentyEight extends LightningElement {

    dataAccounts = [];
    columnsList = [];
    @wire(MessageContext)
    msgContext;

    connectedCallback() {
        // eslint-disable-next-line @lwc/lwc/no-async-operation
        setTimeout(() => {
            this.subscribeMessage();
        }, 1000);
    }

    subscribeMessage() {
        if (this.subscription) {
            console.warn('Already subscribed!');
            return;
        }

        this.subscription = subscribe(
            this.msgContext,
            CHANNEL,
            (message) => this.messageReceived(message),
            { scope: APPLICATION_SCOPE }
        );

        console.log('Successfully subscribed to the message channel');
    }

    messageReceived(message) {
        if (message && message.accountData) {
            this.dataAccounts = [...message.accountData];
            console.log('data in subscribe: ', JSON.stringify(this.dataAccounts));
            this.columnsList = Object.keys(this.dataAccounts[0]).map((key) => {
                return {
                    label: key,
                    fieldName: key,
                }
            });

        } else {
            this.dataAccounts = [{ Name: 'No Data Obtained' }];
        }
    }

}