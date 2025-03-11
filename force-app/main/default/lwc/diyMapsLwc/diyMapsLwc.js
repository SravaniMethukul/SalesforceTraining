import { LightningElement, wire } from 'lwc';
import getAccounts from '@salesforce/apex/MapControllerLwc.getAccounts';

export default class DiyMapsLwc extends LightningElement {
    mapMarkers = [];
    markersTitle = "Accounts Location";
    SelectedMarker;
    dataReceived;

    @wire(getAccounts)
    dataObtained({ data, error }) {
        if (data) {
            this.dataReceived = data;
            console.log('Map Data: ', JSON.stringify(this.dataReceived));
            this.formatResponse(data);
        }
        if (error) {
            console.log('error occured', error.getMessage());
        }
    }

    formatResponse(data) {
        this.mapMarkers = data.map(item => {
            return {
                location: {
                    Street: item.BillingCity || '',
                    City: item.BillingCity || '',
                    PostalCode: item.BillingPostalCode || '',
                    State: item.BillingState || '',
                    Country: item.BillingCountry || '',
                },
                icon: 'utility:salesforce1',
                title: item.Name,
                value: item.Name,
                description: item.description,
            }
        });
        this.SelectedMarker = this.mapMarkers.length && this.mapMarkers[0].value;
    }

    callMarketHandler(event) {
        this.SelectedMarker = event.detail.selectedMarkerValue;
        console.log('selected marker event: ', JSON.stringify(this.SelectedMarker));
    }


}