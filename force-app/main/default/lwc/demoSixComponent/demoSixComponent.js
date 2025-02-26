import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import ACCOUNT_NAME from '@salesforce/schema/Account.Name';
import ACCOUNT_INDUSTRY from '@salesforce/schema/Account.Industry';
import ANNUAL_REVENUE from '@salesforce/schema/Account.AnnualRevenue';
import ACCOUNT_PHONE from '@salesforce/schema/Account.Phone';

export default class DemoSixComponent extends LightningElement {
    objectName = ACCOUNT_OBJECT;
    fieldslist = {
        nameField: ACCOUNT_NAME,
        industryField: ACCOUNT_INDUSTRY,
        annualrevenueField: ANNUAL_REVENUE,
        phoneField: ACCOUNT_PHONE,
    };

    successHandler(event) {
        console.log("Inside Success Handler");
        const toast = new ShowToastEvent({
            title: "Record updated successfully",
            message: "record Id for updated record: " + event.detail.id,
            variant: "success",
            mode: "sticky" //three available: sticky (Keeps the toast visible until the user dismisses it.), dismissible (Allows the user to manually close the toast.), 
            // pester (toast disappears after few seconds)
        });
        this.dispatchEvent(toast);
    }

    submitHandler(event) {
        console.log("Inside Submit Handler");
        //custom validation
        //1. get annual revenue input
        //2. check value
        //3. submit data to server
        event.preventDefault(); // prevent submission
        const inputrevenue = this.template.querySelector(".revenue").value;
        console.log(inputrevenue);
        if (inputrevenue < 10000) {
            const toast = new ShowToastEvent({
                title: "Annual Revenue cannot be less than 100",
                message: event.detail.message,
                variant: "error",
            });
            this.dispatchEvent(toast);
        }
        else {
            const fields = event.detail.fields;
            console.log(fields);
            this.template.querySelector("lightning-record-edit-form").submit(fields);
        }
    }

    errorHandler(event) {
        console.log("Inside Error Handler");
        console.log(JSON.stringify(event));
        const toast = new ShowToastEvent({
            title: "Error Updating Data",
            message: event.detail.message,
            variant: "error",
        });
        this.dispatchEvent(toast);

    }
}