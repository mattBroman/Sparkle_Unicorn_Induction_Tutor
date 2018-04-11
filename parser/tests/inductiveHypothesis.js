import test from 'ava';
import parser from '../parser';
import util from './_common';

const { pass, fail, returns } = util('_InductiveHypothesis');

test('Accept empty environment', pass,
`\\begin{inductiveHypothesis}
\\end{inductiveHypothesis}`);
test('Accept one assumption', pass,
`\\begin{inductiveHypothesis}
Let n = k
\\end{inductiveHypothesis}`);
test('Accept one equivalence expression', pass,
`\\begin{inductiveHypothesis}
k+k=2k
\\end{inductiveHypothesis}`);
test('Accept valid inductive hypothesis (1)', pass,
`\\begin{inductiveHypothesis}
Let n = 4
4 = 4
\\end{inductiveHypothesis}`);
test('Accept valid inductive hypothesis (2)', pass,
`\\begin{inductiveHypothesis}
Let n = 4
Let x = 16
4 = 4
\\end{inductiveHypothesis}`);

test('Reject incomplete environment (1)', fail,
`\\begin{inductiveHypothesis}`);
test('Reject incomplete environment (2)', fail,
`\\begin{inductiveHypothesis}
`);
test('Reject incomplete environment (3)', fail,
`\\end{inductiveHypothesis}`);
test('Reject multiple equivalence expressions', fail, 
`\\begin{inductiveHypothesis}
Let n = 4
Let k = 13
3 = 4
4 = 5
\\end{inductiveHypothesis}`);

test('Returns valid schema (1)', returns,
`\\begin{inductiveHypothesis}
\\end{inductiveHypothesis}`,{
  assumptions: null,
  hypothesis: null
});
test('Returns valid schema (2)', returns,
`\\begin{inductiveHypothesis}
Let x = 13
\\end{inductiveHypothesis}`,{
  assumptions: {
    "x":["13"]
  },
  hypothesis: null
});
test('Returns valid schema (3)', returns,
`\\begin{inductiveHypothesis}
x = 13
\\end{inductiveHypothesis}`,{
  assumptions: null,
  hypothesis: {
    left: ["x"],
    right: ["13"]
  }
});
test('Returns valid schema (4)', returns,
`\\begin{inductiveHypothesis}
Let x = 13
let b=k+1
x = 13
\\end{inductiveHypothesis}`,{
  assumptions: {
    "x":["13"],
    "b":["k","1","+"]
  },
  hypothesis: {
    left: ["x"],
    right: ["13"]
  }
});