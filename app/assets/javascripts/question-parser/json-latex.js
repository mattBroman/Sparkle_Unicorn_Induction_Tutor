function jsontolatex(data){
    let response = ""
    const basecase = data["baseCase"]
    
    response += basecaselatex(basecase)
 
    
    const inductiveStep = data["inductiveStep"]
    
    response += inductiveSteplatex(inductiveStep);
    
    response += " $p(n)$ holds for all $n \\geq b$."
    
    return response;
}

function inductiveSteplatex(inductiveStep){
 let response = ""
  if(inductiveStep != null){
     
     response += "{\\bf Inductive Step: }We must show that $p(k) \\implies p(k+1)$ \\\\\\\\"
    
     const hypothesisdata = inductiveStep["hypothesis"]
     
     if(hypothesisdata){
      response += assumelatex(hypothesisdata)
     }
     
     const showdata = inductiveStep["show"]
     
     if(showdata){
      response += showlatex(showdata)
     }
     
     const pre = inductiveStep["pre"]
     const uih = inductiveStep["uih"]
     const post = inductiveStep["post"]
 
    if(pre && uih && post){
     response += istepworklatex(pre,uih,post)
    }
    
    
    if(hypothesisdata && showdata && pre && post && uih){
       response += "Because, $p(k) \\implies p(k+1)$ holds,"

    }
    
    
    
   }
   return response;
 
}

function basecaselatex(basecase){
 let response = "";
 if(basecase != null){
         const assumptions = basecase["assumptions"];
         if(assumptions !== null){
          let b = Object.keys(basecase["assumptions"])[0];
          response += "{\\bf Basis Step: } We must prove that the base case p(b) holds when $b=" + basecase["assumptions"][b] + "$.\\\\\n"
         }
         
         const eqs = basecase["equivalenceExpressions"]
         if(eqs){
          response += "\\begin{align*}\n"
          response += MultipleEquation(basecase["equivalenceExpressions"]) + "\n"
          response += "\\end{align*}\n"
         }
         if(assumptions && eqs){
           response += "Therefore p(b) holds. \\\\\n"

         }
    }
 return response;
 
}



function istepworklatex(pre,uih,post){
 let response = "\\begin{align*}\n"
 
 response += MultipleEquation(pre)
 response += "\\\\\n"
 response += SingleEquation(uih,true)
 response += "\\text{ , by our IH}\\\\\n"
 response += MultipleEquation(post)
 response += "\n\\end{align*}"
 
 
 return response
}

function showlatex(eq){
 let response = "Let $n=k+1$, we must show:"
 
 response += SingleEquation(eq,false)
 response += "\\\\\n"
 return response
}

function assumelatex(eq){
 let response = "{\\bf Inductive Hypothesis: }Assume $p(k)$ for some ${k}\\geq{b}$: "
 
 response += SingleEquation(eq,false)
 response += "\\\\\\\\\n"
 
 return response
 
 
}







function SingleEquation(eq,aligned){
 
 const lefteq = eq["left"]
 const righteq = eq["right"]

 let left = null
 let right = null
 if(lefteq !== null){
  left = PostfixToInfix(lefteq)
 }
 else{
  left = ""
 }
 right = PostfixToInfix(righteq)
 if(aligned){
  return (left+"&="+right)
 }
 else{
  return("$"+left+"="+right+"$")
 }
 
 
}


function MultipleEquation(eqs){
 let response =""
 for(var i = 0; i < eqs.length; i+=1){
  response+=SingleEquation(eqs[i],true)
  if(i < eqs.length-1){
   response+=" \\\\\n"
  }
 }
 
 return response
}


function hasPrecedenceOver(a,b){
 
 const precedence = {
  "+":1,
  "-":1,
  "*":2,
  "/":2,
  "^":3,
  "none":99
 }
 
 return precedence[a] > precedence[b]
 
 
}

function isOperator(arg){
 return (arg=="+" | arg=="-" | arg == "*" | arg=="/" | arg=="^" | arg=="none" | arg=="sum" | arg=="prod")
}

function isOperand(arg){
 return !isOperator(arg)
}

function isComplexOperator(arg){
  return (arg === 'sum' || arg === 'prod')

}

function getcomplexblock(_postfix){
 const postfix = _postfix;
 let inner = 0
 const nextBlock = [];
 let nextToken = postfix.shift();
 while(nextToken !== '|' || inner > 0) {
  if(nextToken==="|") inner-=1;
  if (nextToken === 'sum' || nextToken === 'prod') inner += 3;
  nextBlock.push(nextToken);
  nextToken = postfix.shift();
 }
 
 return {
  nextBlock,
  remainder: postfix
 };
}

function PostfixComplex(name,postfix){
 
 const iter = postfix.shift()
 
 const lowerblock = getcomplexblock(postfix)
 
 
 const upperblock = getcomplexblock(lowerblock.remainder)
 
 const eqblock = getcomplexblock(upperblock.remainder)
 
 const lowerbound = PostfixToInfix(lowerblock.nextBlock)
 
 const upperbound = PostfixToInfix(upperblock.nextBlock)
 
 const eq = PostfixToInfix(eqblock.nextBlock)
 
 return{
  operand: `\\${name}_{${iter}=${lowerbound}}^{${upperbound}}{${eq}}`,
  remainder: eqblock.remainder
 }
 
 
 
}


function PostfixToInfix(_postfix){
 let postfix = _postfix
 const operands = []
 const operators = []
 
 while(postfix.length != 0){
  
  const token = postfix.shift()
   
  if(isOperand(token)){
    operands.push(token)
    operators.push("none")
   
  }
  else if(isComplexOperator(token)){
   const complex_result = PostfixComplex(token,postfix)
   
   operands.push(complex_result.operand)
   operators.push("none")
   postfix = complex_result.remainder
   
   
   
  }
  else{
   const operandR = operands.pop()
   const operandL = operands.pop()
   
   const operatorR = operators.pop()
   const operatorL = operators.pop()

   const left = hasPrecedenceOver(token, operatorL) ? `(${operandL})` : operandL
   const right = hasPrecedenceOver(token, operatorR) ? `(${operandR})` : operandR
   
   if(token === "/"){
    operands.push(`\\frac{${operandL}}{${operandR}}`)
   }
   else{
    operands.push(left+token+right)
   }
   
   operators.push(token)
  }
  
  
 }
 return operands[0]

}



module.exports = {
    jsontolatex,
    PostfixToInfix,
    hasPrecedenceOver,
    isOperand,
    isOperator,
    SingleEquation,
    MultipleEquation,
    istepworklatex,
    assumelatex,
    showlatex
    
}







