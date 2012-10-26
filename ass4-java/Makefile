PROJ = ExpressionSolver.jar 
BUILD_DIR = build
SRCS = src/com/Main.java \
	src/com/Expression.java \
	src/com/CompoundExpression.java \
	src/com/Operator.java \
	src/com/Constant.java \
	src/com/WalkOrder.java \
	src/com/ArithmeticOperator.java 
MAIN_CLASS = com.Main

JC = javac 
JFLAGS = 
JAR = jar
JARFLAGS = cfe

$(PROJ) : clean_build createBuildDir compile 	
	@echo "Jarring up  application $(PROJ)"
	cd $(BUILD_DIR); $(JAR) $(JARFLAGS) $(PROJ) $(MAIN_CLASS) * 
	mv $(BUILD_DIR)/$(PROJ) .

createBuildDir :
	mkdir -p $(BUILD_DIR)

clean : clean_dist clean_build  

clean_dist :
	rm -f $(PROJ)

clean_build :
	rm -rf $(BUILD_DIR)

compile : 
	$(JC) $(JFLAGS) -d $(BUILD_DIR) $(SRCS)

