import test from 'ava';
import parser from '../parser';
import util from './_common';

const { pass, fail, returns } = util('_UseIHBlock');

test('Accept expression with identifier (1)', pass,
`\\useIH{3 = 2x}`);
test('Accept expression with identifier (2)', pass,
`\\useIH{= 2y-13}`);

test('Reject incomplete identifier (1)', fail,
`\\useIH{2x}`);
test('Reject incomplete identifier (2)', fail,
`\\useIH{3 = }`);

test('Returns proper schema (1)', returns,
`\\useIH{3 = 2x}`,{
  left: ["3"],
  right: ["2","x","*"]
});
test('Returns proper schema (2)', returns,
`\\useIH{= 2y - 13}`,{
  left: null,
  right: ["2","y","*","13","-"]
});

