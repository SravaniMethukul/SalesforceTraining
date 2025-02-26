import { LightningElement } from 'lwc';

/*import { sum } from './util';
import valueFromExport from './util';
import { oddOreven } from 'c/myutil';*/

export default class DataBinding extends LightningElement {
    customStyle = 'myStyle_admin';
    name = 'John';
    isloggedin = false;
    person = {
        name: 'John',
        age: 30,
        position: 'Developer',
        address: {
            city: 'Adoni',
            state: 'Andhra Pradesh',
            country: 'India'
        }
    };
    fruits = ['apple', 'orange'];
    price = 2000;

    display() {
        console.log(this.fruits);
    }
    //get method
    get fruit() {
        return this.fruits[0];
    }

    get discount() {
        return (this.price * 0.2);
    }

    handleChange(event) {
        console.log(event.target.name);
        console.log(event.target.value);
        this.name = event.target.value;
    }

    /* handleClick(event) {
         this.customStyle = 'myStyle';
     }
 
     handleClickOnButton(event) {
         alert(oddOreven(5));
         alert(sum(10, 20));
         alert(valueFromExport);
     }*/
}