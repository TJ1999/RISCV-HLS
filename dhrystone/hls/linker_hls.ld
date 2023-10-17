OUTPUT_ARCH(riscv)
ENTRY(_start)

SECTIONS
{
    __stack_size = 0x2000;
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
    }
    PROVIDE (_etext = .);

    .rodata :
    {
        *(.rodata*)
        . = ALIGN(4);
    }

    .sdata :
    {
        __DATA_BEGIN__ = .;
        *(.sdata*)
        . = ALIGN(4);
    }

    .data :
    {
        *(.data*)
        . = ALIGN(4);
    }
    _edata = .;
    PROVIDE (_edata = .);

    .bss :
    {
        *(.*bss*)
        . = ALIGN(4);
    }

    .stack :
    {
        . += __stack_size;
        . = ALIGN(16);
        PROVIDE(_estack = .);
    }

    _end = .; 
    PROVIDE (end = .);

    __global_pointer$ = __DATA_BEGIN__ + 0x800;
}
