import test from 'ava';
import parser from '../parser';
import util from './_common';

const { pass, fail, returns } = util('_SumBlock');

test('Should accept valid sum (1)', pass,
`\\sum_{i=13}^{k+1}{2i+3}`);
test('Should accept valid sum (2)', pass,
`\\sum_{i=2k+1}^{3k}{2i+3}`);

test('Should reject incomplete sum blocks (1)', fail,
`\\sum_{i=1}`);
test('Should reject incomplete sum blocks (2)', fail,
`\\sum^{1}`);
test('Should reject incomplete sum blocks (3)', fail,
`\\sum{i+1}`);
test('Should reject incomplete sum blocks (4)', fail,
`\\sum_{i=1}^{13}`);
test('Should reject incomplete sum blocks (5)', fail,
`\\sum^{i=1}{3i}`);
test('Should reject incomplete sum blocks (6)', fail,
`\\sum_{i=1}{3i}`);

test('Should return valid postfix (1)', returns,
`\\sum_{i=13}^{k+1}{2i+3}`, [
  "sum",
  "i",
  "13","|",
  "k","1","+","|",
  "2","i","*","3","+","|"
]);
test('Should return valid postfix (2)', returns,
`\\sum_{i=2k+1}^{3k}{2i+3}`, [
  "sum",
  "i",
  "2","k","*","1","+","|",
  "3","k","*","|",
  "2","i","*","3","+","|"
]);