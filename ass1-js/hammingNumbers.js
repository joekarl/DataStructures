load('linkedList.js');

//constructor
HammingNumbersGenerator = function() {};

//instance methods
HammingNumbersGenerator.prototype = {
  //generate Hamming numbers and assign them to a list
  generateTerms: function(multiplier) {
    var newList = new LinkedList();
    this.lTemp.rewind();
    while (this.lTemp.current) {
      newList.add(this.lTemp.current.data * multiplier);
      this.lTemp.advance();
    }
    return newList;
  },
  //check to see if we have enough terms and can quit
  /*
    n+1 generations of the hamming numbers will always contain the complete set of numbers for n generations
    so we Check to see if the next iteration of the list terms has terms that will fit into the final list
    like so: 
      final: [1,2,3,5]
      temp: [4,6,9,10,15,25]
      temp contains numbers that are smaller than the largest number in the final list, therefore we must go one extra iteration of the number generation
    this has a side effect of using one extra iteration to generate numbers but does create the correct results
  */
  hasEnoughTerms: function() {
    if (!this.lTemp.current) {
      return;
    }
    this.lTemp.rewind();
    var min = this.lTemp.current.data;

    return this.lFinal.length >= this.numberOfTermsToGenerate && this.lFinal.get(this.numberOfTermsToGenerate - 1).data <= min;
  },
  generateSequence: function(numberOfTermsToGenerate) {
    this.numberOfTermsToGenerate = numberOfTermsToGenerate || 100;
    this.lFinal = new LinkedList();
    this.lTemp = new LinkedList();
    this.l2Terms = new LinkedList();
    this.l3Terms = new LinkedList();
    this.l5Terms = new LinkedList();
  
    this.lFinal.add(1);
    this.lTemp.add(2);
    this.lTemp.add(3);
    this.lTemp.add(5);

    while (!this.hasEnoughTerms()) {
      this.lFinal = LinkedList.mergeLists(this.lFinal,this.lTemp);
      this.l2Terms = this.generateTerms(2);
      this.l3Terms = this.generateTerms(3);
      this.l5Terms = this.generateTerms(5);

      this.lTemp = LinkedList.mergeLists(this.l2Terms,this.l3Terms);
      this.lTemp = LinkedList.mergeLists(this.lTemp,this.l5Terms);
    }

    return LinkedList.range(this.lFinal, 0, this.numberOfTermsToGenerate);
  }
};


