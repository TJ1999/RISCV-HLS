#if 0
#include "rv32i.h"
#include "assert.h"
#include <iostream>
#include <iomanip>
#include <vector>
#include <limits>

#include "test.h"

std::uint64_t instruction_counter = 0;

void run_program(u32* prog) {
	u32 pc = 0;
	u1 error = 0;
	std::cout << "starting program..." << std::endl;

	while(1) {
		processor(prog, error, pc);
		if (pc == 0x100) {  // fixed address in linker
			std::cout << "start" << std::endl;
		}
		instruction_counter++;
		if (pc == 0x200) {  // fixed address in linker
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
