import test from 'ava';
import parser from '../parser';
import util from './common';

const { pass, fail } = util('Factor');

test('Variable', pass, "x");
test('Number', pass, "12");

test('Variable', fail, "+");
test('Variable', fail, "%");

