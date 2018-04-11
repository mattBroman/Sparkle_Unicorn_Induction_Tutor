import test from 'ava';
import parser from '../parser';
import util from './_common';

const { pass, fail, returns } = util('_InductiveStep');

test('Accept expression with identifier (1)', pass,
`\inductiveStep{3 = 2x}`);
test('Accept expression with identifier (2)', pass,
`\inductiveStep{= 2y - 13}`);
test('Accepts expression without spaces', pass,
`\inductiveStep{14=17}`)

test('Reject incomplete identifier (1)', fail, 
`\inductiveStep{2x}`);
test('Reject incomplete identifier (2)', fail, 
`\inductiveStep{3 = }`);

test('Returns proper schema (1)', returns,
`\inductiveStep{3 = 2x}`,{
  left: ["3"],
  right: ["2","x","*"]
});
test('Returns proper schema (2)', returns,
`\inductiveStep{= 2y - 13}`,{
  left: null,
  right: ["2","y","*","13","-"]
});
test('Returns proper schema (3)', returns,
`\inductiveStep{14=17}`,{
  left: ["14"],
  right: ["17"]
});
