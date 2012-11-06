#import "LinearProbeHash.h"
#import "ModifiedLinearProbeHash.h"
#import "NumericKey.h"
#import <stdio.h>
#import <assert.h>
#import <unistd.h>
#import <stdlib.h>
#import <sys/time.h>
#include <time.h>

#define KEYS 500000
#define SHUFFLES 1000000

int main()
{
  //create keys and objects
  RObject ** keys = calloc(KEYS, sizeof(RObject));
  RObject ** values = calloc(KEYS, sizeof(RObject));
  int * insertSequence = calloc(KEYS, sizeof(int));
  int * searchSequence = calloc(KEYS, sizeof(int));  
  
  int i;
  for (i = 0; i < KEYS; ++i) 
  {
    keys[i] = [[NumericKey alloc] initWithValue:rand() % KEYS];
    values[i] = [[RObject alloc] init];
    insertSequence[i] = i;
    searchSequence[i] = i;
  }

  //setup randomizer
  srand(time(NULL));

  //shuffle the input and search sequence
  for (i = 0; i < SHUFFLES; ++i)
  {
    int r1 = rand() % KEYS;
    int r2 = rand() % KEYS;
    int r3 = rand() % KEYS;
    int r4 = rand() % KEYS;
    int temp;
    temp = insertSequence[r1];
    insertSequence[r1] = insertSequence[r2];
    insertSequence[r2] = temp;
    
    temp = searchSequence[r3];
    searchSequence[r3] = searchSequence[r4];
    searchSequence[r4] = temp;
  }


  //create a hash the size of our domain
  id linearHash = [[LinearProbeHash alloc] initWithCapacity:KEYS];
  struct timeval t;
  gettimeofday(&t, NULL);
  printf("Starting Normal time at %d\n", (int)t.tv_sec);

  //insert stuff into the hash
  for (i = 0; i < KEYS; ++i)
  {
    [linearHash insert:values[insertSequence[i]] withKey:keys[i]];
  }
 
  //search for things in the hash
  for (i = 0; i < KEYS; ++i)
  {
    [linearHash objectWithKey:keys[searchSequence[i]]];
  }

  gettimeofday(&t, NULL);
  printf("Ending time at %d\n", (int)t.tv_sec);

  id modLinearHash = [[ModifiedLinearProbeHash alloc] initWithCapacity:KEYS];
  gettimeofday(&t, NULL);
  printf("Starting Modified time at %d\n", (int)t.tv_sec);

  for (i = 0; i < KEYS; ++i)
  {
    [modLinearHash insert:values[insertSequence[i]] withKey:keys[i]];
  }
 
  for (i = 0; i < KEYS; ++i)
  {
    [modLinearHash objectWithKey:keys[searchSequence[i]]];
  }

  gettimeofday(&t, NULL);
  printf("Ending time at %d\n", (int)t.tv_sec);

  //report on the number collisions that each function had
  printf("=====================================================\n");
  printf("Collisions\n\n");
  printf("Collisions in linear probe: %d\n", [linearHash numberOfCollisions]);
  printf("Collisions in modified linear probe: %d\n",[linearHash numberOfCollisions]);

  
  return 0;
}
