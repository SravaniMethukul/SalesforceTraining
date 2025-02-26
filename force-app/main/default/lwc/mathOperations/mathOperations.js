import { LightningElement } from 'lwc';

export default class MathOperations extends LightningElement {
    input1 = null;
    input2 = null;
    result = null;
    errorMessage = null;
    getInputValues1(event) {
        this.input1 = event.target.value;
        this.errorMessage = null;
    }

    getInputValues2(event) {
        this.input2 = event.target.value;
        this.errorMessage = null;
    }

    onhandleOperation(event) {
        if (this.input1 != null && this.input2 != null) {
            if (event.target.label === 'Add') {
                this.result = parseInt(this.input1, 10) + parseInt(this.input2, 10);
            }
            else if (event.target.label === 'Subract') {
                this.result = parseInt(this.input1, 10) - parseInt(this.input2, 10);
            }
            else if (event.target.label === 'Multiply') {
                this.result = parseInt(this.input1, 10) * parseInt(this.input2, 10);
            }
            else if (event.target.label === 'Divide') {
                if (this.input2 !== 0) {
                    this.result = parseFloat(this.input1) / parseFloat(this.input2);
                }
                else {
                    this.errorMessage = 'Please enter valid number for input2'
                }
            }
            else if (event.target.label === 'Clear') {
                this.input1 = null;
                this.input2 = null;
                this.result = null;
                this.errorMessage = null;
            }
        }
        else if (this.input1 === null && this.input2 === null) {
            if (event.target.label === 'Clear') {
                this.input1 = null;
                this.input2 = null;
                this.errorMessage = null;
                this.result = null;
            }
            else {
                this.errorMessage = 'Please enter Input1 and input2';
                this.result = null;
            }
        }
        else if (this.input1 === null) {
            if (event.target.label === 'Clear') {
                this.input1 = null;
                this.input2 = null;
                this.errorMessage = null;
                this.result = null;
            }
            else {
                this.errorMessage = 'Please enter Input 1';
                this.result = null;
            }
        }
        else if (this.input2 === null) {
            if (event.target.label === 'Clear') {
                this.input1 = null;
                this.input2 = null;
                this.errorMessage = null;
                this.result = null;
            }
            else {
                this.errorMessage = 'Please enter Input 2';
            }
        }
    }
}