import test from 'ava';
import parser from '../parser';
import { pass, fail } from './common';

const token = "Variable";

test("vartest a", pass, token, "a");
test("vartest A", pass, token, "A");
test('vartest Z', pass, token, "Z");
test("vartest 1", fail, token, "1");
test("vartest a1", fail, token, "a1");

// full test
//for(var letter in "abdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ") {
//    test("vartest " + letter,pass,token,letter);
//}
//for(var num in "0123456789+-_=/\|]}[{;:.>,<") {
//    test("vartest " + num,fail,token,num);
//}

test('word test', fail, token, 'failure')