/* eslint-disable @lwc/lwc/no-async-operation */
import { LightningElement, track } from 'lwc';
export default class FetchApiExampleEmployeeSearch extends LightningElement {
    loading = false;
    delayTimeout;
    valueToSearch = "";
    lengthOfArray = true;
    @track allemployees = [];
    @track searchEmpResult = [];

    connectedCallback() {
        this.searchEmployee();
    }

    handleSearch() {
        // eslint-disable-next-line no-undef
        //use lwc-ref
        //this.valueToSearch = this.template.querySelector(".searchClassInput").value;
        this.valueToSearch = this.refs.searchInput.value;
        console.log('value entered:', this.valueToSearch);
        if (this.valueToSearch) {
            this.searchEmpResult = this.allemployees.filter((emp) =>
                `${emp.firstName} ${emp.lastName}`.toLowerCase().includes(this.valueToSearch));
            console.log('search employee result: ', this.searchEmpResult);
        }

        this.lengthOfArray = this.searchEmpResult.length > 0;
    }

    async searchEmployee() {
        try {
            let url = `https://dummyjson.com/users/search?q=${this.valueToSearch}`;
            let res = await fetch(url, { method: "GET" });
            let data = await res.json();
            console.log("data output", data);
            this.loading = false;
            console.log("data response", data.users);
            if (data.users) {
                this.allemployees = data.users;
                console.log("data employees data", this.allemployees);
            }
        }
        catch (error) {
            console.log("error", error);
        }
    }
}