import test from 'ava';
import parser from '../parser';
import util from './_common';

const { pass, fail, returns } = util('_Expression_E');

test('Accepts expression with spaces', pass, "10 ^ 13");
test('Accepts expression without spaces', pass, "10^13");
test('Accepts expression negative numbers (1)', pass, "-10 ^ -13");
test('Accepts expression negative numbers (2)', pass, "-10^-13");
test('Accepts expression with leading p expression', pass, "( 10 - 4 ) ^ 18")
test('Accepts expression extension (1)', pass, "10 ^ 13 ^ 12");
test('Accepts expression extension (2)', pass, "10 ^ ( 10 + 3 ) ^ 12");
test('Accepts nested p expressions (1)', pass, "3 ^ ( 2 ) ^ 4");
test('Accepts nested p expressions (2)', pass, "3 ^ ( 2 + 2 ) ^ 4");
test('Accepts nested p expressions (3)', pass, "3 ^ ( 2 * 2 ) ^ 4");
test('Accepts nested p expressions (4)', pass, "3 ^ ( 2 ^ 2 ) ^ 4");
test('Accepts nested p expressions (5)', pass, "3 ^ ( ( 2 + 4 ) + 4 ) ^ 4");

test('Rejects incomplete expression (1)', fail, "10 ^");
test('Rejects incomplete expression (2)', fail, "^ 13");
test('Rejects incomplete expression (3)', fail, "^");

test('Returns postfix (1)', returns, "10 ^ 13", ["10", "13", "^"]);
test('Returns postfix (2)', returns, "10^13", ["10", "13", "^"]);
test('Returns postfix (3)', returns, "-10 ^ -13", ["-10", "-13", "^"]);
test('Returns postfix (4)', returns, "-10^-13", ["-10", "-13", "^"]);
test('Returns postfix (5)', returns, "10 ^ 20 ^ 30", ["10", "20", "30", "^", "^"]);
test('Nested p expressions are proper postfix (1)', returns, "3 ^ ( 2 ) ^ 4", ["3", "2", "4", "^", "^"]);
test('Nested p expressions are proper postfix (2)', returns, "3 ^ ( 2 + 2 ) ^ 4", [
  "3",
  "2", "2", "+",
  "4", "^", "^"
]);
test('Nested p expressions are proper postfix (3)', returns, "3 ^ ( 2 * 2 ) ^ 4", [
  "3",
  "2", "2", "*",
  "4", "^", "^"
]);
test('Nested p expressions are proper postfix (4)', returns, "3 ^ ( 2 ^ 2 ) ^ 4", [
  "3",
  "2", "2", "^",
  "4", "^", "^"
]);
test('Nested p expressions are proper postfix (5)', returns, "3 ^ ( ( 2 + 4 ) + 4 ) ^ 4", [
  "3",
      "2", "4", "+",
    "4", "+",
  "4", "^", "^"
]);