#include "rv32i.h"

#include <iostream>

static u32 xreg[32] = { 0 };
static u32 _pc = 0;

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

void processor(u32 memory[102400], u1 *error, u32 *pc) {
#pragma HLS INTERFACE mode=ap_ctrl_none port=return
#pragma HLS INTERFACE mode=ap_none port=error
#pragma HLS INTERFACE mode=ap_none port=pc
#pragma HLS INTERFACE mode=ap_memory port=memory
#pragma HLS RESET variable=_pc

	static u1 _error = 0;

	// fetch 32-bit instruction
	i32 instr = static_cast<u32>(memory[_pc / 4]);

	u7 o_pcode = static_cast<u7>(instr);
	u3 funct3 = static_cast<u3>(instr >> 12);
	u7 funct7 = static_cast<u7>(instr >> 25);
	u12 funct12 = static_cast<u12>(instr >> 20);
	u5 rs1 = static_cast<u5>(instr >> 15);
	u5 rs2 = static_cast<u5>(instr >> 20);
	u5 rd = static_cast<u5>(instr >> 7);
	i32 imm_B = ((instr >> 7) & 0x1e) | ((instr >> 20) & 0x7e0)
			| ((instr << 4) & 0x800) | ((instr >> 19) & 0xffff'f000);
	i32 imm_I = (instr >> 20);
	u5 imm_I2 = (instr >> 20) & 0x1f;
	i32 imm_J = ((instr >> 20) & 0x7fe) | ((instr >> 9) & 0x800)
			| (instr & 0xf'f000) | ((instr >> 11) & 0xfff0'0000);
	i32 imm_S = ((instr >> 7) & 0x1f) | ((instr >> 20) & 0xffff'ffe0);
	i32 imm_U = instr & 0xffff'f000;
	bool branch = false;
	xreg[0] = 0;

	// branch on instruction
	switch (o_pcode) {
	case 0b011'0111:  // LUI
		xreg[rd] = imm_U;
		break;
	case 0b001'0111:  // AUI_pc
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
			// error
			Error(&_error);
			break;
		}
		break;
	case 0b0000011:  // Load
		switch (funct3) {
		case 0b000: {  // LB
			u32 pos = xreg[rs1] + imm_I;
			u32 temp = memory[pos / 4];
			i8 result = temp >> ((pos % 4) * 8);
			xreg[rd] = result;
			break;
		}
		case 0b001: {  // LH
			u32 pos = xreg[rs1] + imm_I;
			u32 temp = memory[pos / 4];
			i16 result = temp >> ((pos % 4) * 8);
			xreg[rd] = result;
			break;
		}
		case 0b010:  // LW
			xreg[rd] = static_cast<u32>(memory[(xreg[rs1] + imm_I) / 4]);
			break;
		case 0b100: {  // LBU
			u32 pos = xreg[rs1] + imm_I;
			u32 temp = memory[pos / 4];
			u8 result = temp >> ((pos % 4) * 8);
			xreg[rd] = result;
			break;
		}
		case 0b101: {  // LHU
			u32 pos = xreg[rs1] + imm_I;
			u32 temp = memory[pos / 4];
			u16 result = temp >> ((pos % 4) * 8);
			xreg[rd] = result;
			break;
		}
		default:
			// error
			Error(&_error);
			break;
		}
		break;
	case 0b0100011:  // Store
		switch (funct3) {
		case 0b000: {  // SB
			u32 pos = (xreg[rs1] + imm_S) / 4;
			u32 offset = ((xreg[rs1] + imm_S) % 4) * 8;
			u32 mask = 0xff << offset;
			memory[pos] = (memory[pos] & (~mask))
					| ((xreg[rs2] & 0xff) << offset);
			break;
		}
		case 0b001: {  // SH
			u32 pos = (xreg[rs1] + imm_S) / 4;
			u32 offset = ((xreg[rs1] + imm_S) % 4) * 8;
			u32 mask = 0xffff << offset;
			memory[pos] = (memory[pos] & (~mask))
					| ((xreg[rs2] & 0xffff) << offset);
			break;
		}
		case 0b010:  // SW
			memory[(xreg[rs1] + imm_S) / 4] = xreg[rs2];
			break;
		default:
			// error
			Error(&_error);
			break;
		}
		break;
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
				// error
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
				xreg[rd] = xreg[rs1] + xreg[rs2];
				break;
			case 0b0100000:  // SUB
				// no cast to signed needed because of overflow
				xreg[rd] = xreg[rs1] - xreg[rs2];
				break;
			default:
				// error
				Error(&_error);
				break;
			}
			break;
		case 0b001:  // SLL
			if (funct7 == 0) {
				xreg[rd] = xreg[rs1] << (xreg[rs2] & 0x1f);
			} else {
				// error
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
				// error
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
				// error
				Error(&_error);
			}
			break;
		case 0b100:  // XOR
			if (funct7 == 0) {
				xreg[rd] = xreg[rs1] ^ xreg[rs2];
			} else {
				// error
				Error(&_error);
			}
			break;
		case 0b101:  // Shift
			switch (funct7) {
			case 0b0000000:  // SRL
				xreg[rd] = xreg[rs1] >> (xreg[rs2] & 0x1f);
				break;
			case 0b0100000:  // SRA
				xreg[rd] = static_cast<i32>(xreg[rs1]) >> (xreg[rs2] & 0x1f);
				break;
			default:
				// error
				Error(&_error);
				break;
			}
			break;
		case 0b110:  // OR
			if (funct7 == 0) {
				xreg[rd] = xreg[rs1] | xreg[rs2];
			} else {
				// error
				Error(&_error);
			}
			break;
		case 0b111:  // AND
			if (funct7 == 0) {
				xreg[rd] = xreg[rs1] & xreg[rs2];
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

	// increment program counter
	if (!branch) {
		_pc += 4;
	}
	*pc = _pc;
	*error = _error;
}
