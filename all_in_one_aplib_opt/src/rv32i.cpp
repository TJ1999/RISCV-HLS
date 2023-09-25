#include "rv32i.h"

#include <iostream>

u32 xreg[32] = { 0 };
static u32 _pc = 0;
static u1 _error = 0;

void reset_processor() {
  for (int i = 0; i < 32; i++) {
    xreg[i] = 0;
  }
  _pc = 0;
  _error = 0;
}

void Error(u1 *error) {
#pragma HLS INLINE
#ifndef __SYNTHESIS__
  std::cout << "Instruction not known at _pc: " << _pc << std::endl;
#endif
  *error = static_cast<u1>(1);
}

void processor(u32 memory[102400], u1 *error, u32 *pc) {
#pragma HLS INTERFACE mode=ap_ctrl_none port=return
#pragma HLS INTERFACE mode=ap_none port=error
#pragma HLS INTERFACE mode=ap_none port=pc
#pragma HLS INTERFACE mode=ap_memory port=memory
#pragma HLS RESET variable=_pc

  // fetch 32-bit instruction
  i32 instr = static_cast<u32>(memory[_pc / 4]);

  u7 op_code = static_cast<u7>(instr);
  u3 funct3 = static_cast<u3>(instr >> 12);
  u7 funct7 = static_cast<u7>(instr >> 25);
  u12 funct12 = static_cast<u12>(instr >> 20);
  u5 rs1 = static_cast<u5>(instr >> 15);
  u5 rs2 = static_cast<u5>(instr >> 20);
  u5 rd = static_cast<u5>(instr >> 7);
  i32 imm_B = static_cast<i13>(instr[31], instr[7], instr(30, 25), instr(11, 8), (u1) 0);
  i32 imm_I = static_cast<i12>(instr(31, 20));
  u5 imm_I2 = instr(24, 20);
  i32 imm_J = static_cast<i21>(instr[31], instr(19, 12), instr[20], instr(30, 21), (u1) 0);
  i32 imm_S = static_cast<i12>(instr(31, 25), instr(11, 7));
  i32 imm_U = instr & 0xffff'f000;

  xreg[0] = 0;

  u32 source1 = xreg[rs1];
  u32 source2 = xreg[rs2];
  u1 write_result = 0;
  u32 result;

  bool branch = false;

  // branch on instruction
  switch (op_code) {
  case 0b011'0111:  // LUI
    result = imm_U;
    write_result = 1;
    break;
  case 0b001'0111:  // AUI_pc
    result = imm_U + _pc;
    write_result = 1;
    break;
  case 0b110'1111:  // JAL
    result = _pc + 4;
    _pc = _pc + imm_J;
    write_result = 1;
    branch = true;
    break;
  case 0b110'0111:  // JALR
    result = _pc + 4;
    _pc = source1 + imm_I;
    write_result = 1;
    branch = true;
    break;
  case 0b1100011:  // Branch
    switch (funct3) {
    case 0b000:  // BEQ
      if (source1 == source2) {
        _pc = _pc + imm_B;
        branch = true;
      }
      break;
    case 0b001:  // BNE
      if (source1 != source2) {
        _pc = _pc + imm_B;
        branch = true;
      }
      break;
    case 0b100:  // BLT
      if (static_cast<i32>(source1) < static_cast<i32>(source2)) {
        _pc = _pc + imm_B;
        branch = true;
      }
      break;
    case 0b101:  // BGE
      if (static_cast<i32>(source1) >= static_cast<i32>(source2)) {
        _pc = _pc + imm_B;
        branch = true;
      }
      break;
    case 0b110:  // BLTU
      if (static_cast<u32>(source1) < static_cast<u32>(source2)) {
        _pc = _pc + imm_B;
        branch = true;
      }
      break;
    case 0b111:  // BGEU
      if (static_cast<u32>(source1) >= static_cast<u32>(source2)) {
        _pc = _pc + imm_B;
        branch = true;
      }
      break;
    default:
      // error
      Error(&_error);
      break;
    }
    break;
  case 0b0000011: {  // Load
    u32 pos = (source1 + imm_I) / 4;
    u32 offset = ((source1 + imm_I) % 4) * 8;
    switch (funct3) {
    case 0b000:  // LB
      if (offset == 0) {
        result = static_cast<i8>(memory[pos](7, 0));
      } else if (offset == 8) {
        result = static_cast<i8>(memory[pos](15, 8));
      } else if (offset == 16) {
        result = static_cast<i8>(memory[pos](23, 16));
      } else if (offset == 24) {
        result = static_cast<i8>(memory[pos](31, 24));
      }
      write_result = 1;
      break;
    case 0b001:  // LH
      if (offset == 0) {
        result = static_cast<i16>(memory[pos](15, 0));
      } else if (offset == 16) {
        result = static_cast<i16>(memory[pos](31, 16));
      }
      write_result = 1;
      break;
    case 0b010: // LW
      result = static_cast<u32>(memory[pos]);
      write_result = 1;
      break;
    case 0b100:  // LBU
      if (offset == 0) {
        result = static_cast<u8>(memory[pos](7, 0));
      } else if (offset == 8) {
        result = static_cast<u8>(memory[pos](15, 8));
      } else if (offset == 16) {
        result = static_cast<u8>(memory[pos](23, 16));
      } else if (offset == 24) {
        result = static_cast<u8>(memory[pos](31, 24));
      }
      write_result = 1;
      break;
    case 0b101:  // LHU
      if (offset == 0) {
        result = static_cast<u16>(memory[pos](15, 0));
      } else if (offset == 16) {
        result = static_cast<u16>(memory[pos](31, 16));
      }
      write_result = 1;
      break;
    default:
      // error
      Error(&_error);
      break;
    }
    break;
  }
  case 0b0100011: {  // Store
    u32 pos = (source1 + imm_S) / 4;
    u32 offset = ((source1 + imm_S) % 4) * 8;
    switch (funct3) {
    case 0b000:  // SB
      if (offset == 0) {
        memory[pos](7, 0) = source2;
      } else if (offset == 8) {
        memory[pos](15, 8) = source2;
      } else if (offset == 16) {
        memory[pos](23, 16) = source2;
      } else if (offset == 24) {
        memory[pos](31, 24) = source2;
      }
      break;
    case 0b001:  // SH
      if (offset == 0) {
        memory[pos](15, 0) = source2;
      } else if (offset == 16) {
        memory[pos](31, 16) = source2;
      }
      break;
    case 0b010:  // SW
      memory[pos] = source2;
      break;
    default:
      // error
      Error(&_error);
      break;
    }
    break;
  }
  case 0b0010011:  // Arithmetic Intermediate
    switch (funct3) {
    case 0b000:  // ADDI
      result = source1 + imm_I;
      write_result = 1;
      break;
    case 0b010:  // SLTI
      if (static_cast<i32>(source1) < imm_I) {
        result = 1;
      } else {
        result = 0;
      }
      write_result = 1;
      break;
    case 0b011:  // SLTIU
      if (static_cast<u32>(source1) < imm_I) {
        result = 1;
      } else {
        result = 0;
      }
      write_result = 1;
      break;
    case 0b100:  // XORI
      result = source1 ^ imm_I;
      write_result = 1;
      break;
    case 0b110:  // ORI
      result = source1 | imm_I;
      write_result = 1;
      break;
    case 0b111:  // ANDI
      result = source1 & imm_I;
      write_result = 1;
      break;
    case 0b001:  // SLLI
      if (funct7 == 0) {
        result = source1 << imm_I2;
        write_result = 1;
      } else {
        // error
        Error(&_error);
      }
      break;
    case 0b101:  // Shift Right
      switch (funct7) {
      case 0b0000000:  // SRLI
        result = source1 >> imm_I2;
        write_result = 1;
        break;
      case 0b0100000:  // SRAI
        result = static_cast<i32>(source1) >> imm_I2;
        write_result = 1;
        break;
      default:
        // error
        Error(&_error);
        break;
      }
      break;
    default:
      // error
      Error(&_error);
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
        write_result = 1;
        break;
      case 0b0100000:  // SUB
        // no cast to signed needed because of overflow
        result = source1 - source2;
        write_result = 1;
        break;
      default:
        // error
        Error(&_error);
        break;
      }
      break;
    case 0b001:  // SLL
      if (funct7 == 0) {
        result = source1 << source2(4, 0);
        write_result = 1;
      } else {
        // error
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
        write_result = 1;
      } else {
        // error
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
        write_result = 1;
      } else {
        // error
        Error(&_error);
      }
      break;
    case 0b100:  // XOR
      if (funct7 == 0) {
        result = source1 ^ source2;
        write_result = 1;
      } else {
        // error
        Error(&_error);
      }
      break;
    case 0b101:  // Shift
      switch (funct7) {
      case 0b0000000:  // SRL
        result = source1 >> source2(4, 0);
        write_result = 1;
        break;
      case 0b0100000:  // SRA
        result = static_cast<i32>(source1) >> source2(4, 0);
        write_result = 1;
        break;
      default:
        // error
        Error(&_error);
        break;
      }
      break;
    case 0b110:  // OR
      if (funct7 == 0) {
        result = source1 | source2;
        write_result = 1;
      } else {
        // error
        Error(&_error);
      }
      break;
    case 0b111:  // AND
      if (funct7 == 0) {
        result = source1 & source2;
        write_result = 1;
      } else {
        // error
        Error(&_error);
      }
      break;
    default:
      // error
      Error(&_error);
      break;
    }
    break;
  case 0b0001111:  // FENCE
    // do nothing
    Error(&_error);
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
    // error
    Error(&_error);
    break;
  }

  // write result
  if (write_result) {
    xreg[rd] = result;
  }

  // increment program counter
  if (!branch) {
    _pc += 4;
  }
  *pc = _pc;
  *error = _error;
}
