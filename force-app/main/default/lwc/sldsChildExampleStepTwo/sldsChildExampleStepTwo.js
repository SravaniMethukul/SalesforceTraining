import { LightningElement } from 'lwc';

export default class SldsChildExampleStepTwo extends LightningElement {
    feedBackRating = '';
    feedBackComments = '';

    handleFeedBackRating(event) {
        this.feedBackRating = event.target.value;
    }

    handleFeedBackComments(event) {
        this.feedBackComments = event.target.value;
    }

    handlePreviousClick() {
        // Emit the previous event to the parent
        const prevEvent = new CustomEvent('previous');
        this.dispatchEvent(prevEvent);
    }

    handleSubmitClick() {
        const stepData = {
            rating: this.feedBackRating,
            comments: this.feedBackComments,
        };

        let evt = new CustomEvent('submit', { detail: stepData });
        this.dispatchEvent(evt);
    }
}