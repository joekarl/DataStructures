#include <stdlib.h>
#include "dbl_linked_list.h"


dll_node *create_node(int data)
{
  dll_node *node = malloc(sizeof(dll_node));
  node->next = NULL;
  node->prev = NULL;
  node->data = data;
  return node;
}

void free_node(dll_node *node)
{
  node->next = NULL;
  node->prev = NULL;
  free(node);
}

dl_list *create_dl_list(int data)
{
  dl_list *list = malloc(sizeof(dl_list));
  list->head = create_node(data);
  list->tail = list->head;
  list->current = list->head;
  list->length = 1;
  return list;
}

void add_node(dl_list *list, int data)
{
  dll_node *current = list->current;
  fast_forward(list);
  list->tail->next = create_node(data);
  list->tail->next->prev = list->tail;
  list->tail = list->tail->next;
  list->length++;
  list->current = current;
}

void increment_list(dl_list *list)
{
  if (!list->current) return;
  list->current = list->current->next;
}

void rewind_list(dl_list *list)
{
  list->current = list->head;
}

void free_list(dl_list *list)
{
  rewind_list(list);
  list->head = NULL;
  list->tail = NULL;
  list->length = 0;
  while(list->current)
  {
    dll_node *next = list->current->next;
    free_node(list->current);
    list->current = next;
  }
}

void fast_forward(dl_list *list)
{
  list->current = list->tail;
}


