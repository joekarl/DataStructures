package com;

import com.WalkOrder;

public interface Expression<T> {
  public T execute();
  public void walkTree(WalkOrder order, WalkExecutor executor);

  public static interface WalkExecutor {
    void execute(Expression exp);
  }
}

