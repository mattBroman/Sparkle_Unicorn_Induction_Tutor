const test = require('ava');
const parser = require('../parser');

function pass(t, token, input) {
    t.notThrows(function() {
        parser.parse(input, {startRule: token}); 
    });
};

function fail(t, token, input) {
    t.throws(function() {
       parser.parse(input, {startRule: token}); 
    });
}

module.exports = {
    pass,
    fail
};




