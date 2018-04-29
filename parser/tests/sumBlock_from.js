import test from 'ava';
import parser from '../parser';
import util from './_common';

const { pass, fail, returns } = util('_SumBlock_From');

test('Should accept a valid input (1)', pass, 
`_{j=13}`);
test('Should accept a valid input (2)', pass, 
`_{ i = 2k + 1 }`);

test('Should reject invalid input (1)', fail,
`_{j=}`);
test('Should reject invalid input (2)', fail,
`_{=13}`);

test('Should return an array of tokens (1)', returns,
`_{j=13}`,["j","13"]);
test('Should return an array of tokens (2)', returns,
`_{ i = 2k + 1}`,["i","2","k","*","1","+"]);
