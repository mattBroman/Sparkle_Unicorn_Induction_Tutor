// Simple Arithmetics Grammar
// ==========================
//
// Accepts expressions like "2 * (3 + 4)" and computes their value.

// Example pulled from pegjs.com/online
// To compile do 'npm run build'
// To test do 'npm run test'

_Root
	= _Assumption
    / _EquivalenceExpression
    / _Expression
    / _Term
    / _Proof
    
_Proof
  = _*
    baseCase: _BaseCase?
    _*
    inductiveStep: _InductiveStep?
    _*
    {
      return {
        baseCase,
        inductiveStep
      };
    }

_BaseCase
  = "\\begin{base}" _Newline
    _* 
    assumptions:(
      first:_Assumption
      chain:(_Newline _* assumption:_Assumption {
          return assumption;
        })* 
   	  {
        const result = chain.reduce((acc,cur) => Object.assign({},acc,cur), {});
        return Object.assign({},first,result);
      }
    )?
    _*
    equivalenceExpressions:(
      first:_EquivalenceExpression
      chain:(_Newline _* equivalence:_EquivalenceExpression {
         return equivalence;
        })*
      {
        return [first].concat(chain);
      }
    )?
    _*
    "\\end{base}"
    {
      return {
      	assumptions,
        equivalenceExpressions
      };
    }

_InductiveStep
  = "\\begin{inductiveStep}" _Newline
    _*
    hypothesis:_AssumeBlock?
    _*
    show:_ShowBlock?
    _*
    pre:(
      first:_EquivalenceExpression
      chain:(_Newline _* equivalence:_EquivalenceExpression {
        return equivalence;
      })*
      {
        return [first].concat(chain);
      }
    )?
    _*
    uih:_UseIHBlock?
    _*
    post:(
      first:_EquivalenceExpression
      chain:(_Newline _* equivalence:_EquivalenceExpression {
        return equivalence;
      })*
      {
        return [first].concat(chain);
      }
    )?
    _*
    "\\end{inductiveStep}"
    {
      return {
        hypothesis,
        show,
        pre,
        uih,
        post
      };
    }

_AssumeBlock
  = "\\assume{"
    _*
    expression:_EquivalenceExpression
    _*
    "}"
    {
      return expression;
    }

_ShowBlock
  = "\\show{"
    _*
    expression:_EquivalenceExpression
    _*
    "}"
    {
      return expression;
    }

_UseIHBlock
  = "\\useIH{"
    _*
    expression:_EquivalenceExpression
    _*
    "}"
    {
      return expression;
    }

_Assumption
  = ("L"/"l") "et " 
  	variable:[a-z] " "? "=" " "? 
    value:_Expression {
	  return {
        [variable]:value
      };
	}

_EquivalenceExpression
  = left:_Expression? " "? "=" " "? 
    right:_Expression {
      return {
        left,
        right
      };
    }

_Expression
  = _Expression_AS
  / _Expression_MD
  / _Expression_E
  / _Term
  / _Expression_P

_Expression_P
  = "(" " "? content:_Expression " "? ")" { return content; }

_Expression_E
  = left:(_Term/_Expression_P) " "? "^" " "? 
  	right:(_Expression_E/_Term/_Expression_P) { 
    	return left.concat(right).concat("^"); 
    }

_Expression_MD
  = left:(_Expression_E/_Term/_Expression_P)
    chain:(" "?
      op:("*"/"/") " "?
      right:(_Expression_E/_Term/_Expression_P) {
        return right.concat(op);
      })+
    {
      return [].concat.apply(left,chain);
    }

_Expression_AS
  = left:(_Expression_E/_Expression_MD/_Term/_Expression_P) 
  	chain:(" "? 
    	op:("-"/"+") " "? 
      right:(_Expression_E/_Expression_MD/_Term/_Expression_P) { 
        return right.concat(op); 
      })+ 
    { 
   		return [].concat.apply(left,chain); 
    }

_Term
  = left:_Numeral?
  	chain:(variable:[a-z] {
   	  return [variable,"*"]; 
    })+ 
  { 
  	if (left) return [].concat.apply(left,chain);
    return [].concat.apply([chain[0][0]],chain.slice(1));
  }
  / _Numeral
  / variable:[a-z] { return [variable]; }

_Numeral
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

_ "whitespace"
  = [ \t\n\r]

_Newline 
  = [\n\r]