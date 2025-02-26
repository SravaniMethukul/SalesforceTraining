import { LightningElement, track } from 'lwc';

export default class Hello extends LightningElement {
    @track person = ['Sravani', 20000, 'AJ Skill'];

    @track employee = {
        name: "AJ Skill",
        position: "Developer"
    };

    employees_data = [
        {
            employeename: 'Sravani',
            profession: 'Tester',
        },
        {
            employeename: 'Sai Sharath',
            profession: 'Developer',
        },
        {
            employeename: 'Hari',
            profession: 'Cloud Engineer',
        }
    ];

    isShown = false;
    fruits = ["Apple", "Orange", "Banana"];

    handleClick(event) {
        //this.person[0] = 'Sai Sharath';
        //this.employee.position = 'Tester';
        this.isShown = !this.isShown;
    }

    get personName() {
        return this.person[0];
    }

}