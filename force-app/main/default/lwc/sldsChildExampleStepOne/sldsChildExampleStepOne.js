import { LightningElement } from 'lwc';

export default class SldsChildExampleStepOne extends LightningElement {

    userName = '';
    userEmail = '';

    handleName(event) {
        this.userName = event.target.value;
    }

    handleEmail(event) {
        this.userEmail = event.target.value;
    }

    handleNextClick() {
        const stepData = {
            name: this.userName,
            email: this.userEmail,
        };
        let evt = new CustomEvent('next', { detail: stepData });
        this.dispatchEvent(evt);
    }

}