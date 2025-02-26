/* eslint-disable @lwc/lwc/no-async-operation */
import { LightningElement } from 'lwc';

export default class AsyncAndAwaitDemo extends LightningElement {

    /*check_username(firstName) {
        return new Promise((resolve, reject) => {
            setTimeout(() => {
                if (firstName === 'AJ')
                    resolve('verified user name');
                else
                    reject('invalid username');
            }, 2000)
        });
    }

    async handleClick() {
        /*this.check_username('AJ')
            .then(result => {
                console.log(result);
            })
            .catch(error => {
                console.log(error);
            })
        try {
        const response = await this.check_username('Sravani');
        console.log(response);
        }
        catch (error) {
            console.log(error);
        }
    }*/
    currentIndex = 0;
    currentPost = null;
    posts = [];

    connectedCallback() {
        this.fetchPosts();
    }

    async fetchPosts() {
        try {
            const response = await fetch('https://jsonplaceholder.typicode.com/posts');
            this.posts = await response.json();
            this.updateCurrentPost();
        } catch (error) {
            console.error('Error:', error);
        }
    }

    /*async handleClick() {

        console.log('Entered handle click');
        let url = "https://jsonplaceholder.typicode.com/posts";
        try {
            let response = await fetch(url, { method: "GET" });
            console.log(response); // if it is readable stream convert to json using .json
            let data = await response.json(); // parse json from response
            console.log(data);
            this.posts = data;
            console.log(this.posts)// log the fetched data
        }
        catch (e) {
            console.log(e);
        }*/

    updateCurrentPost() {
        if (this.posts.length > 0 && this.currentIndex >= 0 && this.currentIndex < this.posts.length) {
            this.currentPost = this.posts[this.currentIndex];
        }
    }

    handlePrevious() {
        if (this.currentIndex > 0) {
            this.currentIndex--;
            this.updateCurrentPost();
        }
    }

    handleNext() {
        if (this.currentIndex < this.posts.length - 1) {
            this.currentIndex++;
            this.updateCurrentPost();
        }
    }

    get isFirstPost() {
        return this.currentIndex === 0;
    }

    get isLastPost() {
        return this.currentIndex === this.posts.length - 1;
    }
}