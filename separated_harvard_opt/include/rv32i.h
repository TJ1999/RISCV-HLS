#pragma once

#include "ap_int.h"
#include <vector>
#include <cstdint>

using u1 = ap_uint<1>;
using u3 = ap_uint<3>;
using u5 = ap_uint<5>;
using i5 = ap_int<5>;
using u7 = ap_uint<7>;
using u8 = ap_uint<8>;
using i8 = ap_int<8>;
using i12 = ap_int<12>;
using u12 = ap_uint<12>;
using i13 = ap_int<13>;
using i16 = ap_int<16>;
using u16 = ap_uint<16>;
using i20 = ap_int<20>;
using i21 = ap_int<21>;
using u32 = ap_uint<32>;
using i32 = ap_int<32>;

static constexpr std::size_t MEMORY_SIZE = 102400;

void reset_processor ();
void processor(const u32* memory, u32* data, u1* error);
void do_process(const u32* instr_memory, u32* data_memory, u1 *error);
void benchmark(bool &finished);
