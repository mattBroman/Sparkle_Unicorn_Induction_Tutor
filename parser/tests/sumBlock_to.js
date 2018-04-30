import test from 'ava';
import parser from '../parser';
import util from './_common';

const { pass, fail, returns } = util('_SumBlock_To');

test('Should accept valid input (1)', pass,
`^{13}`);
test('Should accept valid input (2)', pass,
`^{2k + 1}`);

test('Should reject invalid input (1)', fail,
`^{13 = 14}`);
test('Should reject invalid input (2)', fail,
`^{}`);

test('Should return array of tokens (1)', returns,
`^{13}`, ["13"]);
test('Should return array of tokens (2)', returns,
`^{2k + 1}`, ["2","k","*","1","+"]);