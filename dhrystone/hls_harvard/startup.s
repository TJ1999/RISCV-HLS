.section .startup
.global _start
.global main
.global tohost

_start:
    .option push
	.option norelax
	auipc gp, %pcrel_hi(__global_pointer$)
	addi gp, gp, %pcrel_lo(_start)
	.option pop
    la  sp, _estack
    j   main

# used for spike simulation (see: https://github.com/riscv-software-src/riscv-isa-sim/issues/364)
.section .data
    tohost: .word 0
    fromhost: .word 0
