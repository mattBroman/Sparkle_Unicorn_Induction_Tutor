import test from 'ava';
import {SingleEquation} from '../json-latex.js'



test("postfix to infix (1)", t => {
    const expected = "2+2&=4";
    const actual = SingleEquation({"left":["2","2","+"],"right":["4"]},true);
    t.is(actual, expected);
});

test("postfix to infix (1)", t => {
    const expected = "2+2=4";
    const actual = SingleEquation({"left":["2","2","+"],"right":["4"]},false);
    t.is(actual, expected);
});