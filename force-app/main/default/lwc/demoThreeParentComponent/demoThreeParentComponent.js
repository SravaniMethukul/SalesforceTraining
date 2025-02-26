import { LightningElement } from 'lwc';

export default class DemoThreeParentComponent extends LightningElement {

    personDataObtained = {};
    educationDataObtained = [];
    person = {
        code: 101,
        name: "Sravani",
        age: 26,
        gender: "female",
    };

    educationDetails = [{
        code: 101,
        name: "Sravani",
        age: 26,
        gender: "female",
        education: "Intermediate",
    },
    {
        code: 102,
        name: "Sai",
        age: 29,
        gender: "male",
        education: "Engineering",
    }
    ];

    handlePersonDataUpdated(event) {
        try {
            console.log('handling person data')
            this.personDataObtained = event.detail;
            console.log('Person Data Updated:', JSON.stringify(this.personDataObtained));
        }
        catch (error) {
            console.error('error occured in parent handle method: ', error);
        }
    }

    handleEducationDataUpdated(event) {
        try {
            console.log('handling education data')
            this.educationDataObtained = event.detail;
            console.log('Person Education Data Updated:', JSON.stringify(this.educationDataObtained));
        }
        catch (error) {
            console.error('error occured in education: ', error);
        }
    }


}