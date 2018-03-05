import test from 'ava';
import parser from '../parser';
import util from './common';

const { pass, fail } = util('BaseCase');




test('line by line w/ graph', pass, `
    \\begin{base} 
    let b = 3
    3 = 3
    \\end{base}
`);

test('multiple lines w/ graph', pass, `
    \\begin{base} 
    
    let b = 3
    3=3
    \\end{base}
`);


test('line by line w/ graphs', pass, `
    \\begin{base} 
    let b = 3
    3=3
    4=4
    5=5
    \\end{base}
`);

test('multiple lines w/ graphs', pass, `
    \\begin{base} 
    
    let b = 3
    
    3=3
    
    4=4
    
    5=5
    
    6=6
    
    \\end{base}
`);


test('line by line w/ graphs, non =', pass, `


    \\begin{base} 
    let b = 3
    3 > 3
    4 = 4
    5 < 5
    \\end{base}
`);

test('multiple lines w/ graphs, non =', pass, 

`
    \\begin{base} 
    
    let y = 3
    
    3 \\leq 3
    
    4 \\geq 4
    
    5 <5
      = 5
    
    6 = 6
    = 7
    
    \\end{base}
`);


test('lengthy variable name', fail, `
    \\begin{base} 
    
    let bb = 3
    
    \\end{base}
`);


test('too many spaces with varaible name', fail, `
    \\begin{base} 
    
    let bb =3
    
    \\end{base}
`);

test('multi line but wrong graph structure', fail, 

`
    \\begin{base} 
    
    let y = 3
    
    3 \\leq 3
    
    4 \\geq 4
    
    5 <5
      > 5
    
    6 = 6
    = 7
    
    \\end{base}
`);

test('empty', fail, "\\begin{bas} \\end{base}");
