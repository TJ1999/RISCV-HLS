#include "rv32i.h"

#include <iostream>

static u32 g_xreg[32] = { 0 };
static u32 g_pc = 0;
static u1 g_error = 0;

void reset_processor () {
  for (int i = 0; i < 32; i++) {
    g_xreg[i] = 0;
  }
  g_pc = 0;
  g_error = 0;
}

void Error (u1 *error) {
#pragma HLS INLINE
#ifndef __SYNTHESIS__
  std::cout << "Error at PC " << g_pc << std::endl;
#endif
  *error = static_cast<u1>(1);
}

void fetch_instruction (const u32 memory[MEMORY_DEPTH], u32 &pc, i32 &instr, u1 &error, u32 &old_pc) {
  if ((pc % 4) || (pc / 4 >= MEMORY_DEPTH))
    Error(&error);
  instr = static_cast<i32>(memory[pc / 4]);
  old_pc = pc;
  pc += 4;
}

void decode_fetch_operands (i32 instr, u7 &op_code, u3 &funct3, u7 &funct7, u12 &funct12, u32 &source1, u32 &source2,
                            u5 &rd, i32 &imm_B, i32 &imm_I, i32 &imm_J, i32 &imm_S, i32 &imm_U, u32 xreg[32]) {
  op_code = static_cast<u7>(instr);
  funct3 = static_cast<u3>(instr >> 12);
  funct7 = static_cast<u7>(instr >> 25);
  funct12 = static_cast<u12>(instr >> 20);
  rd = static_cast<u5>(instr >> 7);
  imm_B = static_cast<i13>(instr[31], instr[7], instr(30, 25), instr(11, 8), (u1)0);
  imm_I = static_cast<i12>(instr(31, 20));
  imm_J = static_cast<i21>(instr[31], instr(19, 12), instr[20], instr(30, 21), (u1)0);
  imm_S = static_cast<i12>(instr(31, 25), instr(11, 7));
  imm_U = static_cast<i32>(instr & 0xffff'f000);

  u5 rs1 = static_cast<u5>(instr >> 15);
  u5 rs2 = static_cast<u5>(instr >> 20);

  xreg[0] = 0;
  source1 = xreg[rs1];
  source2 = xreg[rs2];
}

void execute_branch (u7 op_code, u3 funct3, u32 &result, u32 &pc, u32 old_pc, u1 &error, i32 imm_B, i32 imm_I,
                     i32 imm_J, u32 source1, u32 source2, u1& write_back) {
  switch (op_code) {
    case 0b110'1111:  // JAL
      result = old_pc + 4;
      pc = old_pc + imm_J;
      write_back = 1;
      break;
    case 0b110'0111:  // JALR
      result = old_pc + 4;
      pc = source1 + imm_I;
      write_back = 1;
      break;
    case 0b1100011:  // Branch
      write_back = 0;
      switch (funct3) {
        case 0b000:  // BEQ
          if (source1 == source2) {
            pc = old_pc + imm_B;
          }
          break;
        case 0b001:  // BNE
          if (source1 != source2) {
            pc = old_pc + imm_B;
          }
          break;
        case 0b100:  // BLT
          if (static_cast<i32>(source1) < static_cast<i32>(source2)) {
            pc = old_pc + imm_B;
          }
          break;
        case 0b101:  // BGE
          if (static_cast<i32>(source1) >= static_cast<i32>(source2)) {
            pc = old_pc + imm_B;
          }
          break;
        case 0b110:  // BLTU
          if (static_cast<u32>(source1) < static_cast<u32>(source2)) {
            pc = old_pc + imm_B;
          }
          break;
        case 0b111:  // BGEU
          if (static_cast<u32>(source1) >= static_cast<u32>(source2)) {
            pc = old_pc + imm_B;
          }
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

void execute_load (u3 funct3, i32 imm_I, u32 &result, const u32 memory[MEMORY_DEPTH], u1 &error, u32 source1, u1& write_back) {
  u32 pos = (source1 + imm_I) / 4;
  u32 offset = ((source1 + imm_I) % 4) * 8;
  if (pos >= MEMORY_DEPTH) {
    Error(&error);
  }
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
      break;
    case 0b001:  // LH
      if (offset == 0) {
        result = static_cast<i16>(memory[pos](15, 0));
      } else if (offset == 16) {
        result = static_cast<i16>(memory[pos](31, 16));
      }
      break;
    case 0b010: // LW
      result = static_cast<u32>(memory[pos]);
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
      break;
    case 0b101:  // LHU
      if (offset == 0) {
        result = static_cast<u16>(memory[pos](15, 0));
      } else if (offset == 16) {
        result = static_cast<u16>(memory[pos](31, 16));
      }
      break;
    default:
      Error(&error);
      break;
  }
  write_back = 1;
}

void execute_store (u32 memory[MEMORY_DEPTH], u3 funct3, i32 imm_S, u1 &error, u32 source1, u32 source2, u1& write_back) {
  u32 pos = (source1 + imm_S) / 4;
  u32 offset = ((source1 + imm_S) % 4) * 8;
  if (pos >= MEMORY_DEPTH) {
    Error(&error);
  }
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
      Error(&error);
      break;
  }
  write_back = 0;
}

void execute_arithm (u7 op_code, u3 funct3, u7 funct7, u32 source1, u32 source2, i32 imm_I, i32 imm_U, u32 &result,
                     u1 &error, u32 old_pc, u1& write_back) {
  switch (op_code) {
    case 0b001'0111:  // AUI_pc
      result = imm_U + old_pc;
      write_back = 1;
      break;
    case 0b011'0111:  // LUI
      result = imm_U;
      write_back = 1;
      break;
    case 0b0010011:  // Arithmetic Intermediate
      write_back = 1;
      switch (funct3) {
        case 0b000:  // ADDI
          result = source1 + imm_I;
          break;
        case 0b010:  // SLTI
          if (static_cast<i32>(source1) < imm_I) {
            result = 1;
          } else {
            result = 0;
          }
          break;
        case 0b011:  // SLTIU
          if (static_cast<u32>(source1) < imm_I) {
            result = 1;
          } else {
            result = 0;
          }
          break;
        case 0b100:  // XORI
          result = source1 ^ imm_I;
          break;
        case 0b110:  // ORI
          result = source1 | imm_I;
          break;
        case 0b111:  // ANDI
          result = source1 & imm_I;
          break;
        case 0b001:  // SLLI
          if (funct7 == 0) {
            result = source1 << static_cast<u5>(imm_I(4, 0));
          } else {
            Error(&error);
          }
          break;
        case 0b101:  // Shift Right
          switch (funct7) {
            case 0b0000000:  // SRLI
              result = static_cast<u32>(source1) >> static_cast<u5>(imm_I(4, 0));
              break;
            case 0b0100000:  // SRAI
              result = static_cast<i32>(source1) >> static_cast<u5>(imm_I(4, 0));
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
      write_back = 1;
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
              result = static_cast<u32>(source1) >> static_cast<u5>(source2(4, 0));  // TODO static_cast needed?
              break;
            case 0b0100000:  // SRA
              result = static_cast<i32>(source1) >> static_cast<u5>(source2(4, 0));
              break;
            default:
              // error
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
      write_back = 0;
      Error(&error);
      break;
    case 0b1110011:  // ECALL / EBRAK
      write_back = 0;
      if (imm_I == 0) {  // ECALL
        // nop
      } else {  // EBREAK
        Error(&error);
      }
      break;
    default:
      Error(&error);
      break;
  }
}

void do_write_back (u32 result, u5 rd, u32 xreg[32], u1 write_back) {
  if (write_back) {
    xreg[rd] = result;
  }
}

void processor (u32 memory[MEMORY_DEPTH], u1 &o_error, u32 &o_pc) {
#pragma HLS INTERFACE mode=ap_ctrl_none port=return
#pragma HLS INTERFACE mode=ap_none port=o_error
#pragma HLS INTERFACE mode=ap_none port=o_pc
#pragma HLS INTERFACE mode=ap_memory port=memory
#pragma HLS RESET variable=g_pc

#pragma HLS ARRAY_PARTITION variable=g_xreg type=complete

  i32 instr;
  u7 op_code;
  u3 funct3;
  u7 funct7;
  u12 funct12;
  u32 source1;
  u32 source2;
  u5 rd;
  i32 imm_B;
  i32 imm_I;
  i32 imm_J;
  i32 imm_S;
  i32 imm_U;
  u32 result;
  u32 old_pc;
  u1 write_back;

  fetch_instruction(memory, g_pc, instr, g_error, old_pc);
  decode_fetch_operands(instr, op_code, funct3, funct7, funct12, source1, source2, rd, imm_B, imm_I, imm_J, imm_S,
                        imm_U, g_xreg);
  switch (op_code) {
    case 0b1101111:  // JAL
    case 0b1100111:  // JALR
    case 0b1100011:  // Bxxx
      execute_branch(op_code, funct3, result, g_pc, old_pc, g_error, imm_B, imm_I, imm_J, source1, source2, write_back);
      break;
    case 0b0000011:
      execute_load(funct3, imm_I, result, memory, g_error, source1, write_back);
      break;
    case 0b0100011:
      execute_store(memory, funct3, imm_S, g_error, source1, source2, write_back);
      break;
    default:
      execute_arithm(op_code, funct3, funct7, source1, source2, imm_I, imm_U, result, g_error, old_pc, write_back);
      break;
  }
  do_write_back(result, rd, g_xreg, write_back);
  o_pc = g_pc;
  o_error = g_error;
}
