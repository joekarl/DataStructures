package com;

import com.WalkOrder;

/*
 * Class to model an abstract expression
 * Uses generics to make this strongly typed
 *
 */
public interface Expression<T> {
  //Executes the expression and returns a specified value
  public T execute();

  //walk this expression's expression tree in a given order
  //run the executor on each expression in the expression tree
  public void walkTree(WalkOrder order, WalkExecutor executor);

  //provides an interface to execute code against a specified expression
  public static interface WalkExecutor {
    void execute(Expression exp);
  }
}

