import test from 'ava';
import parser from '../parser';
import util from './common';

const { pass, fail, returns } = util('_Expression_E');

test('Accepts expression with spaces', pass, "10 ^ 13");
test('Accepts expression without spaces', pass, "10^13");
test('Accepts expression negative numbers (1)', pass, "-10 ^ -13");
test('Accepts expression negative numbers (2)', pass, "-10^-13");
test('Accepts expression extension', pass, "10 ^ 13 ^ 12");

test('Rejects incomplete expression (1)', fail, "10 ^");
test('Rejects incomplete expression (2)', fail, "^ 13");
test('Rejects incomplete expression (3)', fail, "^");

test('Returns postfix (1)', returns, "10 ^ 13", ["10", "13", "^"]);
test('Returns postfix (2)', returns, "10^13", ["10", "13", "^"]);
test('Returns postfix (3)', returns, "-10 ^ -13", ["-10", "-13", "^"]);
test('Returns postfix (4)', returns, "-10^-13", ["-10", "-13", "^"]);
test('Returns postfix (5)', returns, "10 ^ 20 ^ 30", ["10", "20", "30", "^", "^"]);