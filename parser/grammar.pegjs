// Simple Arithmetics Grammar
// ==========================
//
// Accepts expressions like "2 * (3 + 4)" and computes their value.

// Example pulled from pegjs.com/online
// To compile do 'npm run build'
// To test do 'npm run test'
//Grammar will be as follows
//<Proof> ::= <Basis><Induction>
//<Basis> ::= <LetN><Math>+
//<LetN> ::= 'let' <Variable> '=' <Number> (subject to change)
//<Math> ::= <Graph>+
//<Graph> ::= <Branch> | <Chain>
//<Branch> ::= <Expression><Comparison><Expression>
//<Chain> ::= <Expression><Equality><Expression> \n
                         (<Equality><Expression> \n)*

  
BaseCase
  = "\begin{base}" _* (Expressions)* _* "\end{base}"
  
Expressions 
  = Expression _* Equality _* Expression

Equality
  = "="

Expression
  = Term _* "+" _* Expression
  / Term _* "-" _* Expression
  / Term _* "%" _* Expression
  / Term

Term
  = Power _* "*" _* Term
  / Power _* "/" _* Term
  / Power

Power
  = Factor _* "^" _* Power
  / Factor

Factor
  = "(" _* Expression _* ")" 
  / Integer
  / Variable

Integer "integer"
  = [-]?[0-9]+

Variable "Variable"
  = [a-zA-Z]

_ "whitespace"
  = [ \t\n\r]
              