import test from 'ava';
import parser from '../parser';
import util from './common';

const { pass, fail, returns } = util('_Expression_MD');

test('Accepts division expression with spaces', pass, "10 / 13");
test('Accepts division expression without spaces', pass, "10/13");
test('Accepts division expression negative numbers (1)', pass, "-10 / -13");
test('Accepts division expression negative numbers (2)', pass, "-10/-13");
test('Accepts division expression extension', pass, "10 / 13 / 12");
test('Accepts multiplication expression with spaces', pass, "10 * 13");
test('Accepts multiplication expression without spaces', pass, "10*13");
test('Accepts multiplication expression negative numbers (1)', pass, "-10 * -13");
test('Accepts multiplication expression negative numbers (2)', pass, "-10*-13");
test('Accepts multiplication expression extension', pass, "10 * 13 * 12");
test('Accepts nested e expression (1)', pass, "10 * 13 ^ 11");
test('Accepts nested e expression (2)', pass, "10 ^ 13 / 11");
test('Accepts nested e expression (3)', pass, "10 / 14 * 13 ^ 6 ^ 9 / 18 ^ 7 * 6 / 4 ^ 4 * 4 ^ 6");
test('Accepts nested p expressions (1)', pass, "3 * ( 2 ) / 4");
test('Accepts nested p expressions (2)', pass, "3 * ( 2 + 2 ) / 4");
test('Accepts nested p expressions (3)', pass, "3 * ( 2 * 2 ) / 4");
test('Accepts nested p expressions (4)', pass, "3 * ( 2 ^ 2 ) / 4");
test('Accepts nested p expressions (5)', pass, "3 * ( ( 2 + 4 ) + 4 ) / 4");

// test('Accepts variable chains (1)', pass, "3x");
// test('Accepts variable chains (2)', pass, "3xy * z");
// test('Accepts variable chains (3)', pass, "3 + 4z * y / 9xz");

test('Rejects incomplete division expression (1)', fail, "10 /");
test('Rejects incomplete division expression (2)', fail, "/ 13");
test('Rejects incomplete division expression (3)', fail, "/");
test('Rejects incomplete multiplication expression (1)', fail, "10 *");
test('Rejects incomplete multiplication expression (2)', fail, "* 13");
test('Rejects incomplete multiplication expression (3)', fail, "*");

test('Returns postfix division (1)', returns, "10 / 13", ["10", "13", "/"]);
test('Returns postfix division (2)', returns, "10/13", ["10", "13", "/"]);
test('Returns postfix division (3)', returns, "-10 / -13", ["-10", "-13", "/"]);
test('Returns postfix division (4)', returns, "-10/-13", ["-10", "-13", "/"]);
test('Returns postfix division (5)', returns, "10 / 20 / 30", ["10", "20", "/", "30", "/"]);
test('Returns postfix multiplication (1)', returns, "10 * 13", ["10", "13", "*"]);
test('Returns postfix multiplication (2)', returns, "10*13", ["10", "13", "*"]);
test('Returns postfix multiplication (3)', returns, "-10 * -13", ["-10", "-13", "*"]);
test('Returns postfix multiplication (4)', returns, "-10*-13", ["-10", "-13", "*"]);
test('Returns postfix multiplication (5)', returns, "10 * 20 * 30", ["10", "20", "*", "30", "*"]);
test('Returns postfix', returns, "10 / 20 * 30 / 40", ["10", "20", "/", "30", "*", "40", "/"]);
test('Nested e expression are proper postfix (1)', returns, "10 * 13 ^ 11", ["10", "13", "11", "^", "*"]);
test('Nested e expression are proper postfix (2)', returns, "10 ^ 13 / 11", ["10", "13", "^", "11", "/"]);
test('Nested e expression are proper postfix (3)', returns, "10 / 14 * 13 ^ 6 ^ 9 / 18 ^ 7 * 6 / 4 ^ 4 * 4 ^ 6", [
  "10",
  "14",
  "/",
  "13", "6", "9", "^", "^",
  "*",
  "18", "7", "^",
  "/",
  "6",
  "*",
  "4", "4", "^",
  "/",
  "4", "6", "^",
  "*"
]);
test('Nested p expressions are proper postfix (1)', returns, "3 * ( 2 ) / 4", ["3", "2", "*", "4", "/"]);
test('Nested p expressions are proper postfix (2)', returns, "3 * ( 2 + 2 ) / 4", [
  "3",
  "2", "2", "+",
  "*", "4", "/"
]);
test('Nested p expressions are proper postfix (3)', returns, "3 * ( 2 * 2 ) / 4", [
  "3",
  "2", "2", "*",
  "*", "4", "/"
]);
test('Nested p expressions are proper postfix (4)', returns, "3 * ( 2 ^ 2 ) / 4", [
  "3",
  "2", "2", "^",
  "*", "4", "/"
]);
test('Nested p expressions are proper postfix (5)', returns, "3 * ( ( 2 + 4 ) + 4 ) / 4", [
  "3",
      "2", "4", "+",
    "4", "+",
  "*", "4", "/"
]);