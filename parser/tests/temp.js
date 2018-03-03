import test from 'ava';
import parser from '../parser';

test('foo', t => {
    const test = parser.parse("2 * (3 + 4)");
    t.is(test,13);
});
