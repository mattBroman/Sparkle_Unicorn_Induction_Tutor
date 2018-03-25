import test from 'ava';
import parser from '../parser';
import util from './common';

const { pass, fail, returns } = util('_Expression');

test('Accepts as expressions (1)', pass, "10 - 13");
test('Accepts as expressions (2)', pass, "10 + 13");
test('Accepts as expressions (3)', pass, "10 - 13 + 27 - 30");