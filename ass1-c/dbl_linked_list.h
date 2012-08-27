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

dl_list *create_dl_list();
void add_node(dl_list *list, int data);
void increment_list(dl_list *list);
void rewind_list(dl_list *list);
void free_list(dl_list *list);
void fast_forward(dl_list *list);
void print_list(dl_list *list);
dll_node *get_list_node(dl_list *list, int index);
dl_list *merge_lists(dl_list *l1, dl_list *l2);
dl_list *range_list(dl_list *list, int start, int end);

#endif
