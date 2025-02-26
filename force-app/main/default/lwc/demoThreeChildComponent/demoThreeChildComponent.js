import { LightningElement, api } from 'lwc';

export default class DemoThreeChildComponent extends LightningElement {
    modifiedpersondata;
    modifiedEducationData = [];

    @api
    set personInfo(data) {
        if (data) {
            console.log("setter called");
            console.log("data obtained: ", data);

            //this.modifiedpersondata = { ...data };
            this.modifiedpersondata = {
                ...data,
                name: data.gender === 'male' ? `Mr. ${data.name}` : data.gender === 'female' ? `Ms. ${data.name}` : data.name
            };

            console.log("modified data after modification:", JSON.stringify(this.modifiedpersondata));

            // Dispatch event with updated person data
            this.dispatchEvent(new CustomEvent("persondataupdated", { detail: this.modifiedpersondata }));
            console.log('Dispatched the child data');
        }
        else {
            console.error("Received invalid person data");
        }
    }

    get personInfo() {
        return this.modifiedpersondata;
    }

    @api
    set educationInfo(data) {
        if (data && Array.isArray(data)) {
            //this.modifiedEducationData = [...data];
            console.log("modified data after spread operator education info: ", this.modifiedEducationData);

            this.modifiedEducationData = data.map((person) => ({
                ...person,
                degree: person.education === "Engineering"
                    ? "Bachelors"
                    : person.education === "Intermediate"
                        ? "PUC"
                        : "Educated"
            }));

            console.log("Updated education info: ", JSON.stringify(this.modifiedEducationData));
            console.log('Updated education info 1: ', this.modifiedEducationData[0]);
            // Dispatch event with updated education data
            this.dispatchEvent(new CustomEvent("educationdataupdated", { detail: this.modifiedEducationData }));
        }
        else {
            console.error("Received invalid education data");
        }
    }

    get educationInfo() {
        return this.modifiedEducationData;
    }
}