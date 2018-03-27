import test from 'ava';
import parser from '../parser';
import util from './_common';

const { pass, fail, returns } = util('_BaseCase');

test('Accept empty environment', pass, 
`\\begin{base}
\\end{base}`);
test('Accept one assumption', pass, 
`\\begin{base}
Let x = 4
\\end{base}`);
test('Accept one equivalence expression', pass, 
`\\begin{base}
3 = 4

\\end{base}`);
test('Accept valid base case (1)', pass, 
`\\begin{base}
Let x = 4
3 = 4
\\end{base}`);
test('Accept valid base case (2)', pass, 
`\\begin{base}
Let x = 4
Let n = k+1
3 = 4
\\end{base}`);
test('Accept valid base case (3)', pass, 
`\\begin{base}
Let x = 4
3 = 4
= 6
\\end{base}`);
test('Accept valid base case (4)', pass, 
`\\begin{base}
Let x = 4
Let n = k+1
3 = 4
= 6
\\end{base}`);

test('Reject incomplete environment (1)', fail, 
`\\begin{base}`);
test('Reject incomplete environment (2)', fail, 
`\\begin{base}
`);
test('Reject incomplete environment (3)', fail, 
`\\end{base}`);

test('Returns valid schema (1)', returns, 
`\\begin{base}
\\end{base}`,
{
  assumptions: null,
  equivalenceExpressions: null
});
test('Returns valid schema (2)', returns, 
`\\begin{base}
Let x = 4
\\end{base}`,
{
  assumptions: {
    "x":["4"]
  },
  equivalenceExpressions: null
});
test('Returns valid schema (3)', returns, 
`\\begin{base}
3 = 4
\\end{base}`,
{
  assumptions: null,
  equivalenceExpressions: [
    {
      left: ["3"],
      right: ["4"]
    }
  ]
});
test('Returns valid schema (4)', returns, 
`\\begin{base}
Let x = 4
3 = 4
\\end{base}`,
{
  assumptions: {
    "x":["4"]
  },
  equivalenceExpressions: [
    {
      left: ["3"],
      right: ["4"]
    }
  ]
});
test('Returns valid schema (5)', returns, 
`\\begin{base}
Let x = 4
Let n = k+1
3 = 4
\\end{base}`,
{
  assumptions: {
    "x":["4"],
    "n":["k","1","+"]
  },
  equivalenceExpressions: [
    {
      left: ["3"],
      right: ["4"]
    }
  ]
});
test('Returns valid schema (6)', returns, 
`\\begin{base}
Let x = 4
3 = 4
= 6
\\end{base}`,
{
  assumptions: {
    "x":["4"]
  },
  equivalenceExpressions: [
    {
      left: ["3"],
      right: ["4"]
    },
    {
      left: null,
      right: ["6"]
    }
  ]
});
test('Returns valid schema (7)', returns, 
`\\begin{base}
Let x = 4
Let n = k+1
3 = 4
= 6
\\end{base}`,
{
  assumptions: {
    "x":["4"],
    "n":["k","1","+"]
  },
  equivalenceExpressions: [
    {
      left: ["3"],
      right: ["4"]
    },
    {
      left: null,
      right: ["6"]
    }
  ]
});