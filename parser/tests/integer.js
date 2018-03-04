import test from 'ava';
import parser from '../parser';
import util from './common';

const { pass, fail } = util('Integer');

test('foo', pass, "234");
test('foo8', fail, "a");