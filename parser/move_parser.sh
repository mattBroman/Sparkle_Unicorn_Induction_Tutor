#!/bin/bash
cp parser.js test.js
sed -i '1s/^/(function(root) { \n/' test.js
head -n -5 test.js > test2.js
cat test2.js > test.js
rm test2.js

echo """root.PARSER = {
  SyntaxError: peg\$SyntaxError,
  parse:       peg\$parse
};
})(this);""" >> test.js

mv test.js ../induction/app/assets/javascripts/parser.js