import test from 'ava';
import {istepworklatex} from '../json-latex.js'



test("istepwork (1)", t => {
    const expected = `\\begin{align*}\n\\sum_{i=1}^{k+1}{i}&=\\sum_{i=1}^{k}{i}+k+1\\\\\n&=k*(k+1)/2+k+1\\text{ , by our IH}\\\\\n&=(k+1)*(k+1+1)/2\n\\end{align*}`;
    const actual = istepworklatex(
        [{"left":["sum","i","1","|","k","1","+","|","i","|"],"right":["sum","i","1","|","k","|","i","|","k","+","1","+"]}],
        {"left":null,"right":["k","k","1","+","*","2","/","k","+","1","+"]},
        [{"left":null, "right":["k","1","+","k","1","+","1","+","*","2","/"]}]
        );
    t.is(actual, expected);
});