import { LightningElement, track } from 'lwc';

export default class DiyPlayerComponent extends LightningElement {
    teamOptions = [{ label: 'CSK', value: 'CSK' },
    { label: 'RCB', value: 'RCB' },
    { label: 'SRH', value: 'SRH' },
    ];
    @track playersAdded = [];
    @track topPlayer = [];
    newPlayer = {};

    handleChange(event) {
        const { name, value } = event.target;
        console.log('name: ', JSON.stringify(event.target));
        this.newPlayer[name] = value;
        this.newPlayer.id = this.playersAdded.length + 1;
        console.log('new players: ', JSON.stringify(this.newPlayer));
        console.log('players added: ', JSON.stringify(this.playersAdded));

    }

    handleAddMore() {
        this.playersAdded = [...this.playersAdded, this.newPlayer];
        console.log('players added in add more: ', JSON.stringify(this.playersAdded));
        const inputsToClear = this.template.querySelectorAll('lightning-input , lightning-combobox');
        inputsToClear.forEach((inp) => {
            inp.value = '';
        })
        this.newPlayer = {};
    }

    handleTopPlayer() {
        if (this.playersAdded) {
            this.Score = this.playersAdded.map(ele => ele.Score);
            console.log('scores: ', JSON.stringify(this.Score));
            const maxScore = Math.max(...this.Score);
            console.log('max scores: ', maxScore);
            // eslint-disable-next-line array-callback-return
            this.topPlayer = this.playersAdded.filter(ele => Number(ele.Score) === Number(maxScore));
            console.log('top players max scores: ', JSON.stringify(this.topPlayer));
            console.log('Top players added in add more: ', JSON.stringify(this.topPlayer));
        }
    }

    handleDeletePlayer(event) {
        const idToDelete = event.detail;
        console.log('detail obtained: ', idToDelete);
        this.playersAdded = this.playersAdded.filter(p => p.id !== Number(idToDelete));
        console.log('players after delete: ', JSON.stringify(this.playersAdded));
        let startIndex = 1;
        this.playersAdded = this.playersAdded.map(p => {
            p.id = startIndex
            startIndex++;
            return p;
        });
        console.log('players after change index: ', JSON.stringify(this.playersAdded));
        this.handleTopPlayer();
    }
}