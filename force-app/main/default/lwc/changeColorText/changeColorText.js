import { LightningElement } from 'lwc';

export default class ChangeColorText extends LightningElement {
    welcomeText = 'Welcome to Salesforce';
    customStyle;
    handleButton(event) {
        if (event.target.label === 'Red')
            this.customStyle = 'RedColor';
        else if (event.target.label === 'Blue')
            this.customStyle = 'BlueColor';
    }
}