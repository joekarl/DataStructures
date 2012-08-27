
#include <stdio.h>
#include <stdlib.h>
#include "dbl_linked_list.h"

int main(int argc, char **argv)
{
  
  dl_list *list = create_dl_list();
  add_node(list,1);
  add_node(list,2);
  add_node(list,3);

  rewind_list(list);
  while(list->current)
  {
    printf("%d\n",list->current->data);
    increment_list(list);
  }

  rewind_list(list);

  print_list(list);
  printf("\n");

  free_list(list);

  return 0;
}
