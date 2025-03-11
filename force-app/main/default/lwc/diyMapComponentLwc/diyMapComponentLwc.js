import { LightningElement, api } from 'lwc';

export default class DiyMapComponentLwc extends LightningElement {
    @api mapMarkersToDisplay;
    @api markerTitle;
}