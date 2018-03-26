import test from 'ava';
import parser from '../parser';
import util from './_common';

const { pass, fail, returns } = util('_');

test('Accept valid whitespace (1)', pass, ` `);
test('Accept valid whitespace (2)', pass, `\t`);
test('Accept valid whitespace (3)', pass, `\n`);
test('Accept valid whitespace (4)', pass, `\r`);

test('Reject multiple whitespace characters (1)', fail, `  `);
test('Reject multiple whitespace characters (2)', fail, `\t\t`);
test('Reject multiple whitespace characters (3)', fail, `\n\n`);
test('Reject multiple whitespace characters (4)', fail, `\r\r`);