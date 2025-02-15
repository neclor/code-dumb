/**
 * my_string.c
 * 
 * @author: Pavlov Aleksandr s2400691
 * @date: 
 * @projet: INFO0030 Projet 1
*/

#include <stdlib.h>
#include <ctype.h>

int my_strcasecmp(const char *s1, const char *s2) {
   const unsigned char *p1 = (const unsigned char *)s1;
   const unsigned char *p2 = (const unsigned char *)s2;
   if (p1 == p2) return 0;
   int result;
   while ((result = tolower(*p1) - tolower(*p2)) == 0) {
      if (*p1 == '\0') break;
      p1++;
      p2++;
   }
   return result;
}
