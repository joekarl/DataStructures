#ifndef LINKEDLIST_H
#define LINKEDLIST_H

//Doubly linked list node
typedef struct dbl_list_node {
  int data;
  struct dbl_list_node *next;
  struct dbl_list_node *prev; 
} dll_node;

//Doubly linked list
//NOT THREADSAFE (rewind/increment/ff/free all change list globally)
typedef struct dl_list {
  struct dbl_list_node *head;
  struct dbl_list_node *tail;
  struct dbl_list_node *current;
  int length;
} dl_list;

//Malloc a dl_list and initialize it
dl_list *create_dl_list();

//Create a node with a given data value and add it to a list
void add_node(dl_list *list, unsigned int data);

//Move the list->current to the next node in the list
void increment_list(dl_list *list);

//Move the list->current to the head of the list
void rewind_list(dl_list *list);

//Free the list and all of its nodes
void free_list(dl_list *list);

//Move the list->current to the tail of the list
void fast_forward(dl_list *list);

//printf the list to stdout
void print_list(dl_list *list);

//return the node at a given index of the list
//if index is out of the list range, return NULL
dll_node *get_list_node(dl_list *list, int index);

//create a new list with an ascending order merge of the two provided lists
dl_list *merge_lists(dl_list *l1, dl_list *l2);

//create a new list containing the nodes within the range of the initial list
dl_list *range_list(dl_list *list, int start, int end);

#endif
