import test from 'ava';
import parser from '../parser';
import { pass, fail } from './common';


const token = "Term";


test('Multiply', pass, token, "2*2");
test('Divide', pass, token, "2/4");

test('Multiply', fail, token, "2**2");
test('Divide', fail, token, "2/4/");

test('Multiply spaces', pass, token, "2  * 2");
test('Divide spaces', pass, token, "2/      4");
