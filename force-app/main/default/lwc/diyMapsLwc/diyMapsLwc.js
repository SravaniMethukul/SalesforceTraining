import { LightningElement, wire } from 'lwc';
import getAccounts from '@salesforce/apex/MapControllerLwc.getAccounts';

export default class DiyMapsLwc extends LightningElement {
    mapMarkers = [];
    markersTitle = "Location Of Accounts";
    SelectedMarker;
    dataReceived;

    @wire(getAccounts)
    dataObtained({ data, error }) {
        if (data) {
            this.dataReceived = data;
            this.formatResponseObtained(data);
        }
        if (error) {
            console.log('error occured', error.getMessage());
        }
    }

    formatResponseObtained(data) {
        this.mapMarkers = data.map(item => {
            return {
                location: {
                    Street: item.BillingCity || '',
                    City: item.BillingCity || '',
                    PostalCode: item.BillingPostalCode || '',
                    State: item.BillingState || '',
                    Country: item.BillingCountry || '',
                },
                icon: 'utility:location',
                title: item.Name,
                value: item.Name,
            }
        });
        this.SelectedMarker = this.mapMarkers.length && this.mapMarkers[0].value;
    }

    markerHandler(event) {
        this.SelectedMarker = event.detail.selectedMarkerValue;
    }
}