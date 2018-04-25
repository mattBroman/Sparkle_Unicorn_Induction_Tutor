import test from 'ava';
import parser from '../parser';
import util from './_common';

const { pass, fail, returns } = util('_AssumeBlock');

test('Accept expression with identifier (1)', pass,
`\\assume{3 = 2x}`);
test('Accept expression with identifier (2)', pass,
`\\assume{= 2y-13}`);

test('Reject incomplete identifier (1)', fail,
`\\assume{2x}`);
test('Reject incomplete identifier (2)', fail,
`\\assume{3 = }`);

test('Returns proper schema (1)', returns,
`\\assume{3 = 2x}`,{
  left: ["3"],
  right: ["2","x","*"]
});
test('Returns proper schema (2)', returns,
`\\assume{= 2y - 13}`,{
  left: null,
  right: ["2","y","*","13","-"]
});

