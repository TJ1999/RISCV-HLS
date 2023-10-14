#!/bin/bash

clear
riscv32-unknown-elf-objcopy -O binary dry2 dry2.bin
hexdump -v -e '1/4 "%08x "' dry2.bin
