import test from 'ava';
import parser from '../parser';
import { pass, fail } from './common';


const token = "Factor";




test('Variable', pass, token, "x");
test('Subtract', pass, token, "2-4");

test('Add', fail, token, "22+");
test('Subtract', fail, token, "2-4 -");

test('Add Spaces', pass, token, "2+     3");
test('Subtract Spaces', pass, token, "2 -4");