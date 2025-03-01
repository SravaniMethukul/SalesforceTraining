import { LightningElement, wire } from 'lwc';
import CHANNEL from '@salesforce/messageChannel/messageChannelForDataTable__c';
import { publish, subscribe, APPLICATION_SCOPE, MessageContext } from 'lightning/messageService';
import getAccountList from '@salesforce/apex/AccountControllerClass.getAccountList';

export default class DiyComponentToPublishTwentyEight extends LightningElement {
    @wire(MessageContext)
    messageContext;

    dataReceived = [];
    rating;

    ratingOptions = [
        { label: 'Hot', value: 'Hot' },
        { label: 'Warm', value: 'Warm' },
        { label: 'Cold', value: 'Cold' },
    ];

    handleChange(event) {
        this.rating = event.detail.value;
        console.log('rating: ', this.rating);
    }

    @wire(getAccountList, { rating: '$rating' })
    accountDataObtained({ data, error }) {
        if (data) {
            console.log('entered wire method: ');
            this.dataReceived = data;
            console.log('data received: ', JSON.stringify(this.dataReceived));
        }
        if (error) {
            console.log('error: ', error.message);
        }
    }

    handleClick() {
        if (!this.dataReceived || this.dataReceived.length === 0) {
            console.warn('No data available to publish!');
            return;
        }
        let msg = {
            accountData: this.dataReceived,
        }
        console.log('msg obtained: ', JSON.stringify(msg));
        publish(this.messageContext, CHANNEL, msg);
    }

}