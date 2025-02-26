import { LightningElement, track } from 'lwc';

export default class DiyTimerParent extends LightningElement {
    @track timeValue = ''; // Reactive property for combobox value
    @track isDisabled = false;
    timeOptions = [
        { label: '2 minutes', value: '2' },
        { label: '5 minutes', value: '5' },
        { label: '8 minutes', value: '8' }
    ];
    changeButtonLabel = 'Start';

    handleChange(event) {
        this.timeValue = event.detail.value; // Update reactive property
        console.log('Selected time value:', this.timeValue);
    }

    handleStartStop() {
        console.log('entered parent start');
        if (this.changeButtonLabel === 'Start') {
            this.template.querySelector('c-diy-timer-child').startTimer();
            this.isDisabled = true;
        } else if (this.changeButtonLabel === 'Stop') {
            this.template.querySelector('c-diy-timer-child').stopTimer();
            this.isDisabled = false;
        }
    }

    handleReset() {
        console.log('entered parent start');
        this.template.querySelector('c-diy-timer-child').resetTimer();
        this.isDisabled = false;
    }

    handleButtonLabel(event) {
        this.changeButtonLabel = event.detail;
    }
}
