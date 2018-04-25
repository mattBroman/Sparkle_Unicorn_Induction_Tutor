import test from 'ava';
import parser from '../parser';
import util from './_common';

const { pass, fail, returns } = util('_Root');

test('Accepts no input', pass, ``);
test('Accepts one assumption', pass, `Let x = 4`);
test('Accepts one equivalence expression', pass, `3 = 4`);
test('Accepts one expression', pass, `3+4`);
test('Accepts one term', pass, `13`);
test('Accepts one proof', pass, 
`\\begin{base}
\\end{base}
\\begin{inductiveStep}
\\end{inductiveStep}`);

test('Returns valid schema (1)', returns,
``,
{
  baseCase: null,
  inductiveStep: null
});
test('Returns valid schema (2)', returns,
`Let x = 4`,
{
  "x":["4"]
});
test('Returns valid schema (3)', returns,
`3 = 4`,
{
  left: ["3"],
  right: ["4"]
});
test('Returns valid schema (4)', returns,
`3+4`,
["3","4","+"]);
test('Returns valid schema (5)', returns,
`13`,
["13"]);
test('Returns valid schema (6)', returns,
`\\begin{base}
\\end{base}
\\begin{inductiveStep}
\\end{inductiveStep}`,
{
  baseCase: {
    assumptions: null,
    equivalenceExpressions: null
  },
  inductiveStep: {
    hypothesis: null,
    show: null,
    pre: null,
    uih: null,
    post: null
  },
});