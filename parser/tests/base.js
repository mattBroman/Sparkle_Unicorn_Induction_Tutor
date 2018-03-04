import test from 'ava';
import parser from '../parser';
import util from './common';

const { pass, fail } = util('BaseCase');

test('foo', pass, "\begin{base} \end{base}");
test('foo8', fail, "\\begin{bas} \\end{base}");
