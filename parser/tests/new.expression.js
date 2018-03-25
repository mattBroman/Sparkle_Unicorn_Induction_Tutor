import test from 'ava';
import parser from '../parser';
import util from './common';

const { pass, fail, returns } = util('_Expression');

test('Accepts e expressions', pass, "4 ^ 9 ^ 3");
test('Accepts md expressions', pass, "10 * 13 / 18 * 27");
test('Accepts as expressions', pass, "10 - 13 + 27 - 30");

test('Accepts emdas expressions', pass, "3 * 4 ^ 2 ^ 2 - 8 / 6 ^ 3 + 18");
test('Accepts mdas expressions', pass, "2 + 3 * 8 / 4 - 17");
test('Accepts das expressions', pass, "3 / 8 - 4 + 6");
test('Accepts as expressions', pass, "3 + 6 - 4");
test('Accepts s expressions', pass, "2 - 5 - 8");

test('MD expressions return proper postfix', returns, "10 * 13 / 18 * 27", ["10", "13", "*", "18", "/", "27", "*"]);
test('AS expressions return proper postfix', returns, "10 - 13 + 27 - 30", ["10", "13", "-", "27", "+", "30", "-"]);

test('EMDAS expressions return proper postfix', returns, "3 * 4 ^ 2 ^ 2 - 8 / 6 ^ 3 + 18", [
    "3",
      "4","2","2","^","^", 
    "*",
    "8", 
      "6", "3", "^", 
    "/",
  "-","18","+"
]);
test('MDAS expressions return proper postfix', returns, "2 + 3 * 8 / 4 - 17", [
  "2",
    "3","8","*","4","/",
  "+","17","-"
]);
test('DAS expressions return proper postfix', returns, "3 / 8 - 4 + 6", [
    "3","8","/",
  "4","-","6","+"
]);
test('AS expressions return proper postfix', returns, "3 + 6 - 4", ["3", "6", "+", "4", "-"]);
test('S expressions return proper postfix', returns, "2 - 5 - 8", ["2", "5", "-", "8", "-"]);