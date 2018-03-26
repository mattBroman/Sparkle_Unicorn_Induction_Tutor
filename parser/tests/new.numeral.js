import test from 'ava';
import parser from '../parser';
import util from './common';

const { pass, fail, returns } = util('_Numeral');

test('Accepts numbers (1)', pass, "9");
test('Accepts numbers (2)', pass, "831");
test('Accepts 0', pass, "0");
test('Accepts decimal values (1)', pass, "12.345");
test('Accepts decimal values (2)', pass, "0.00001");
test('Accepts negative numbers', pass, "-13");

test('Rejects double negative', fail, "--13");
test('Rejects negative gap', fail, "- 13");
test('Rejects decimal with null prefix', fail, ".13");
test('Rejects decimal "chaining"', fail, "0.13.13.13");
test('Rejects leading 0', fail, "02345");
test('Rejects invalid characters', fail, "13!");

test('Should return term as array (1)', returns, "9", ["9"]);
test('Should return term as array (2)', returns, "134", ["134"]);
test('Should return term as array (3)', returns, "-13.13", ["-13.13"]);
test('Should return term as array (4)', returns, "0.001", ["0.001"]);