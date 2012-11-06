
BUILD_DIR = build

PROJ = open_address_hashing
SRCS = main.m \
	RObject.m \
	Hash.m \
	Record.m \
	NumericKey.m \
	ModifiedLinearProbeHash.m \
	LinearProbeHash.m

TEST_SRCS = test.m \
	RObject.m \
	Hash.m \
	Record.m \
	CollisionKey.m \
	ModifiedLinearProbeHash.m \
	LinearProbeHash.m

OBJS = $(SRCS:.m=.o)
TEST_OBJS = $(TEST_SRCS:.m=.o)
BUILD_OBJS = $(addprefix $(BUILD_DIR)/,$(OBJS))
TEST_BUILD_OBJS = $(addprefix $(BUILD_DIR)/,$(TEST_OBJS))

CC = gcc
CFLAGS = -Wall -Werror -ggdb
LD = gcc
LDFLAGS = -lobjc 

$(PROJ) : createBuildDir $(BUILD_OBJS)
	@echo "Linking $(PROJ)"
	$(LD) -o $(PROJ) $(BUILD_OBJS) $(LDFLAGS)

test : createBuildDir $(TEST_BUILD_OBJS)
	@echo "Linking test"
	$(LD) -o test $(TEST_BUILD_OBJS) $(LDFLAGS)

createBuildDir :
	mkdir -p $(BUILD_DIR)

clean : 
	rm -rf $(BUILD_DIR)
	rm -f $(PROJ)
	rm -f test 

$(BUILD_DIR)/%.o : %.m
	$(CC) $(CFLAGS) -c $< -o $@
