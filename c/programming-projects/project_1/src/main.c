/**
 * main.c
 *
 * Ce fichier contient la fonction main() du programme de manipulation
 * de fichiers pnm.
 *
 * @author: Pavlov Aleksandr s2400691
 * @date:
 * @projet: INFO0030 Projet 1
*/

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <ctype.h>
#include <getopt.h>

#include "pnm/pnm.h"

#define PROGRAM_NAME "./pnm"
#define VERSION "1.0"
#define AUTHORS "Pavlov Aleksandr (s2400691)"

enum {
   GETOPT_HELP_CHAR = -2,
   GETOPT_VERSION_CHAR = -3,
};

static struct option const longopts[] = {
   {"format", required_argument, NULL, 'f'},
   {"input", required_argument, NULL, 'i'},
   {"output", required_argument, NULL, 'o'},
   {"help", no_argument, NULL, GETOPT_HELP_CHAR},
   {"version", no_argument, NULL, GETOPT_VERSION_CHAR},
   {NULL, no_argument, NULL, 0}
};

const char *program_name;

void usage(int status) {
   if (status != EXIT_SUCCESS) {
      fprintf(stderr, "Try '%s --help' for more information.\n",
         program_name);
   } else {
      printf("Usage: %s [-f FORMAT] -i SOURCE -o DEST\n", program_name);
      fputs("\
Manipulates PNM format files.\n\
\n\
Mandatory arguments to long options are mandatory for short options too.\n\
  -f, --format=FORMAT          specify format FORMAT={PBM,PGM,PPM}\n\
  -i, --input=FILE             specify input file\n\
  -o, --output=FILE            specify output file\n\
      --help        display this help and exit\n\
      --version     output version information and exit\n\
", stdout);
   }
   exit(status);
}

int compare_ignore_case(const char *s1, const char *s2) {
   int i = 0;
   while (1) {
      char c1 = s1[i], c2 = s2[i];
      if (c1 == '\0' && c2 == '\0') return 1;
      if (c1 == '\0' || c2 == '\0') return 0;
      if (tolower(c1) != tolower(c2)) return 0;
      i++;
   }
}

int main(int argc, char **argv) {
   const char *format_string = NULL;
   const char *input_filename = NULL;
   const char *output_filename = NULL;

   FormatPNM format;
   PNM *image;

   program_name = argv[0];

   int optc;
   while ((optc = getopt_long(argc, argv, "f:i:o:", longopts, NULL)) != -1) {
      switch (optc) {
         case 'f':
            format_string = optarg;
            break;

         case 'i':
            input_filename = optarg;
            break;

         case 'o':
            output_filename = optarg;
            break;

         case GETOPT_HELP_CHAR:
            usage(EXIT_SUCCESS);
            break;

         case GETOPT_VERSION_CHAR:
            fprintf(stdout, "%s %s\n\nWritten by %s.\n",
               PROGRAM_NAME, VERSION, AUTHORS);
            exit(EXIT_SUCCESS);
            break;

         default:
            usage(EXIT_FAILURE);
      }
   }

   if (format_string == NULL) {
      fprintf(stderr, "%s: missing '-f' flag\n", program_name);
      usage(EXIT_FAILURE);
   }
   if (input_filename == NULL) {
      fprintf(stderr, "%s: missing '-i' flag\n", program_name);
      usage(EXIT_FAILURE);
   }
   if (output_filename == NULL) {
      fprintf(stderr, "%s: missing '-o' flag\n", program_name);
      usage(EXIT_FAILURE);
   }

   format = str_to_format(format_string);
   if (input_filename == NULL) {
      fprintf(stderr, "%s: unrecognized format '%s' specified with -f\n",
         program_name, format_string);
      usage(EXIT_FAILURE);
   }

   int ok = 1;
   switch (load_pnm(&image, input_filename)) {
      case PNM_LOAD_MEMORY_ERROR:
         fprintf(stderr, "%s: ", program_name);
         perror("");
         ok = 0;
         break;
      case PNM_LOAD_INVALID_FILENAME:
         fprintf(stderr, "%s: invalid filename '%s': ", program_name, input_filename);
         perror("");
         ok = 0;
         break;
      case PNM_LOAD_DECODE_ERROR:
         fprintf(stderr, "%s: '%s': decode error\n", program_name, input_filename);
         ok = 0;
         break;
   }





   return ok ? EXIT_SUCCESS : EXIT_FAILURE;
}

