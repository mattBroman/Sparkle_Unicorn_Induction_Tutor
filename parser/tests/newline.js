import test from 'ava';
import parser from '../parser';
import util from './_common';

const { pass, fail, returns } = util('_Newline');

test('Accept valid whitespace (1)', pass, `\n`);
test('Accept valid whitespace (2)', pass, `\r`);

test('Reject multiple whitespace characters (1)', fail, `\n\n`);
test('Reject multiple whitespace characters (2)', fail, `\r\r`);