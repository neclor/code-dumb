#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <conio.h>
#include <time.h>

#include "GameOfLife.h"

#define K_ENTER 13
#define K_SPACE ' '
#define K_ARROW_UP 72
#define K_ARROW_DOWN 80

static unsigned int delay = 400;
static unsigned char* dataCopy = NULL;

Field createField(unsigned int width, unsigned int height) {
    unsigned char* data = (unsigned char*)calloc(width, height);
    if (!data) {
        fprintf(stderr, "ERROR: Failed to allocate memory\n");
        exit(1);
    }
    Field field = { data, width, height };
    return field;
}

void updateField(Field* field) {
    unsigned int width = field->width, height = field->height;
    unsigned char* data = field->data;
    if (!dataCopy) {
        dataCopy = (char*)malloc(width * height);
        if (!dataCopy) {
            fprintf(stderr, "ERROR: Failed to allocate memory\n");
            exit(1);
        }
    }
    memcpy(dataCopy, data, width * height);

    for (unsigned int x = 0; x < width; x++) {
        for (unsigned int y = 0; y < height; y++) {
            unsigned int neighborsNumber = 0;
            for (int relativeX = -1; relativeX < 2; relativeX++) {
                unsigned int neighborX = (x + relativeX + width) % width;
                for (int relativeY = -1; relativeY < 2; relativeY++) {
                    unsigned int neighborY = (y + relativeY + height) % height;
                    neighborsNumber += dataCopy[neighborY * (size_t)width + neighborX];
                }
            }
            size_t cellIndex = y * (size_t)width + x;
            neighborsNumber -= dataCopy[cellIndex];

            if (neighborsNumber < 2 || neighborsNumber > 3) {
                data[cellIndex] = 0;
            }
            else if (neighborsNumber == 3) {
                data[cellIndex] = 1;
            }
        }
    }
}

void gameLoop(Field* field) {
    printf("\033[?25l");

    Field gameField = createField(field->width, field->height);
    memcpy(gameField.data, field->data, field->width * field->height);

    unsigned char pause = 0;
    time_t time = 0;

    while (1) {
        int key;
        if (_kbhit()) {
            key = _getch();
            if (key == K_ENTER) {
                break;
            }
            else if (key == K_SPACE) {
                if (pause) {
                    pause = 0;
                }
                else {
                    pause = 1;
                }
            }
            else if (key == 0 || key == 224) {
                key = _getch();
                switch (key) {
                    case K_ARROW_UP:
                        if (delay > 50) {
                            delay /= 2;
                        }
                        break;
                    case K_ARROW_DOWN:
                        if (delay < 1600) {
                            delay *= 2;
                        }
                        break;
                }
            }
        }

        if (!pause) {
            time_t newTime = clock();
            if ((newTime - time) >= delay) {
                time = newTime;
                updateField(&gameField);
                drawField(&gameField);
            }
        }
    }
}
