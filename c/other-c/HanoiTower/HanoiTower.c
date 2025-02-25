#include <stdio.h>
#include <stdlib.h>
#include <string.h>


#define COUNT 7


int tower_1[COUNT] = { 0 };
int tower_2[COUNT] = { 0 };
int tower_3[COUNT] = { 0 };


int remove(int array[COUNT]) {
    for (int i = 1; i < COUNT; i++) {
        if (array[i] == 0) {
            int num = array[i - 1];
            array[i - 1] = 0;
            return num;
        }
    }
    int num = array[COUNT - 1];
    array[COUNT - 1] = 0;
    return num;
}

void add(int array[COUNT], int number) {
    for (int i = 0; i < COUNT; i++) {
        if (array[i] == 0) {
            array[i] = number;
            return;
        }
    }
}

void draw_towers() {
    printf("|");
    for (int i = 0; i < COUNT; i++) {
        ;
        if (tower_1[i] == 0) {
            printf("-");
        }
        else {
            printf("(%d)", tower_1[i]);
        }
    }
    printf("\n|");
    for (int i = 0; i < COUNT; i++) {
        if (tower_2[i] == 0) {
            printf("-");
        }
        else {
            printf("(%d)", tower_2[i]);
        }
    }
    printf("\n|");
    for (int i = 0; i < COUNT; i++) {
        if (tower_3[i] == 0) {
            printf("-");
        }
        else {
            printf("(%d)", tower_3[i]);
        }
    }
    printf("\n");
    printf("\n");
}

void move(int number, int from[COUNT], int to[COUNT], int buffer[COUNT]) {
    if (number == 1) {
        add(to, remove(from));
        draw_towers();
    }
    else if (number > 1) {
        move(number - 1, from, buffer, to);
        move(1, from, to, buffer);
        move(number - 1, buffer, to, from);
    }
}

int main() {
    for (int i = 0; i < COUNT; i++) {
        tower_1[i] = COUNT - i;
    }
    draw_towers();
    move(COUNT, tower_1, tower_2, tower_3);
    draw_towers();
}
