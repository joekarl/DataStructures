package com;

import com.Operator;
import com.Expression;
import com.Expression.WalkExecutor;
import com.WalkOrder;

/*
 * A class to model a compound expression (has an explicite left and right side)
 * An implementation of Expression
 * Requires a left and right side expression type as well as and expression return type
 *
 */
public class CompoundExpression<T1,T2,T> implements Expression<T> {
  //left side of this expression
  public Expression<T1> lExp;
  //right side of this expression
  public Expression<T2> rExp;
  //operator to be applied on left and right side expressions
  public Operator<T1, T2, T> optr;

  public CompoundExpression(){}

  public CompoundExpression(Expression<T1> lExp, Expression<T2> rExp, Operator<T1,T2,T> optr) {
    this.lExp = lExp;
    this.rExp = rExp;
    this.optr = optr;
  }

  //use operator to act upoon the results of the left and right expressions
  //returns the specified return type T
  @SuppressWarnings("unchecked")
  public T execute() {
    if (lExp == null || rExp == null) {
      if (lExp != null && optr == null) {
        return (T) lExp.execute();
      } 
      throw new IllegalStateException("Malformed compound expression");
    }
    return optr.operate(lExp.execute(), rExp.execute());
  }

  //implementation of walkTree
  //executes the left and right side expressions 
  //and calls the executor in the correct spot based on the WalkOrder
  public void walkTree(WalkOrder order, WalkExecutor executor) {
    if (order == WalkOrder.PREORDER) {
      executor.execute(this);
    }
    if (lExp != null) {
      lExp.walkTree(order, executor);
    }
    if (order == WalkOrder.INORDER) {
      executor.execute(this);
    }
    if (rExp != null) {
      rExp.walkTree(order, executor);
    }
    if (order == WalkOrder.POSTORDER) {
      executor.execute(this);
    }
  }

  public String toString() {
    return optr != null ? optr.toString() : "";
  }

}

