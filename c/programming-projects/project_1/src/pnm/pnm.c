/**
 * pnm.c
 * 
 * @author: Pavlov Aleksandr s2400691
 * @date: 12.02.2025
 * @projet: INFO0030 Projet 1
*/

#include <stdlib.h>
#include <stdio.h>
#include <ctype.h>

#include "my_string.h"
#include "pnm.h"

struct PNM_t {
   FormatPNM format;
   size_t width;
   size_t height;
   unsigned int max_value;
   unsigned int *data;
};

FormatPNM str_to_format(const char *format_string) {
   if (my_strcasecmp(format_string, "PBM") == 0) return FORMAT_PBM;
   if (my_strcasecmp(format_string, "PGM") == 0) return FORMAT_PGM;
   if (my_strcasecmp(format_string, "PPM") == 0) return FORMAT_PPM;
   return NULL;
}


int allocate_pnm(PNM **image) {
   *image = malloc(sizeof(PNM));
   if (image == NULL) return 1;
   return 0;
}

void free_pnm(PNM **image) {
   free((*image)->data);
   free(*image);
   *image = NULL;
}

int load_pnm(PNM **image, const char *filename) {
   FILE *file = fopen(filename, "r");
   if (file == NULL) return PNM_LOAD_INVALID_FILENAME;

   printf("%s opened\n", filename);
   

   // if (allocate_pnm(image) == 1) return PNM_LOAD_MEMORY_ERROR;



   

   fclose(file);
   return PNM_LOAD_SUCCESS;
}


int write_pnm(PNM *image, const char *filename) {
   /* Insérez le code ici */

   return 0;
}





/*

fscanf(FILE *stream, format, …)	Читает форматированные данные из файла.

fgets(char *str, int size, FILE *stream)	Читает строку, включая пробелы и \n.

fgetc(FILE *stream)	Читает один символ.

getc(FILE *stream)	Аналогично fgetc().

ungetc(int ch, FILE *stream)	"Возвращает" символ в поток.

fread(void *ptr, size_t size, size_t count, FILE *stream)




*/