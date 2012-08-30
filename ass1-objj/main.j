@import "HammingNumbers.j"


var readline = require('readline').readline;
print("How many numbers do want to generate? ");
var n = readline();
var seq = [HammingNumbers generateSequenceWithLength:n];
print(seq);
print('\n');
