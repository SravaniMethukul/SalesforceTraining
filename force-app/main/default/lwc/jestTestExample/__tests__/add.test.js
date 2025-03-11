import { sum } from '../add';

describe('sum()', () => {
    it('should be 5 and 6 turns 11', () => {
        expect(sum(5, 6)).toBe(15)
    })
})
