package com;

import com.Expression;

public interface Operator<T1, T2, RETURN_TYPE> {
  public RETURN_TYPE operate(T1 lSide, T2 rSide);
}
