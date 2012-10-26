#!/bin/env bash

java -jar ExpressionSolver.jar "(100   )"
echo

java -jar ExpressionSolver.jar "(100        + 200 )"
echo

java -jar ExpressionSolver.jar "(100*  (200 - 300))"
echo

java -jar ExpressionSolver.jar "(      (100*(200 + 300))*    (  (400 - 200)/ (100 + 100) ))"
echo
