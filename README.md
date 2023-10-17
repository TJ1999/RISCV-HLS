# RICV-HLS

This repository provides different variations of how a RV32I core can be implemented using HLS.
The C++ specifications are synthesized using Vitis HLS 2023.1 and implemented using Vivado 2023.1 on a Digilent ARTY A7 Board

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

Vitis is generating a memory interface for BRAM memory with a read latency of one clock cycle

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

By trying to pipeline the function using a while loop, latency remains unchanged

### All-In-One Implementation using arbitrary integer functions and little optimize

In this variation, the source registers are read in the first place. 

The result is stored in a variable and at the end stored in the register. The same mechanism is done with load and store instructions as well as branch instructions.

By trying to pipeline the function using a while loop, latency remains unchanged

### All-In-One Implementation using arbitrary integer functions and little optimize with harvard and loop

In this variation, the harvard architecture has been applied. Unfortunately, this has not further improved performance.

In a following step, a while loop has been applied. But without success. Depending on how the while loop has been applied, Vitis complains about
> WARNING: [RTGEN 206-101] Port 'processor/error' has no fanin or fanout and is left dangling.

In the synthesized design the error port was not working anymore. In that case however, The number of flip flops and LUTs went down significantly. With some restructure of writing to the error variable the ressource usage and performance is equivilent to no loop.


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

In this variation, a while loop has been applied. This time without the warning message as with the all in one variation.

Unfortunately, performance decreased a little, but ressources and power consumption descresed too.

Directives like `ARRAY_PARTITION` to the registers and applying a true dual port memory has not further improved performance.

### Separated optimized harvard

By using the harvard architecture latency can be reduced by applying the `ARRAY_PARTITION` directive to the register array. This has not worked with the von neumann architecture.

## Results
Notes:
- Rocket Chips are too big and complex to compare them here
- OoO Chip by Andrew Hanselman offeres no sources
- All benchmarks form this papers variations regardless of architecture take approx. 14.70 million instructions and have taken 50000 dhrystone runs

**100 Mhz:**

| *Parameter*   | Aio   | Aio ap | Aio opt | Aio opt hvd | Sep   | Sep opt | Sep opt hvd | PiocRV32I |
| ------------- | ----- | ------ | ------- | ----------- | ----- | ------- | ----------- | --------- |
| LOC           | 338   | 356    | 391     | 404         | 429   | 434     | 447         | 3044      |
| FFs           | 1078  | 819    | 437     | 462         | 448   | 440     | 1452        | 446       |
| LUTs          | 2093  | 1868   | 1557    | 1726        | 1697  | 1600    | 3980        | 1226      |
| est. P (W)    | 0.232 | 0.218  | 0.234   | 0.222       | 0.243 | 0.218   | 0.242       | 0.231     |
| II            | 3-7   | 3-7    | 4-6     | 4-6         | 5-7   | 6       | 3           | -         |
| Latency       | 2-6   | 2-6    | 3-5     | 3-5         | 4-6   | 5       | 5           | -         |
| CPI           | 5.6   | 5.6    | 5.5     | 5.5         | 5.8   | 5.9     | 3.0         | 5.3       |
|               |       |        |         |             |       |         |             |           |
| dhrystone[^1] | 608   | 609    | 622     | 623         | 587   | 573     | 1134        | 647       |

**50 MHz:**
| *Parameter*   | Aio   | Aio ap | Aio opt | Aio opt hvd | Sep   | Sep opt | Sep opt hvd | PiocRV32I | COMET   |
| ------------- | ----- | ------ | ------- | ----------- | ----- | ------- | ----------- | --------- | ------- |
| LOC           | 338   | 356    | 391     | 404         | 429   | 434     | 447         | 3044      | ~700    |
| FFs           | 209   | 231    | 313     | 338         | 283   | 307     | 1334        | 446       | 811     |
| LUTs          | 1863  | 1741   | 1598    | 1694        | 1595  | 1545    | 3202        | 1220      | 1818    |
| est. Power    | 0.219 | 0.214  | 0.225   | 0.231       | 0.216 | 0.213   | 0.229       | 0.219     | 0.288   |
| II            | 3-4   | 3-4    | 4       | 4           | 4     | 4       | 2           | -         | -       |
| Latency       | 2-3   | 2-3    | 3       | 3           | 3     | 3       | 3           | -         | -       |
| CPI           | 3.9   | 3.9    | 3.9     | 4.0         | 3.9   | 4.0     | 2.0         | 5.3       | 1.9[^2] |
|               |       |        |         |             |       |         |             |           |         |
| dhrystone[^1] | 870   | 870    | 862     | 855         | 862   | 855     | 1698        | 649       | -       |

[^1]: in Dhrystones/Second/Mhz

[^2]: according to their paper
