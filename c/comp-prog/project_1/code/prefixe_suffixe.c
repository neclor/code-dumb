#include <assert.h>
#include <stdlib.h>

#include "prefixe_suffixe.h"

// ===== Prototypes =====

static int pref_equal_suff(int *T, const unsigned int N, unsigned int k);

// ===== Code =====

/**
 * Sp 1
 * Checking all prefixes starting from the longest one until we find a match
 * or exhaust all possibilities.
 */
int prefixe_suffixe(int *T, const unsigned int N) {
   assert((T != NULL) && (0 < N));

   unsigned int k = N - 1;
   while (k > 0) {
      if (pref_equal_suff(T, N, k)) return k;
      k--;
   }
   return 0;
}

/**
 * Sp 2
 * Comparing the prefix and suffix of the given length, element by element.
 */
static int pref_equal_suff(int *T, const unsigned int N, const unsigned int k) {
   assert((T != NULL) && (0 < N) && (0 < k && k < N));

   unsigned int i = 0;
   while (i <= k - 1) {
      if (T[i] != T[N - k + i]) return 0;
      i++;
   }
   return 1;
}
