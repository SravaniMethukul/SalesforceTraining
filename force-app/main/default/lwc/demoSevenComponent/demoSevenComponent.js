import { LightningElement, wire } from 'lwc';

import { getRecord } from 'lightning/uiRecordApi';
import Id from '@salesforce/user/Id'; // used to get logged in userId

export default class DemoSevenComponent extends LightningElement {

    accountData;
    userId = Id;
    userData;
    constructor() {
        super();
        console.log("super method called");
    }

    //wire adaptors are asynchronous calls so they are executed first and on second time data is retreived
    //once data is received it is called again (reactive in nature)
    //even user wire adaptor is also asynchronous call
    //connected callback is called after first time wire adaptor is called (flow of execution -> constructor, first time wire, connectedcallback, once data is updated in wire it is again called)
    // to make property reactive in wire we need to specify it in double quotes with $
    @wire(getRecord, { recordId: '$userId', fields: ['User.Name', 'User.Email'] })
    getUserRecord({ data, error }) {
        if (data) {
            this.userData = data.fields;
        }
        if (error) {
            console.log('Error occured: ', error.message);
        }
    }

    //@wire(getRecord, { recordId: "001dM00002ITwtFQAT", fields: ['Account.Name', 'Account.Industry'] })
    /*getAccountRecord(response) {
        console.log('wire method called');
        if (response.data) {
            console.log('response: ', response);
            console.log('response Data: ', response.data);
            this.accountData = response.data.fields;
        }
    }*/
    /*@wire(getRecord, { recordId: "001dM00002ITwtFQAT", layoutTypes: "full" }) // layoutTypes used to retreive all the data fields 
    getAccountRecord({ data, error }) { // data destructuring happened here response divided into data and error
        if (data) {
            console.log('user Id: ', this.userId);
            console.log('data received: ', data);
            this.accountData = data.fields;
        }
        if (error) {
            console.log('error message: ', error.message);
        }
    }*/

    connectedCallback() {
        console.log("Connected callback called");
    }

}