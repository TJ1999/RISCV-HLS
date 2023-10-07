#if 0
#include "rv32i.h"
#include "assert.h"
#include <iostream>
#include <vector>

void processor_tick_n(unsigned int times, std::vector<u32> &memory) {
  u1 error = static_cast<u1>(1);
  for (int i = 0; i < times; i++) {
    processor(memory.data(), error);
  }
  if (error == 1) {
    std::cout << "Error in processor!";
    assert(false);
  }
}

bool check_mem(unsigned int test_no, std::vector<u32> &mem, unsigned int mem_pos, i32 value) {
  i32 result = static_cast<u32>(mem[mem_pos / 4]);
  if (result != value) {
    std::cout << "Test " << test_no << " failed: " << result << " != " << value << std::endl;
    return false;
  }
  std::cout << "Test " << test_no << " successful" << std::endl;
  return true;
}

bool check_mem_byte(unsigned int test_no, std::vector<u32> &mem, unsigned int mem_pos, u8 value) {
  i32 temp = static_cast<i32>(mem[mem_pos / 4]);
  u8 result = temp >> ((mem_pos % 4) * 8);
  if (result != value) {
    std::cout << "Test " << test_no << " failed: " << result << " != " << value << std::endl;
    return false;
  }
  std::cout << "Test " << test_no << " successful" << std::endl;
  return true;
}

