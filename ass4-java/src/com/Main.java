package com;

import com.CompoundExpression;
import com.ArithmeticOperator.*;
import com.Constant;
import java.util.Stack;
import java.util.List;
import java.util.ArrayList;

public class Main {
  public static void main(String ... args) {

    //get expression from args and tokenize it
    List<String> expressionTokens = new ArrayList<String>();
    if (args.length == 1) {
      System.out.println("Input expression: " + args[0]);
      String token = "";
      for(int i = 0; i < args[0].length(); ++i) {
        char c = args[0].charAt(i);
        switch(c) {
          case '(':
            if (!"".equals(token)) {
              expressionTokens.add(token);
            }
            expressionTokens.add("(");
            token = "";
            break;
          case ')':
            if (!"".equals(token)) {
              expressionTokens.add(token);
            }
            expressionTokens.add(")");
            token = "";
            break;
          case '0':
          case '1':
          case '2':
          case '3':
          case '4':
          case '5':
          case '6':
          case '7':
          case '8':
          case '9':
            token += c;
            break;
          case ' ':
            if (!"".equals(token)) {
              expressionTokens.add(token);
            }
            token = "";
            break;
          case '+':
          case '-':
          case '/':
          case '*':
            if (!"".equals(token)) {
              expressionTokens.add(token);
            }
            expressionTokens.add("" + c);
            token = "";
            break;
        }
      }
      if (!"".equals(token)) {
        expressionTokens.add(token);
      }
    }

    Stack<CompoundExpression<Integer,Integer,Integer>> expressionStack = new Stack<CompoundExpression<Integer,Integer,Integer>>();
    CompoundExpression<Integer,Integer,Integer> currentExpression = null;

    if (!expressionTokens.isEmpty() && !"(".equals(expressionTokens.get(0))) {
      currentExpression = new CompoundExpression<Integer,Integer,Integer>();
      expressionStack.push(currentExpression);
    }

    //OK, so we have our expression in tokens
    //now lets build an expression tree
    for(String token : expressionTokens) {
      if ("(".equals(token)) {
        currentExpression = new CompoundExpression<Integer,Integer,Integer>();
        expressionStack.push(currentExpression);
      } else if (")".equals(token)) {
        CompoundExpression<Integer,Integer,Integer> leafExpression = expressionStack.pop();
        if (!expressionStack.isEmpty()) {
          currentExpression = expressionStack.peek(); 
        } else {
          currentExpression = null;
        }
        if (leafExpression != null && currentExpression != null) {
          if (currentExpression.lExp == null) {
            currentExpression.lExp = leafExpression; 
          } else {
            currentExpression.rExp = leafExpression;
          }
        }
        if (currentExpression == null) {
          currentExpression = leafExpression;
        }
      } else if ("+".equals(token)
          || "-".equals(token)
          || "/".equals(token)
          || "*".equals(token)) {
        currentExpression.optr = ArithmeticOperator.<Integer,Integer,Integer>operatorForString(token,Integer.class); 
      } else {
        if (currentExpression.lExp == null) {
          currentExpression.lExp = new Constant<Integer>(Integer.valueOf(token));
        } else if (currentExpression.rExp == null) {
          currentExpression.rExp = new Constant<Integer>(Integer.valueOf(token));
        }
      }
    }

    //At this point, currentExpression is the root of our expression tree
    //Evaluate via the expression tree in the usual way
    System.out.println("Eval Expression Tree: " + currentExpression.execute());

    System.out.print("PreOrder: ");
    currentExpression.walkTree(WalkOrder.PREORDER, new Expression.WalkExecutor() {
      
      public void execute(Expression exp) {
        System.out.print(exp.toString() + " ");
      }

    });

    System.out.println("");
    
    System.out.print("InOrder: ");
    currentExpression.walkTree(WalkOrder.INORDER, new Expression.WalkExecutor() {
      
      public void execute(Expression exp) {
        System.out.print(exp.toString() + " ");
      }

    });

    System.out.println("");

    System.out.print("PostOrder: ");
    currentExpression.walkTree(WalkOrder.POSTORDER, new Expression.WalkExecutor() {
      
      public void execute(Expression exp) {
        System.out.print(exp.toString() + " ");
      }

    });

    System.out.println("");

    

    final Stack<Integer> postfixStack = new Stack<Integer>();
    //Evaluate via postfix traversal
    currentExpression.walkTree(WalkOrder.POSTORDER, new Expression.WalkExecutor() {

      public void execute(Expression exp) {
        if (exp instanceof Constant) {
          Constant<Integer> constant = (Constant<Integer>) exp;
          postfixStack.push(constant.value);
        } else if (exp instanceof CompoundExpression) {
          Operator<Integer, Integer, Integer> optr = ((CompoundExpression<Integer, Integer, Integer>) exp).optr;
          if (optr != null) {
            Integer rSide = postfixStack.pop();
            Integer lSide = postfixStack.pop();
            postfixStack.push(optr.operate(lSide,rSide));
          } 
        }
      }

    });

    System.out.println("Result from postorder evaluation: " + postfixStack.pop());

  }
}

