#include <stdio.h>
#include <stdlib.h>
#include <string.h>


int main() {


	unsigned long long *array = malloc(sizeof(long long));
	unsigned long long size = 1;

	array[0] = 2;

	while (1) {
		unsigned long long new_num = 1;
		for (unsigned long long i = 0; i < size; i++) {
			new_num *= array[i];
		}
		new_num++;

		array = (unsigned long long *)realloc((void *)(array), (size + 1) * sizeof(unsigned long long));
		size++;

		array[size - 1] = new_num;

		printf("%llu \n", new_num);
	}
}
