import { LightningElement, api } from 'lwc';

export default class DiyTimerChild extends LightningElement {
    @api amountOfTime;
    remainingTime;
    displayTime = '00:00';
    timerInterval;

    @api startTimer() {
        console.log('entered child start');
        if (this.amountOfTime) {
            this.dispatchButtonLabelChange('Stop');
            this.remainingTime = this.amountOfTime * 60 * 1000;
            this.updateDisplayTime();
            // eslint-disable-next-line @lwc/lwc/no-async-operation
            this.timerInterval = setInterval(() => {
                this.remainingTime -= 1000;
                this.updateDisplayTime();
                if (this.remainingTime <= 0) {
                    this.stopTimer();
                    this.displayTime = "Time's up!";
                }
            }, 1000);
        }
    }

    @api stopTimer() {
        console.log('entered child stop');
        clearInterval(this.timerInterval);
        this.timerInterval = null;
        this.dispatchButtonLabelChange('Start');
    }

    @api resetTimer() {
        console.log('entered child reset');
        this.stopTimer();
        this.displayTime = '00:00';
    }

    updateDisplayTime() {
        const totalSeconds = Math.floor(this.remainingTime / 1000);
        const minutes = String(Math.floor(totalSeconds / 60)).padStart(2, '0');
        const seconds = String(totalSeconds % 60).padStart(2, '0');
        this.displayTime = `${minutes}:${seconds}`;
    }

    dispatchButtonLabelChange(label) {
        this.dispatchEvent(new CustomEvent('buttonlabelchange', { detail: label }));
    }
}
