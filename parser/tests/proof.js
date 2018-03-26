import test from 'ava';
import parser from '../parser';
import util from './_common';

const { pass, fail, returns } = util('_Proof');

test('Accepts empty input', pass, "");
test('Accepts whitespace padded base case', pass, 
`

\begin{base}
\end{base}

`);
test('Accepts valid base case', pass, 
`\begin{base}
Let x = 4
3 = 4
\end{base}`);

test('Returns valid schema (1)', returns, 
``,
{
  baseCase: null
});
test('Returns valid schema (2)', returns, 
`

\begin{base}
\end{base}

`,
{
  baseCase: {
    assumptions: null,
    equivalenceExpressions: null
  }
});
test('Returns valid schema (3)', returns, 
`\begin{base}
Let x = 4
3 = 4
\end{base}`,
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
  }
});