import { LightningElement } from 'lwc';
import defaulttemplate from './demoLifeCycleFourParentComponent.html';
import accounttemplate from './templateAccount.html';
import contacttemplate from './templateContact.html';
export default class DemoLifeCycleFourParentComponent extends LightningElement {
    accountButtonClicked;
    contactButtonClicked;
    backButtonClicked;

    handleAccountClick() {
        console.log('Account button clicked');
        this.accountButtonClicked = true;
        this.contactButtonClicked = false;
    }

    handleContactClick() {
        console.log('Contact button clicked');
        this.contactButtonClicked = true;
        this.accountButtonClicked = false;
    }

    handleBackClick() {
        this.backButtonClicked = true;
        this.contactButtonClicked = false;
        this.accountButtonClicked = false;
    }

    render() {

        return this.accountButtonClicked ? accounttemplate : this.contactButtonClicked ? contacttemplate : this.backButtonClicked ? defaulttemplate : defaulttemplate;
        /* if (this.accountButtonClicked) {
             return accounttemplate;
         } else if (this.contactButtonClicked) {
             return contacttemplate;
         }
         else if (this.backButtonClicked) {
             return defaulttemplate;
         }
         return defaulttemplate;*/
    }

    /*message;
    constructor() {
        super();
        console.log("Constructer From Parent");
    }

    connectedCallback() {
        console.log("connected call back From Parent");
        //cannot access control here like (input, button)
        // we can do fetch api or apex calls
        //this.template.querySelector('lightning-input').value = 'asddda'; //don't do this
        const x = setInterval(() => {
            console.log('Inside interval');
            this.message = 'Hai World';
            clearInterval(x);
        }, 1000);
    }

    renderedCallback() {
        console.log("rendered call back From Parent");
    }

    handlerClick() {
        console.log("Hanlde Click called");
        this.message = "Hai Clicked"
    }

    disconnectedCallback() {
        console.log("disconnected call back From Parent");
    }

    errorCallback(error, stack) {

    }*/
}