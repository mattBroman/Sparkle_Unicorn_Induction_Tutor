import test from 'ava';
import parser from '../parser';
import { pass, fail } from './common';


const token = "_";

test('no space', fail, token, "");
test('spaces', pass, token, " ");
test('newline', pass, token, "\n");

