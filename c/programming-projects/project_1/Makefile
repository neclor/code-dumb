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

SRCS = $(shell find $(SRC_DIR) -type f -name "*.c")
OBJS = main.o pnm.o

all: $(TARGET)

$(TARGET): $(OBJECTS)
	$(LD) -o $@ $(OBJECTS) $(LDFLAGS)

main.o: main.c
	$(CC) -c main.c -o main.o $(CFLAGS)

pnm.o: pnm.c
	$(CC) -c pnm.c -o pnm.o $(CFLAGS)

clean:
	rm -f *.o $(EXEC) *~


clean:
	rm -rf *.o $(OBJ_DIR) $(TARGET) *~

git:
	git pull
	git add .
	git commit -m "Makefile push `date +'%Y-%m-%d %H:%M:%S'`"
	git push
