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

## Separated optimized harvard

By using the harvard architecture latency can be reduced by applying the `ARRAY_PARTITION` directive to the register array. This has not worked with the von neumann architecture.

## Results
Notes:
- Rocket Chips are too big and complex to compare them here
- OoO Chip by Andrew Hanselman offeres no sources
- PicoRV32I does not execute benchmark due to an memory misalignment trap
- All benchmarks form this papers variations regardless of architecture take approx. 14.700 million instructions

**100 Mhz:**

| *Parameter*   | Aio   | Aio ap | Aio opt | Aio opt hvd | Sep   | Sep opt | Sep opt hvd | COMET  | PiocRV32I |
| ------------- | ----- | ------ | ------- | ----------- | ----- | ------- | ----------- | ------ | --------- |
| LOC           | 338   | 356    | 391     | 404         | 429   | 434     | 447         |        | 3044      |
| FFs           | 1078  | 819    | 437     | 462         | 448   | 440     | 1452        |        | 464       |
| LUTs          | 2093  | 1868   | 1557    | 1726        | 1697  | 1600    | 3980        | Timing | 1097      |
| DSPs          | 0     | 0      | 0       | 0           | 0     | 0       | 0           | Vio-   | 0         |
| est. Power    | 0.232 | 0.218  | 0.234   | 0.222       | 0.243 | 0.218   | 0.242       | lation | 0.213     |
| II            | 6     | 6      | 5       | 5           | 6     | 6       | 3           |        | -         |
| Latency       | 7     | 7      | 6       | 6           | 7     | 7       | 7           |        | -         |
|               |       |        |         |             |       |         |             |        |           |
| dhrystone[^1] | 608   | 609    | 622     | 623         | 587   | 573     | 1134        |        | 908[^2]   |

**50 MHz:**
| *Parameter*   | Aio   | Aio ap | Aio opt | Aio opt hvd | Sep   | Sep opt | Sep opt hvd | COMET | PiocRV32I |
| ------------- | ----- | ------ | ------- | ----------- | ----- | ------- | ----------- | ----- | --------- |
| LOC           | 338   | 356    | 391     | 404         | 429   | 434     | 447         | ~700  | 3044      |
| FFs           | 209   | 231    | 313     | 338         | 283   | 307     | 1334        | 811   | 464       |
| LUTs          | 1863  | 1741   | 1598    | 1694        | 1595  | 1545    | 3202        | 1818  | 1097      |
| DSPs          | 0     | 0      | 0       | 0           | 0     | 0       | 0           | 4     | 0         |
| est. Power    | 0.219 | 0.214  | 0.225   | 0.231       | 0.216 | 0.213   | 0.229       | 0.228 | 0.204     |
| II            | 3     | 3      | 3       | 3           | 3     | 4       | 2           | -     | -         |
| Latency       | 4     | 4      | 4       | 4           | 4     | 5       | 5           | -     | -         |
|               |       |        |         |             |       |         |             |       |           |
| dhrystone[^1] | 870   | 870    | 862     | 855         | 862   | 855     | 1698        | [^3]  | 908[^2]   |

[^1]: in Dhrystones/Second/Mhz

[^2]: according to GitHub: with enabled `ENABLE_FAST_MUL`, `ENABLE_DIV`, and `BARREL_SHIFTER` options with CPI ~4.1 or CPI ~5.232 without look-ahead memory and only 0.305 DMIPS/MHz or 536 Drystones/s. Pico Processor synthesises but behaves not as expected. Jumping to a function results in too far jumps. Therefore, the benchmark could not be executed

[^3]: only provides 8192 byte data mem hard coded
