assert = function(truthy,msg) {
  msg = msg || "";
  if (!truthy) {
    println('Assertion failed... ' + msg);
  } else {
    println('Pass... ' + msg);
  }
}
