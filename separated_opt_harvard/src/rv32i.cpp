#include "rv32i.h"

#include <iostream>

u32 g_xreg[32] = { 0 };
u32 g_pc = 0;
u1 g_error = 0;

void reset_processor() {
  for (int i = 0; i < 32; i++) {
    g_xreg[i] = 0;
  }
  g_pc = 0;
  g_error = 0;
}

void Error(u1 *error) {
#pragma HLS INLINE
#ifndef __SYNTHESIS__
  std::cout << "Error at PC " << g_pc << std::endl;
#endif
  *error = static_cast<u1>(1);
}

void fetch_instruction(const u32 memory[MEMORY_SIZE], u32 pc, i32 &instr, u1 &error) {
  if (pc % 4) {
    Error(&error);
  }
  instr = static_cast<i32>(memory[pc / 4]);
}

void decode_fetch_operands(i32 instr, u7 &op_code, u3 &funct3, u7 &funct7, u32 &source1, u32 &source2, u5 &rd, i32 &imm,
    u32 xreg[32]) {
  op_code = static_cast<u7>(instr);
  funct3 = static_cast<u3>(instr >> 12);
  funct7 = static_cast<u7>(instr >> 25);
  rd = static_cast<u5>(instr >> 7);
  u5 rs1 = static_cast<u5>(instr >> 15);
  u5 rs2 = static_cast<u5>(instr >> 20);

  xreg[0] = 0;
  source1 = xreg[rs1];
  source2 = xreg[rs2];

  // prepare immediate
  switch (op_code) {
  // I-type
  case 0b0000011:  // load
  case 0b0010011:  // Arithm
  case 0b1100111:  // JALR
  case 0b1110011:  // Syscalls
    imm = static_cast<i12>(instr(31, 20));
    break;
    // S-type
  case 0b0100011:  // store
    imm = static_cast<i12>(instr(31, 25), instr(11, 7));
    break;
    // B-type
  case 0b1100011:  // branch
    imm = static_cast<i13>(instr[31], instr[7], instr(30, 25), instr(11, 8), (u1) 0);
    break;
    // U-type
  case 0b0110111:  // LUI
  case 0b0010111:  // AUIPC
    imm = static_cast<i32>(instr & 0xffff'f000);
    break;
    // J-type
  case 0b1101111:  // JAL
    imm = static_cast<i21>(instr[31], instr(19, 12), instr[20], instr(30, 21), (u1) 0);
    break;
  }
}

void execute_branch(u7 op_code, u3 funct3, u32 &result, u32 &pc, u1 &error, u32 source1, u32 source2, u1 &write_reg,
    u1 &branch) {
  switch (op_code) {
  case 0b110'1111:  // JAL
    result = pc + 4;
    write_reg = 1;
    branch = 1;
    break;
  case 0b110'0111:  // JALR
    result = pc + 4;
    pc = source1;
    write_reg = 1;
    branch = 1;
    break;
  case 0b1100011:  // Branch
    switch (funct3) {
    case 0b000:  // BEQ
      branch = source1 == source2;
      break;
    case 0b001:  // BNE
      branch = source1 != source2;
      break;
    case 0b100:  // BLT
      branch = static_cast<i32>(source1) < static_cast<i32>(source2);
      break;
    case 0b101:  // BGE
      branch = static_cast<i32>(source1) >= static_cast<i32>(source2);
      break;
    case 0b110:  // BLTU
      branch = static_cast<u32>(source1) < static_cast<u32>(source2);
      break;
    case 0b111:  // BGEU
      branch = static_cast<u32>(source1) >= static_cast<u32>(source2);
      break;
    default:
      Error(&error);
      break;
    }
    break;
  default:
    Error(&error);
    break;
  }
}

void execute_load(u3 funct3, i32 imm, u32 &result, const u32 memory[MEMORY_SIZE], u1 &error, u32 source1) {
  u32 mem_pos = (source1 + imm) >> 2;
  if (!(mem_pos & 0x0400'0000)) {
    Error(&error);
  } else {
    mem_pos &= 0x03FF'FFFF;
  }
  u2 offset = source1 + imm;
  u32 mem_val = memory[mem_pos];
  switch (funct3) {
  case 0b000:  // LB
    if (offset == 0) {
      result = static_cast<i8>(mem_val(7, 0));
    } else if (offset == 1) {
      result = static_cast<i8>(mem_val(15, 8));
    } else if (offset == 2) {
      result = static_cast<i8>(mem_val(23, 16));
    } else if (offset == 3) {
      result = static_cast<i8>(mem_val(31, 24));
    }
    break;
  case 0b001:  // LH
    if (offset == 0) {
      result = static_cast<i16>(mem_val(15, 0));
    } else if (offset == 2) {
      result = static_cast<i16>(mem_val(31, 16));
    }
    break;
  case 0b010: // LW
    result = static_cast<u32>(mem_val);
    break;
  case 0b100:  // LBU
    if (offset == 0) {
      result = static_cast<u8>(mem_val(7, 0));
    } else if (offset == 1) {
      result = static_cast<u8>(mem_val(15, 8));
    } else if (offset == 2) {
      result = static_cast<u8>(mem_val(23, 16));
    } else if (offset == 3) {
      result = static_cast<u8>(mem_val(31, 24));
    }
    break;
  case 0b101:  // LHU
    if (offset == 0) {
      result = static_cast<u16>(mem_val(15, 0));
    } else if (offset == 2) {
      result = static_cast<u16>(mem_val(31, 16));
    }
    break;
  default:
    Error(&error);
    break;
  }
}

void execute_store(const u32 memory[MEMORY_SIZE], u3 funct3, i32 imm, u1 &error, u32 source1, u32 source2, u32 &result,
    u32 &write_addr) {
  write_addr = (source1 + imm) >> 2;
  if (!(write_addr & 0x0400'0000)) {
    Error(&error);
  } else {
    write_addr &= 0x03FF'FFFF;
  }
  u2 offset = source1 + imm;
  result = memory[write_addr];
  switch (funct3) {
  case 0b000:  // SB
    if (offset == 0) {
      result(7, 0) = source2;
    } else if (offset == 1) {
      result(15, 8) = source2;
    } else if (offset == 2) {
      result(23, 16) = source2;
    } else if (offset == 3) {
      result(31, 24) = source2;
    }
    break;
  case 0b001:  // SH
    if (offset == 0) {
      result(15, 0) = source2;
    } else if (offset == 2) {
      result(31, 16) = source2;
    }
    break;
  case 0b010:  // SW
    result = source2;
    break;
  default:
    // error
    Error(&error);
    break;
  }
}

void execute_arithm(u7 op_code, u3 funct3, u7 funct7, u32 source1, u32 source2, i32 imm, u32 &result, u1 &error,
    u32 pc) {
  switch (op_code) {
  case 0b011'0111:  // LUI
    result = imm;
    break;
  case 0b001'0111:  // AUIPC
    result = imm + pc;
    break;
  case 0b0010011:  // Arithmetic Intermediate
    switch (funct3) {
    case 0b000:  // ADDI
      result = source1 + imm;
      break;
    case 0b010:  // SLTI
      if (static_cast<i32>(source1) < static_cast<i32>(imm)) {
        result = 1;
      } else {
        result = 0;
      }
      break;
    case 0b011:  // SLTIU
      if (static_cast<u32>(source1) < static_cast<u32>(imm)) {
        result = 1;
      } else {
        result = 0;
      }
      break;
    case 0b100:  // XORI
      result = source1 ^ imm;
      break;
    case 0b110:  // ORI
      result = source1 | imm;
      break;
    case 0b111:  // ANDI
      result = source1 & imm;
      break;
    case 0b001:  // SLLI
      if (funct7 == 0) {
        result = source1 << static_cast<u5>(imm(4, 0));
      } else {
        Error(&error);
      }
      break;
    case 0b101:  // Shift Right
      switch (funct7) {
      case 0b0000000:  // SRLI
        result = static_cast<u32>(source1) >> static_cast<u5>(imm(4, 0));
        break;
      case 0b0100000:  // SRAI
        result = static_cast<i32>(source1) >> static_cast<u5>(imm(4, 0));
        break;
      default:
        Error(&error);
        break;
      }
      break;
    default:
      Error(&error);
      break;
    }
    break;
  case 0b0110011:  // Arithmetic Register
    switch (funct3) {
    case 0b000:  // Addition
      switch (funct7) {
      case 0b0000000:  // ADD
        // no cast to signed needed because of overflow
        result = source1 + source2;
        break;
      case 0b0100000:  // SUB
        // no cast to signed needed because of overflow
        result = source1 - source2;
        break;
      default:
        // error
        Error(&error);
        break;
      }
      break;
    case 0b001:  // SLL
      if (funct7 == 0) {
        result = source1 << static_cast<u5>(source2(4, 0));
      } else {
        Error(&error);
      }
      break;
    case 0b010:  // SLT
      if (funct7 == 0) {
        if (static_cast<i32>(source1) < static_cast<i32>(source2)) {
          result = 1;
        } else {
          result = 0;
        }
      } else {
        Error(&error);
      }
      break;
    case 0b011:  // SLTU
      if (funct7 == 0) {
        if (static_cast<u32>(source1) < static_cast<u32>(source2)) {
          result = 1;
        } else {
          result = 0;
        }
      } else {
        Error(&error);
      }
      break;
    case 0b100:  // XOR
      if (funct7 == 0) {
        result = source1 ^ source2;
      } else {
        Error(&error);
      }
      break;
    case 0b101:  // Shift
      switch (funct7) {
      case 0b0000000:  // SRL
        result = static_cast<u32>(source1) >> static_cast<u5>(source2(4, 0));
        break;
      case 0b0100000:  // SRA
        result = static_cast<i32>(source1) >> static_cast<u5>(source2(4, 0));
        break;
      default:
        Error(&error);
        break;
      }
      break;
    case 0b110:  // OR
      if (funct7 == 0) {
        result = source1 | source2;
      } else {
        Error(&error);
      }
      break;
    case 0b111:  // AND
      if (funct7 == 0) {
        result = source1 & source2;
      } else {
        Error(&error);
      }
      break;
    default:
      Error(&error);
      break;
    }
    break;
  case 0b0001111:  // FENCE
    // do nothing
    break;
  case 0b1110011:  // ECALL / EBRAK
    if (imm == 0) {
      // ECALL
      // nop
    } else {
      // EBREAK or unknown
      Error(&error);
    }
    break;
  default:
    Error(&error);
    break;
  }
}

void write_back(u32 result, u5 rd, u32 xreg[32], u32 memory[MEMORY_SIZE], i32 imm, u1 write_reg, u1 write_mem,
    u32 write_addr, u1 branch, u32 &pc) {
  if (write_reg) {
    xreg[rd] = result;
  }
  if (write_mem) {
    memory[write_addr] = result;
  }
  if (branch) {
    pc += imm;
  } else {
    pc += 4;
  }
}

void do_process(const u32 instr_memory[MEMORY_SIZE / 2], u32 data_memory[MEMORY_SIZE / 2], u1 *error) {
  i32 instr;
  u7 op_code;
  u3 funct3;
  u7 funct7;
  u32 source1;
  u32 source2;
  u5 rd;
  i32 imm;
  u32 result;
  u1 write_reg = 0;
  u1 write_mem = 0;
  u1 branch = 0;
  u32 write_addr;

  fetch_instruction(instr_memory, g_pc, instr, g_error);
  decode_fetch_operands(instr, op_code, funct3, funct7, source1, source2, rd, imm, g_xreg);
  switch (op_code) {
  case 0b1101111:  // JAL
  case 0b1100111:  // JALR
  case 0b1100011:  // Bxxx
    execute_branch(op_code, funct3, result, g_pc, g_error, source1, source2, write_reg, branch);
    break;
  case 0b0000011:
    execute_load(funct3, imm, result, data_memory, g_error, source1);
    write_reg = 1;
    break;
  case 0b0100011:
    execute_store(data_memory, funct3, imm, g_error, source1, source2, result, write_addr);
    write_mem = 1;
    break;
  default:
    execute_arithm(op_code, funct3, funct7, source1, source2, imm, result, g_error, g_pc);
    write_reg = 1;
    break;
  }
  write_back(result, rd, g_xreg, data_memory, imm, write_reg, write_mem, write_addr, branch, g_pc);
  *error = g_error;
}

void processor(const u32 instr_memory[MEMORY_SIZE / 2], u32 data_memory[MEMORY_SIZE / 2], u1 *error) {
#pragma HLS INTERFACE mode=ap_ctrl_none port=return
#pragma HLS INTERFACE mode=ap_none port=error
#pragma HLS INTERFACE mode=ap_memory port=instr_memory
#pragma HLS INTERFACE mode=ap_memory port=data_memory
#pragma HLS RESET variable=g_pc

#pragma HLS ARRAY_PARTITION variable=g_xreg type=complete

  while (1) {
    do_process(instr_memory, data_memory, error);
  }
}
