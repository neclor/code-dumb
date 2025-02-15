/**
 * pnm.c
 * 
 * Ce fichier contient les définitions de types et 
 * les fonctions de manipulation d'images PNM.
 * 
 * @author: Aleksandr Pavlov s2400691
 * @date: 12.02.2025
 * @projet: INFO0030 Projet 1
*/

#include <stdio.h>
#include <stdlib.h>
// #include <assert.h>

#include "pnm.h"

struct PNM_t {
   FormatPNM format;
   unsigned int width;
   unsigned int height;
   unsigned int max_value;
   unsigned int *data;
};


int load_pnm(PNM **image, const char* filename) {
   FILE *file = fopen(filename, "r");
   if (file == NULL) {
      perror("File opening error");
      return -2;
   }





   

   fclose(file);
   return 0;
}


int write_pnm(PNM *image, const char* filename) {

   /* Insérez le code ici */

   return 0;
}
