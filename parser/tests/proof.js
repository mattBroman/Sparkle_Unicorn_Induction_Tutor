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
test('Accepts whitespace padded proof block', pass,
`
\\begin{proof}
\\end{proof}

`);
test('Accepts valid proof block', pass,
`\\begin{proof}
Let n = k+1
13*(k+1) = 13k + 13
\inductiveStep{=2k}
=14
\\end{proof}`);
test('Accepts valid input (1)', pass,
`
\\begin{base}
\\end{base}
\\begin{inductiveHypothesis}
\\end{inductiveHypothesis}
\\begin{proof}
\\end{proof}`);
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
\\begin{inductiveHypothesis}
Let n = k
3k - 18 = 4k
\\end{inductiveHypothesis}
\\begin{proof}
let n = k + 1
3 = 4
\inductiveStep{=7}
=9
\\end{proof}`);

test('Rejects invalid ordering (1)', fail, 
`\\begin{inductiveHypothesis}
\\end{inductiveHypothesis}
\\begin{base}
\\end{base}`);
test('Rejects invalid ordering (2)', fail, 
`\\begin{proof}
\\end{proof}
\\begin{base}
\\end{base}`);
test('Rejects invalid ordering (3)', fail, 
`\\begin{proof}
\\end{proof}
\\begin{inductiveHypothesis}
\\end{inductiveHypothesis}`);

test('Returns valid schema (1)', returns, 
``,
{
  baseCase: null,
  inductiveHypothesis: null,
  proof: null
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
  inductiveHypothesis: null,
  proof: null
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
  inductiveHypothesis: null,
  proof: null
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
  },
  proof: null
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
  },
  proof: null
});
test('Returns valid schema (6)', returns,
`
\\begin{base}
\\end{base}
\\begin{inductiveHypothesis}
\\end{inductiveHypothesis}
\\begin{proof}
\\end{proof}`,{
  baseCase: {
    assumptions: null,
    equivalenceExpressions: null
  },
  inductiveHypothesis: {
    assumptions: null,
    hypothesis: null
  },
  proof: {
    assumptions: null,
    pre: null,
    is: null,
    post: null
  }
});
test('Returns valid schema (7)', returns,
`
\\begin{proof}
\\end{proof}

`,{
  baseCase:  null,
  inductiveHypothesis: null,
  proof: {
    assumptions: null,
    pre: null,
    is: null,
    post: null
  }
});
test('Returns valid schema (8)', returns,
`\\begin{proof}
Let n = k+1
13*(k+1) = 13k + 13
\inductiveStep{=2k}
=14
\\end{proof}`,{
  baseCase:  null,
  inductiveHypothesis: null,
  proof: {
    assumptions: {
      "n":["k","1","+"]
    },
    pre: [
      {
        left: ["13","k","1","+","*"],
        right: ["13","k","*","13","+"]
      }
    ],
    is: {
      left:null,
      right: ["2","k","*"]
    },
    post: [
      {
        left: null,
        right: ["14"]
      }
    ]
  }
});
test('Returns valid schema (9)', returns,
`
\\begin{base}
Let n = 1
3n - 18 = 3*1 - 18
= 3 - 18
= -15
4n = 4 * 1
= 4
\\end{base}
\\begin{inductiveHypothesis}
Let n = k
3k - 18 = 4k
\\end{inductiveHypothesis}
\\begin{proof}
let n = k + 1
3 = 4
\inductiveStep{=7}
=9
\\end{proof}`,{
  baseCase: {
    assumptions: {
      "n":["1"]
    },
    equivalenceExpressions: [
      {
        left: ["3","n","*","18","-"],
        right: ["3","1","*","18","-"]
      },
      {
        left: null,
        right: ["3","18","-"]
      },
      {
        left: null,
        right: ["-15"]
      },
      {
        left: ["4","n","*"],
        right: ["4","1","*"]
      },
      {
        left: null,
        right: ["4"]
      }
    ]
  },
  inductiveHypothesis: {
    assumptions: {
      "n":["k"]
    },
    hypothesis: {
      left: ["3","k","*","18","-"],
      right: ["4","k","*"]
    }
  },
  proof: {
    assumptions: {
      "n": ["k","1","+"]
    },
    pre: [
      {
        left: ["3"],
        right: ["4"]
      }
    ],
    is: {
      left: null,
      right: ["7"]
    },
    post: [
      {
        left: null,
        right: ["9"]
      }
    ]
  }
});