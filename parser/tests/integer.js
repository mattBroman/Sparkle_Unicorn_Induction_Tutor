import test from 'ava';
import parser from '../parser';
import { pass, fail } from './common';


const token = "Integer";

test('foo', pass, token, "234");
test('foo8', fail, token, "a");