//Read Line from console
//via @Tero on stackoverflow
//http://stackoverflow.com/questions/4508897/console-input-function-for-rhino/5317717#5317717
var readLine = (typeof readline === 'function') ? (readline) : (function() {
  importPackage(java.io);
  importPackage(java.lang);
  var stdin = new BufferedReader(new InputStreamReader(System['in']));

  return function() {
     return String(stdin.readLine());  // Read line, 
  };                                    // force to JavaScript String
}());
