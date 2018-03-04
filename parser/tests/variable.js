import test from 'ava';
import parser from '../parser';
import util from './common';

const { pass, fail } = util('Variable');

test("vartest a", pass, "a");
test("vartest A", pass, "A");
test('vartest Z', pass, "Z");
test("vartest 1", fail, "1");
test("vartest a1", fail, "a1");

// full test
//for(var letter in "abdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ") {
//    test("vartest " + letter,pass,token,letter);
//}
//for(var num in "0123456789+-_=/\|]}[{;:.>,<") {
//    test("vartest " + num,fail,token,num);
//}

test('word test', fail, 'failure')