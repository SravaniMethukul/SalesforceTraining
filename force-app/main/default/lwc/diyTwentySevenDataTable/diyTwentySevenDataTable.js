import { LightningElement, wire } from 'lwc';
import getContact from '@salesforce/apex/ContactHelper.getContact';
import MyModal from 'c/diyTwentySevenModalForDataTable';

export default class DiyTwentySevenDataTable extends LightningElement {
    contactDataObtained;
    recordIdObtained;
    rowObtained;
    columnslist = [
        { label: "Id", fieldName: "Id" },
        { label: "FirstName", fieldName: "FirstName" },
        { label: "LastName", fieldName: "LastName" },
        {
            label: 'View Record Data',
            type: 'button-icon',
            typeAttributes:
                { iconName: "action:preview" },
        }
    ];

    @wire(getContact)
    contactData({ data, error }) {
        if (data) {
            console.log('entered wire method: ');
            this.contactDataObtained = data;
        }
        if (error) {
            console.log('error occured: ', error);
        }
    }

    async handleRowAction(event) {
        this.rowObtained = event.detail.row;
        console.log('get row: ', JSON.stringify(this.rowObtained));
        this.recordIdObtained = this.rowObtained.Id
        console.log('record Id obtained: ', this.recordIdObtained);
        await MyModal.open({
            size: 'small',
            description: 'Accessible description of modal\'s purpose',
            //content: "Unpacked now declared put you confined daughter improved. Celebrated imprudence few interested especially reasonable off one. Wonder bed elinor family secure met. It want gave west into high no in. Depend repair met before man admire see and. An he observe be it covered delight hastily message. Margaret no ladyship endeavor ye to settling. Seen you eyes son show. Far two unaffected one alteration apartments celebrated but middletons interested. Described deficient applauded consisted my me do. Passed edward two talent effect seemed engage six. On ye great do child sorry lived. Proceed cottage far letters ashamed get clothes day. Stairs regret at if matter to. On as needed almost at basket remain. By improved sensible servants children striking in surprise",
            content: this.rowObtained,
        })
    }

}

