# Adding an Operator

## Within evaluate.rb
 
 You need to modify the @@complex_operations static hash to define your new operation. The new operation must include three elements:
   + **eval** : evaluation of the term
   + **parse** : parse out the terms for evaluation
   + **post** : convert infix to postfix for the operation 

## Within grammar.pegjs
The grammar needs to be updated to handle the new operation within this file. PegJS uses this file to generate compiled JS code (parser.js)

## within json-latex.js
The conversion of postfix to infix needs to be updated here as well

