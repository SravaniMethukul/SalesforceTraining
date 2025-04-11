import { LightningElement } from 'lwc';
import searchWithSpotify from '@salesforce/apex/spotifyIntegration.searchWithSpotify';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class SpotifyIntegratePractice extends LightningElement {

    inputVal;
    responseObtained;
    displayResult;
    trackData = '';
    trackUrl = '';
    trackAlbumName = '';
    trackimageUrl = '';
    trackArtists = '';
    releaseDate = '';

    handleChange(event) {
        this.inputVal = event.target.value;
    }

    async searchTrack() {
        let isValid = this.validateInput();
        if (isValid) {
            try {
                let responseString = await searchWithSpotify({
                    trackName: this.inputVal
                });
                console.log("response obtained", JSON.stringify(responseString));
                try {
                    let response = JSON.parse(responseString);
                    console.log('Parsed object:', response);
                    this.trackData = response.albums;
                    this.trackimageUrl = this.trackData.items[0].images[0].url;
                    this.trackUrl = this.trackData.items[0].external_urls.spotify;
                    this.trackAlbumName = this.trackData.items[0].name;
                    this.releaseDate = this.trackData.items[0].release_date;
                    console.log('tracked data:', JSON.stringify(this.trackData));
                    console.log('tracked url:', JSON.stringify(this.trackUrl));
                    console.log('tracked image url:', JSON.stringify(this.trackimageUrl));
                    console.log('tracked url:', JSON.stringify(this.trackAlbumName));
                    this.displayResult = true;

                } catch (parseError) {
                    console.error('JSON parsing failed:', parseError);
                    this.showToast('Parsing Error', 'Failed to parse Spotify response.', 'error');
                }
            }
            catch (error) {
                console.log(error);
                this.showToast('Error occured', error.body.message, 'error');
            }
        }
    }

    validateInput() {
        let isValid = true;
        let element = this.template.querySelector('lightning-input');
        if (!element.checkValidity()) {
            element.reportValidity();
            isValid = false;
        }
        return isValid;
    }

    showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        })
        this.dispatchEvent(event);
    }

    get artistName() {
        let artistNameArr = this.trackData.items[0].artists.map(curItem => curItem.name);
        let artistNames = artistNameArr.join(',');
        return artistNames;
    }

}