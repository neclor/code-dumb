/**
 * main.c
 * 
 * Ce fichier contient la fonction main() du programme de manipulation
 * de fichiers pnm.
 *
 * @author: Aleksandr Pavlov s2400691
 * @date: 
 * @projet: INFO0030 Projet 1
*/

#include <stdio.h>
#include <stdlib.h>
// #include <assert.h>
#include <unistd.h>
#include <ctype.h>
#include <getopt.h>

// #include "my_system.h"
#include "pnm.h"

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
      printf("Usage: %s -f FORMAT -i SOURCE -o DEST\n", program_name);
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
      //fputs(HELP_OPTION_DESCRIPTION, stdout);
      //fputs(VERSION_OPTION_DESCRIPTION, stdout);
   }
   exit(status);
}

int main(int argc, char **argv) {
   int optc;

   char *format_string = NULL;
   char *input_file = NULL;
   char *output_file = NULL;

   program_name = argv[0];

   while ((optc = getopt_long(argc, argv, "f:i:o:", longopts, NULL)) != -1) {
      switch (optc) {
         case 'f':
            format_string = optarg;
            break;

         case 'i':
            input_file = optarg;
            break;

         case 'o':
            output_file = optarg;
            break;

         // case_GETOPT_HELP_CHAR;
         case GETOPT_HELP_CHAR:
            usage(EXIT_SUCCESS);
            break;

         // case_GETOPT_VERSION_CHAR(PROGRAM_NAME, VERSION, AUTHORS);
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
   if (input_file == NULL) {
      fprintf(stderr, "%s: missing '-i' flag\n", program_name);
      usage(EXIT_FAILURE);
   }
   if (output_file == NULL) {
      fprintf(stderr, "%s: missing '-o' flag\n", program_name);
      usage(EXIT_FAILURE);
   }



   FormatPNM abc;



   printf("format: %s\ninput: %s\noutput: %s\n", format_string, input_file, output_file);

   return 0;
}

