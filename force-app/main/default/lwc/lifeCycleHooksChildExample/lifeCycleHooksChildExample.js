import { LightningElement } from 'lwc';

export default class LifeCycleHooksChildExample extends LightningElement {

    constructor() {
        super();
        console.log('Call received from constructor from child');
    }

    connectedCallback() {
        console.log("call received from connected call back from child")
    }

    renderedCallback() {
        console.log("call received from renedered call back from child")
    }

    disconnectedCallback() {
        console.log("call received from dieconnected call back from child")
    }
}