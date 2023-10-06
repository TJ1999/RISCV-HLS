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

| Setting         | Value                               |
| --------------- | ----------------------------------- |
| Part            | xc7a100tcpg236-1 lowest speed grade |
| Period for Try1 | 10ns (100Mhz)                       |
| Period for Try2 | 20ns (50Mhz)                        |

## Variations

### All-In-One Implementation

This is the first implementation trying to put the whole logic in one single cpp file and function.
By trying to change the architecture from von Neumann to Harvard, Latency stays the same.

### All-In-One Implementation using arbitrary integer functions

functions like bit access or bit range access has been used.
There was a warning when using these with variable-indexed ranges:

> *WARNING: [SYNCHK 200-23] all_in_one_aplib/src/rv32i.cpp:120: variable-indexed range selection may cause suboptimal QoR*

Therefore, instructions like store and load have been implemented using if case instructions to use constant indexes

Adding the `#pragma HLS ARRAY_PARTITION variable=xreg type=complete` has not made any advances

By trying to change the architecture from von Neumann to Harvard, Latency stays the same.

### All-In-One Implementation using arbitrary integer functions and little optimize

In this variation, the source registers are read in the first place. Also the result is stored in a variable and at the end stored in the register.

### Separated

The all in one function has been splitted in the following functions:
- `fetch_instruction`
- `decode_fetch_operands`
- `execute_xxx` A switch has been implemented to choose the correct execute function. These are one of:
  - `execute_branch`
  - `execute_load`
  - `execute_store`
  - `execute_arithm`
- `write_back`

Moreover, the `#pragma HLS ARRAY_PARTITION variable=xreg type=complete` can now be defined to further improve performance.

By trying to change the architecture from von Neumann to Harvard, Latency stays the same.

### Separated optimized

TODO

## Results
Notes:
- Rocket Chips are too big and complex to compare them here
- OoO Chip by Andrew Hanselman offeres no sources
- PicoRV32I does not execute benchmark due to an memory misalignment trap

> ***WARNING: Benchmarks need to be redone due to new linkerscript file!!!***

**100 Mhz:**

| *Parameter*   | Aio   | Aio aplib | Aio opt | Separated | COMET     | PiocRV32I |
| ------------- | ----- | --------- | ------- | --------- | --------- | --------- |
| LOC           | 355   | 369       | 416     | 423       |           | 3044      |
| FFs           | 1057  | 795       | 352     | 1617      |           | 464       |
| LUTs          | 2253  | 2104      | 1807    | 2926      |           | 1097      |
| DSPs          | 0     | 0         | 0       | 0         |           | 0         |
| est. Power    | 0.246 | 0.244     | 0.227   | 0.279     | Timing    | 0.213     |
| II            | 6     | 5         | 6       | 4         | Violation | -         |
| Latency       | 7     | 6         | 7       | 5         |           | -         |
|               |       |           |         |           |           |           |
| dhrystone[^1] | 573   | 640       | 552     | 696       |           | 908[^2]   |
| embench       |       |           |         |           |           |           |

**50 MHz:**
| *Parameter*   | Aio   | Aio aplib | Aio opt | Separated | COMET | PiocRV32I |
| ------------- | ----- | --------- | ------- | --------- | ----- | --------- |
| LOC           | 355   | 369       | 416     | 423       | ~700  | 3044      |
| FFs           | 187   | 258       | 239     | 1438      | 811   | 464       |
| LUTs          | 1918  | 1914      | 1845    | 2700      | 1818  | 1097      |
| DSPs          | 0     | 0         | 0       | 0         | 4     | 0         |
| est. Power    | 0.231 | 0.222     | 0.238   | 0.241     | 0.228 | 0.204     |
| II            | 3     | 3         | 3       | 3         | -     | -         |
| Latency       | 4     | 4         | 4       | 4         | -     | -         |
|               |       |           |         |           |       |           |
| dhrystone[^1] | 870   | 870       | 862     | 855       | [^3]  | 908[^2]   |
| embench       |       |           |         |           |       |           |

[^1]: in Dhrystones/Second/Mhz

[^2]: according to GitHub: with enabled `ENABLE_FAST_MUL`, `ENABLE_DIV`, and `BARREL_SHIFTER` options with CPI ~4.1 or CPI ~5.232 without look-ahead memory and only 0.305 DMIPS/MHz or 536 Drystones/s. Pico Processor synthesises but behaves not as expected. Jumping to a function results in too far jumps. Therefore, the benchmark could not be executed

[^3]: only provides 8192 byte data mem hard coded
