function jsontolatex(data){
    
 
    
    
    
    
    
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
   
   operands.push(left+token+right)
   operators.push(token)
  }
  
  
 }
 return operands[0]

}


function sum_prod_infix(data){
    
    
    
    
}

module.exports = {
    PostfixToInfix,
    hasPrecedenceOver,
    isOperand,
    isOperator
}







