import test from 'ava';
import {PostfixToInfix} from '../json-latex.js'



test("postfix to infix (1)", t => {
    const expected = "2+2";
    const actual = PostfixToInfix(["2","2","+"]);
    t.is(actual, expected);
});
    
    
test("postfix to infix (2)", t => {
    const expected ="k+2";
    const actual = PostfixToInfix(["k","2","+"]);
    t.is(actual, expected);
}); 
    
    
test("postfix to infix (3)", t => {
    const expected = "(2+2)*5";
    const actual = PostfixToInfix(["2","2","+","5","*"]);
    t.is(actual, expected);
}); 



test("postfix to infix (4)", t => {
    const expected = "\\sum_{i=0}^{n}{i}+2";
    const actual = PostfixToInfix(["sum","i","0","|","n","|","i","|","2","+"]);
    t.is(actual, expected);
}); 

test("postfix to infix (5)", t => {
    const expected = "\\prod_{i=0}^{n}{i}+2";
    const actual = PostfixToInfix(["prod","i","0","|","n","|","i","|","2","+"]);
    t.is(actual, expected);
}); 

test("postfix to infix (5)", t => {
    const expected = "\\sum_{i=0}^{n}{\\prod_{j=1}^{n}{j*i}}+2";
    const actual = PostfixToInfix(["sum","i","0","|","n","|","i","|","2","+"]);
    t.is(actual, expected);
}); 
