import test from 'ava';
import parser from '../parser';
import util from './common';

const { pass, fail } = util('Term');

test('Multiply', pass, "2*2");
test('Divide', pass, "2/4");

test('Multiply', fail, "2**2");
test('Divide', fail, "2/4/");

test('Multiply spaces', pass, "2  * 2");
test('Divide spaces', pass, "2/      4");
