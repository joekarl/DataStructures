#include <stdlib.h>
#include <stdio.h>
#include "dbl_linked_list.h"


dll_node *create_dll_node(unsigned long long data)
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

void add_node(dl_list *list, dll_node *node)
{
  if (!node) return;
  if (list->length == 0) 
  {
    //initialize list and set length to 0
    list->head = node;
    list->current = node;
    list->tail = node;
    list->length++;
  } 
  else 
  {
    //add node to tail of list
    fast_forward(list);
    list->tail->next = node;
    list->tail->next->prev = list->tail;
    list->tail = list->tail->next;
    list->length++;
  }
}

void increment_list(dl_list *list)
{
  //if current is null ignore call
  if (!list->current) return;
  list->current = list->current->next;
}

void rewind_list(dl_list *list)
{
  list->current = list->head;
}

dll_node *pop_list(dl_list *list)
{
  if (list && list->tail)
  {
    dll_node *node = list->tail;
    list->tail = list->tail->prev;
    list->length--;
    if (list->tail)
    {
      list->tail->next = NULL;
    } 
    else
    {
      list->head = NULL;
      list->current = NULL;
    }
    return node;
  }
  return NULL;
}

void free_list(dl_list *list)
{
  rewind_list(list);
  list->head = NULL;
  list->tail = NULL;
  list->length = 0;
  //loop through nodes freeing them one at a time
  while(list->current)
  {
    dll_node *next = list->current->next;
    free_node(list->current);
    list->current = next;
  }
  free(list);
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
    printf("%lld",list->current->data);
    //print seperator if not last in the list
    if (list->current != list->tail) 
    {
      printf(", ");
    }
    increment_list(list);
  }
  printf("]");
  list->current = current;
}

//optimized to grab head or tail
//if not head or tail O(n) to find node
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

dl_list *range_list(dl_list *list, int start, int end)
{
  int i = 0;
  dl_list *range_list = create_dl_list();
  rewind_list(list);
  while(list->current && i < end)
  {
    if (i++ >= start)
    {
      add_node(range_list, create_dll_node(list->current->data));
    }
    increment_list(list);
  }
  return range_list;
}


