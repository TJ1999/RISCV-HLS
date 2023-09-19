arg=$1
cd ${arg}
riscv32-unknown-elf-objcopy -O binary ${arg} ${arg}.bin
hexdump -v -e '1/4 "%08x "' ${arg}.bin
cd ..