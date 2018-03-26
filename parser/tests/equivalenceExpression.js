import test from 'ava';
import parser from '../parser';
import util from './_common';

const { pass, fail, returns } = util('_EquivalenceExpression');

test('Accepts equivalence expression with spaces', pass, "3 = 4");
test('Accepts equivalence expression without spaces', pass, "3=4");
test('Accepts valid equivalence expressions (1)', pass, "3x = xy");
test('Accepts valid equivalence expressions (2)', pass, "-0.8 - -2 = 2 + 3");
test('Accepts valid equivalence expressions (3)', pass, "3*4=4/5");
test('Accepts valid equivalence expressions (4)', pass, "2 ^ 3 = 3 * (4 + 5)");
test('Accepts valid equivalence expressions (5)', pass, "= 1 + ( 2 - 3 ) * 4 / 5 ^ 6")

test('Rejects incomplete equivalence (1)', fail, "3 =");
test('Rejects incomplete equivalence (3)', fail, "=");

test('Returns proper postfix (1)', returns, "3x = xy", {
  left: ["3", "x", "*"],
  right: ["x", "y", "*"]
});
test('Returns proper postfix (2)', returns, "-0.8 - -2 = 2 + 3", {
  left: ["-0.8", "-2", "-"],
  right: ["2", "3", "+"]
});
test('Returns proper postfix (3)', returns, "3*4=4/5", {
  left: ["3","4","*"],
  right: ["4","5","/"]
});
test('Returns proper postfix (4)', returns, "2 ^ 3 = 3 * (4 + 5)", {
  left: ["2", "3", "^"],
  right: ["3", "4", "5", "+", "*"]
});
test('Returns proper postfix (5)', returns, "= 1 + ( 2 - 3 ) * 4 / 5 ^ 6", {
  left: null,
  right: [
    "1",
      "2","3","-",
      "4","*",
        "5","6","^",
      "/",
    "+"
  ]
});