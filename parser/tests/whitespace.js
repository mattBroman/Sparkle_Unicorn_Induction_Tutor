import test from 'ava';
import parser from '../parser';
import util from './common';

const { pass, fail } = util('_');

test('no space', fail, "");
test('spaces', pass, " ");
test('newline', pass, "\n");

