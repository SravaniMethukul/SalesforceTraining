import { LightningElement, track } from 'lwc';

export default class FetchApiExampleEmployee extends LightningElement {

    @track employeesData = [];
    @track currentIndex = 0;
    @track currentEmployee = '';


    connectedCallback() {
        this.fetchEmployees();
    }

    async fetchEmployees() {
        try {
            console.log('Entered fetch employees');
            let url = 'https://dummyjson.com/users';
            let response = await fetch(url, { method: 'GET' });
            console.log('response', response);
            let data = await response.json();
            this.employeesData = data.users;
            console.log('employees Data: ', this.employeesData);
            this.updateEmployee();
        }
        catch (error) {
            console.log('error message is ', error);
        }
    }

    updateEmployee() {
        if (this.employeesData.length > 0 && this.currentIndex >= 0 && this.currentIndex < this.employeesData.length) {
            this.currentEmployee = this.employeesData[this.currentIndex];
        }
    }

    handlePrevious() {
        this.currentIndex--;
        this.updateEmployee();
    }

    handleNext() {
        this.currentIndex++;
        this.updateEmployee();
    }

    get isFirstpost() {
        return this.currentIndex === 0;
    }

    get isLastpost() {
        return this.currentIndex === this.employeesData.length - 1;
    }
}