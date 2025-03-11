import { createElement } from 'lwc';
import jestTestExample from 'c/jestTestExample';

describe('c-jest-test-example', () => {
    it('display welcome message', () => {
        const element = createElement('c-jest-test-example', {
            is: jestTestExample
        })
        document.body.appendChild(element);
        const div = element.shadowRoot.querySelector('div');
        expect(div.textContent).toBe('Welcome to AJSkill');

    })
})




