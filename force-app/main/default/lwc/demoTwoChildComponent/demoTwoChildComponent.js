import { LightningElement, api } from 'lwc';

export default class DemoTwoChildComponent extends LightningElement {
    progressValue = 0;
    intervalId;

    @api handleStartProgress() {
        if (this.intervalId) {
            clearInterval(this.intervalId);
        }

        // eslint-disable-next-line @lwc/lwc/no-async-operation
        this.intervalId = setInterval(() => {
            this.progressValue = this.progressValue + 10;
            if (this.progressValue >= 100) {
                clearInterval(this.intervalId);
                this.progressValue = 100;
                const eve = new CustomEvent('progressfinished');
                this.dispatchEvent(eve);
            }
        }, 300);
    }

    @api setprogressValBar(val) {
        this.progressValue = val;
    }

    handleClick() {
        console.log('Event Raised by Child');
        /* const eve = new CustomEvent('display', { detail: "Test Data" });
         this.dispatchEvent(eve);*/

        const eve = new CustomEvent('display', {
            detail: {
                code: 101, name: 'Sravani'
            }
        });
        this.dispatchEvent(eve);
    }
}