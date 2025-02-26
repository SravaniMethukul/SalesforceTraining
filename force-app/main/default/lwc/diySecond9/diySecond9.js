import { LightningElement, track } from 'lwc';

export default class DiySecond9 extends LightningElement {
    stockAvailable = true;
    errorMessage = null;
    @track product = {
        name: "Apple",
        price: 20000,
        stock: 20
    };

    handleInputChange(event) {
        this.currentStockValue = parseInt(event.target.value, 10);
        if (this.currentStockValue < 0) {
            this.errorMessage = 'Enter the valid Stock Value';
            this.stockAvailable = false;
        }
        else if (this.currentStockValue === 0) {
            this.product.stock = this.currentStockValue;
            this.stockAvailable = false;
            this.errorMessage = 'No Stock Available';
        }
        else {
            this.product.stock = this.currentStockValue;
            this.stockAvailable = true;
            this.errorMessage = null;
        }
    }
}