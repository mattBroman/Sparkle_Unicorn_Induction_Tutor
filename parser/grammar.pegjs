// Simple Arithmetics Grammar
// ==========================
//
// Accepts expressions like "2 * (3 + 4)" and computes their value.

// Example pulled from pegjs.com/online
// To compile do 'npm run build'
// To test do 'npm run test'
  
BaseCase
  = _* "\\begin{base}" _* BaseValue _* (Graph _*)+ _* "\\end{base}" _*

BaseValue
  = "let" _ Variable _ "=" _ Integer

Graph
  = Expression __* NonEqOp __* Expression (_* "=" __* Expression)*
  / Expression __* "=" __* Expression (_* "=" __* Expression)*

  

NonEqOp
  = "\\leq"
  / "\\geq"
  / "<"
  / ">"

Expression
  = Term __* "+" __* Expression
  / Term __* "-" __* Expression
  / Term __* "%" __* Expression
  / Term

Term
  = Power __* "*" __* Term
  / Power __* "/" __* Term
  / Power

Power
  = Factor __* "^" __* Power
  / Factor

Factor
  = "(" __* Expression __* ")" 
  / Integer
  / Variable

Integer "integer"
  = [-]?[0-9]+

Variable "Variable"
  = [a-zA-Z]

_ "whitespace"
  = [ \t\n\r]
              
__ "whitespace (no newlines)"
  = [ \t]
  
Newline 
  = [\n]


// Expression rules

_Expression
  = _Expression_AS
  / _Expression_MD
  / _Expression_E

_Expression_E
  = left:_Term " "? "^" " "? 
  	right:(_Expression_E/_Term) { 
    	return left.concat(right).concat("^"); 
    }

_Expression_MD
  = left:(_Expression_E/_Term)
    chain:(" "?
      op:("*"/"/") " "?
      right:(_Expression_E/_Term) {
        return right.concat(op);
      })+
    {
      return [].concat.apply(left,chain);
    }

_Expression_AS
  = left:(_Expression_MD/_Term) 
  	chain:(" "? 
    	op:("-"/"+") " "? 
      right:(_Expression_MD/_Term) { 
        return right.concat(op); 
      })+ 
    { 
   		return [].concat.apply(left,chain); 
    }

_Term
  = neg:"-"? 
  	prefix:
    	(first:[1-9] rest:[0-9]* 
          {
              return [first].concat(rest).join(""); 
          } 
    	/ "0")
    suffix:
    	("." rest:[0-9]+ 
          { 
              return "."+rest.join(""); 
          }
        )?
    {
		let result = (neg)
        	? "-" + prefix
            : prefix;
        if (suffix) result += suffix;
        return [result];
	}