package com;

import com.Expression;

/*
 * Class to model an operator
 * needs generics for left side type, right side type
 * and return type
 *
 */
public interface Operator<T1, T2, RETURN_TYPE> {
  public RETURN_TYPE operate(T1 lSide, T2 rSide);
}
