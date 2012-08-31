#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include "dbl_linked_list.h"
#include "hamming_numbers.h"

int main(int argc, char **argv)
{
  
  //make sure list is working
  dl_list *list = create_dl_list();
  add_node(list,create_dll_node(1));
  add_node(list,create_dll_node(2));
  add_node(list,create_dll_node(3));

  assert(list->length == 3);
  
  rewind_list(list);
  while(list->current)
  {
    printf("%lld\n",list->current->data);
    increment_list(list);
  }

  rewind_list(list);
  assert(list->head == list->current);

  fast_forward(list);
  assert(list->tail == list->current);

  rewind_list(list);
  print_list(list);
  printf("\n");

  pop_list(list);

  assert(list->length == 2);
  assert(list->head->data == 1);
  assert(list->tail->data == 2);
  assert(list->tail->next == NULL);

  pop_list(list);

  assert(list->length == 1);
  assert(list->head->data == 1);
  assert(list->tail->data == 1);
  assert(list->tail->next == NULL);

  pop_list(list);

  assert(list->length == 0);
  assert(list->head == NULL);
  assert(list->tail == NULL);
  assert(list->current == NULL);

  free_list(list);
  list = NULL;

  //Hamming numbers assertions
  dl_list *seq = generate_hamming_numbers(1);
  assert(seq->length == 1);
  assert(seq->head->data == 2);
  
  free_list(seq);
  seq = NULL;
  
  int expected[20];
  expected[0] = 2;
  expected[1] = 3;
  expected[2] = 4;
  expected[3] = 5;
  expected[4] = 6;
  expected[5] = 8;
  expected[6] = 9;
  expected[7] = 10;
  expected[8] = 12;
  expected[9] = 15;
  expected[10] = 16;
  expected[11] = 18;
  expected[12] = 20;
  expected[13] = 24;
  expected[14] = 25;
  expected[15] = 27;
  expected[16] = 30;
  expected[17] = 32;
  expected[18] = 36;
  expected[19] = 40;

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
