import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation'

export default class DemoNavigation extends NavigationMixin(LightningElement) {

    //navigate to separate component
    definitionOfComponent = {
        componentDef: 'c:diyWireAdaptorObjectInfo',
        attributes: {
            objectApiName: 'Contact',
        }
    };

    handleClick() {
        // Encode component definition and attributes to Base64
        const encodedDefinition = btoa(JSON.stringify(this.definitionOfComponent));

        // Navigate to the component using a URL
        this[NavigationMixin.Navigate]({
            // Use 'standard__webPage' to navigate to a custom URL
            type: 'standard__webPage',
            attributes: {
                url: '/one/one.app#' + encodedDefinition  // Append encoded definition to the URL
            }
        });
    }

}