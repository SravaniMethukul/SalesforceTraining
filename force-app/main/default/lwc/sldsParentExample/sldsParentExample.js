import { LightningElement } from 'lwc';

export default class SldsParentExample extends LightningElement {
    currentStep = 1;
    feedbackData = '';

    handleNext(event) {
        const stepData = event.detail;
        this.feedbackData = { ...this.feedbackData, ...stepData };
        this.currentStep += 1;
    }

    handlePrevious() {
        this.currentStep -= 1;
    }

    handleSubmit(event) {
        const stepData = event.detail;
        this.feedbackData = { ...this.feedbackData, ...stepData };
        console.log('Final Feedback Data:', JSON.stringify(this.feedbackData));
    }

    get isStep1() {
        return this.currentStep === 1;
    }

    get isStep2() {
        return this.currentStep === 2;
    }

}