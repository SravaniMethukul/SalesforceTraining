import { LightningElement, track } from 'lwc';

export default class ConditionalRenderingDIY9 extends LightningElement {

    inputValue = '';
    upperCaseValue = '';
    salaryAmount = 0;
    updatedEmployees = [];
    checkBoxValue = false;

    @track product = {
        name: "Apple",
        price: 30,
        stock: 100
    };
    stockvalueAvaible;
    isStockAvailable;
    noStockAvailabletext = '';

    @track employees = [
        {
            name: "Sravani",
            salary: 20000,
            position: "Associate",
        },
        {
            name: "Sai Sharath",
            salary: 80000,
            position: "Analyst",
        },
        {
            name: "Hari",
            salary: 90000,
            position: "Specialist",
        }
    ];

    handleChangeOnInput(event) {
        this.inputValue = event.target.value;
        if (this.checkBoxValue === true) {
            this.upperCaseValue = this.inputValue.toUpperCase();
        }
    }
    //add checkbox for uppercase
    handleOnChange(event) {
        try {
            if (event.target.checked === true) {
                this.inputValue = event.target.value;
                this.upperCaseValue = this.inputValue.toUpperCase();
                this.checkBoxValue = true;
            }
            else {
                this.upperCaseValue = this.inputValue;
                this.checkBoxValue = false;
            }
        }
        catch (error) {
            console.error('Error in handleInput:', error);
        }
    }

    handleOnChangeProductDetails(event) {
        const value = event.target.value ? parseInt(event.target.value) : '';
        /*const value;
        if (event.target.value) {
            value = parseInt(event.target.value);
        } else {
            value = '';
        }*/
        if (value === '') {
            this.isStockAvailable = true;
            this.noStockAvailabletext = '';
        }
        else if (value === 0) {
            this.isStockAvailable = false;
            this.noStockAvailabletext = 'No Stock Available';
        }
        else if (value > 0) {
            this.isStockAvailable = true;
            this.product.stock = value;
        }
    }

    handleOnChangeEmployeeDetails(event) {
        const value = parseInt(event.target.salaryAmount);
        updatedEmployees = employees.filter(emp => emp.salary > value);
        return updatedEmployees;
    }
}