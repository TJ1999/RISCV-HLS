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

This is the first implementation trying to put the whole logic in one single cpp file and function

### All-In-One Implementation using arbitrary integer functions

functions like bit access or bit range access has been used.
There was a warning when using these with variable-indexed ranges:

> *WARNING: [SYNCHK 200-23] all_in_one_aplib/src/rv32i.cpp:120: variable-indexed range selection may cause suboptimal QoR*

Therefore, instructions like store and load have been implemented using if case instructions to use constant indexes

Adding the `#pragma HLS ARRAY_PARTITION variable=xreg type=complete` has not made any advances

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

## Results

**100 Mhz:**

| *Parameter*   | Aio   | Aio aplib | Aio opt | Separated | PiocRV32I |
| ------------- | ----- | --------- | ------- | --------- | --------- |
| LOC           | 357   | 371       | 411     | 425       | 3044      |
| FFs           | 1108  | 846       | 537     | 1635      |           |
| LUTs          | 2261  | 2167      | 2100    | 2909      |           |
| DSPs          | 0     | 0         | 0       | 0         |           |
| est. Power    | 0.248 | 0.268     | 0.233   | 0.260     |           |
| II            | 6     | 5         | 6       | 4         |           |
| Latency       | 7     | 6         | 7       | 5         |           |
|               |       |           |         |           |           |
| dhrystone[^1] | 573   | 640       | 535     | 694       | 908[^2]   |
| embench       |       |           |         |           |           |

**50 MHz:**
| *Parameter*   | Aio   | Aio aplib | Aio opt | Separated | PiocRV32I |
| ------------- | ----- | --------- | ------- | --------- | --------- |
| LOC           | 357   | 371       | 411     | 425       | 3044      |
| FFs           | 235   | 308       | 461     | 1456      |           |
| LUTs          | 2040  | 2004      | 2073    | 2726      |           |
| DSPs          | 0     | 0         | 0       | 0         |           |
| est. Power    | 0.237 | 0.228     | 0.220   | 0.238     |           |
| II            | 3     | 3         | 4       | 3         |           |
| Latency       | 4     | 4         | 5       | 4         |           |
|               |       |           |         |           |           |
| dhrystone[^1] | 434   | 434       | 345     | 427       | 908[^2]   |
| embench       |       |           |         |           |           |

[^1]: in Dhrystones/Second/Mhz

[^2]: with enabled `ENABLE_FAST_MUL`, `ENABLE_DIV`, and `BARREL_SHIFTER` options with CPI ~4.1 or CPI ~5.232 without look-ahead memory and only 0.305 DMIPS/MHz or 536 Drystones/s
