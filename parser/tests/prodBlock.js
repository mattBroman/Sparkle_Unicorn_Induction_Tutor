import test from 'ava';
import parser from '../parser';
import util from './_common';

const { pass, fail, returns } = util('_ProdBlock');

test('Should accept valid prod (1)', pass,
`\\prod_{i=13}^{k+1}{2i+3}`);
test('Should accept valid prod (2)', pass,
`\\prod_{i=2k+1}^{3k}{2i+3}`);

test('Should reject incomplete prod blocks (1)', fail,
`\\prod_{i=1}`);
test('Should reject incomplete prod blocks (2)', fail,
`\\prod^{1}`);
test('Should reject incomplete prod blocks (3)', fail,
`\\prod{i+1}`);
test('Should reject incomplete prod blocks (4)', fail,
`\\prod_{i=1}^{13}`);
test('Should reject incomplete prod blocks (5)', fail,
`\\prod^{i=1}{3i}`);
test('Should reject incomplete prod blocks (6)', fail,
`\\prod_{i=1}{3i}`);

test('Should return valid postfix (1)', returns,
`\\prod_{i=13}^{k+1}{2i+3}`, [
  "prod",
  "i",
  "13","|",
  "k","1","+","|",
  "2","i","*","3","+","|"
]);
test('Should return valid postfix (2)', returns,
`\\prod_{i=2k+1}^{3k}{2i+3}`, [
  "prod",
  "i",
  "2","k","*","1","+","|",
  "3","k","*","|",
  "2","i","*","3","+","|"
]);