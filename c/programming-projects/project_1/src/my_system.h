/*
 * This code is based on the GNU project system.h file.
 * See <https://www.gnu.org/software/coreutils/>
 * The original code is licensed under the GPLv3 license.
 * Copyright (c) Free Software Foundation.
 * See <https://www.gnu.org/licenses/>.
*/

/**
 * my_system.h
 * 
 * @author: Aleksandr Pavlov s2400691
 * @date: 12.02.2025
 * @projet: INFO0030 Projet 1
*/

#ifndef _MY_SYSTEM_H
#define _MY_SYSTEM_H 1

#include <stdio.h>

#define CHAR_MIN 0

/* Factor out some of the common --help and --version processing code.  */

/* These enum values cannot possibly conflict with the option values
   ordinarily used by commands, including CHAR_MAX + 1, etc.  Avoid
   CHAR_MIN - 1, as it may equal -1, the getopt end-of-options value.  */
enum {
   GETOPT_HELP_CHAR = (CHAR_MIN - 2),
   GETOPT_VERSION_CHAR = (CHAR_MIN - 3),
};

#define GETOPT_HELP_OPTION_DECL \
   "help", no_argument, NULL, GETOPT_HELP_CHAR
#define GETOPT_VERSION_OPTION_DECL \
   "version", no_argument, NULL, GETOPT_VERSION_CHAR

#define case_GETOPT_HELP_CHAR \
   case GETOPT_HELP_CHAR: \
      usage(EXIT_SUCCESS); \
      break;

#define HELP_OPTION_DESCRIPTION \
   "      --help        display this help and exit\n"
#define VERSION_OPTION_DESCRIPTION \
   "      --version     output version information and exit\n"

#define case_GETOPT_VERSION_CHAR(Program_name, Version, Authors) \
   case GETOPT_VERSION_CHAR: \
      fprintf(stdout, "%s %s\n\nWritten by %s.\n", \
         Program_name, Version, Authors); \
      exit(EXIT_SUCCESS); \
      break;

#define emit_try_help() \
   do { \
      fprintf(stderr, "Try '%s --help' for more information.\n", \
         program_name); \
   } while (0)

static inline void emit_mandatory_arg_note() {
   fputs("\n\
Mandatory arguments to long options are mandatory for short options too.\n\
", stdout);
}

#endif /* my_system.h  */
