#include <stdlib.h>
#include <stdio.h>
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

dl_list *create_dl_list()
{
  dl_list *list = malloc(sizeof(dl_list));
  list->head = NULL;
  list->tail = NULL;
  list->current = NULL;
  list->length = 0;
  return list;
}

void add_node(dl_list *list, int data)
{
  if (list->length == 0) 
  {
    dll_node *node = create_node(data);
    list->head = node;
    list->current = node;
    list->tail = node;
    list->length++;
  } 
  else 
  {
    fast_forward(list);
    list->tail->next = create_node(data);
    list->tail->next->prev = list->tail;
    list->tail = list->tail->next;
    list->length++;
  }
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

void print_list(dl_list *list)
{
  printf("[");
  dll_node *current = list->current;
  rewind_list(list);
  while(list->current){
    printf("%d",list->current->data);
    if (list->current != list->tail) 
    {
      printf(", ");
    }
    increment_list(list);
  }
  printf("]");
  list->current = current;
}

dll_node *get_list_node(dl_list *list, int index)
{
  if (!index)
  {
    return list->head;
  }
  else if (index == (list->length - 1))
  {
    return list->tail;
  }
  else
  {
    dll_node *node = list->head;
    int i = 0;
    while (i != index)
    {
      node = node->next;
      ++i;
      if (!node) return NULL;
    }
    return node;
  }
}


dl_list *merge_lists(dl_list *l1, dl_list *l2)
{
  dl_list *merged_list = create_dl_list();

  rewind_list(l1);
  rewind_list(l2);

  while(l1->current && l2->current)
  {
    if (l1->current->data == l2->current->data)
    {
      add_node(merged_list, l1->current->data);
      increment_list(l1);
      increment_list(l2);
    } 
    else if (l1->current->data < l2->current->data)
    {
      add_node(merged_list, l1->current->data);
      increment_list(l1);
    } 
    else
    {
      add_node(merged_list, l2->current->data);
      increment_list(l2);
    }
  }

  while(l1->current)
  {
    add_node(merged_list, l1->current->data);
    increment_list(l1);
  }
  
  while(l2->current)
  {
    add_node(merged_list, l2->current->data);
    increment_list(l2);
  }

  return merged_list;
}

dl_list *range_list(dl_list *list, int start, int end)
{
  int i = 0;
  dl_list *range_list = create_dl_list();
  rewind_list(list);
  while(list->current && i < end)
  {
    if (i++ >= start)
    {
      add_node(range_list, list->current->data);
    }
    increment_list(list);
  }
  return range_list;
}


