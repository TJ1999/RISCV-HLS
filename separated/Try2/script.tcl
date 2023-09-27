############################################################
## This file is generated automatically by Vitis HLS.
## Please DO NOT edit it.
## Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
## Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
############################################################
open_project separated
set_top processor
add_files separated/src/rv32i.cpp -cflags "-Iseparated/include"
add_files -tb separated/src/processor_tb.cpp -cflags "-Iseparated/include -Wno-unknown-pragmas"
add_files -tb separated/src/processor_tb_big.cpp -cflags "-Iseparated/include -Wno-unknown-pragmas"
open_solution "Try2" -flow_target vivado
set_part {xc7a100t-csg324-1}
create_clock -period 20 -name default
config_export -display_name RISCV_sep_2 -format ip_catalog -output C:/work/RISCV-HLS/exported_rtls -rtl verilog -vendor TJ -version 1.0.0
source "./separated/Try2/directives.tcl"
csim_design
csynth_design
cosim_design
export_design -rtl verilog -format ip_catalog -output C:/work/RISCV-HLS/exported_rtls
