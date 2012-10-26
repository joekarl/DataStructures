
package com;

import com.Expression;

public class Constant<T> implements Expression<T> {
  public T value;

  public Constant(T value) {
    this.value = value;
  }

  public T execute() {
    return value;
  }

  public void walkTree(WalkOrder order, WalkExecutor executor) {
    executor.execute(this);
  }
  
  public String toString() {
    return value != null ? value.toString() : "EMPTY";
  }
}

