import test from 'ava';
import parser from '../parser';
import util from './_common';

const { pass, fail, returns } = util('_Proof');

test('Accepts empty input', pass, "");
test('Accepts whitespace padded base case', pass, 
`
\\begin{base}
\\end{base}

`);
test('Accepts valid base case', pass, 
`\\begin{base}
Let x = 4
3 = 4
\\end{base}`);
test('Accepts whitespace padded inductive step block', pass,
`
\\begin{inductiveStep}
\\end{inductiveStep}

`);
test('Accepts valid inductive step block', pass,
`\\begin{inductiveStep}
\\assume{=4}
\\show{=4}
4=4
\\useIH{=4}
4=4
\\end{inductiveStep}`);
test('Accepts valid input (1)', pass,
`
\\begin{base}
\\end{base}
\\begin{inductiveStep}
\\end{inductiveStep}`);
test('Accepts valid input (2)', pass,
`
\\begin{base}
Let n = 1
3n - 18 = 3*1 - 18
= 3 - 18
= -15
4n = 4 * 1
= 4
\\end{base}
\\begin{inductiveStep}
\\assume{n+n=2n}
\\show{n+1+n+1=2*(n+1)}
\\useIH{n+1+n+1=2n+2}
=2*(n+1) 
\\end{inductiveStep}`);

test('Rejects invalid ordering', fail, 
`\\begin{inductiveStep}
\\end{inductiveStep}
\\begin{base}
\\end{base}`);

test('Returns valid schema (1)', returns, 
``,
{
  baseCase: null,
  inductiveStep: null
});
test('Returns valid schema (2)', returns, 
`

\\begin{base}
\\end{base}

`,
{
  baseCase: {
    assumptions: null,
    equivalenceExpressions: null
  },
  inductiveStep: null
});
test('Returns valid schema (3)', returns, 
`\\begin{base}
Let x = 4
3 = 4
\\end{base}`,
{
  baseCase: {
    assumptions: {
      "x":["4"]
    },
    equivalenceExpressions: [
      {
        left: ["3"],
        right: ["4"]
      }
    ]
  },
  inductiveStep: null
});
test('Returns valid schema (4)', returns,
`
\\begin{inductiveStep}
\\end{inductiveStep}

`,{
  baseCase: null,
  inductiveStep: {
    hypothesis: null,
    show: null,
    pre: null,
    uih: null,
    post: null
  }
});
test('Returns valid schema (5)', returns,
`\\begin{inductiveStep}
3 = 4
\\useIH{=5}
\\end{inductiveStep}`,{
  baseCase: null,
  inductiveStep: {
    hypothesis: null,
    show: null,
    pre: [
      {
        left: ["3"],
        right: ["4"]
      }
    ],
    uih: {
      left: null,
      right: ["5"]
    },
    post: null
  }
});