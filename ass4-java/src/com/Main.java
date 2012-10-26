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
      //Loop through each character
      //Seperate each token from the expression and ignore the whitespace
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


    //We need to keep expressions on a stack while we're building the tree
    //This is because our tree is only a one way tree 
    //so we can't rely on the child expressions having a reference to their parent
    Stack<CompoundExpression<Integer,Integer,Integer>> expressionStack = new Stack<CompoundExpression<Integer,Integer,Integer>>();
    CompoundExpression<Integer,Integer,Integer> currentExpression = null;

    //If expression Tokens is empty or a malformed expression
    //create a dummy expression so the program doesn't crash...
    if (!expressionTokens.isEmpty() && !"(".equals(expressionTokens.get(0))) {
      currentExpression = new CompoundExpression<Integer,Integer,Integer>();
      expressionStack.push(currentExpression);
    }

    //OK, so we have our expression in tokens
    //now lets build an expression tree
    for(String token : expressionTokens) {
      if ("(".equals(token)) {
        //start of an expression push it onto our stack
        currentExpression = new CompoundExpression<Integer,Integer,Integer>();
        expressionStack.push(currentExpression);
      } else if (")".equals(token)) {
        //end of an expression
        //pop the current expression so we can assign it to it's parent if it has one
        CompoundExpression<Integer,Integer,Integer> leafExpression = expressionStack.pop();
        if (!expressionStack.isEmpty()) {
          currentExpression = expressionStack.peek(); 
        } else {
          currentExpression = null;
        }
        if (leafExpression != null && currentExpression != null) {
          //if the leafExpression has a parent
          //assign the leaf to either the parent's left or ride side
          if (currentExpression.lExp == null) {
            currentExpression.lExp = leafExpression; 
          } else {
            currentExpression.rExp = leafExpression;
          }
        }
        if (currentExpression == null) {
          //if the leaf is the root expression
          //leave it as the current expression
          currentExpression = leafExpression;
        }
      } else if ("+".equals(token)
          || "-".equals(token)
          || "/".equals(token)
          || "*".equals(token)) {
        //Get the appropriate arithmetic operator and assign it
        //to the current expression
        currentExpression.optr = ArithmeticOperator.<Integer,Integer,Integer>operatorForString(token,Integer.class); 
      } else {
        //this is a number
        //create a new constant and assign it to the current expression left or right
        if (currentExpression.lExp == null) {
          currentExpression.lExp = new Constant<Integer>(Integer.valueOf(token));
        } else if (currentExpression.rExp == null) {
          currentExpression.rExp = new Constant<Integer>(Integer.valueOf(token));
        }
      }
    }

    //At this point, currentExpression is the root of our expression tree
    //Evaluate via the expression tree in the usual way via recursion
    System.out.println("Eval Expression Tree: " + currentExpression.execute());


    //Just for grins, lets print out members of the expression via preorder traversal
    System.out.print("PreOrder: ");
    currentExpression.walkTree(WalkOrder.PREORDER, new Expression.WalkExecutor() {
      
      public void execute(Expression exp) {
        System.out.print(exp.toString() + " ");
      }

    });

    System.out.println("");
    
    //Just for grins, lets print out members of the expression via inorder traversal
    System.out.print("InOrder: ");
    currentExpression.walkTree(WalkOrder.INORDER, new Expression.WalkExecutor() {
      
      public void execute(Expression exp) {
        System.out.print(exp.toString() + " ");
      }

    });

    System.out.println("");

    //Just for grins, lets print out members of the expression via postorder traversal
    System.out.print("PostOrder: ");
    currentExpression.walkTree(WalkOrder.POSTORDER, new Expression.WalkExecutor() {
      
      public void execute(Expression exp) {
        System.out.print(exp.toString() + " ");
      }

    });

    System.out.println("");

    

    //Evaluate via postfix traversal
    final Stack<Integer> postfixStack = new Stack<Integer>();
    currentExpression.walkTree(WalkOrder.POSTORDER, new Expression.WalkExecutor() {

      public void execute(Expression exp) {
        if (exp instanceof Constant) {
          //if we're a number, push on the stack
          Constant<Integer> constant = (Constant<Integer>) exp;
          postfixStack.push(constant.value);
        } else if (exp instanceof CompoundExpression) {
          //if we're a compound expression
          //get the operator, use it to eval the last two numbers on the stack
          //then push the result back onto the stack
          Operator<Integer, Integer, Integer> optr = ((CompoundExpression<Integer, Integer, Integer>) exp).optr;
          if (optr != null) {
            Integer rSide = postfixStack.pop();
            Integer lSide = postfixStack.pop();
            postfixStack.push(optr.operate(lSide,rSide));
          } 
        }
      }

    });

    //print out the result which is the last number in the stack after traversal
    System.out.println("Result from postorder evaluation: " + postfixStack.pop());

  }
}

