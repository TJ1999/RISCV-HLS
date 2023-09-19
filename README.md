# Commands
To build the embench-iot project:
```sh
python3 build_all.py --arch riscv32 --chip hls --board hls --user-libs="-lm" --builddir build
```

To convert elf to bin:
```sh
riscv32-unknown-elf-objcopy -O binary aha-mont64 aha-mont64.bin
```

To make 32-bit values out of it:
```sh
hexdump -v -e '1/4 "0x%08x,\n"' <file>
```

To make a `coe` file for Vivado:
```sh
hexdump -v -e '1/4 "%08x,\n"' <file>
```

# Settings
| Setting | Value
|---------|-------
| Part    | xc7a35tcpg236-1 lowest speed grade
| Period  | 10ns (100Mhz)

# Variations
## RISCV (RV32i) All-In-One Implementation
This is the first implementation trying to put the whole logic in one single cpp file and function

# Results
| Parameter | All-in-one | ...
|-----------|------------|-----
|   LOC     |        384 |  
|   FFs     |       1108 |
|   LUTs    |       2261 |
|   DSPs    |          0 |
| est. Power|      0.248 |
|   II      |          6 |
|   Latency |          7 |
|           |            |
| dhrystone |        TBD |
|  embench  |        TBD |
