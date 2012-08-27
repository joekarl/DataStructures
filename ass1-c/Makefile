PROJ = sequence_generation
BUILD_DIR = build
OBJS = sequence_generation.o \
	dbl_linked_list.o \
	hamming_numbers.o
BUILD_OBJS = $(addprefix $(BUILD_DIR)/,$(OBJS))
TEST_OBJS = dbl_linked_list.o \
	hamming_numbers.o \
	test.o
BUILD_TEST_OBJS = $(addprefix $(BUILD_DIR)/,$(TEST_OBJS))
SRCS = $(OBJS,.o=.c)
TEST_SRCS = 
CC = gcc
CFLAGS = 
LD = gcc
LDFLAGS = 

$(PROJ) : $(BUILD_OBJS)
	@echo "Linking $(PROJ)"
	$(LD) -o $(PROJ) $(BUILD_OBJS) $(LDFLAGS)

test : $(BUILD_TEST_OBJS)
	@echo "Linking test"
	$(LD) -o test $(BUILD_TEST_OBJS) $(LDFLAGS)

clean : 
	rm -rf $(BUILD_DIR)
	rm -f $(PROJ)
	rm -f test

$(BUILD_DIR)/%.o : %.c
	mkdir -p $(BUILD_DIR)
	@echo "Building $@"
	$(CC) $(CFLAGS) -c $< -o $@
