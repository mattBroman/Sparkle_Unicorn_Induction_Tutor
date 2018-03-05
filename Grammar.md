https://docs.google.com/document/d/19CI1v3pI4xVOe6bf1HagSlyyLBNQRt2mXDKlOoV9oM0/edit?usp=sharing


problem ::= seq op (problem op) | n

seq ::= base behavior

op ::= + | - | / | * | mod | ^ | nothing

base ::= const  (base)

behavior ::=  behavior op b | b op behavior | b

b  ::= const | prev (const)



Examples:

1 * 2 * … * n   
seq(1, prev + 1)  *


2^0 + 2^1 + … + 2^n     
seq(2, 2)  ^ seq(0, prev+1) +


1,1,2,3 … n     
seq([1 1], prev + prev 1)


