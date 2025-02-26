import { LightningElement, api } from 'lwc';

export default class DemoChildComponent extends LightningElement {

    @api employee;
    @api sliderval;
    @api maxSliderValue;

    @api resetSliderValue() {
        // eslint-disable-next-line @lwc/lwc/no-api-reassignments
        this.sliderval = 0;
    }
}