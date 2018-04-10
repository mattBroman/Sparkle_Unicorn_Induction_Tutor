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
test('Accepts whitespace padded inductive hypothesis', pass,
`
\\begin{inductiveHypothesis}
\\end{inductiveHypothesis}

`);
test('Accepts valid inductive hypothesis', pass,
`\\begin{inductiveHypothesis}
Let x = 4
3 = 4
\\end{inductiveHypothesis}`);
test('Accepts valid input (1)', pass,
`
\\begin{base}
\\end{base}
\\begin{inductiveHypothesis}
\\end{inductiveHypothesis}`);

test('Rejects invalid ordering (1)', fail, 
`\\begin{inductiveHypothesis}
\\end{inductiveHypothesis}
\\begin{base}
\\end{base}`);

test('Returns valid schema (1)', returns, 
``,
{
  baseCase: null,
  inductiveHypothesis: null
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
  inductiveHypothesis: null
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
  inductiveHypothesis: null
});
test('Returns valid schema (4)', returns,
`
\\begin{inductiveHypothesis}
\\end{inductiveHypothesis}

`,{
  baseCase: null,
  inductiveHypothesis: {
    assumptions: null,
    hypothesis: null
  }
});
test('Returns valid schema (5)', returns,
`\\begin{inductiveHypothesis}
Let x = 4
3 = 4
\\end{inductiveHypothesis}`,{
  baseCase: null,
  inductiveHypothesis: {
    assumptions: {
      "x":["4"]
    },
    hypothesis: {
      left: ["3"],
      right: ["4"]
    }
  }
});
test('Returns valid schema (4)', returns,
`
\\begin{base}
\\end{base}
\\begin{inductiveHypothesis}
\\end{inductiveHypothesis}`,{
  baseCase: {
    assumptions: null,
    equivalenceExpressions: null
  },
  inductiveHypothesis: {
    assumptions: null,
    hypothesis: null
  }
});