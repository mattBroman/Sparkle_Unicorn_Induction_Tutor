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
test('Returns valid schema (2)', returns,
`\\begin{proof}
Let n = k+1
\\end{proof}`,{
  assumptions: {
    "n":["k","1","+"]
  },
  pre: null,
  is: null,
  post: null
});
test('Returns valid schema (3)', returns,
`\\begin{proof}
k + k = 2k
\\end{proof}`,{
  assumptions: null,
  pre: [
    {
      left: ["k","k","+"],
      right: ["2","k","*"]
    }
  ],
  is: null,
  post: null
});
test('Returns valid schema (4)', returns,
`\\begin{proof}
\inductiveStep{= 19 - 7x}
\\end{proof}`,{
  assumptions: null,
  pre: null,
  is: {
   left: null,
   right: ["19","7","x","*","-"] 
  },
  post: null
});
test('Returns valid schema (5)', returns,
`\\begin{proof}
Let n = k+1
3=4
\\end{proof}`,{
  assumptions: {
    "n":["k","1","+"]
  },
  pre: [
    {
      left: ["3"],
      right: ["4"]
    }
  ],
  is: null,
  post: null
});
test('Returns valid schema (6)', returns,
`\\begin{proof}
Let n = k+1
\inductiveStep{=7}
\\end{proof}`,{
  assumptions: {
    "n":["k","1","+"]
  },
  pre: null,
  is: {
    left: null,
    right:["7"]
  },
  post: null
});
test('Returns valid schema (7)', returns,
`\\begin{proof}
3=4
\inductiveStep{3=4}
\\end{proof}`,{
  assumptions: null,
  pre: [
    {
      left: ["3"],
      right: ["4"] 
    }
  ],
  is: {
    left: ["3"],
    right:["4"]
  },
  post: null
});
test('Returns valid schema (8)', returns,
`\\begin{proof}
Let n = k+1
let x = 1
13=8x
\inductiveStep{=7+5}
\\end{proof}`,{
  assumptions: {
    "n":["k","1","+"],
    "x":["1"]
  },
  pre: [
    {
      left: ["13"],
      right: ["8","x","*"] 
    }
  ],
  is: {
    left: null,
    right:["7","5","+"]
  },
  post: null
});
test('Returns valid schema (9)', returns,
`\\begin{proof}
\inductiveStep{=7+5}
=9x
=13y
=2z
\\end{proof}`,{
  assumptions: null,
  pre: null,
  is: {
    left: null,
    right:["7","5","+"]
  },
  post: [
    {
      left: null,
      right: ["9","x","*"]
    },
    {
      left: null,
      right: ["13","y","*"]
    },
    {
      left: null,
      right: ["2","z","*"]
    }
  ]
});