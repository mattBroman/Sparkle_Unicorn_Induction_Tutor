import test from 'ava';
import parser from '../parser';
import util from './_common';

const { pass, fail, returns } = util('_ShowBlock');

test('Accept expression with identifier (1)', pass,
`\\show{3 = 2x}`);
test('Accept expression with identifier (2)', pass,
`\\show{= 2y-13}`);

test('Reject incomplete identifier (1)', fail,
`\\show{2x}`);
test('Reject incomplete identifier (2)', fail,
`\\show{3 = }`);

test('Returns proper schema (1)', returns,
`\\show{3 = 2x}`,{
  left: ["3"],
  right: ["2","x","*"]
});
test('Returns proper schema (2)', returns,
`\\show{= 2y - 13}`,{
  left: null,
  right: ["2","y","*","13","-"]
});

