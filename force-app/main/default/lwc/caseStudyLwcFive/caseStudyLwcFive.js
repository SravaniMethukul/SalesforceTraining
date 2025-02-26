import { LightningElement, track } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class CaseStudyLwcFive extends LightningElement {
    @track formOptions = {};

    handleChange(event) {
        const { name, value } = event.target;
        console.log('event data: ', event.target);
        this.formOptions[name] = value;
        console.log('form options: ', JSON.stringify(this.formOptions));
    }

    handleClick() {
        createRecord({ apiName: 'Contact', fields: this.formOptions })
            .then((response) => {
                console.log('response: ', response);
                console.log('response Id: ', response.id);
                this.dispatchEvent(new ShowToastEvent({
                    title: 'Contact Created Successfully',
                    message: 'Contact Record: ' + response.id,
                    variant: 'success',
                }));
                this.formOptions = {};
            })
            .catch((error) => {
                // If there are validation errors, display the error message
                if (error.body && error.body.output) {
                    const validationErrors = error.body.output.errors;
                    const errorMessage = validationErrors.map(err => err.message).join(', ');
                    //const duplicationError = validationErrors.filter((err) => err.errorCode && err.errorCode.includes('DUPLICATES_DETECTED'));
                    //console.log('duplicate Code: ', JSON.stringify(duplicationError));
                    console.log("error body: ", error.body);
                    console.log("error body output: ", error.body.output);

                    // Show the validation error messages in a toast
                    this.dispatchEvent(new ShowToastEvent({
                        title: 'Validation Error',
                        message: errorMessage,
                        variant: 'error',
                    }));
                } else {
                    this.dispatchEvent(new ShowToastEvent({
                        title: 'Error',
                        message: 'There was an error creating the contact.',
                        variant: 'error',
                    }));
                }
            })

    }

    handleClear() {
        const inp = this.template.querySelectorAll('lightning-input');
        inp.forEach(element => {
            element.value = '';
        });
        this.formOptions = {};
    }
}