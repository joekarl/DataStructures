#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include "dbl_linked_list.h"
#include "hamming_numbers.h"

int main(int argc, char **argv)
{
  
  //make sure list is working
  dl_list *list = create_dl_list();
  add_node(list,1);
  add_node(list,2);
  add_node(list,3);

  assert(list->length == 3);
  
  rewind_list(list);
  while(list->current)
  {
    printf("%d\n",list->current->data);
    increment_list(list);
  }

  rewind_list(list);
  assert(list->head == list->current);

  fast_forward(list);
  assert(list->tail == list->current);

  rewind_list(list);
  print_list(list);
  printf("\n");

  free_list(list);
  list = NULL;

  //Hamming numbers assertions
  dl_list *seq = generate_hamming_numbers(1);
  assert(seq->length == 1);
  assert(seq->head->data == 1);
  
  free_list(seq);
  seq = NULL;
  
  int expected[20];
  expected[0] = 1;
  expected[1] = 2;
  expected[2] = 3;
  expected[3] = 4;
  expected[4] = 5;
  expected[5] = 6;
  expected[6] = 8;
  expected[7] = 9;
  expected[8] = 10;
  expected[9] = 12;
  expected[10] = 15;
  expected[11] = 16;
  expected[12] = 18;
  expected[13] = 20;
  expected[14] = 24;
  expected[15] = 25;
  expected[16] = 27;
  expected[17] = 30;
  expected[18] = 32;
  expected[19] = 36;

  seq = generate_hamming_numbers(20);
  int i = 0;
  rewind_list(seq);
  while (seq->current)
  {
    assert(seq->current->data == expected[i++]);
    increment_list(seq);
  }

  free_list(seq);

  printf("All tests successful\n");

  return 0;
}
