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
  //see readme for explanation on why and how this works...
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


