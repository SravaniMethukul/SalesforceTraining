import { LightningElement, wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class NavigateToOtherPage extends NavigationMixin(LightningElement) {

    navigateToNewRecordPage() {
        this[NavigationMixin.Navigate]({
            type: "standard__objectPage",
            attributes: {
                objectApiName: "Account",
                actionName: "view",

            },
        })
    }

}