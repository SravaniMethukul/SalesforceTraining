import { LightningElement, api } from 'lwc';

export default class DemoParentComponent extends LightningElement {
    sliderValueInput;
    @api maxSliderValue;
    employees = [
        {
            id: 101,
            name: "sravani",
        },
        {
            id: 102,
            name: "sai",
        },
        {
            id: 103,
            name: "hari",
        },
    ];

    handleInput(event) {
        this.sliderValueInput = event.target.value;
    }

    handleReset() {
        this.template.querySelector("lightning-input").value = "";
        this.template.querySelector("c-demo-child-component").resetSliderValue();
    }
}