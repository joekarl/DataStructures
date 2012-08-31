PROJ = sequence_generation
BUILD_DIR = build
OBJS = main.o \
	HammingNumbers.o \
	DblLinkedList.o \
	DblLinkedListNode.o \
	RObject.o
BUILD_OBJS = $(addprefix $(BUILD_DIR)/,$(OBJS))
SRCS = $(OBJS,.o=.m)
CC = gcc
CFLAGS = -Wall -Werror
LD = gcc
LDFLAGS = -lobjc 

$(PROJ) : $(BUILD_OBJS)
	@echo "Linking $(PROJ)"
	$(LD) -o $(PROJ) $(BUILD_OBJS) $(LDFLAGS)

clean : 
	rm -rf $(BUILD_DIR)
	rm -f $(PROJ)

$(BUILD_DIR)/%.o : %.m
	mkdir -p $(BUILD_DIR)
	@echo "Building $@"
	$(CC) $(CFLAGS) -c $< -o $@
