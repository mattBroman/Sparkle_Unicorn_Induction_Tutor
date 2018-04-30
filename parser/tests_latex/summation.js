 import test from 'ava';

 
 var json_ex = {"baseCase" : {"assumptions" : {"b":["1"]}, "equivalenceExpressions" : [{"left":["sum","i","1","|","1","|","i","|"], "right":["1","1","1","+","*","2","/"]}]},
                "inductiveStep":{
                "hypothesis" : {"left":["sum","i","1","|","k","|","i","|"],"right":["k","k","1","+","*","2","/"]},
                "show" :{"left":["sum","i","1","|","k","1","+","|","i","|"], "right":["k","1","+","k","1","+","1","+","*","2","/"]},
                "pre" : [{"left":["sum","i","1","|","k","1","+","|","i","|"],"right":["sum","i","1","|","k","|","i","|","k","+","1","+"]}],
                "post" :[{"left":null, "right":["k","1","+","k","1","+","1","+","*","2","/"]}],
                "uih" :{"left":null,"right":["k","k","1","+","*","2","/","k","+","1","+"]} 
                    
                }}
                
                
test(
    "summation proof",
    returns,
    json_ex,

`










`



);