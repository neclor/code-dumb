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

#include "my_system.h"
#include "pnm.h"

#define PROGRAM_NAME "./pnm"
#define VERSION "1.0"
#define AUTHORS "Pavlov Aleksandr (s2400691)"

struct option const longopts[] = {
   {"format", required_argument, NULL, 'f'},
   {"input", required_argument, NULL, 'i'},
   {"output", required_argument, NULL, 'o'},
   {GETOPT_HELP_OPTION_DECL},
   {GETOPT_VERSION_OPTION_DECL},
   {NULL, no_argument, NULL, 0}
};

const char *program_name;

void usage (int status) {
   if (status != EXIT_SUCCESS)
      emit_try_help();
   else {
      printf ("Usage: %s -f FORMAT -i SOURCE -o DEST\n", program_name);
      fputs ("\
Manipulates PNM format files.\n\
", stdout);

      emit_mandatory_arg_note();

      fputs("\
  -f, --format=FORMAT          specify format\n\
  -i, --input=FILE             specify input file\n\
  -o, --output=FILE            specify output file\n\
", stdout);
      fputs(HELP_OPTION_DESCRIPTION, stdout);
      fputs(VERSION_OPTION_DESCRIPTION, stdout);
   }
   exit(status);
}

void set_program_name(const char *name) {
   program_name = name;
}

int main(int argc, char **argv) {
   int c;

   char *format_string = NULL;
   char *input_file = NULL;
   char *output_file = NULL;

   set_program_name(argv[0]);

   while ((c = getopt_long(argc, argv, "f:i:o:", longopts, NULL)) != -1) {
      switch (c) {
         case 'f':
            format_string = optarg;
            break;

         case 'i':
            input_file = optarg;
            break;

         case 'o':
            output_file = optarg;
            break;

         case_GETOPT_HELP_CHAR;

         case_GETOPT_VERSION_CHAR(PROGRAM_NAME, VERSION, AUTHORS);

         default:
            usage(EXIT_FAILURE);
      }
   }

   printf("%s\n%s\n%s\n", format_string, input_file, output_file);

   return 0;
}

