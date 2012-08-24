#ifndef LINKEDLIST_H
#define LINKEDLIST_H

typedef struct dbl_list_node {
  int data;
  struct dbl_list_node *next;
  struct dbl_list_node *prev; 
} dll_node;

typedef struct dl_list {
  struct dbl_list_node *head;
  struct dbl_list_node *tail;
  struct dbl_list_node *current;
  int length;
} dl_list;

dl_list *create_dl_list(int data);
void add_node(dl_list *list, int data);
void increment_list(dl_list *list);
void rewind_list(dl_list *list);
void free_list(dl_list *list);
void fast_forward(dl_list *list);

#endif
