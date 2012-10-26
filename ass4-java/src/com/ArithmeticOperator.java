package com;

import com.Operator;
import com.Expression;
import java.lang.Number;


/*
 * This class provides implementations of Arithmetic Operators
 *
 * If java had real generics, this would be easier, but it has sort of half way generics
 * so we get to make implementation specific copies of code like we'd have to do in C, o_0
 *
 * There is a convenience static method that will give an instance of an operator based 
 * on the given operator and output type
 *
 * To be complete this class would need implementations for all of the different 
 * permutations of primitive wrappers and since this assignment doesn't call for 
 * anything other than integer operations I didn't spend the time to complete the implementation....
 *
 */
public abstract class ArithmeticOperator<T1 extends Number,T2 extends Number,T extends Number> implements Operator<T1,T2,T> {

  public static <T1 extends Number,T2 extends Number,T extends Number> ArithmeticOperator<T1,T2,T> operatorForString(String op, Class<T> clazz) {
    if (clazz != Integer.class) {
      throw new UnsupportedOperationException();
    }
    if ("+".equals(op)) {
      return (ArithmeticOperator<T1,T2,T>) new INTEGER.Add();
    } else if ("-".equals(op)) {
      return (ArithmeticOperator<T1,T2,T>) new INTEGER.Subtract();
    } else if ("/".equals(op)) {
      return (ArithmeticOperator<T1,T2,T>) new INTEGER.Divide();
    } else if ("*".equals(op)) {
      return (ArithmeticOperator<T1,T2,T>) new INTEGER.Multiply();
    } else {
      throw new IllegalStateException();
    }
  }

  public static class INTEGER {
    public static class Add extends ArithmeticOperator<Integer, Integer, Integer> {
      public Integer operate(Integer lSide, Integer rSide) {
        return lSide + rSide;
      }
      
      public String toString() { return "+"; }

    }

    public static class Divide extends ArithmeticOperator<Integer, Integer, Integer> {
      public Integer operate(Integer lSide, Integer rSide) {
        return lSide / rSide;
      }
      
      public String toString() { return "/"; }
    
    }
    public static class Multiply extends ArithmeticOperator<Integer, Integer, Integer> {
      public Integer operate(Integer lSide, Integer rSide) {
        return lSide * rSide;
      }
      
      public String toString() { return "*"; }
    
    }
    public static class Subtract extends ArithmeticOperator<Integer, Integer, Integer> {
      public Integer operate(Integer lSide, Integer rSide) {
        return lSide - rSide;
      }
      
      public String toString() { return "-"; }
    
    }
  }

}
