Problem ::= seq op (problem op) | n

Seq ::= base behavior

Op ::= + | - | / | * | mod | ^ | nothing

Base ::= const  (base)

Behavior ::=  behavior op b | b op behavior | b

b  ::= const | prev (const)




Examples:
1*2* … * n
seq(1, prev + 1)  *

2^0 + 2^1 + … + 2^n
seq(2, 2)  ^ seq(0, prev+1) +

1,1,2,3 … n
seq([1 1], prev + prev 1)

