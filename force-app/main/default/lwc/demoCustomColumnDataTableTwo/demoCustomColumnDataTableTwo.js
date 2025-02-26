import { LightningElement } from 'lwc';

export default class DemoCustomColumnDataTableTwo extends LightningElement {
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
    ]
}