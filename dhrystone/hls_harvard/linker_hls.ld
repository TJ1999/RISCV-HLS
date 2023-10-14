OUTPUT_ARCH(riscv)
ENTRY(_start)

MEMORY
{
    INSTR_RAM (xrx)     : ORIGIN = 0x00000000, LENGTH = 204800
    DATA_RAM (xrw)      : ORIGIN = 0x10000000, LENGTH = 204800
}

SECTIONS
{
    __stack_size = 0x2000;
    __heap_size = 0x4000;
    PROVIDE(__stack_size = __stack_size);

    . = 0x00000000;
    PROVIDE (__executable_start = .);
    .text :
    {
        . = ALIGN(4);
        *(.startup*)
        . = 0x100;
        *(.start_trigger)
        . = 0x200;
        *(.stop_trigger)
        *(.text*)
        . = ALIGN(4);
    } > INSTR_RAM
    PROVIDE (_etext = .);

    .rodata :
    {
        *(.rodata*)
        . = ALIGN(4);
    } > DATA_RAM

    .sdata :
    {
        __DATA_BEGIN__ = .;
        *(.sdata*)
        . = ALIGN(4);
    } > DATA_RAM

    .data :
    {
        *(.data*)
        . = ALIGN(4);
    } > DATA_RAM
    _edata = .;
    PROVIDE (_edata = .);

    .bss :
    {
        *(.*bss*)
        . = ALIGN(4);
    } > DATA_RAM

    .stack :
    {
        . += __stack_size;
        . += __heap_size;
        . = ALIGN(16);
        PROVIDE(_estack = .);
    } > DATA_RAM

    _end = .; 
    PROVIDE (end = .);

    __global_pointer$ = __DATA_BEGIN__ + 0x800;
}
