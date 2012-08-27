#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "hamming_numbers.h"
#include "dbl_linked_list.h"

char *help_string() {
  return "Usage: sequence_generation [-h] [--help] <number to generate>\n";
}

int main(int argc, char **argv)
{
  int n = 0;

  if (argc == 1 
    || strcmp(argv[1],"-h") == 0
    || strcmp(argv[1],"--help") == 0)
  {
    printf("%s", help_string());
    return 0;
  } 
  else
  {
    char * error = 0;
    n = strtol(argv[1], &error, 10);
    if (n <= 0 || (*error) != 0)
    {
      printf("Invalid Input\n%s", help_string());
      return 1;
    }
  }

  dl_list *seq = generate_hamming_numbers(n);

  print_list(seq);
  printf("\n");

  return 0;
}
