import { LightningElement, api } from 'lwc';
import MyModal from 'c/modelForCaseStudy';
import { NavigationMixin } from 'lightning/navigation';

export default class CaseStudyLwcSeven extends NavigationMixin(LightningElement) {
    @api recordId

    async handleClick() {
        try {
            console.log('Opening modal with recordId:', this.recordId);
            await MyModal.open({
                size: 'small',
                description: 'Modal for creating a Receipt record',
                content: this.recordId,
            })
                //receive created receipt record Id from modal and navigate
                //window.location.href = 'lightning/r/receipt__c/${res.recordId}/view
                .then((res) => {
                    console.log('Navigate now');
                    this[NavigationMixin.Navigate]({
                        type: 'standard__recordPage',
                        attributes: {
                            recordId: res.recordId,  // Navigate to the new record
                            objectApiName: 'Receipt__c',  // Specify the object API name
                            actionName: 'view',  // Action to 'view' the record
                        }
                    });
                })
                .catch((error) => {
                    console.log('error : ', error);
                })

        } catch (error) {
            console.error('Error opening modal:', error);
        }
    }
}
