#include "rv32i.h"

#include <iostream>

u32 xreg[32] = { 0 };
u32 _pc = 0;

void reset_processor() {
  for (int i = 0; i < 32; i++) {
    xreg[i] = 0;
  }
  _pc = 0;
}

void Error(u1 *error) {
#pragma HLS INLINE
#ifndef __SYNTHESIS__
  std::cout << "Instruction not known at _pc: " << _pc << std::endl;
#endif
  *error = static_cast<u1>(1);
}

void processor(const u32 instr_memory[MEMORY_SIZE / 2], u32 data_memory[MEMORY_SIZE / 2], u1 *error) {
#pragma HLS INTERFACE mode=ap_ctrl_none port=return
#pragma HLS INTERFACE mode=ap_none port=error
#pragma HLS INTERFACE mode=ap_memory port=instr_memory
#pragma HLS INTERFACE mode=ap_memory port=data_memory
#pragma HLS RESET variable=_pc

  static u1 _error = 0;

  if (_pc % 4) {
    Error(&_error);
  }

  // fetch 32-bit instruction
  i32 instr = static_cast<u32>(instr_memory[_pc / 4]);

  u7 op_code = static_cast<u7>(instr);
  u3 funct3 = static_cast<u3>(instr >> 12);
  u7 funct7 = static_cast<u7>(instr >> 25);
  u12 funct12 = static_cast<u12>(instr >> 20);
  u5 rs1 = static_cast<u5>(instr >> 15);
  u5 rs2 = static_cast<u5>(instr >> 20);
  u5 rd = static_cast<u5>(instr >> 7);
  xreg[0] = 0;
  u32 source1 = xreg[rs1];
  u32 source2 = xreg[rs2];
  u1 write_result = 0;
  u1 write_memory = 0;
  u32 mem_pos = 0;
  u32 result;
  i32 imm;
  bool branch = false;

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

  // branch on instruction
  switch (op_code) {
  case 0b011'0111:  // LUI
    result = imm;
    write_result = 1;
    break;
  case 0b001'0111:  // AUIPC
    result = imm + _pc;
    write_result = 1;
    break;
  case 0b110'1111:  // JAL
    result = _pc + 4;
    write_result = 1;
    branch = true;
    break;
  case 0b110'0111:  // JALR
    result = _pc + 4;
    _pc = source1;
    write_result = 1;
    branch = true;
    break;
  case 0b1100011: {  // Branch
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
      Error(&_error);
      break;
    }
    break;
  }
  case 0b0000011: {  // Load
    mem_pos = (source1 + imm) >> 2;
    if (!(mem_pos & 0x0400'0000)) {
      Error(&_error);
    } else {
      mem_pos &= 0x03FF'FFFF;
    }
    u2 offset = source1 + imm;
    u32 mem_val = data_memory[mem_pos];
    write_result = 1;
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
      Error(&_error);
      break;
    }
    break;
  }
  case 0b0100011: {  // Store
    mem_pos = (source1 + imm) >> 2;
    if (!(mem_pos & 0x0400'0000)) {
      Error(&_error);
    } else {
      mem_pos &= 0x03FF'FFFF;
    }
    u2 offset = source1 + imm;
    u32 mem_val = data_memory[mem_pos];
    write_memory = 1;
    switch (funct3) {
    case 0b000:  // SB
      if (offset == 0) {
        mem_val(7, 0) = source2;
      } else if (offset == 1) {
        mem_val(15, 8) = source2;
      } else if (offset == 2) {
        mem_val(23, 16) = source2;
      } else if (offset == 3) {
        mem_val(31, 24) = source2;
      }
      result = mem_val;
      break;
    case 0b001:  // SH
      if (offset == 0) {
        mem_val(15, 0) = source2;
      } else if (offset == 2) {
        mem_val(31, 16) = source2;
      }
      result = mem_val;
      break;
    case 0b010:  // SW
      result = source2;
      break;
    default:
      Error(&_error);
      break;
    }
    break;
  }
  case 0b0010011:  // Arithmetic Intermediate
    write_result = 1;
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
        Error(&_error);
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
        Error(&_error);
        break;
      }
      break;
    default:
      Error(&_error);
      break;
    }
    break;
  case 0b0110011:  // Arithmetic Register
    write_result = 1;
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
        Error(&_error);
        break;
      }
      break;
    case 0b001:  // SLL
      if (funct7 == 0) {
        result = source1 << static_cast<u5>(source2(4, 0));
      } else {
        Error(&_error);
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
        Error(&_error);
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
        Error(&_error);
      }
      break;
    case 0b100:  // XOR
      if (funct7 == 0) {
        result = source1 ^ source2;
      } else {
        Error(&_error);
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
        Error(&_error);
        break;
      }
      break;
    case 0b110:  // OR
      if (funct7 == 0) {
        result = source1 | source2;
      } else {
        Error(&_error);
      }
      break;
    case 0b111:  // AND
      if (funct7 == 0) {
        result = source1 & source2;
      } else {
        Error(&_error);
      }
      break;
    default:
      Error(&_error);
      break;
    }
    break;
  case 0b0001111:  // FENCE
    // do nothing
    break;
  case 0b1110011:  // ECALL / EBRAK
    if (funct12 == 0) {
      // ECALL
      // nop
    } else {
      // EBREAK or unknown
      Error(&_error);
    }
    break;
  default:
    Error(&_error);
    break;
  }

  // write result
  if (write_result) {
    xreg[rd] = result;
  }
  // write memory
  if (write_memory) {
    data_memory[mem_pos] = result;
  }

  // increment program counter
  if (branch) {
    _pc += imm;
  } else {
    _pc += 4;
  }
  *error = _error;
}
