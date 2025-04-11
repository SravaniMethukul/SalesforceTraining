import { api } from 'lwc';
import LightningModal from 'lightning/modal';

export default class LwcModalForDataTable extends LightningModal {
    @api contactInfo = [];

    handleClose() {
        this.close();
    }
}


