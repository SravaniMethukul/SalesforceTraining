import { LightningElement } from 'lwc';

export default class DiyMapFormLwc extends LightningElement {

    city;
    state;
    country;
    mapMarkers = [];
    details = {};
    markerToDisplay;
    markerTitleToDisplay;

    handleInput(event) {
        const { name, value } = event.target;
        this.details[name] = value;
        console.log('map marker: ', JSON.stringify(this.details));
    }

    handleSubmit() {
        this.mapMarkers = [{
            location: {
                City: this.details.City || '',
                State: this.details.State || '',
                Country: this.details.Country || '',
            },
            icon: 'utility:salesforce1',
            title: this.details.City || '',
            value: this.details.City || '',
        }];
        console.log('map marker after applying map: ', JSON.stringify(this.mapMarkers));

        this.markerToDisplay = this.mapMarkers;
        this.markerTitleToDisplay = this.mapMarkers[0].location.City;
    }

}