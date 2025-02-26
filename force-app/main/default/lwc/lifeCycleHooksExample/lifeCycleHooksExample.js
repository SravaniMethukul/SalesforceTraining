import { LightningElement } from 'lwc';

export default class LifeCycleHooksExample extends LightningElement {
    isVisible = true;
    constructor() {
        super();
        console.log('Call received from constructor');
    }

    connectedCallback() {
        console.log("call received from connected call back")
    }

    renderedCallback() {
        console.log("call received from renedered call back")
    }

    errorCallback() {
        console.log("call received from error call back")
    }

    handleClick() {
        if (this.isVisible === true) {
            this.isVisible = false;
        }
        else {
            this.isVisible = true;
        }
    }
}