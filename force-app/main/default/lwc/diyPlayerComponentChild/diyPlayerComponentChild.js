import { LightningElement, api } from 'lwc';

export default class DiyPlayerComponentChild extends LightningElement {
    @api playersAdded = [];
    @api topPlayer = [];

    handleDeleteClick(event) {
        const { id } = event.target.dataset;
        console.log('Id is: ', id);
        this.message = `Clicked Option: ${id}`;
        this.dispatchEvent(new CustomEvent('deleteplayer', { detail: id }));
    }
}






