# RICV-HLS

## Commands

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

## Settings

| Setting | Value                              |
| ------- | ---------------------------------- |
| Part    | xc7a35tcpg236-1 lowest speed grade |
| Period  | 10ns (100Mhz)                      |

## Variations

### RISCV (RV32i) All-In-One Implementation

This is the first implementation trying to put the whole logic in one single cpp file and function

### RISCV (RV32i) All-In-One Implementation using arbitrary integer functions

functions like bit access or bit range access has been used.
There was a warning when using these with variable-indexed ranges:

> *WARNING: [SYNCHK 200-23] all_in_one_aplib/src/rv32i.cpp:120: variable-indexed range selection may cause suboptimal QoR*

Therefore, instructions like store and load have been implemented using if case instructions to use constant indexes

Adding the `#pragma HLS ARRAY_PARTITION variable=xreg type=complete` has not made any advances

### RISCV (RV32i) All-In-One Implementation using arbitrary integer functions and little optimize

In this variation, the source registers are read in the first place. Also the result is stored in a variable and at the end stored in the register.

## Results

| *Parameter*   | All-in-one | All-in-one aplib | All-in-one aplib opt | PiocRV32I |
| ------------- | ---------- | ---------------- | -------------------- | --------- |
| LOC           | 384        | 371              | 411                  | 3044      |
| FFs           | 1108       | 846              | 537                  |           |
| LUTs          | 2261       | 2167             | 2100                 |           |
| DSPs          | 0          | 0                | 0                    |           |
| est. Power    | 0.248      | 0.268            | 0.233                |           |
| II            | 6          | 5                | 6                    |           |
| Latency       | 7          | 6                | 7                    |           |
|               |            |                  |                      |           |
| dhrystone[^1] | 573        | 640              | 535                  | 908[^2]   |
| embench       |            |                  |                      |           |

[^1]: in Dhrystones/Second/Mhz

[^2]: with enabled `ENABLE_FAST_MUL`, `ENABLE_DIV`, and `BARREL_SHIFTER` options with CPI ~4.1 or CPI ~5.232 without look-ahead memory and only 0.305 DMIPS/MHz or 536 Drystones/s
