import { LightningElement } from 'lwc';

export default class QuerySelectorExample extends LightningElement {

    employees = [
        {
            id: 101,
            name: "John",
            salary: 50000,
        },
        {
            id: 102,
            name: "Tohn",
            salary: 40000,
        },
        {
            id: 103,
            name: "Johnson",
            salary: 70000,
        }
    ];

    handleSelect(event) {
        const empno = event.target.dataset.empno;
        const empname = event.target.dataset.empname;
        // eslint-disable-next-line no-alert
        alert(`code=${empno} and name=${empname}`);
    }

    handleClear(event) {
        const empno = event.target.dataset.empno;
        this.template.querySelector(`lightning-input[data-empno='${empno}']`).value = "";
    }

    handleClearFirst() {
        this.template.querySelector("lightning-input[data-empno='101']").value = "";
        //this.template.querySelector(".salary").value = ""; // clear only first input box
        //this.template.querySelectorAll(".salary").value = ""; // clear all input boxes
    }

    handleClearAll() {
        //return type is array staticnodelist
        // eslint-disable-next-line no-return-assign
        Array.from(this.template.querySelectorAll("lightning-input")).forEach(e => e.value = "");
    }



    /*handleClick(event) {
        const p = this.template.querySelectorAll("p");
        console.log(p); // static node type
        Array.from(p).forEach((element) => {
            // eslint-disable-next-line @lwc/lwc/no-inner-html
            console.log(element.innerHTML);
        })

        const elementdiv = this.template.querySelector(".dynamic");
        // eslint-disable-next-line @lwc/lwc/no-inner-html
        elementdiv.innerHTML = "<p style='Background: blue'>Dynamic Division</p>";

        const inp = this.template.querySelector("lightning-input[data-id1]").value;
        console.log(inp);

        this.template.querySelector("lightning-input[data-id1]").value = 'Sample Data';
        console.log(event.target.dataset.btn);

    }

    inputChangeA(event) {
        const inp = this.template.querySelector("lightning-input[data-id1]").value;
        console.log(inp);
        console.log(event.target.dataset.id1);
        console.log(event.target.dataset.id5);
    }*/
}