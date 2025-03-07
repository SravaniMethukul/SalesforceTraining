import { LightningElement, api, wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { CurrentPageReference } from 'lightning/navigation';
import Phone from '@salesforce/schema/Account.Phone';
import { encodeDefaultFieldValues } from 'lightning/pageReferenceUtils';
import FirstName from '@salesforce/schema/Contact.FirstName';


export default class DemoCustomColumnDataTableTwo extends NavigationMixin(LightningElement) {
    @api recordId;

    //data, columnsList
    columnsList = [
        { label: "Id", fieldName: "Id" },
        { label: "Name", fieldName: "Name" },
        {
            label: "Progress", fieldName: "Score", type: 'progRing',
            typeAttributes: {
                variant: 'warning'
            }
        },
    ];

    data = [
        { 'Id': 123, 'Name': 'ABC', 'Score': 20 },
        { 'Id': 1234, 'Name': 'CDF', 'Score': 80 },
        { 'Id': 4564, 'Name': 'EGH', 'Score': 100 },
    ];


    @wire(CurrentPageReference)
    pageRef;

    get pageReference() {
        return JSON.stringify(this.pageRef);
    }

    //navigate to standard home page
    /* handleClick() {
         this[NavigationMixin.Navigate]({
             type: 'standard__namedPage',
             attributes: {
                 pageName: 'home',
             }
         })
     }*/


    //Navigate to object Page
    /*handleClick(event) {
        //query string
        const defaultValues = encodeDefaultFieldValues({
            FirstName: 'Contact',
            LastName: 'New',
        });

        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Contact',
                actionName: 'new',
            },
            state: {
                defaultFieldValues: defaultValues,
            }
        })
    }*/

    //navigate to record Page
    /*handleClick(event) {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                objectApiName: 'Account',
                recordId: this.recordId,
                actionName: 'view',
            }
        })
    }*/

    /* handleClick(event) {
 
         this[NavigationMixin.Navigate]({
             type: 'standard__objectPage',
             attributes: {
                 objectApiName: 'Contact',
                 actionName: 'list',
             },
             state: {
                 filterName: 'RecentlyViewedContacts',
             },
         })
     }*/

    //navigate to a tab
    /* handleClick(event) {
         this[NavigationMixin.Navigate]({
             type: 'standard__navItemPage',
             attributes: {
                 apiName: 'App_Page'
             }
         })
     }*/

    //navigate to related  records page
    /*handleClick(event) {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordRelationshipPage',
            attributes: {
                objectApiName: 'Account',
                relationshipApiName: 'Contacts',
                recordId: '001dM00000H8o14QAB',
                actionName: 'view',
            },
        });
    }*/

    //navigate to web page
    /*handleClick(event) {
        this[NavigationMixin.Navigate]({
            type: 'standard__webPage',
            attributes: {
                url: 'https://www.ajskilldevelopment.com',
            }
        })
    }*/

    //navigate to separate component
    /*definitionOfCom = {
        componentDef: 'c:diyWireAdaptorSixteen',
        attributes: {
            objectApiName: 'Account',
        }
    };

    handleClick(event) {
        // Encode component definition and attributes to Base64
        const encodedDefinition = btoa(JSON.stringify(this.definitionOfCom));

        // Navigate to the component using a URL
        this[NavigationMixin.Navigate]({
            type: 'standard__webPage',  // Use 'standard__webPage' to navigate to a custom URL
            attributes: {
                url: '/one/one.app#' + encodedDefinition  // Append encoded definition to the URL
            }
        });
    }*/

}


