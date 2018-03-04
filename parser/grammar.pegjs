// Simple Arithmetics Grammar
// ==========================
//
// Accepts expressions like "2 * (3 + 4)" and computes their value.

// Example pulled from pegjs.com/online
// To compile do 'npm run build'
// To test do 'npm run test'
  
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
              