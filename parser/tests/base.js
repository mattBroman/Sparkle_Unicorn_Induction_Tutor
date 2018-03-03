import test from 'ava';
import parser from '../parser';
import { pass, fail } from './common';

const token = "BaseCase";

test('foo', pass, token, "\begin{base} \end{base}");
test('foo8', fail, token, "\\begin{bas} \\end{base}");
