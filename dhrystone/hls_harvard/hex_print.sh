#!/bin/bash

clear
riscv32-unknown-elf-objcopy -O binary -j .text dry2 dry2_instr.bin
riscv32-unknown-elf-objcopy -O binary -R .text dry2 dry2_data.bin

echo "Instruction data:\n"
hexdump -v -e '1/4 "0x%08x,\n"' dry2_instr.bin
echo "\n\nData data:\n"
hexdump -v -e '1/4 "0x%08x,\n"' dry2_data.bin
echo "\n"