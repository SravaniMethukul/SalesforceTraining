import { LightningElement } from 'lwc';

export default class DemoTwoParentComponent extends LightningElement {

    handleClick() {
        this.template.querySelector('c-demo-two-child-component').handleStartProgress();
        this.template.querySelector('lightning-button').disabled = true;
    }

    handleFinish() {
        this.template.querySelector('c-demo-two-child-component').setprogressValBar(0);
        this.template.querySelector('lightning-button').disabled = false;
    }

    handleDisplay(event) {
        console.log('Parent Handler for child event');
        console.log(event.detail.code);
        console.log(event.detail.name);
    }
}