int main() {
  unsigned int test_no = 0;
  std::vector<u32> memory;

  // TEST1: Test LUI
  test_no++;
  memory = { 0x0004'50b7,  // lui x1, 0x45
      0x0010'2023,  // sw x1, 0(x0)
      };
  processor_tick_n(2, memory);
  assert(check_mem(test_no, memory, 0, 0x0004'5000));
  reset_processor();

  // TEST2: Test AUIPC
  test_no++;
  memory = { 0x0000'0013,  // nop
      0x0000'1097,  // auipc x1, 1
      0x0010'2023,  // sw x1, 0(x0)
      };
  processor_tick_n(3, memory);
  assert(check_mem(test_no, memory, 0, 0x0000'1004));
  reset_processor();

  // TEST3: Test JAL
  test_no++;
  memory = { 0x0000'0013,  // nop
      0x0040'00EF,  // jal x1, 4
      0x0010'2023,  // sw x1, 0(x0)
      };
  processor_tick_n(3, memory);
  assert(check_mem(test_no, memory, 0, 8));
  reset_processor();

  // TEST4: Test JALR
  test_no++;
  memory = { 0x0040'0113,  // addi x2, x0, 4
      0x0081'00E7,  // jalr x1, x2, 8
      0x0000'0013,  // nop
      0x0010'2023,  // sw x1, 0(x0)
      };
  processor_tick_n(3, memory);
  assert(check_mem(test_no, memory, 0, 8));
  reset_processor();

  // TEST5: Test BEQ
  test_no++;
  memory = { 0x07B0'0093,  // addi x1, x0, 123
      0x07B0'0113,  // addi x2, x0, 123
      0x0020'8463,  // beq x1, x2, 8
      0xFF5F'F06F,  // j entry
      0x0010'2023,  // sw x1, 0(x0)
      };
  processor_tick_n(4, memory);
  assert(check_mem(test_no, memory, 0, 123));
  reset_processor();

  // TEST6: Test BNE
  test_no++;
  memory = { 0xFFE0'0093,  // addi x1, x0, -2
      0x0020'0113,  // addi x2, x0, 2
      0x0020'9463,  // bne x1, x2, 8
      0xFF5F'F06F,  // j entry
      0x0010'2023,  // sw x1, 0(x0)
      };
  processor_tick_n(4, memory);
  assert(check_mem(test_no, memory, 0, -2));
  reset_processor();

  // TEST7: Test BLT
  test_no++;
  memory = { 0x07B0'0093,  // addi x1, x0, 123
      0x07C0'0113,  // addi x2, x0, 124
      0x0020'C463,  // blt x1, x2, 8
      0xFF5F'F06F,  // j entry
      0x0010'2023,  // sw x1, 0(x0)
      };
  processor_tick_n(4, memory);
  assert(check_mem(test_no, memory, 0, 123));
  reset_processor();

  // TEST8: Test BGE
  test_no++;
  memory = { 0x07C0'0093,  // addi x1, x0, 124
      0x07B0'0113,  // addi x2, x0, 123
      0x0020'D463,  // bge x1, x2, 8
      0xFF5F'F06F,  // j entry
      0x0010'2023,  // sw x1, 0(x0)
      };
  processor_tick_n(4, memory);
  assert(check_mem(test_no, memory, 0, 124));
  reset_processor();

  // TEST9: Test BLTU
  test_no++;
  memory = { 0x07C0'0093,  // addi x1, x0, 124
      0xFFF0'0113,  // addi x2, x0, -1
      0x0020'E463,  // bltu x1, x2, 8
      0xFF5F'F06F,  // j entry
      0x0010'2023,  // sw x1, 0(x0)
      };
  processor_tick_n(4, memory);
  assert(check_mem(test_no, memory, 0, 124));
  reset_processor();

  // TEST10: Test BGEU
  test_no++;
  memory = { 0xFFF0'0093,  // addi x1, x0, -1
      0x07B0'0113,  // addi x2, x0, 123
      0x0020'F463,  // bgeu x1, x2, 8
      0xFF5F'F06F,  // j entry
      0x0010'2023,  // sw x1, 0(x0)
      };
  processor_tick_n(4, memory);
  assert(check_mem(test_no, memory, 0, -1));
  reset_processor();

  // TEST11: Test LB
  test_no++;
  memory = { 0x0090'0083,  // lb x1, 9(x0)
      0x0010'2023,  // sw x1, 0(x0)
      0x0001'F100,  // .word
      };
  processor_tick_n(2, memory);
  assert(check_mem(test_no, memory, 0, -15));
  reset_processor();

  // TEST12: Test LH
  test_no++;
  memory = { 0x00A0'1083,  // lh x1, 10(x0)
      0x0010'2023,  // sw x1, 0(x0)
      0xFC18'1234,  // .word
      };
  processor_tick_n(2, memory);
  assert(check_mem(test_no, memory, 0, -1'000));
  reset_processor();

  // TEST13: Test LW
  test_no++;
  memory = { 0x0080'2083,  // lw x1, 8(x0)
      0x0010'2023,  // sw x1, 0(x0)
      0xFFED2979,  // .word -1234567
      };
  processor_tick_n(2, memory);
  assert(check_mem(test_no, memory, 0, -1'234'567));
  reset_processor();

  // TEST14: Test LBU
  test_no++;
  memory = { 0x0090'4083,  // lbu x1, 9(x0)
      0x0010'2023,  // sw x1, 0(x0)
      0x1234'FF00,  // .word
      };
  processor_tick_n(2, memory);
  assert(check_mem(test_no, memory, 0, 255));
  reset_processor();

  // TEST15: Test LHU
  test_no++;
  memory = { 0x00A0'5083,  // lhu x1, 10(x0)
      0x0010'2023,  // sw x1, 0(x0)
      0xFF00'1234,  // .word
      };
  processor_tick_n(2, memory);
  assert(check_mem(test_no, memory, 0, 65280));
  reset_processor();

  // TEST16: Test SB
  test_no++;
  memory = { 0x1234'50B7,  // lui	x1, %hi(0x12345678)
      0x6780'8093,  // addi x1, x1, %lo(0x12345678)
      0x0010'0123,  // sb x1, 2(x0)
      };
  processor_tick_n(3, memory);
  assert(check_mem_byte(test_no, memory, 2, 0x78));
  reset_processor();

  // TEST17: Test SH
  test_no++;
  memory = { 0x1234'50B7,  // lui	x1, %hi(0x12345678)
      0x6780'8093,  // addi x1, x1, %lo(0x12345678)
      0x0010'1123,  // sh x1, 2(x0)
      };
  processor_tick_n(3, memory);
  assert(check_mem_byte(test_no, memory, 2, 0x78));
  assert(check_mem_byte(test_no, memory, 3, 0x56));
  reset_processor();

  // TEST18: Test SW
  test_no++;
  memory = { 0x1234'50B7,  // lui	x1, %hi(0x12345678)
      0x6780'8093,  // addi x1, x1, %lo(0x12345678)
      0x0010'2023,  // sw x1, 0(x0)
      };
  processor_tick_n(3, memory);
  assert(check_mem(test_no, memory, 0, 0x12345678));
  reset_processor();

  // TEST19: Test ADDI
  test_no++;
  memory = { 0x4D20'0093,  // addi x1, x0, 1234
      0x0010'2023,  // sw x1, 0(x0)
      };
  processor_tick_n(2, memory);
  assert(check_mem(test_no, memory, 0, 1234));
  reset_processor();

  // TEST20: Test SLTI
  test_no++;
  memory = { 0xFFF0'0113,  // addi x2, x0, -1
      0x0011'2093,  // slti x1, x2, 1
      0x0010'2023,  // sw x1, 0(x0)
      };
  processor_tick_n(3, memory);
  assert(check_mem(test_no, memory, 0, 1));
  reset_processor();

  // TEST21: Test SLTIU
  test_no++;
  memory = { 0x0010'0113,  // addi x2, x0, 1
      0xFFF1'3093,  // slti x1, x2, -1
      0x0010'2023,  // sw x1, 0(x0)
      };
  processor_tick_n(3, memory);
  assert(check_mem(test_no, memory, 0, 1));
  reset_processor();

  // TEST22: Test XORI
  test_no++;
  memory = { 0x0120'0113,  // addi x2, x0, 0x12
      0x0341'4093,  // xori x1, x2, 0x34
      0x0010'2023,  // sw x1, 0(x0)
      };
  processor_tick_n(3, memory);
  assert(check_mem(test_no, memory, 0, 0x26));
  reset_processor();

  // TEST23: Test ORI
  test_no++;
  memory = { 0x0120'0113,  // addi x2, x0, 0x12
      0x0341'6093,  // ori x1, x2, 0x34
      0x0010'2023,  // sw x1, 0(x0)
      };
  processor_tick_n(3, memory);
  assert(check_mem(test_no, memory, 0, 0x36));
  reset_processor();

  // TEST24: Test ANDI
  test_no++;
  memory = { 0x0120'0113,  // addi x2, x0, 0x12
      0x0341'7093,  // andi x1, x2, 0x34
      0x0010'2023,  // sw x1, 0(x0)
      };
  processor_tick_n(3, memory);
  assert(check_mem(test_no, memory, 0, 0x10));
  reset_processor();

  // TEST25: Test SLLI
  test_no++;
  memory = { 0x0010'0113,  // addi x2, x0, 1
      0x01E1'1093,  // slli x1, x2, 30
      0x0010'2023,  // sw x1, 0(x0)
      };
  processor_tick_n(3, memory);
  assert(check_mem(test_no, memory, 0, 0x4000'0000));
  reset_processor();

  // TEST26: Test SRLI
  test_no++;
  memory = { 0x00C0'2103,  // lw x2, 12(x0)
      0x00C1'5093,  // srli x1, x2, 12
      0x0010'2023,  // sw x1, 0(x0)
      0xFF00'0000,  // -0x01000000
      };
  processor_tick_n(3, memory);
  assert(check_mem(test_no, memory, 0, 0x000f'f000));
  reset_processor();

  // TEST27: Test SRAI
  test_no++;
  memory = { 0x00C0'2103,  // lw x2, 12(x0) # -0x01000000
      0x40C1'5093,  // srai x1, x2, 12
      0x0010'2023,  // sw x1, 0(x0)
      0xFF00'0000,  // -0x01000000
      };
  processor_tick_n(3, memory);
  assert(check_mem(test_no, memory, 0, 0xffff'f000));
  reset_processor();

  // TEST28: Test ADD
  test_no++;
  memory = { 0x4000'0193,  // addi x3, x0, 1024
      0x2000'0113,  // addi x2, x0, 512
      0x0031'00B3,  // add x1, x2, x3
      0x0010'2023,  // sw x1, 0(x0)
      };
  processor_tick_n(4, memory);
  assert(check_mem(test_no, memory, 0, 1536));
  reset_processor();

  // TEST29: Test SUB
  test_no++;
  memory = { 0x4000'0193,  // addi x3, x0, 1024
      0x4010'0113,  // addi x2, x0, 1025
      0x4021'80B3,  // sub x1, x3, x2
      0x0010'2023,  // sw x1, 0(x0)
      };
  processor_tick_n(4, memory);
  assert(check_mem(test_no, memory, 0, -1));
  reset_processor();

  // TEST30: Test SLL
  test_no++;
  memory = { 0x0010'0193,  // addi x3, x0, 1
      0x01E0'0113,  // addi x2, x0, 30
      0x0021'90B3,  // sll x1, x3, x2
      0x0010'2023,  // sw x1, 0(x0)
      };
  processor_tick_n(4, memory);
  assert(check_mem(test_no, memory, 0, 0x4000'0000));
  reset_processor();

  // TEST31: Test SLT
  test_no++;
  memory = { 0xFFF0'0193,  // addi x3, x0, -1
      0x0010'0113,  // addi x2, x0, 1
      0x0021'A0B3,  // sll x1, x3, x2
      0x0010'2023,  // sw x1, 0(x0)
      };
  processor_tick_n(4, memory);
  assert(check_mem(test_no, memory, 0, 1));
  reset_processor();

  // TEST32: Test SLTU
  test_no++;
  memory = { 0x0010'0193,  // addi x3, x0, 1
      0xFFF0'0113,  // addi x2, x0, -1
      0x0021'B0B3,  // sll x1, x3, x2
      0x0010'2023,  // sw x1, 0(x0)
      };
  processor_tick_n(4, memory);
  assert(check_mem(test_no, memory, 0, 1));
  reset_processor();

  // TEST33: Test XOR
  test_no++;
  memory = { 0x0120'0193,  // addi x3, x0, 0x12
      0x0340'0113,  // addi x2, x0, 0x34
      0x0021'C0B3,  // xor x1, x3, x2
      0x0010'2023,  // sw x1, 0(x0)
      };
  processor_tick_n(4, memory);
  assert(check_mem(test_no, memory, 0, 0x26));
  reset_processor();

  // TEST34: Test SRL
  test_no++;
  memory = { 0x0100'2183,  // lw x3, 16(x0)
      0x00C0'0113,  // addi x2, x0, 12
      0x0021'D0B3,  // srl x1, x3, x2
      0x0010'2023,  // sw x1, 0(x0)
      0xFF00'0000,  // -0x01000000
      };
  processor_tick_n(4, memory);
  assert(check_mem(test_no, memory, 0, 0x000f'f000));
  reset_processor();

  // TEST35: Test SRA
  test_no++;
  memory = { 0x0100'2183,  // lw x3, 16(x0)
      0x00C0'0113,  // addi x2, x0, 12
      0x4021'D0B3,  // sra x1, x3, x2
      0x0010'2023,  // sw x1, 0(x0)
      0xFF00'0000,  // -0x01000000
      };
  processor_tick_n(4, memory);
  assert(check_mem(test_no, memory, 0, 0xffff'f000));
  reset_processor();

  // TEST36: Test OR
  test_no++;
  memory = { 0x0120'0193,  // addi x3, x0, 0x12
      0x0340'0113,  // addi x2, x0, 0x34
      0x0021'E0B3,  // or x1, x3, x2
      0x0010'2023,  // sw x1, 0(x0)
      };
  processor_tick_n(4, memory);
  assert(check_mem(test_no, memory, 0, 0x36));
  reset_processor();

  // TEST37: Test AND
  test_no++;
  memory = { 0x0120'0193,  // addi x3, x0, 0x12
      0x0340'0113,  // addi x2, x0, 0x34
      0x0021'F0B3,  // and x1, x3, x2
      0x0010'2023,  // sw x1, 0(x0)
      };
  processor_tick_n(4, memory);
  assert(check_mem(test_no, memory, 0, 0x10));
  reset_processor();

  return 0;
}
#endif
