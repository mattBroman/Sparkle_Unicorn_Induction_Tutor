import test from 'ava';
import {MultipleEquation} from '../json-latex.js'



test("postfix to infix (1)", t => {
    const expected = `2+2&=4 \\\\3+3&=6`;
    const actual = MultipleEquation([{"left":["2","2","+"],"right":["4"]},{"left":["3","3","+"],"right":["6"]}]);
    t.is(actual, expected);
});