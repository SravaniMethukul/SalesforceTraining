import { LightningElement, track } from 'lwc';

export default class Diythird9 extends LightningElement {

    salaryEntered = null;
    updatedEmployees = [];
    employeesAvailable = false;
    employeesNotAvailable = false;
    res = [];
    employees = [
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

    handleOnInput(event) {
        try {
            const value = parseInt(event.target.value, 10);
            console.log("value:", value);
            if (isNaN(value)) {
                this.employeesNotAvailable = false;
                this.employeesAvailable = false;
                return;
            }
            /*if (isNaN(value)) {
                //this.updatedEmployees = [];
                this.employeesAvailable = false;
                return;
            }*/
            //instead of filter use map and for each
            this.employees.forEach(emp => {
                this.res = this.employees.map(e => {
                    if (e.salary > value) {
                        return e;
                    }
                    return null;
                });
            });
            this.updatedEmployees = this.res.filter(emp => emp !== null);
            //this.updatedEmployees = this.employees.filter(emp => emp.salary > value);
            console.log(this.updatedEmployees);
            this.employeesAvailable = this.updatedEmployees.length > 0;
            this.employeesNotAvailable = this.updatedEmployees.length === 0;
        }
        catch (error) {
            console.error('Handle input:', error.message);
        }
    }
}