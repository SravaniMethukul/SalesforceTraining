import { LightningElement } from 'lwc';

export default class Diy9 extends LightningElement {
    inputText = null;
    checkboxInput = false;
    upperCaseText = null;

    HandleInput(event) {
        try {
            this.inputText = event.target.value;
            if (this.checkboxInput === true) {
                this.upperCaseText = this.inputText.toUpperCase();
            }
        }
        catch (error) {
            console.error('Error in handleInput:', error);
        }
    }

    HandleCheckbox(event) {
        try {
            if (event.target.checked === true) {
                this.checkboxInput = true;
                this.upperCaseText = this.inputText.toUpperCase();
            }
            else {
                this.checkboxInput = false;
                this.upperCaseText = this.inputText;
            }
            //include checkbox outside
        }
        catch (error) {
            console.error('Error in handleCheckbox:', error);
        }
    }
}