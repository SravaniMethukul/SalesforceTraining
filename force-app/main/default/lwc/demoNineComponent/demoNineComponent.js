import { LightningElement } from 'lwc';
import { createRecord, updateRecord, deleteRecord } from 'lightning/uiRecordApi';

export default class DemoNineComponent extends LightningElement {
    formData = {};

    /* data should be in form of key value pairs for fields to add
    { 
        Name: 'Sravani,
        AnnaulRevenue: 20000,
    } */
    changeHandler(event) {
        const { name, value } = event.target;
        this.formData[name] = value;
    }

    /*handleClick() {
        createRecord({ apiName: 'Account', fields: this.formData })
            .then(response => {
                console.log('response obtained:', response);
                this.formData = {};
            })
    }*/

    handleClick() {
        updateRecord({ fields: this.formData })
            .then(response => {
                console.log('response obtained:', response);
                this.formData = {};
            })
    }

    /*handleClick(){
        const recordId='';
        deleteRecord(recordId)
        .then(response){
            console.log('response: ',resposne);
        }
    }*/

}