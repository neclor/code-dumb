# Makefile
# By: Pavlov Aleksandr s2400691
# INFO0030: Projet 1

TARGET = pnm

CC = gcc
CFLAGS = --std=c99 --pedantic -Wall -W -Wmissing-prototypes
LD = gcc
LDFLAGS =

SRC_DIR = src
OBJ_DIR = bin

OBJS = $(OBJ_DIR)/main.o $(OBJ_DIR)/pnm.o $(OBJ_DIR)/my_string.o

all: $(TARGET)

$(TARGET): $(OBJS)
	$(LD) $^ -o $@ $(LDFLAGS)

$(OBJ_DIR)/main.o: $(SRC_DIR)/main.c
	mkdir -p $(OBJ_DIR)
	$(CC) -c $(SRC_DIR)/main.c -o $@ $(CFLAGS)

$(OBJ_DIR)/pnm.o: $(SRC_DIR)/pnm/pnm.c $(SRC_DIR)/pnm/pnm.h
	$(CC) -c $(SRC_DIR)/pnm/pnm.c -o $@ $(CFLAGS)

$(OBJ_DIR)/my_string.o: $(SRC_DIR)/my_string/my_string.c $(SRC_DIR)/my_string/my_string.h
	$(CC) -c $(SRC_DIR)/my_string/my_string.c -o $@ $(CFLAGS)

clean:
	rm -f $(OBJ_DIR)/*.o $(TARGET)

git:
	git pull
	git add .
	git commit -m "Makefile push `date +'%Y-%m-%d %H:%M:%S'`"
	git push
