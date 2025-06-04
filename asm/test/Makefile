TARGET = test

SRC_DIR	= src
OBJ_DIR = build

INC = $(addprefix -I, $(shell find $(SRC_DIR) -type d))

SRC_EXT = s
SRCS = $(shell find $(SRC_DIR) -type f -name "*.$(SRC_EXT)")
HEDS = $(shell find $(SRC_DIR) -type f -name "*.h")
OBJS = $(SRCS:$(SRC_DIR)/%.$(SRC_EXT)=$(OBJ_DIR)/%.o)

CC = gcc
#C_FLAGS = -g --std=c99 --pedantic -Wall -W -Wextra -Wmissing-prototypes `pkg-config --cflags gtk+-2.0` $(INC)
C_FLAGS = -g -Wall -fno-pie

LD = gcc
#LD_FLAGS = `pkg-config --libs gtk+-2.0`
LDFLAGS = -no-pie

all: $(TARGET)

$(TARGET): $(OBJS)
	$(LD) $^ -o $@ $(LD_FLAGS)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.$(SRC_EXT)
	@mkdir -p $(dir $@)
	$(CC) -c $< -o $@ $(C_FLAGS)

clean:
	@rm -rf $(OBJ_DIR) $(TARGET)

git:
	@git pull
	@git add .
	@git commit -m Update
	@git push

.PHONY: all $(TARGET) clean git