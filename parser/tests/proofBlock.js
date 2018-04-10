import test from 'ava';
import parser from '../parser';
import util from './_common';

const { pass, fail, returns } = util('_ProofBlock');

test('Accept empty environment', pass,
`\\begin{proof}
\\end{proof}`);
test('Accept one assumption', pass,
`\\begin{proof}
Let n = k+1
\\end{proof}`);
test('Accept one equivalence expression', pass,
`\\begin{proof}
k + k = 2k
\\end{proof}`);
test('Accept one inductive step', pass,
`\\begin{proof}
\inductiveStep{= 19 - 7x}
\\end{proof}`);
test('Accept valid input (1)', pass,
`\\begin{proof}
Let n = k+1
3=4
\\end{proof}`);
test('Accept valid input (2)', pass,
`\\begin{proof}
Let n = k+1
\inductiveStep{=7}
\\end{proof}`);
test('Accept valid input (3)', pass,
`\\begin{proof}
3=4
\inductiveStep{3=4}
\\end{proof}`);
test('Accept valid input (4)', pass,
`\\begin{proof}
Let n = k+1
let x = 1
13=8x
\inductiveStep{=7+5}
\\end{proof}`);
test('Accept valid input (5)', pass,
`\\begin{proof}
Let n = k+1
13=8x
=19y
=z
\inductiveStep{=7+5}
\\end{proof}`);
test('Accept valid input (6)', pass,
`\\begin{proof}
Let n = k+1
13=8x
\inductiveStep{=7+5}
=9x
\\end{proof}`);
test('Accept valid input (7)', pass,
`\\begin{proof}
\inductiveStep{=7+5}
=9x
=13y
=2z
\\end{proof}`);

test('Reject multiple inductive steps', fail,
`\\begin{proof}
\inductiveStep{3=3x}
\inductiveStep{=4x}
\\end{proof}`);

test('Returns valid schema (1)', returns,
`\\begin{proof}
\\end{proof}`,{
  assumptions: null,
  pre: null,
  is: null,
  post: null
});