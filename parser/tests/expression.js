import test from 'ava';
import parser from '../parser';
import util from './common';

const { pass, fail } = util('Expression');

test('(2+2)', pass, '(2+2)');
test('(34-5)', pass, '(34-5)');
test('2+2', pass , '2+2');
test('34-5', pass, '34-5');

test('vartest1', pass, "x + x");
test('vartest2', fail, "x1 + 3");
test('vartest3', pass, "y + 1");
test('vartest4', pass, "a * 2");
test('vartest5', pass, "2*b");
test('vartest15', pass, "a / 4");
test('vartest16', pass, "g % 5");
test('vartest17', pass, "h ^ 6");
test('vartest18', fail, "c + 1h");
test('vartest19', fail, "d * 2j");
test('vartest20', fail, "e - 3l");
test('vartest21', fail, "a / 4i");
test('vartest22', fail, "g % 5o");
test('vartest23', fail, "h ^ 6p");
test('vartest24', fail, "9c + 1h");

