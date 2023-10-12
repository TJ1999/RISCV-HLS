// ==============================================================
// Generated by Vitis HLS v2023.1.1
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// ==============================================================

`timescale 1 ns / 1 ps 

module processor_do_process (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        memory_address0,
        memory_ce0,
        memory_we0,
        memory_d0,
        memory_q0,
        ap_return
);

parameter    ap_ST_fsm_state1 = 6'd1;
parameter    ap_ST_fsm_state2 = 6'd2;
parameter    ap_ST_fsm_state3 = 6'd4;
parameter    ap_ST_fsm_state4 = 6'd8;
parameter    ap_ST_fsm_state5 = 6'd16;
parameter    ap_ST_fsm_state6 = 6'd32;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
output  [16:0] memory_address0;
output   memory_ce0;
output   memory_we0;
output  [31:0] memory_d0;
input  [31:0] memory_q0;
output  [0:0] ap_return;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg[16:0] memory_address0;
reg memory_ce0;
reg memory_we0;

(* fsm_encoding = "none" *) reg   [5:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
reg   [31:0] g_pc;
reg   [0:0] g_error;
reg   [4:0] g_xreg_address0;
reg    g_xreg_ce0;
reg    g_xreg_we0;
reg   [31:0] g_xreg_d0;
wire   [31:0] g_xreg_q0;
reg   [4:0] g_xreg_address1;
reg    g_xreg_ce1;
reg    g_xreg_we1;
wire   [31:0] g_xreg_d1;
wire   [31:0] g_xreg_q1;
reg   [31:0] reg_372;
wire    ap_CS_fsm_state2;
wire    ap_CS_fsm_state5;
reg   [6:0] op_code_reg_1123;
reg   [31:0] pc_reg_1102;
wire   [6:0] op_code_fu_414_p1;
reg   [2:0] funct3_reg_1134;
reg   [6:0] funct7_reg_1139;
reg   [4:0] rd_reg_1144;
wire   [20:0] imm_6_fu_626_p3;
reg   [20:0] imm_6_reg_1160;
reg   [31:0] source1_reg_1165;
wire    ap_CS_fsm_state3;
reg   [31:0] result_18_reg_1178;
wire   [31:0] imm_8_fu_731_p3;
reg   [31:0] imm_8_reg_1190;
wire   [0:0] grp_fu_335_p2;
reg   [0:0] branch_5_reg_1200;
wire    ap_CS_fsm_state4;
reg   [0:0] branch_4_reg_1204;
wire   [0:0] grp_fu_339_p2;
reg   [0:0] branch_3_reg_1208;
reg   [0:0] branch_2_reg_1212;
wire   [0:0] grp_fu_343_p2;
reg   [0:0] branch_1_reg_1216;
reg   [0:0] branch_reg_1220;
reg   [16:0] memory_addr_1_reg_1229;
wire   [31:0] result_execute_arithm_fu_315_ap_return;
reg   [31:0] result_reg_1234;
wire   [31:0] add_ln378_fu_803_p2;
wire   [31:0] zext_ln160_fu_823_p1;
wire   [1:0] offset_1_fu_814_p2;
wire   [31:0] zext_ln158_fu_831_p1;
wire   [31:0] zext_ln151_fu_899_p1;
wire  signed [31:0] sext_ln139_fu_903_p1;
wire  signed [31:0] sext_ln137_fu_911_p1;
wire  signed [31:0] sext_ln130_fu_979_p1;
wire   [31:0] result_13_fu_1004_p5;
wire   [1:0] offset_fu_995_p2;
wire   [31:0] result_12_fu_1019_p5;
wire   [31:0] result_11_fu_1034_p5;
wire   [31:0] result_10_fu_1046_p5;
wire   [31:0] result_9_fu_1058_p5;
wire   [31:0] result_8_fu_1070_p5;
wire    result_execute_arithm_fu_315_ap_ready;
wire   [0:0] result_execute_arithm_fu_315_g_error;
wire    result_execute_arithm_fu_315_g_error_ap_vld;
reg   [31:0] empty_reg_220;
reg   [31:0] empty_17_reg_230;
reg   [31:0] p_0_0_03053_reg_250;
reg   [31:0] result_4_reg_274;
wire   [31:0] grp_fu_328_p2;
reg   [31:0] ap_phi_mux_storemerge_phi_fu_309_p4;
reg   [31:0] storemerge_reg_306;
wire    ap_CS_fsm_state6;
wire   [63:0] zext_ln29_fu_409_p1;
wire   [63:0] zext_ln42_fu_468_p1;
wire   [63:0] zext_ln43_fu_473_p1;
wire   [63:0] zext_ln372_fu_739_p1;
wire   [63:0] zext_ln122_fu_765_p1;
wire   [63:0] zext_ln173_fu_792_p1;
wire   [63:0] zext_ln372_1_fu_1088_p1;
wire   [0:0] icmp_ln26_fu_387_p2;
wire   [1:0] trunc_ln25_fu_383_p1;
wire   [16:0] lshr_ln_fu_399_p4;
wire   [4:0] rs1_fu_448_p4;
wire   [4:0] rs2_fu_458_p4;
wire   [6:0] tmp_1_fu_488_p4;
wire   [4:0] tmp_s_fu_478_p4;
wire   [11:0] imm_1_fu_498_p3;
wire   [0:0] tmp_5_fu_538_p3;
wire   [0:0] tmp_4_fu_530_p3;
wire   [5:0] tmp_3_fu_520_p4;
wire   [3:0] tmp_2_fu_510_p4;
wire   [12:0] imm_2_fu_546_p6;
wire   [7:0] tmp_8_fu_582_p4;
wire   [0:0] tmp_7_fu_574_p3;
wire   [9:0] tmp_6_fu_564_p4;
wire   [0:0] icmp_ln46_fu_606_p2;
wire  signed [20:0] sext_ln392_1_fu_560_p1;
wire   [20:0] imm_4_fu_592_p6;
wire   [0:0] icmp_ln46_1_fu_620_p2;
wire  signed [20:0] sext_ln392_fu_506_p1;
wire   [20:0] imm_5_fu_612_p3;
wire   [11:0] imm_fu_634_p4;
wire   [19:0] tmp_fu_648_p4;
wire   [0:0] icmp_ln46_2_fu_669_p2;
wire   [0:0] icmp_ln46_3_fu_674_p2;
wire   [0:0] or_ln46_fu_679_p2;
wire   [31:0] imm_3_fu_658_p3;
wire  signed [31:0] sext_ln392_2_fu_666_p1;
wire   [0:0] icmp_ln46_4_fu_693_p2;
wire   [0:0] icmp_ln46_5_fu_698_p2;
wire   [0:0] icmp_ln46_6_fu_703_p2;
wire   [0:0] icmp_ln46_7_fu_708_p2;
wire   [0:0] or_ln46_2_fu_719_p2;
wire   [0:0] or_ln46_1_fu_713_p2;
wire   [0:0] or_ln46_3_fu_725_p2;
wire  signed [31:0] sext_ln52_fu_644_p1;
wire   [31:0] imm_7_fu_685_p3;
wire   [18:0] trunc_ln120_1_fu_746_p1;
wire   [18:0] trunc_ln120_fu_743_p1;
wire   [18:0] add_ln120_fu_749_p2;
wire   [16:0] mem_pos_fu_755_p4;
wire   [18:0] trunc_ln171_1_fu_773_p1;
wire   [18:0] trunc_ln171_fu_770_p1;
wire   [18:0] add_ln171_fu_776_p2;
wire   [16:0] write_addr_fu_782_p4;
wire   [1:0] trunc_ln120_3_fu_811_p1;
wire   [1:0] trunc_ln120_2_fu_808_p1;
wire   [15:0] grp_fu_347_p4;
wire   [15:0] result_16_fu_827_p1;
wire   [0:0] grp_fu_367_p2;
wire   [7:0] tmp_14_fu_859_p4;
wire   [7:0] tmp_13_fu_849_p4;
wire   [0:0] grp_fu_362_p2;
wire   [0:0] grp_fu_357_p2;
wire   [7:0] trunc_ln147_fu_845_p1;
wire   [7:0] tmp_12_fu_835_p4;
wire   [0:0] or_ln146_fu_877_p2;
wire   [7:0] select_ln146_fu_869_p3;
wire   [7:0] select_ln146_1_fu_883_p3;
wire   [7:0] result_6_fu_891_p3;
wire   [15:0] result_14_fu_907_p1;
wire   [7:0] tmp_11_fu_939_p4;
wire   [7:0] tmp_10_fu_929_p4;
wire   [7:0] trunc_ln126_fu_925_p1;
wire   [7:0] tmp_9_fu_915_p4;
wire   [0:0] or_ln125_fu_957_p2;
wire   [7:0] select_ln125_fu_949_p3;
wire   [7:0] select_ln125_1_fu_963_p3;
wire   [7:0] result_5_fu_971_p3;
wire   [1:0] trunc_ln171_3_fu_992_p1;
wire   [1:0] trunc_ln171_2_fu_989_p1;
wire   [15:0] trunc_ln190_fu_1001_p1;
wire   [15:0] trunc_ln188_fu_1016_p1;
wire   [7:0] trunc_ln177_fu_1031_p1;
reg   [5:0] ap_NS_fsm;
reg    ap_ST_fsm_state1_blk;
wire    ap_ST_fsm_state2_blk;
wire    ap_ST_fsm_state3_blk;
wire    ap_ST_fsm_state4_blk;
wire    ap_ST_fsm_state5_blk;
wire    ap_ST_fsm_state6_blk;
reg    ap_condition_159;
reg    ap_condition_227;
reg    ap_condition_223;
reg    ap_condition_214;
reg    ap_condition_208;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_CS_fsm = 6'd1;
#0 g_pc = 32'd0;
#0 g_error = 1'd0;
end

processor_do_process_g_xreg_RAM_AUTO_1R1W #(
    .DataWidth( 32 ),
    .AddressRange( 32 ),
    .AddressWidth( 5 ))
g_xreg_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(g_xreg_address0),
    .ce0(g_xreg_ce0),
    .we0(g_xreg_we0),
    .d0(g_xreg_d0),
    .q0(g_xreg_q0),
    .address1(g_xreg_address1),
    .ce1(g_xreg_ce1),
    .we1(g_xreg_we1),
    .d1(g_xreg_d1),
    .q1(g_xreg_q1)
);

processor_execute_arithm result_execute_arithm_fu_315(
    .ap_ready(result_execute_arithm_fu_315_ap_ready),
    .op_code_val(op_code_reg_1123),
    .funct3_val(funct3_reg_1134),
    .funct7_val(funct7_reg_1139),
    .source1_val(source1_reg_1165),
    .source2_val(result_18_reg_1178),
    .imm_val(imm_8_reg_1190),
    .pc_val(pc_reg_1102),
    .g_error(result_execute_arithm_fu_315_g_error),
    .g_error_ap_vld(result_execute_arithm_fu_315_g_error_ap_vld),
    .ap_return(result_execute_arithm_fu_315_ap_return)
);

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        g_pc <= 32'd0;
    end else begin
        if ((1'b1 == ap_CS_fsm_state6)) begin
            g_pc <= ap_phi_mux_storemerge_phi_fu_309_p4;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_state4) & ((op_code_reg_1123 == 7'd103) | (op_code_reg_1123 == 7'd111)))) begin
        empty_17_reg_230 <= empty_reg_220;
    end else if ((((grp_fu_335_p2 == 1'd0) & (funct3_reg_1134 == 3'd7) & (op_code_reg_1123 == 7'd99) & (1'b1 == ap_CS_fsm_state4)) | ((grp_fu_335_p2 == 1'd1) & (funct3_reg_1134 == 3'd6) & (op_code_reg_1123 == 7'd99) & (1'b1 == ap_CS_fsm_state4)) | ((funct3_reg_1134 == 3'd0) & (op_code_reg_1123 == 7'd99) & (1'b1 == ap_CS_fsm_state4) & (grp_fu_343_p2 == 1'd1)) | ((funct3_reg_1134 == 3'd1) & (op_code_reg_1123 == 7'd99) & (1'b1 == ap_CS_fsm_state4) & (grp_fu_343_p2 == 1'd0)) | ((funct3_reg_1134 == 3'd4) & (op_code_reg_1123 == 7'd99) & (1'b1 == ap_CS_fsm_state4) & (grp_fu_339_p2 == 1'd1)) | ((funct3_reg_1134 == 3'd5) & (op_code_reg_1123 == 7'd99) & (1'b1 == ap_CS_fsm_state4) & (grp_fu_339_p2 == 1'd0)))) begin
        empty_17_reg_230 <= pc_reg_1102;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state3)) begin
        if ((op_code_reg_1123 == 7'd111)) begin
            empty_reg_220 <= pc_reg_1102;
        end else if ((op_code_reg_1123 == 7'd103)) begin
            empty_reg_220 <= g_xreg_q1;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((((1'b1 == ap_CS_fsm_state5) & (((funct3_reg_1134 == 3'd3) & (op_code_reg_1123 == 7'd99)) | ((funct3_reg_1134 == 3'd2) & (op_code_reg_1123 == 7'd99)))) | ((icmp_ln26_fu_387_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b1)) | (~(funct3_reg_1134 == 3'd2) & ~(funct3_reg_1134 == 3'd0) & ~(funct3_reg_1134 == 3'd1) & (op_code_reg_1123 == 7'd35) & (1'b1 == ap_CS_fsm_state5)) | (~(funct3_reg_1134 == 3'd2) & ~(funct3_reg_1134 == 3'd0) & ~(funct3_reg_1134 == 3'd1) & ~(funct3_reg_1134 == 3'd4) & ~(funct3_reg_1134 == 3'd5) & (op_code_reg_1123 == 7'd3) & (1'b1 == ap_CS_fsm_state5)))) begin
        g_error <= 1'd1;
    end else if ((~(op_code_reg_1123 == 7'd35) & ~(op_code_reg_1123 == 7'd3) & ~(op_code_reg_1123 == 7'd103) & ~(op_code_reg_1123 == 7'd111) & ~(op_code_reg_1123 == 7'd99) & (result_execute_arithm_fu_315_g_error_ap_vld == 1'b1) & (1'b1 == ap_CS_fsm_state4))) begin
        g_error <= result_execute_arithm_fu_315_g_error;
    end
end

always @ (posedge ap_clk) begin
    if (((funct3_reg_1134 == 3'd0) & (op_code_reg_1123 == 7'd35) & (offset_fu_995_p2 == 2'd2) & (1'b1 == ap_CS_fsm_state5))) begin
        p_0_0_03053_reg_250 <= result_11_fu_1034_p5;
    end else if (((funct3_reg_1134 == 3'd0) & (op_code_reg_1123 == 7'd35) & (offset_fu_995_p2 == 2'd1) & (1'b1 == ap_CS_fsm_state5))) begin
        p_0_0_03053_reg_250 <= result_10_fu_1046_p5;
    end else if (((funct3_reg_1134 == 3'd0) & (op_code_reg_1123 == 7'd35) & (offset_fu_995_p2 == 2'd0) & (1'b1 == ap_CS_fsm_state5))) begin
        p_0_0_03053_reg_250 <= result_9_fu_1058_p5;
    end else if (((funct3_reg_1134 == 3'd1) & (op_code_reg_1123 == 7'd35) & (offset_fu_995_p2 == 2'd2) & (1'b1 == ap_CS_fsm_state5))) begin
        p_0_0_03053_reg_250 <= result_13_fu_1004_p5;
    end else if (((funct3_reg_1134 == 3'd1) & (op_code_reg_1123 == 7'd35) & (offset_fu_995_p2 == 2'd0) & (1'b1 == ap_CS_fsm_state5))) begin
        p_0_0_03053_reg_250 <= result_12_fu_1019_p5;
    end else if (((funct3_reg_1134 == 3'd2) & (op_code_reg_1123 == 7'd35) & (1'b1 == ap_CS_fsm_state5))) begin
        p_0_0_03053_reg_250 <= result_18_reg_1178;
    end else if (((funct3_reg_1134 == 3'd0) & (op_code_reg_1123 == 7'd35) & (offset_fu_995_p2 == 2'd3) & (1'b1 == ap_CS_fsm_state5))) begin
        p_0_0_03053_reg_250 <= result_8_fu_1070_p5;
    end else if (((~(offset_fu_995_p2 == 2'd0) & ~(offset_fu_995_p2 == 2'd2) & (funct3_reg_1134 == 3'd1) & (op_code_reg_1123 == 7'd35) & (1'b1 == ap_CS_fsm_state5)) | (~(funct3_reg_1134 == 3'd2) & ~(funct3_reg_1134 == 3'd0) & ~(funct3_reg_1134 == 3'd1) & (op_code_reg_1123 == 7'd35) & (1'b1 == ap_CS_fsm_state5)))) begin
        p_0_0_03053_reg_250 <= memory_q0;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        if ((1'b1 == ap_condition_208)) begin
            result_4_reg_274 <= zext_ln160_fu_823_p1;
        end else if ((1'b1 == ap_condition_214)) begin
            result_4_reg_274 <= zext_ln158_fu_831_p1;
        end else if ((1'b1 == ap_condition_223)) begin
            result_4_reg_274 <= sext_ln139_fu_903_p1;
        end else if ((1'b1 == ap_condition_227)) begin
            result_4_reg_274 <= sext_ln137_fu_911_p1;
        end else if (((funct3_reg_1134 == 3'd2) & (op_code_reg_1123 == 7'd3))) begin
            result_4_reg_274 <= memory_q0;
        end else if (((funct3_reg_1134 == 3'd0) & (op_code_reg_1123 == 7'd3))) begin
            result_4_reg_274 <= sext_ln130_fu_979_p1;
        end else if (((funct3_reg_1134 == 3'd4) & (op_code_reg_1123 == 7'd3))) begin
            result_4_reg_274 <= zext_ln151_fu_899_p1;
        end else if ((1'b1 == ap_condition_159)) begin
            result_4_reg_274 <= result_reg_1234;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_state5) & ((op_code_reg_1123 == 7'd111) | ((op_code_reg_1123 == 7'd103) | (((((((funct3_reg_1134 == 3'd6) & (op_code_reg_1123 == 7'd99) & (branch_4_reg_1204 == 1'd1)) | ((funct3_reg_1134 == 3'd7) & (op_code_reg_1123 == 7'd99) & (branch_5_reg_1200 == 1'd0))) | ((funct3_reg_1134 == 3'd5) & (op_code_reg_1123 == 7'd99) & (branch_3_reg_1208 == 1'd0))) | ((funct3_reg_1134 == 3'd4) & (op_code_reg_1123 == 7'd99) & (branch_2_reg_1212 == 1'd1))) | (~(funct3_reg_1134 == 3'd3) & ~(funct3_reg_1134 == 3'd2) & ~(funct3_reg_1134 == 3'd1) & ~(funct3_reg_1134 == 3'd4) & ~(funct3_reg_1134 == 3'd5) & ~(funct3_reg_1134 == 3'd6) & ~(funct3_reg_1134 == 3'd7) & (op_code_reg_1123 == 7'd99) & (branch_reg_1220 == 1'd1))) | ((funct3_reg_1134 == 3'd1) & (op_code_reg_1123 == 7'd99) & (branch_1_reg_1216 == 1'd0))))))) begin
        storemerge_reg_306 <= add_ln378_fu_803_p2;
    end else if (((1'b1 == ap_CS_fsm_state6) & ((((((((((funct3_reg_1134 == 3'd3) & (op_code_reg_1123 == 7'd99)) | ((funct3_reg_1134 == 3'd2) & (op_code_reg_1123 == 7'd99))) | ((funct3_reg_1134 == 3'd7) & (op_code_reg_1123 == 7'd99) & (branch_5_reg_1200 == 1'd1))) | ((funct3_reg_1134 == 3'd6) & (op_code_reg_1123 == 7'd99) & (branch_4_reg_1204 == 1'd0))) | ((funct3_reg_1134 == 3'd5) & (op_code_reg_1123 == 7'd99) & (branch_3_reg_1208 == 1'd1))) | ((funct3_reg_1134 == 3'd4) & (op_code_reg_1123 == 7'd99) & (branch_2_reg_1212 == 1'd0))) | (~(funct3_reg_1134 == 3'd1) & ~(funct3_reg_1134 == 3'd4) & ~(funct3_reg_1134 == 3'd5) & ~(funct3_reg_1134 == 3'd6) & ~(funct3_reg_1134 == 3'd7) & (op_code_reg_1123 == 7'd99) & (branch_reg_1220 == 1'd0))) | ((funct3_reg_1134 == 3'd1) & (op_code_reg_1123 == 7'd99) & (branch_1_reg_1216 == 1'd1))) | (~(op_code_reg_1123 == 7'd103) & ~(op_code_reg_1123 == 7'd111) & ~(op_code_reg_1123 == 7'd99))))) begin
        storemerge_reg_306 <= grp_fu_328_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((funct3_reg_1134 == 3'd1) & (op_code_reg_1123 == 7'd99) & (1'b1 == ap_CS_fsm_state4))) begin
        branch_1_reg_1216 <= grp_fu_343_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((funct3_reg_1134 == 3'd4) & (op_code_reg_1123 == 7'd99) & (1'b1 == ap_CS_fsm_state4))) begin
        branch_2_reg_1212 <= grp_fu_339_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((funct3_reg_1134 == 3'd5) & (op_code_reg_1123 == 7'd99) & (1'b1 == ap_CS_fsm_state4))) begin
        branch_3_reg_1208 <= grp_fu_339_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((funct3_reg_1134 == 3'd6) & (op_code_reg_1123 == 7'd99) & (1'b1 == ap_CS_fsm_state4))) begin
        branch_4_reg_1204 <= grp_fu_335_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((funct3_reg_1134 == 3'd7) & (op_code_reg_1123 == 7'd99) & (1'b1 == ap_CS_fsm_state4))) begin
        branch_5_reg_1200 <= grp_fu_335_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((funct3_reg_1134 == 3'd0) & (op_code_reg_1123 == 7'd99) & (1'b1 == ap_CS_fsm_state4))) begin
        branch_reg_1220 <= grp_fu_343_p2;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state2)) begin
        funct3_reg_1134 <= {{memory_q0[14:12]}};
        funct7_reg_1139 <= {{memory_q0[31:25]}};
        imm_6_reg_1160 <= imm_6_fu_626_p3;
        op_code_reg_1123 <= op_code_fu_414_p1;
        rd_reg_1144 <= {{memory_q0[11:7]}};
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state3)) begin
        imm_8_reg_1190 <= imm_8_fu_731_p3;
        result_18_reg_1178 <= g_xreg_q0;
        source1_reg_1165 <= g_xreg_q1;
    end
end

always @ (posedge ap_clk) begin
    if (((op_code_reg_1123 == 7'd35) & (1'b1 == ap_CS_fsm_state4))) begin
        memory_addr_1_reg_1229 <= zext_ln173_fu_792_p1;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state1)) begin
        pc_reg_1102 <= g_pc;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_state2) | ((op_code_reg_1123 == 7'd35) & (1'b1 == ap_CS_fsm_state5)) | ((op_code_reg_1123 == 7'd3) & (1'b1 == ap_CS_fsm_state5)))) begin
        reg_372 <= memory_q0;
    end
end

always @ (posedge ap_clk) begin
    if ((~(op_code_reg_1123 == 7'd35) & ~(op_code_reg_1123 == 7'd3) & ~(op_code_reg_1123 == 7'd103) & ~(op_code_reg_1123 == 7'd111) & ~(op_code_reg_1123 == 7'd99) & (1'b1 == ap_CS_fsm_state4))) begin
        result_reg_1234 <= result_execute_arithm_fu_315_ap_return;
    end
end

always @ (*) begin
    if ((ap_start == 1'b0)) begin
        ap_ST_fsm_state1_blk = 1'b1;
    end else begin
        ap_ST_fsm_state1_blk = 1'b0;
    end
end

assign ap_ST_fsm_state2_blk = 1'b0;

assign ap_ST_fsm_state3_blk = 1'b0;

assign ap_ST_fsm_state4_blk = 1'b0;

assign ap_ST_fsm_state5_blk = 1'b0;

assign ap_ST_fsm_state6_blk = 1'b0;

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state6) | ((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b0)))) begin
        ap_done = 1'b1;
    end else begin
        ap_done = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b0))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state6) & ((((((((((funct3_reg_1134 == 3'd3) & (op_code_reg_1123 == 7'd99)) | ((funct3_reg_1134 == 3'd2) & (op_code_reg_1123 == 7'd99))) | ((funct3_reg_1134 == 3'd7) & (op_code_reg_1123 == 7'd99) & (branch_5_reg_1200 == 1'd1))) | ((funct3_reg_1134 == 3'd6) & (op_code_reg_1123 == 7'd99) & (branch_4_reg_1204 == 1'd0))) | ((funct3_reg_1134 == 3'd5) & (op_code_reg_1123 == 7'd99) & (branch_3_reg_1208 == 1'd1))) | ((funct3_reg_1134 == 3'd4) & (op_code_reg_1123 == 7'd99) & (branch_2_reg_1212 == 1'd0))) | (~(funct3_reg_1134 == 3'd1) & ~(funct3_reg_1134 == 3'd4) & ~(funct3_reg_1134 == 3'd5) & ~(funct3_reg_1134 == 3'd6) & ~(funct3_reg_1134 == 3'd7) & (op_code_reg_1123 == 7'd99) & (branch_reg_1220 == 1'd0))) | ((funct3_reg_1134 == 3'd1) & (op_code_reg_1123 == 7'd99) & (branch_1_reg_1216 == 1'd1))) | (~(op_code_reg_1123 == 7'd103) & ~(op_code_reg_1123 == 7'd111) & ~(op_code_reg_1123 == 7'd99))))) begin
        ap_phi_mux_storemerge_phi_fu_309_p4 = grp_fu_328_p2;
    end else begin
        ap_phi_mux_storemerge_phi_fu_309_p4 = storemerge_reg_306;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state6)) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state6)) begin
        g_xreg_address0 = zext_ln372_1_fu_1088_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        g_xreg_address0 = zext_ln43_fu_473_p1;
    end else if ((1'b1 == ap_CS_fsm_state1)) begin
        g_xreg_address0 = 5'd0;
    end else begin
        g_xreg_address0 = 'bx;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state3)) begin
        g_xreg_address1 = zext_ln372_fu_739_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        g_xreg_address1 = zext_ln42_fu_468_p1;
    end else begin
        g_xreg_address1 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state2) | (1'b1 == ap_CS_fsm_state6) | ((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b1)))) begin
        g_xreg_ce0 = 1'b1;
    end else begin
        g_xreg_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state3) | (1'b1 == ap_CS_fsm_state2))) begin
        g_xreg_ce1 = 1'b1;
    end else begin
        g_xreg_ce1 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state6)) begin
        g_xreg_d0 = result_4_reg_274;
    end else if ((1'b1 == ap_CS_fsm_state1)) begin
        g_xreg_d0 = 32'd0;
    end else begin
        g_xreg_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((1'b1 == ap_CS_fsm_state6) & ((~(op_code_reg_1123 == 7'd35) & (op_code_reg_1123 == 7'd3)) | (~(op_code_reg_1123 == 7'd35) & ~(op_code_reg_1123 == 7'd103) & ~(op_code_reg_1123 == 7'd111) & ~(op_code_reg_1123 == 7'd99)))) | ((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b1)))) begin
        g_xreg_we0 = 1'b1;
    end else begin
        g_xreg_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state3) & ((op_code_reg_1123 == 7'd103) | (op_code_reg_1123 == 7'd111)))) begin
        g_xreg_we1 = 1'b1;
    end else begin
        g_xreg_we1 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state6)) begin
        memory_address0 = memory_addr_1_reg_1229;
    end else if (((op_code_reg_1123 == 7'd35) & (1'b1 == ap_CS_fsm_state4))) begin
        memory_address0 = zext_ln173_fu_792_p1;
    end else if (((op_code_reg_1123 == 7'd3) & (1'b1 == ap_CS_fsm_state4))) begin
        memory_address0 = zext_ln122_fu_765_p1;
    end else if ((1'b1 == ap_CS_fsm_state1)) begin
        memory_address0 = zext_ln29_fu_409_p1;
    end else begin
        memory_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state6) | ((op_code_reg_1123 == 7'd35) & (1'b1 == ap_CS_fsm_state4)) | ((op_code_reg_1123 == 7'd3) & (1'b1 == ap_CS_fsm_state4)) | ((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b1)))) begin
        memory_ce0 = 1'b1;
    end else begin
        memory_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((op_code_reg_1123 == 7'd35) & (1'b1 == ap_CS_fsm_state6))) begin
        memory_we0 = 1'b1;
    end else begin
        memory_we0 = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if (((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b1))) begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end
        end
        ap_ST_fsm_state2 : begin
            ap_NS_fsm = ap_ST_fsm_state3;
        end
        ap_ST_fsm_state3 : begin
            ap_NS_fsm = ap_ST_fsm_state4;
        end
        ap_ST_fsm_state4 : begin
            ap_NS_fsm = ap_ST_fsm_state5;
        end
        ap_ST_fsm_state5 : begin
            ap_NS_fsm = ap_ST_fsm_state6;
        end
        ap_ST_fsm_state6 : begin
            ap_NS_fsm = ap_ST_fsm_state1;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign add_ln120_fu_749_p2 = (trunc_ln120_1_fu_746_p1 + trunc_ln120_fu_743_p1);

assign add_ln171_fu_776_p2 = (trunc_ln171_1_fu_773_p1 + trunc_ln171_fu_770_p1);

assign add_ln378_fu_803_p2 = (empty_17_reg_230 + imm_8_reg_1190);

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state3 = ap_CS_fsm[32'd2];

assign ap_CS_fsm_state4 = ap_CS_fsm[32'd3];

assign ap_CS_fsm_state5 = ap_CS_fsm[32'd4];

assign ap_CS_fsm_state6 = ap_CS_fsm[32'd5];

always @ (*) begin
    ap_condition_159 = (~(op_code_reg_1123 == 7'd35) & ~(op_code_reg_1123 == 7'd3) & ~(op_code_reg_1123 == 7'd103) & ~(op_code_reg_1123 == 7'd111) & ~(op_code_reg_1123 == 7'd99));
end

always @ (*) begin
    ap_condition_208 = ((funct3_reg_1134 == 3'd5) & (op_code_reg_1123 == 7'd3) & (offset_1_fu_814_p2 == 2'd2));
end

always @ (*) begin
    ap_condition_214 = ((funct3_reg_1134 == 3'd5) & (op_code_reg_1123 == 7'd3) & (offset_1_fu_814_p2 == 2'd0));
end

always @ (*) begin
    ap_condition_223 = ((funct3_reg_1134 == 3'd1) & (op_code_reg_1123 == 7'd3) & (offset_1_fu_814_p2 == 2'd2));
end

always @ (*) begin
    ap_condition_227 = ((funct3_reg_1134 == 3'd1) & (op_code_reg_1123 == 7'd3) & (offset_1_fu_814_p2 == 2'd0));
end

assign ap_return = g_error;

assign g_xreg_d1 = (pc_reg_1102 + 32'd4);

assign grp_fu_328_p2 = (pc_reg_1102 + 32'd4);

assign grp_fu_335_p2 = ((source1_reg_1165 < result_18_reg_1178) ? 1'b1 : 1'b0);

assign grp_fu_339_p2 = (($signed(source1_reg_1165) < $signed(result_18_reg_1178)) ? 1'b1 : 1'b0);

assign grp_fu_343_p2 = ((source1_reg_1165 == result_18_reg_1178) ? 1'b1 : 1'b0);

assign grp_fu_347_p4 = {{memory_q0[31:16]}};

assign grp_fu_357_p2 = ((offset_1_fu_814_p2 == 2'd0) ? 1'b1 : 1'b0);

assign grp_fu_362_p2 = ((offset_1_fu_814_p2 == 2'd1) ? 1'b1 : 1'b0);

assign grp_fu_367_p2 = ((offset_1_fu_814_p2 == 2'd2) ? 1'b1 : 1'b0);

assign icmp_ln26_fu_387_p2 = ((trunc_ln25_fu_383_p1 == 2'd0) ? 1'b1 : 1'b0);

assign icmp_ln46_1_fu_620_p2 = ((op_code_fu_414_p1 == 7'd35) ? 1'b1 : 1'b0);

assign icmp_ln46_2_fu_669_p2 = ((op_code_reg_1123 == 7'd55) ? 1'b1 : 1'b0);

assign icmp_ln46_3_fu_674_p2 = ((op_code_reg_1123 == 7'd23) ? 1'b1 : 1'b0);

assign icmp_ln46_4_fu_693_p2 = ((op_code_reg_1123 == 7'd3) ? 1'b1 : 1'b0);

assign icmp_ln46_5_fu_698_p2 = ((op_code_reg_1123 == 7'd19) ? 1'b1 : 1'b0);

assign icmp_ln46_6_fu_703_p2 = ((op_code_reg_1123 == 7'd103) ? 1'b1 : 1'b0);

assign icmp_ln46_7_fu_708_p2 = ((op_code_reg_1123 == 7'd115) ? 1'b1 : 1'b0);

assign icmp_ln46_fu_606_p2 = ((op_code_fu_414_p1 == 7'd99) ? 1'b1 : 1'b0);

assign imm_1_fu_498_p3 = {{tmp_1_fu_488_p4}, {tmp_s_fu_478_p4}};

assign imm_2_fu_546_p6 = {{{{{tmp_5_fu_538_p3}, {tmp_4_fu_530_p3}}, {tmp_3_fu_520_p4}}, {tmp_2_fu_510_p4}}, {1'd0}};

assign imm_3_fu_658_p3 = {{tmp_fu_648_p4}, {12'd0}};

assign imm_4_fu_592_p6 = {{{{{tmp_5_fu_538_p3}, {tmp_8_fu_582_p4}}, {tmp_7_fu_574_p3}}, {tmp_6_fu_564_p4}}, {1'd0}};

assign imm_5_fu_612_p3 = ((icmp_ln46_fu_606_p2[0:0] == 1'b1) ? sext_ln392_1_fu_560_p1 : imm_4_fu_592_p6);

assign imm_6_fu_626_p3 = ((icmp_ln46_1_fu_620_p2[0:0] == 1'b1) ? sext_ln392_fu_506_p1 : imm_5_fu_612_p3);

assign imm_7_fu_685_p3 = ((or_ln46_fu_679_p2[0:0] == 1'b1) ? imm_3_fu_658_p3 : sext_ln392_2_fu_666_p1);

assign imm_8_fu_731_p3 = ((or_ln46_3_fu_725_p2[0:0] == 1'b1) ? sext_ln52_fu_644_p1 : imm_7_fu_685_p3);

assign imm_fu_634_p4 = {{reg_372[31:20]}};

assign lshr_ln_fu_399_p4 = {{g_pc[18:2]}};

assign mem_pos_fu_755_p4 = {{add_ln120_fu_749_p2[18:2]}};

assign memory_d0 = p_0_0_03053_reg_250;

assign offset_1_fu_814_p2 = (trunc_ln120_3_fu_811_p1 + trunc_ln120_2_fu_808_p1);

assign offset_fu_995_p2 = (trunc_ln171_3_fu_992_p1 + trunc_ln171_2_fu_989_p1);

assign op_code_fu_414_p1 = memory_q0[6:0];

assign or_ln125_fu_957_p2 = (grp_fu_367_p2 | grp_fu_362_p2);

assign or_ln146_fu_877_p2 = (grp_fu_367_p2 | grp_fu_362_p2);

assign or_ln46_1_fu_713_p2 = (icmp_ln46_5_fu_698_p2 | icmp_ln46_4_fu_693_p2);

assign or_ln46_2_fu_719_p2 = (icmp_ln46_7_fu_708_p2 | icmp_ln46_6_fu_703_p2);

assign or_ln46_3_fu_725_p2 = (or_ln46_2_fu_719_p2 | or_ln46_1_fu_713_p2);

assign or_ln46_fu_679_p2 = (icmp_ln46_3_fu_674_p2 | icmp_ln46_2_fu_669_p2);

assign result_10_fu_1046_p5 = {{memory_q0[31:16]}, {trunc_ln177_fu_1031_p1}, {memory_q0[7:0]}};

assign result_11_fu_1034_p5 = {{memory_q0[31:24]}, {trunc_ln177_fu_1031_p1}, {memory_q0[15:0]}};

assign result_12_fu_1019_p5 = {{memory_q0[31:16]}, {trunc_ln188_fu_1016_p1}};

assign result_13_fu_1004_p5 = {{trunc_ln190_fu_1001_p1}, {memory_q0[15:0]}};

assign result_14_fu_907_p1 = memory_q0[15:0];

assign result_16_fu_827_p1 = memory_q0[15:0];

assign result_5_fu_971_p3 = ((or_ln125_fu_957_p2[0:0] == 1'b1) ? select_ln125_fu_949_p3 : select_ln125_1_fu_963_p3);

assign result_6_fu_891_p3 = ((or_ln146_fu_877_p2[0:0] == 1'b1) ? select_ln146_fu_869_p3 : select_ln146_1_fu_883_p3);

assign result_8_fu_1070_p5 = {{trunc_ln177_fu_1031_p1}, {memory_q0[23:0]}};

assign result_9_fu_1058_p5 = {{memory_q0[31:8]}, {trunc_ln177_fu_1031_p1}};

assign rs1_fu_448_p4 = {{memory_q0[19:15]}};

assign rs2_fu_458_p4 = {{memory_q0[24:20]}};

assign select_ln125_1_fu_963_p3 = ((grp_fu_357_p2[0:0] == 1'b1) ? trunc_ln126_fu_925_p1 : tmp_9_fu_915_p4);

assign select_ln125_fu_949_p3 = ((grp_fu_367_p2[0:0] == 1'b1) ? tmp_11_fu_939_p4 : tmp_10_fu_929_p4);

assign select_ln146_1_fu_883_p3 = ((grp_fu_357_p2[0:0] == 1'b1) ? trunc_ln147_fu_845_p1 : tmp_12_fu_835_p4);

assign select_ln146_fu_869_p3 = ((grp_fu_367_p2[0:0] == 1'b1) ? tmp_14_fu_859_p4 : tmp_13_fu_849_p4);

assign sext_ln130_fu_979_p1 = $signed(result_5_fu_971_p3);

assign sext_ln137_fu_911_p1 = $signed(result_14_fu_907_p1);

assign sext_ln139_fu_903_p1 = $signed(grp_fu_347_p4);

assign sext_ln392_1_fu_560_p1 = $signed(imm_2_fu_546_p6);

assign sext_ln392_2_fu_666_p1 = $signed(imm_6_reg_1160);

assign sext_ln392_fu_506_p1 = $signed(imm_1_fu_498_p3);

assign sext_ln52_fu_644_p1 = $signed(imm_fu_634_p4);

assign tmp_10_fu_929_p4 = {{memory_q0[15:8]}};

assign tmp_11_fu_939_p4 = {{memory_q0[23:16]}};

assign tmp_12_fu_835_p4 = {{memory_q0[31:24]}};

assign tmp_13_fu_849_p4 = {{memory_q0[15:8]}};

assign tmp_14_fu_859_p4 = {{memory_q0[23:16]}};

assign tmp_1_fu_488_p4 = {{memory_q0[31:25]}};

assign tmp_2_fu_510_p4 = {{memory_q0[11:8]}};

assign tmp_3_fu_520_p4 = {{memory_q0[30:25]}};

assign tmp_4_fu_530_p3 = memory_q0[32'd7];

assign tmp_5_fu_538_p3 = memory_q0[32'd31];

assign tmp_6_fu_564_p4 = {{memory_q0[30:21]}};

assign tmp_7_fu_574_p3 = memory_q0[32'd20];

assign tmp_8_fu_582_p4 = {{memory_q0[19:12]}};

assign tmp_9_fu_915_p4 = {{memory_q0[31:24]}};

assign tmp_fu_648_p4 = {{reg_372[31:12]}};

assign tmp_s_fu_478_p4 = {{memory_q0[11:7]}};

assign trunc_ln120_1_fu_746_p1 = imm_8_reg_1190[18:0];

assign trunc_ln120_2_fu_808_p1 = source1_reg_1165[1:0];

assign trunc_ln120_3_fu_811_p1 = imm_8_reg_1190[1:0];

assign trunc_ln120_fu_743_p1 = source1_reg_1165[18:0];

assign trunc_ln126_fu_925_p1 = memory_q0[7:0];

assign trunc_ln147_fu_845_p1 = memory_q0[7:0];

assign trunc_ln171_1_fu_773_p1 = imm_8_reg_1190[18:0];

assign trunc_ln171_2_fu_989_p1 = source1_reg_1165[1:0];

assign trunc_ln171_3_fu_992_p1 = imm_8_reg_1190[1:0];

assign trunc_ln171_fu_770_p1 = source1_reg_1165[18:0];

assign trunc_ln177_fu_1031_p1 = result_18_reg_1178[7:0];

assign trunc_ln188_fu_1016_p1 = result_18_reg_1178[15:0];

assign trunc_ln190_fu_1001_p1 = result_18_reg_1178[15:0];

assign trunc_ln25_fu_383_p1 = g_pc[1:0];

assign write_addr_fu_782_p4 = {{add_ln171_fu_776_p2[18:2]}};

assign zext_ln122_fu_765_p1 = mem_pos_fu_755_p4;

assign zext_ln151_fu_899_p1 = result_6_fu_891_p3;

assign zext_ln158_fu_831_p1 = result_16_fu_827_p1;

assign zext_ln160_fu_823_p1 = grp_fu_347_p4;

assign zext_ln173_fu_792_p1 = write_addr_fu_782_p4;

assign zext_ln29_fu_409_p1 = lshr_ln_fu_399_p4;

assign zext_ln372_1_fu_1088_p1 = rd_reg_1144;

assign zext_ln372_fu_739_p1 = rd_reg_1144;

assign zext_ln42_fu_468_p1 = rs1_fu_448_p4;

assign zext_ln43_fu_473_p1 = rs2_fu_458_p4;

endmodule //processor_do_process
