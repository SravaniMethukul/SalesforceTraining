import { LightningElement, track } from 'lwc';

export default class SldsExampleTrackDecorator extends LightningElement {
    // primitive property
    firstName = '';
    lastName = '';
    email = '';

    //non primitive
    studentData = {};
    //use track decorator
    @track reactiveStudentData = {};

    handleFirstNameChange(event) {
        console.log('First Name is updating');
        //this.firstName = event.target.value;
        this.studentData.firstName = event.target.value;
        this.reactiveStudentData.firstName = event.target.value
    }

    handleLastNameChange(event) {
        console.log('last Name is updating');
        //this.lastName = event.target.value;
        this.studentData.lastName = event.target.value;
        this.reactiveStudentData.lastName = event.target.value
    }

    handleEmailChange(event) {
        console.log('Email is updating');
        //this.email = event.target.value;
        this.studentData.email = event.target.value;
        this.reactiveStudentData.email = event.target.value
    }
}