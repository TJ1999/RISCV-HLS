#include "rv32i.h"

#include <iostream>

static u32 xreg[32] = { 0 };
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

void processor(u32 memory[102400], u1 *error) {
#pragma HLS INTERFACE mode=ap_ctrl_none port=return
#pragma HLS INTERFACE mode=ap_none port=error
#pragma HLS INTERFACE mode=ap_memory port=memory
#pragma HLS RESET variable=_pc

  static u1 _error = 0;

  if (_pc % 4) {
    Error(&_error);
  }

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
  bool branch = false;
  xreg[0] = 0;

  // branch on instruction
  switch (op_code) {
  case 0b011'0111:  // LUI
    xreg[rd] = imm_U;
    break;
  case 0b001'0111:  // AUIPC
    xreg[rd] = imm_U + _pc;
    break;
  case 0b110'1111:  // JAL
    xreg[rd] = _pc + 4;
    _pc = _pc + imm_J;
    branch = true;
    break;
  case 0b110'0111:  // JALR
    xreg[rd] = _pc + 4;
    _pc = xreg[rs1] + imm_I;
    branch = true;
    break;
  case 0b1100011:  // Branch
    switch (funct3) {
    case 0b000:  // BEQ
      if (xreg[rs1] == xreg[rs2]) {
        _pc = _pc + imm_B;
        branch = true;
      }
      break;
    case 0b001:  // BNE
      if (xreg[rs1] != xreg[rs2]) {
        _pc = _pc + imm_B;
        branch = true;
      }
      break;
    case 0b100:  // BLT
      if (static_cast<i32>(xreg[rs1]) < static_cast<i32>(xreg[rs2])) {
        _pc = _pc + imm_B;
        branch = true;
      }
      break;
    case 0b101:  // BGE
      if (static_cast<i32>(xreg[rs1]) >= static_cast<i32>(xreg[rs2])) {
        _pc = _pc + imm_B;
        branch = true;
      }
      break;
    case 0b110:  // BLTU
      if (static_cast<u32>(xreg[rs1]) < static_cast<u32>(xreg[rs2])) {
        _pc = _pc + imm_B;
        branch = true;
      }
      break;
    case 0b111:  // BGEU
      if (static_cast<u32>(xreg[rs1]) >= static_cast<u32>(xreg[rs2])) {
        _pc = _pc + imm_B;
        branch = true;
      }
      break;
    default:
      Error(&_error);
      break;
    }
    break;
  case 0b0000011: {  // Load
    u32 pos = (xreg[rs1] + imm_I) / 4;
    u2 offset = xreg[rs1] + imm_I;
    switch (funct3) {
    case 0b000:  // LB
      if (offset == 0) {
        xreg[rd] = static_cast<i8>(memory[pos](7, 0));
      } else if (offset == 1) {
        xreg[rd] = static_cast<i8>(memory[pos](15, 8));
      } else if (offset == 2) {
        xreg[rd] = static_cast<i8>(memory[pos](23, 16));
      } else if (offset == 3) {
        xreg[rd] = static_cast<i8>(memory[pos](31, 24));
      }
      break;
    case 0b001:  // LH
      if (offset == 0) {
        xreg[rd] = static_cast<i16>(memory[pos](15, 0));
      } else if (offset == 2) {
        xreg[rd] = static_cast<i16>(memory[pos](31, 16));
      }
      break;
    case 0b010: // LW
      xreg[rd] = static_cast<u32>(memory[pos]);
      break;
    case 0b100:  // LBU
      if (offset == 0) {
        xreg[rd] = static_cast<u8>(memory[pos](7, 0));
      } else if (offset == 1) {
        xreg[rd] = static_cast<u8>(memory[pos](15, 8));
      } else if (offset == 2) {
        xreg[rd] = static_cast<u8>(memory[pos](23, 16));
      } else if (offset == 3) {
        xreg[rd] = static_cast<u8>(memory[pos](31, 24));
      }
      break;
    case 0b101:  // LHU
      if (offset == 0) {
        xreg[rd] = static_cast<u16>(memory[pos](15, 0));
      } else if (offset == 2) {
        xreg[rd] = static_cast<u16>(memory[pos](31, 16));
      }
      break;
    default:
      Error(&_error);
      break;
    }
    break;
  }
  case 0b0100011: {  // Store
    u32 pos = (xreg[rs1] + imm_S) / 4;
    u2 offset = xreg[rs1] + imm_S;
    switch (funct3) {
    case 0b000:  // SB
      if (offset == 0) {
        memory[pos](7, 0) = xreg[rs2];
      } else if (offset == 1) {
        memory[pos](15, 8) = xreg[rs2];
      } else if (offset == 2) {
        memory[pos](23, 16) = xreg[rs2];
      } else if (offset == 3) {
        memory[pos](31, 24) = xreg[rs2];
      }
      break;
    case 0b001:  // SH
      if (offset == 0) {
        memory[pos](15, 0) = xreg[rs2];
      } else if (offset == 2) {
        memory[pos](31, 16) = xreg[rs2];
      }
      break;
    case 0b010:  // SW
      memory[pos] = xreg[rs2];
      break;
    default:
      Error(&_error);
      break;
    }
    break;
  }
  case 0b0010011:  // Arithmetic Intermediate
    switch (funct3) {
    case 0b000:  // ADDI
      xreg[rd] = xreg[rs1] + imm_I;
      break;
    case 0b010:  // SLTI
      if (static_cast<i32>(xreg[rs1]) < imm_I) {
        xreg[rd] = 1;
      } else {
        xreg[rd] = 0;
      }
      break;
    case 0b011:  // SLTIU
      if (static_cast<u32>(xreg[rs1]) < imm_I) {
        xreg[rd] = 1;
      } else {
        xreg[rd] = 0;
      }
      break;
    case 0b100:  // XORI
      xreg[rd] = xreg[rs1] ^ imm_I;
      break;
    case 0b110:  // ORI
      xreg[rd] = xreg[rs1] | imm_I;
      break;
    case 0b111:  // ANDI
      xreg[rd] = xreg[rs1] & imm_I;
      break;
    case 0b001:  // SLLI
      if (funct7 == 0) {
        xreg[rd] = xreg[rs1] << imm_I2;
      } else {
        Error(&_error);
      }
      break;
    case 0b101:  // Shift Right
      switch (funct7) {
      case 0b0000000:  // SRLI
        xreg[rd] = xreg[rs1] >> imm_I2;
        break;
      case 0b0100000:  // SRAI
        xreg[rd] = static_cast<i32>(xreg[rs1]) >> imm_I2;
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
    switch (funct3) {
    case 0b000:  // Addition
      switch (funct7) {
      case 0b0000000:  // ADD
        // no cast to signed needed because of overflow
        xreg[rd] = xreg[rs1] + xreg[rs2];
        break;
      case 0b0100000:  // SUB
        // no cast to signed needed because of overflow
        xreg[rd] = xreg[rs1] - xreg[rs2];
        break;
      default:
        Error(&_error);
        break;
      }
      break;
    case 0b001:  // SLL
      if (funct7 == 0) {
        xreg[rd] = xreg[rs1] << xreg[rs2](4, 0);
      } else {
        Error(&_error);
      }
      break;
    case 0b010:  // SLT
      if (funct7 == 0) {
        if (static_cast<i32>(xreg[rs1]) < static_cast<i32>(xreg[rs2])) {
          xreg[rd] = 1;
        } else {
          xreg[rd] = 0;
        }
      } else {
        Error(&_error);
      }
      break;
    case 0b011:  // SLTU
      if (funct7 == 0) {
        if (static_cast<u32>(xreg[rs1]) < static_cast<u32>(xreg[rs2])) {
          xreg[rd] = 1;
        } else {
          xreg[rd] = 0;
        }
      } else {
        Error(&_error);
      }
      break;
    case 0b100:  // XOR
      if (funct7 == 0) {
        xreg[rd] = xreg[rs1] ^ xreg[rs2];
      } else {
        Error(&_error);
      }
      break;
    case 0b101:  // Shift
      switch (funct7) {
      case 0b0000000:  // SRL
        xreg[rd] = xreg[rs1] >> xreg[rs2](4, 0);
        break;
      case 0b0100000:  // SRA
        xreg[rd] = static_cast<i32>(xreg[rs1]) >> xreg[rs2](4, 0);
        break;
      default:
        Error(&_error);
        break;
      }
      break;
    case 0b110:  // OR
      if (funct7 == 0) {
        xreg[rd] = xreg[rs1] | xreg[rs2];
      } else {
        Error(&_error);
      }
      break;
    case 0b111:  // AND
      if (funct7 == 0) {
        xreg[rd] = xreg[rs1] & xreg[rs2];
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

  // increment program counter
  if (!branch) {
    _pc += 4;
  }
  *error = _error;
}
