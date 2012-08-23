load('hammingNumbers.js');
load('readLine.js');

//get a valid number from the user
var num;
while (!num) {
  print("Enter the number of Hamming numbers to generate: ");
  var num = parseInt(readLine(),10);
  if (isNaN(num)) {
    println('You did not enter a number...');
    num = null;
  }
}

//define a function to print a certain subset of a list
var countPrint = function(list) {
  var i = 0; 
  list.rewind();
  while(list.current) {
    println("[" + (i + 1) + ", " + list.current.data + "]");
    i++;
    list.advance();
  }
}

//create new number generator and generate the number sequence
var seq = new HammingNumbersGenerator().
  generateSequence(20);

countPrint(seq);

