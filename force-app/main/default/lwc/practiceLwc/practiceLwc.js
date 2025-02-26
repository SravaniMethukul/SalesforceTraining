import { LightningElement } from 'lwc';

export default class PracticeLwc extends LightningElement {

    async handleClick() {
        let url = "https://jsonplaceholder.typicode.com/posts";
        try {
            let response = fetch(url, { method: "GET" })
            console.log(response)
        }
        catch (e) {
            console.log(e);
        }
    }


    /*firstName = 'Sravani';

    check_user(firstName) {
        return new Promise((resolve, reject) => {
            setTimeout(() => {
                if (firstName === 'Sravani') {
                    resolve("verify userName");
                } else {
                    reject("invalid user");
                }
            }, 2000);
        });
    }


    handleClick() {
        this.check_user('Sravani')
            .then((result) => {
                console.log(result);
            })
            .catch((error) => {
                console.log(error);
            })
    }

    async handleClick() {
        try {
            const response = await this.check_user('Sravani123');
            console.log(response);
        }
        catch (e) {
            console.log(e);
        }
    }*/
}