#include <stdio.h>

#include "prefixe_suffixe.h"


#define N1 9
#define N2 10
#define N3 9

#define N4 17
#define N5 5


int main(void) {
   // const unsigned int N1 = 9;
   // const unsigned int N2 = 10;
   // const unsigned int N3 = 9;

   int T1[N1] = {1,4,2,4,5,1,4,2,4};
   int T2[N2] = {1,2,3,2,1,1,2,3,2,1};
   int T3[N3] = {3,2,3,2,1,2,3,2,1};

   int T4[N4] = {1,2,3,4,1,2,3,1,2,3,4,1,2,3,4,1,2};
   int T5[N5] = {0,0,0,0,0};

   printf("Length longest prefix/suffix of T1: %u\n", prefixe_suffixe(T1, N1)); // 4
   printf("Length longest prefix/suffix of T2: %u\n", prefixe_suffixe(T2, N2)); // 5
   printf("Length longest prefix/suffix of T3: %u\n", prefixe_suffixe(T3, N3)); // 0

   printf("\n");
   printf("Length longest prefix/suffix of T4: %u\n", prefixe_suffixe(T4, N4)); // 6
   printf("Length longest prefix/suffix of T5: %u\n", prefixe_suffixe(T5, N5)); // 4
}
