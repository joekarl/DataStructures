#include <stdio.h>
#include <stdlib.h>
#include "hamming_numbers.h"

#define MAX_RECYCLED_NODES 100000000000

int can_stop(dl_list *final, dl_list *temp, int n);

//generate terms from a temp list and put the in the term list
//Also use recycled list nodes to maximize memory use
dl_list *generate_terms(dl_list *list, dl_list *term_list, unsigned int multiplier, dl_list *recycled_node_list);

//return a new or recycled node
dll_node *get_recycled_node(dl_list *recycled_node_list, unsigned long long data);

//clear a list and put its nodes in the recycled nodes list
void recycle_list_nodes(dl_list *list, dl_list *recycled_node_list);

//merge 2 lists and reuse recycled nodes to create a new list
dl_list *merge_lists(dl_list *l1, dl_list *l2, dl_list *recycled_node_list);

dl_list *generate_hamming_numbers(int n) 
{
  dl_list *final = create_dl_list();
  dl_list *temp = create_dl_list();
  dl_list *l2 = create_dl_list();
  dl_list *l3 = create_dl_list();
  dl_list *l5 = create_dl_list();
  dl_list *recycled_node_list = create_dl_list();

  add_node(temp,create_dll_node(2));
  add_node(temp,create_dll_node(3));
  add_node(temp,create_dll_node(5));

  while(!can_stop(final,temp,n))
  {
    dl_list *copy_list = final;
    final = merge_lists(final,temp,recycled_node_list);
    recycle_list_nodes(copy_list,recycled_node_list);
    free_list(copy_list);

    generate_terms(temp,l2,2,recycled_node_list);
    generate_terms(temp,l3,3,recycled_node_list);
    generate_terms(temp,l5,5,recycled_node_list);
    recycle_list_nodes(temp,recycled_node_list);
    free_list(temp);

    temp = merge_lists(l2,l3,recycled_node_list);

    copy_list = temp;
    temp = merge_lists(temp,l5,recycled_node_list);
    recycle_list_nodes(copy_list,recycled_node_list);
    free_list(copy_list);

    copy_list = NULL;

    recycle_list_nodes(l2,recycled_node_list);
    recycle_list_nodes(l3,recycled_node_list);
    recycle_list_nodes(l5,recycled_node_list);
  }

  //printf("Sequence finished generating. Cleaning up....\n");
  
  free_list(l2);
  free_list(l3);
  free_list(l5);
  l2 = NULL;
  l3 = NULL;
  l5 = NULL;

  free_list(temp);
  temp = NULL;

  free_list(recycled_node_list);
  recycled_node_list = NULL;

  //printf("Creating final list....\n");
  dl_list *copy_list = final;
  final = range_list(final, 0, n);

  free_list(copy_list);
  copy_list = NULL;

  return final;
}

//check to see if we have enough numbers in our list and see if the next iteration of numbers has any numbers that are part of the final list
//see README for explanation on how this works
int can_stop(dl_list *final, dl_list *temp, int n)
{
  rewind_list(temp);
  unsigned long long min = temp->current->data;

  /*
  rewind_list(final);
  int final_count = 0;
  while(final->current)
  {
    if (final->current->data <= min)
    {
      final_count++;
    } 
    else
    {
      break;
    }
    increment_list(final);
  }

  printf("Generated first %d terms so far\n",final_count);
  //*/

  return final->length >= n
    && get_list_node(final,n-1)->data <= min;
}

dl_list *generate_terms(dl_list *list, dl_list *term_list, unsigned int multiplier, dl_list *recycled_node_list)
{
  rewind_list(list);
  while(list->current)
  {
    dll_node *recycled_node = get_recycled_node(recycled_node_list, list->current->data * multiplier);
    add_node(term_list,recycled_node) ;
    increment_list(list);
  }
  return term_list;
}

void recycle_list_nodes(dl_list *list, dl_list *recycled_node_list)
{
  dll_node *recycled_node = NULL;
  while ((recycled_node = pop_list(list)))
  {
    if (recycled_node_list->length < MAX_RECYCLED_NODES)
    {
      recycled_node->data = 0;
      recycled_node->next = NULL;
      recycled_node->prev = NULL;
      add_node(recycled_node_list,recycled_node);
    }
    else
    {
      //printf("Freeing nodes because over max recycled nodes limit....\n");
      free_node(recycled_node);
    }
  }
}

dll_node *get_recycled_node(dl_list *recycled_node_list, unsigned long long data)
{
  dll_node *node = pop_list(recycled_node_list);
  if (!node) 
  {
    node = create_dll_node(data);
  } 
  else
  {
    node->data = data;
    node->prev = NULL;
    node->next = NULL;
  }
  return node;
}

//Assumes lists are already in ascending order
//merges them in ascending order
dl_list *merge_lists(dl_list *l1, dl_list *l2, dl_list *recycled_node_list)
{
  dl_list *merged_list = create_dl_list();

  rewind_list(l1);
  rewind_list(l2);
  
  //merge shared list indices
  while(l1->current && l2->current)
  {
    if (l1->current->data == l2->current->data)
    {
      dll_node *node = get_recycled_node(recycled_node_list,l1->current->data);
      add_node(merged_list, node);
      increment_list(l1);
      increment_list(l2);
    } 
    else if (l1->current->data < l2->current->data)
    {
      dll_node *node = get_recycled_node(recycled_node_list,l1->current->data);
      add_node(merged_list, node);
      increment_list(l1);
    } 
    else
    {
      dll_node *node = get_recycled_node(recycled_node_list,l2->current->data);
      add_node(merged_list, node);
      increment_list(l2);
    }
  }

  //merge any leftover nodes
  while(l1->current)
  {
    dll_node *node = get_recycled_node(recycled_node_list,l1->current->data);
    add_node(merged_list, node);
    increment_list(l1);
  }
  
  while(l2->current)
  {
    dll_node *node = get_recycled_node(recycled_node_list,l2->current->data);
    add_node(merged_list, node);
    increment_list(l2);
  }

  return merged_list;
}


