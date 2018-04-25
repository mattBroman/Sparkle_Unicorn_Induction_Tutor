import test from 'ava';
import parser from '../parser';
import util from './_common';

const { pass, fail, returns } = util('_InductiveStep');

test('Accept empty environment', pass, 
`\\begin{inductiveStep}
\\end{inductiveStep}`);
test('Accept assume block', pass,
`\\begin{inductiveStep}
\\assume{n+n=2n}
\\end{inductiveStep}`);
test('Accept show block', pass,
`\\begin{inductiveStep}
\\show{n+1+n+1=2*(n+1)}
\\end{inductiveStep}`);
test('Accept one equivalence expression', pass,
`\\begin{inductiveStep}
13y - 7 = 19
\\end{inductiveStep}`);
test('Accept use IH block', pass,
`\\begin{inductiveStep}
\\useIH{=13x}
\\end{inductiveStep}`);
test('Accept valid input (1)', pass,
`\\begin{inductiveStep}
\\assume{13y=14}
\\show{13x=97}
\\end{inductiveStep}`);
test('Accept valid input (2)', pass,
`\\begin{inductiveStep}
\\assume{13y=14}
4y=2z
\\end{inductiveStep}`);
test('Accept valid input (3)', pass,
`\\begin{inductiveStep}
4y=2z
\\useIH{=3z}
5x+9=2z-5
\\end{inductiveStep}`);
test('Accept valid input (4)', pass,
`\\begin{inductiveStep}
\\show{8*(13+4z)=9}
4y=2z
\\useIH{=3z}
5x+9=2z-5
\\end{inductiveStep}`);
test('Accept valid input (5)', pass,
`\\begin{inductiveStep}
\\assume{9=10}
\\show{8*(13+4z)=9}
4y=2z
9=10
\\useIH{=3z}
5x+9=2z-5
9=10
\\end{inductiveStep}`);

test('Reject multiple assume blocks', fail,
`\\begin{inductiveStep}
\\assume{=5}
\\assume{=6}
\\end{inductiveStep}`);
test('Reject multiple show blocks', fail,
`\\begin{inductiveStep}
\\show{=5}
\\show{=6}
\\end{inductiveStep}`);
test('Reject multiple use IH blocks', fail,
`\\begin{inductiveStep}
\\useIH{=5}
\\useIH{=6}
\\end{inductiveStep}`);
test('Reject invalid ordering (1)', fail,
`\\begin{inductiveStep}
\\show{=5}
\\assume{=5}
\\end{inductiveStep}`);
test('Reject invalid ordering (2)', fail,
`\\begin{inductiveStep}
3x=4x
\\assume{=5}
\\end{inductiveStep}`);
test('Reject invalid ordering (3)', fail,
`\\begin{inductiveStep}
\\useIH{=5}
\\assume{=5}
\\end{inductiveStep}`);
test('Reject invalid ordering (4)', fail,
`\\begin{inductiveStep}
\\3x=5
\\show{=5}
\\end{inductiveStep}`);
test('Reject invalid ordering (5)', fail,
`\\begin{inductiveStep}
\\useIH{=5}
\\show{=5}
\\end{inductiveStep}`);

test('Returns valid schema (1)', returns,
`\\begin{inductiveStep}
\\end{inductiveStep}`, {
  hypothesis: null,
  show: null,
  pre: null,
  uih: null,
  post: null
});
test('Returns valid schema (2)', returns,
`\\begin{inductiveStep}
\\assume{n+n=2n}
\\end{inductiveStep}`, {
  hypothesis: {
    left: ["n","n","+"],
    right: ["2","n","*"]
  },
  show: null,
  pre: null,
  uih: null,
  post: null
});
test('Returns valid schema (3)', returns,
`\\begin{inductiveStep}
\\show{n+1+n+1=2*(n+1)}
\\end{inductiveStep}`, {
  hypothesis: null,
  show: {
    left: ["n","1","+","n","+","1","+"],
    right: ["2","n","1","+","*"]
  },
  pre: null,
  uih: null,
  post: null
});
test('Returns valid schema (4)', returns,
`\\begin{inductiveStep}
13y - 7 = 19
\\end{inductiveStep}`, {
  hypothesis: null,
  show: null,
  pre: [
   {
     left: ["13","y","*","7","-"],
     right: ["19"]
   } 
  ],
  uih: null,
  post: null
});
test('Returns valid schema (5)', returns,
`\\begin{inductiveStep}
\\useIH{=13x}
\\end{inductiveStep}`, {
  hypothesis: null,
  show: null,
  pre: null,
  uih: {
    left: null,
    right: ["13","x","*"]
  },
  post: null
});
test('Returns valid schema (6)', returns,
`\\begin{inductiveStep}
\\assume{13y=14}
\\show{13x=97}
\\end{inductiveStep}`, {
  hypothesis: {
    left: ["13","y","*"],
    right: ["14"]
  },
  show: {
    left: ["13","x","*"],
    right: ["97"]
  },
  pre: null,
  uih: null,
  post: null
});
test('Returns valid schema (7)', returns,
`\\begin{inductiveStep}
\\assume{13y=14}
4y=2z
\\end{inductiveStep}`, {
  hypothesis: {
    left: ["13","y","*"],
    right: ["14"]
  },
  show: null,
  pre: [
    {
      left: ["4","y","*"],
      right: ["2","z","*"]
    }
  ],
  uih: null,
  post: null
});
test('Returns valid schema (8)', returns,
`\\begin{inductiveStep}
4y=2z
\\useIH{=3z}
5x+9=2z-5
\\end{inductiveStep}`, {
  hypothesis: null,
  show: null,
  pre: [
    {
      left: ["4","y","*"],
      right: ["2","z","*"]
    }
  ],
  uih: {
    left: null,
    right: ["3","z","*"]
  },
  post: [
    {
      left: ["5","x","*","9","+"],
      right: ["2","z","*","5","-"]
    }
  ]
});
test('Returns valid schema (9)', returns,
`\\begin{inductiveStep}
\\show{8*(13+4z)=9}
4y=2z
\\useIH{=3z}
5x+9=2z-5
\\end{inductiveStep}`, {
  hypothesis: null,
  show: {
    left: ["8","13","4","z","*","+","*"],
    right: ["9"]
  },
  pre: [
    {
      left: ["4","y","*"],
      right: ["2","z","*"]
    }
  ],
  uih: {
    left: null,
    right: ["3","z","*"]
  },
  post: [
    {
      left: ["5","x","*","9","+"],
      right: ["2","z","*","5","-"]
    }
  ]
});
test('Returns valid schema (10)', returns,
`\\begin{inductiveStep}
\\assume{9=10}
\\show{8*(13+4z)=9}
4y=2z
9=10
\\useIH{=3z}
5x+9=2z-5
9=10
\\end{inductiveStep}`, {
  hypothesis: {
    left: ["9"],
    right: ["10"]
  },
  show: {
    left: ["8","13","4","z","*","+","*"],
    right: ["9"]
  },
  pre: [
    {
      left: ["4","y","*"],
      right: ["2","z","*"]
    },{
      left: ["9"],
      right: ["10"]
    }
  ],
  uih: {
    left: null,
    right: ["3","z","*"]
  },
  post: [
    {
      left: ["5","x","*","9","+"],
      right: ["2","z","*","5","-"]
    },{
      left: ["9"],
      right: ["10"]
    }
  ]
});
