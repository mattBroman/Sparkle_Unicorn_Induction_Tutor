import test from 'ava';
import parser from '../parser';
import {pass, fail} from './common.js'

let token = 'Expression';

test('(2+2)', pass, token, '(2+2)');
test('(34-5)', pass, token, '(34-5)');
test('2+2', pass , token, '2+2');
test('34-5', pass, token, '34-5');

test('vartest1', pass, token, "x + x");
test('vartest2', fail, token, "x1 + 3");
test('vartest3', pass, token, "y + 1");
test('vartest4', pass, token, "a * 2");
test('vartest5', pass, token, "2*b");
test('vartest15', pass, token, "a / 4");
test('vartest16', pass, token, "g % 5");
test('vartest17', pass, token, "h ^ 6");
test('vartest18', fail, token, "c + 1h");
test('vartest19', fail, token, "d * 2j");
test('vartest20', fail, token, "e - 3l");
test('vartest21', fail, token, "a / 4i");
test('vartest22', fail, token, "g % 5o");
test('vartest23', fail, token, "h ^ 6p");
test('vartest24', fail, token, "9c + 1h");

