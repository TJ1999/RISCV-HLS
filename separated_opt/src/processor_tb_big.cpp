#if 0
#include "rv32i.h"
#include "assert.h"
#include <iostream>
#include <iomanip>
#include <vector>
#include <limits>

#include "test.h"

std::uint64_t instruction_counter = 0;
extern u32 g_pc;

void run_program(u32 *prog) {
  u1 error;
  while (1) {
    do_process(prog, &error);
    if (g_pc == 0x100) {  // fixed address in linker
      std::cout << "start" << std::endl;
    }
    instruction_counter++;
    if (g_pc == 0x200) {  // fixed address in linker
      std::cout << "stop" << std::endl;
      std::cout << "instructions taken: " << instruction_counter << std::endl;
      break;
    }
    if (error) {
      break;
    }
  }
}

int main() {
  run_program(dry);
  return 0;
}
#endif
