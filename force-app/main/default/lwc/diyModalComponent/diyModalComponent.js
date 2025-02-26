import { api } from 'lwc';
import LightningModal from 'lightning/modal';

export default class DiyModalComponent extends LightningModal {
    @api
    //content;
    options = [];
    message;
    handleCancel() {
        this.close();
    }

    handleSave() {
        this.close();
    }

    handleOptionClick(event) {
        const { id } = event.target.dataset;
        console.log('Id is: ', id);
        this.message = `Clicked Option: ${id}`;
        // this.close() triggers closing the modal
        // the value of `id` is passed as the result
    }
}