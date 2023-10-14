#include "helper.h"
#include <unistd.h>

extern unsigned int tohost;
void Start_Timer() {
  asm("nop");
}
void Stop_Timer() {
  tohost = 1;
}

static char memory[0x4000];
static char *memory_ptr = memory;
static char *upper_limit = &memory[0x4000];

void *_sbrk(intptr_t increment) {
  char* result = memory_ptr;
  if (memory_ptr + increment <= upper_limit) {
    memory_ptr += increment;
    return result;
  } else {
    return (void *) -1;
  }
}
