load('hammingNumbers.js');
load('assert.js');

println('\nTest hamming generator');
var generator = new HammingNumbersGenerator();
var seq = generator.generateSequence(1690);

var expectedOutput = new LinkedList();
expectedOutput.add(2);
expectedOutput.add(3);
expectedOutput.add(4);
expectedOutput.add(5);
expectedOutput.add(6);
expectedOutput.add(8);
expectedOutput.add(9);
expectedOutput.add(10);
expectedOutput.add(12);
expectedOutput.add(15);
expectedOutput.add(16);
expectedOutput.add(18);
expectedOutput.add(20);
expectedOutput.add(24);
expectedOutput.add(25);
expectedOutput.add(27);
expectedOutput.add(30);
expectedOutput.add(32);
expectedOutput.add(36);
expectedOutput.add(40);

assert(LinkedList.range(seq,0,20).toString() == expectedOutput.toString(), 'Sequence should output first 20 Hamming numbers');

println(LinkedList.range(seq,0,20));

//test arbitrary number in sequence
assert(seq.get(1689).data == 2125764000, 'Sequence 1690 should equal 2125764000');
