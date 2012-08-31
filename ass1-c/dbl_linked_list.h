#ifndef LINKEDLIST_H
#define LINKEDLIST_H

//Doubly linked list node
typedef struct dbl_list_node {
  unsigned long long data;
  struct dbl_list_node *next;
  struct dbl_list_node *prev; 
} dll_node;

//Doubly linked list
//NOT THREADSAFE (rewind/increment/ff/free all change list globally)
typedef struct dl_list {
  struct dbl_list_node *head;
  struct dbl_list_node *tail;
  struct dbl_list_node *current;
  unsigned long long length;
} dl_list;

//Malloc a dll_node and initialize it
dll_node *create_dll_node(unsigned long long data);

//Malloc a dl_list and initialize it
dl_list *create_dl_list();

//add a node with a given data value and add it to a list
void add_node(dl_list *list, dll_node *data);

//Move the list->current to the next node in the list
void increment_list(dl_list *list);

//Move the list->current to the head of the list
void rewind_list(dl_list *list);

//Free a list node
void free_node(dll_node *node);

//Free the list and all of its nodes
void free_list(dl_list *list);

//Move the list->current to the tail of the list
void fast_forward(dl_list *list);

//Remove node from tail of list
dll_node *pop_list(dl_list *list);

//printf the list to stdout
void print_list(dl_list *list);

//return the node at a given index of the list
//if index is out of the list range, return NULL
dll_node *get_list_node(dl_list *list, int index);

//create a new list containing the nodes within the range of the initial list
dl_list *range_list(dl_list *list, int start, int end);

#endif
