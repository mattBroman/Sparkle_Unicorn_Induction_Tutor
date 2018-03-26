import test from 'ava';
import parser from '../parser';
import util from './_common';

const { pass, fail, returns } = util('_Term');

test('Accepts numerals (1)', pass, "13");
test('Accepts numerals (2)', pass, "-0.8");
test('Accepts variables', pass, "x");
test('Accepts variable chains (1)', pass, "14x");
test('Accepts variable chains (2)', pass, "-0.8yz");
test('Accepts variable chains (3)', pass, "xyz");

test('Rejects capital variables', fail, "M");

test('Returns proper postfix (1)', returns, "13", ["13"]);
test('Returns proper postfix (2)', returns, "-0.8", ["-0.8"]);
test('Returns proper postfix (3)', returns, "x", ["x"]);
test('Returns proper postfix (4)', returns, "14x", ["14", "x", "*"]);
test('Returns proper postfix (4)', returns, "-0.8yz", ["-0.8", "y", "*", "z", "*"]);
test('Returns proper postfix (4)', returns, "xyz", ["x", "y", "*", "z", "*"]);