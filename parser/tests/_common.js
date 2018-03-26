const test = require('ava');
const parser = require('../parser');

function util(token) {
    return {
        pass: function(t, input) {
            t.notThrows(function() {
                parser.parse(input, {startRule: token}); 
            });
        },
        fail: function(t, input) {
            t.throws(function() {
               parser.parse(input, {startRule: token}); 
            });
        },
        returns: function(t, input, expected) {
            let actual;
            t.notThrows(function() {
                actual = parser.parse(input, {startRule: token});
            });
            t.deepEqual(expected, actual);
        }
    }
}

module.exports = util;




