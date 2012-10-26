
package com;

import com.Expression;

/*
 * Class to model a constant
 * Uses a generic <T> to specify the value type
 *
 */
public class Constant<T> implements Expression<T> {
  public T value;

  public Constant(T value) {
    this.value = value;
  }

  public T execute() {
    return value;
  }

  //implementation of walkTree
  //just calls the executor with the value of the constant
  public void walkTree(WalkOrder order, WalkExecutor executor) {
    executor.execute(this);
  }
  
  public String toString() {
    return value != null ? value.toString() : "EMPTY";
  }
}

