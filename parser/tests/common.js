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
        }
    }
}

module.exports = util;




