import test from 'ava';
import parser from '../parser';
import util from './_common';

const { pass, fail, returns } = util('_Assumption');

test('Accepts valid declaration (1)', pass, "Let x = 3");
test('Accepts valid declaration (2)', pass, "let d=-7.1");
test('Accepts valid declaration (3)', pass, "Let n = k+1");

test('Rejects invalid declaration (1)', fail, "n = 13");
test('Rejects invalid declaration (2)', fail, "Letx = 7");
test('Rejects invalid declaration (3)', fail, "Let F = -2");
test('Rejects invalid declaration (4)', fail, "Let");
test('Rejects invalid declaration (5)', fail, "= 3");
test('Rejects invalid declaration (6)', fail, "Let 13 = x");
test('Rejects invalid declaration (7)', fail, "Let ab = 7");

test('Returns proper postfix (1)', returns, "Let x = 3", {
  "x":["3"]
});
test('Returns proper postfix (2)', returns, "let d=-7.1", {
  "d":["-7.1"]
});
test('Returns proper postfix (3)', returns, "Let n = k+1", {
  "n":["k","1","+"]
});