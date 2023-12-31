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

parameter    ap_ST_fsm_state1 = 4'd1;
parameter    ap_ST_fsm_state2 = 4'd2;
parameter    ap_ST_fsm_state3 = 4'd4;
parameter    ap_ST_fsm_state4 = 4'd8;

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

(* fsm_encoding = "none" *) reg   [3:0] ap_CS_fsm;
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
reg   [31:0] pc_reg_1127;
wire   [6:0] op_code_fu_417_p1;
reg   [6:0] op_code_reg_1148;
wire    ap_CS_fsm_state2;
reg   [2:0] funct3_reg_1153;
reg   [6:0] funct7_reg_1158;
reg   [4:0] rd_reg_1163;
wire   [31:0] imm_8_fu_741_p3;
reg   [31:0] imm_8_reg_1179;
reg   [31:0] source1_reg_1189;
wire    ap_CS_fsm_state3;
reg   [31:0] result_18_reg_1196;
wire   [0:0] grp_fu_332_p2;
reg   [0:0] branch_5_reg_1204;
reg   [0:0] branch_4_reg_1208;
wire   [0:0] grp_fu_338_p2;
reg   [0:0] branch_3_reg_1212;
reg   [0:0] branch_2_reg_1216;
wire   [0:0] grp_fu_344_p2;
reg   [0:0] branch_1_reg_1220;
reg   [0:0] branch_reg_1224;
reg   [16:0] memory_addr_1_reg_1233;
wire   [31:0] result_execute_arithm_fu_317_ap_return;
wire    result_execute_arithm_fu_317_ap_ready;
wire   [0:0] result_execute_arithm_fu_317_g_error;
wire    result_execute_arithm_fu_317_g_error_ap_vld;
reg   [31:0] empty_reg_220;
reg   [31:0] ap_phi_mux_empty_17_phi_fu_232_p14;
reg   [31:0] empty_17_reg_229;
wire    ap_CS_fsm_state4;
reg   [31:0] ap_phi_mux_p_0_0_03053_phi_fu_252_p18;
wire   [31:0] result_8_fu_1100_p5;
wire   [1:0] offset_fu_1020_p2;
wire   [31:0] result_12_fu_1045_p5;
wire   [31:0] result_13_fu_1029_p5;
wire   [31:0] result_9_fu_1087_p5;
wire   [31:0] result_10_fu_1074_p5;
wire   [31:0] result_11_fu_1061_p5;
reg   [31:0] ap_phi_mux_result_4_phi_fu_279_p22;
reg   [31:0] result_4_reg_275;
wire   [31:0] zext_ln151_fu_926_p1;
wire  signed [31:0] sext_ln130_fu_1009_p1;
wire  signed [31:0] sext_ln137_fu_940_p1;
wire   [1:0] offset_1_fu_839_p2;
wire  signed [31:0] sext_ln139_fu_931_p1;
wire   [31:0] zext_ln158_fu_857_p1;
wire   [31:0] zext_ln160_fu_848_p1;
wire   [31:0] grp_fu_350_p2;
reg   [31:0] ap_phi_mux_storemerge_phi_fu_311_p4;
wire   [31:0] add_ln378_fu_827_p2;
wire   [63:0] zext_ln29_fu_412_p1;
wire   [63:0] zext_ln42_fu_471_p1;
wire   [63:0] zext_ln43_fu_476_p1;
wire   [63:0] zext_ln372_fu_755_p1;
wire   [63:0] zext_ln122_fu_782_p1;
wire   [63:0] zext_ln173_fu_816_p1;
wire   [63:0] zext_ln372_1_fu_1113_p1;
wire   [0:0] icmp_ln26_fu_390_p2;
wire   [1:0] trunc_ln25_fu_386_p1;
wire   [16:0] lshr_ln_fu_402_p4;
wire   [4:0] rs1_fu_451_p4;
wire   [4:0] rs2_fu_461_p4;
wire   [11:0] imm_fu_481_p4;
wire   [6:0] tmp_1_fu_505_p4;
wire   [4:0] tmp_s_fu_495_p4;
wire   [11:0] imm_1_fu_515_p3;
wire   [0:0] tmp_5_fu_555_p3;
wire   [0:0] tmp_4_fu_547_p3;
wire   [5:0] tmp_3_fu_537_p4;
wire   [3:0] tmp_2_fu_527_p4;
wire   [12:0] imm_2_fu_563_p6;
wire   [19:0] tmp_fu_581_p4;
wire   [7:0] tmp_8_fu_617_p4;
wire   [0:0] tmp_7_fu_609_p3;
wire   [9:0] tmp_6_fu_599_p4;
wire   [0:0] icmp_ln46_fu_641_p2;
wire  signed [20:0] sext_ln392_1_fu_577_p1;
wire   [20:0] imm_4_fu_627_p6;
wire   [0:0] icmp_ln46_1_fu_655_p2;
wire  signed [20:0] sext_ln392_fu_523_p1;
wire   [20:0] imm_5_fu_647_p3;
wire   [20:0] imm_6_fu_661_p3;
wire   [0:0] icmp_ln46_2_fu_673_p2;
wire   [0:0] icmp_ln46_3_fu_679_p2;
wire   [0:0] or_ln46_fu_685_p2;
wire   [31:0] imm_3_fu_591_p3;
wire  signed [31:0] sext_ln392_2_fu_669_p1;
wire   [0:0] icmp_ln46_4_fu_699_p2;
wire   [0:0] icmp_ln46_5_fu_705_p2;
wire   [0:0] icmp_ln46_6_fu_711_p2;
wire   [0:0] icmp_ln46_7_fu_717_p2;
wire   [0:0] or_ln46_2_fu_729_p2;
wire   [0:0] or_ln46_1_fu_723_p2;
wire   [0:0] or_ln46_3_fu_735_p2;
wire  signed [31:0] sext_ln52_fu_491_p1;
wire   [31:0] imm_7_fu_691_p3;
wire   [18:0] trunc_ln120_1_fu_763_p1;
wire   [18:0] trunc_ln120_fu_759_p1;
wire   [18:0] add_ln120_fu_766_p2;
wire   [16:0] mem_pos_fu_772_p4;
wire   [18:0] trunc_ln171_1_fu_797_p1;
wire   [18:0] trunc_ln171_fu_793_p1;
wire   [18:0] add_ln171_fu_800_p2;
wire   [16:0] write_addr_fu_806_p4;
wire   [1:0] trunc_ln120_3_fu_836_p1;
wire   [1:0] trunc_ln120_2_fu_833_p1;
wire   [15:0] grp_fu_357_p4;
wire   [15:0] result_16_fu_853_p1;
wire   [0:0] grp_fu_377_p2;
wire   [7:0] tmp_14_fu_886_p4;
wire   [7:0] tmp_13_fu_876_p4;
wire   [0:0] grp_fu_372_p2;
wire   [0:0] grp_fu_367_p2;
wire   [7:0] trunc_ln147_fu_872_p1;
wire   [7:0] tmp_12_fu_862_p4;
wire   [0:0] or_ln146_fu_904_p2;
wire   [7:0] select_ln146_fu_896_p3;
wire   [7:0] select_ln146_1_fu_910_p3;
wire   [7:0] result_6_fu_918_p3;
wire   [15:0] result_14_fu_936_p1;
wire   [7:0] tmp_11_fu_969_p4;
wire   [7:0] tmp_10_fu_959_p4;
wire   [7:0] trunc_ln126_fu_955_p1;
wire   [7:0] tmp_9_fu_945_p4;
wire   [0:0] or_ln125_fu_987_p2;
wire   [7:0] select_ln125_fu_979_p3;
wire   [7:0] select_ln125_1_fu_993_p3;
wire   [7:0] result_5_fu_1001_p3;
wire   [1:0] trunc_ln171_3_fu_1017_p1;
wire   [1:0] trunc_ln171_2_fu_1014_p1;
wire   [15:0] trunc_ln190_fu_1026_p1;
wire   [15:0] trunc_ln188_fu_1042_p1;
wire   [7:0] trunc_ln177_fu_1058_p1;
reg   [3:0] ap_NS_fsm;
reg    ap_ST_fsm_state1_blk;
wire    ap_ST_fsm_state2_blk;
wire    ap_ST_fsm_state3_blk;
wire    ap_ST_fsm_state4_blk;
reg    ap_condition_303;
reg    ap_condition_327;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_CS_fsm = 4'd1;
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

processor_execute_arithm result_execute_arithm_fu_317(
    .ap_ready(result_execute_arithm_fu_317_ap_ready),
    .op_code_val(op_code_reg_1148),
    .funct3_val(funct3_reg_1153),
    .funct7_val(funct7_reg_1158),
    .source1_val(g_xreg_q1),
    .source2_val(g_xreg_q0),
    .imm_val(imm_8_reg_1179),
    .pc_val(pc_reg_1127),
    .g_error(result_execute_arithm_fu_317_g_error),
    .g_error_ap_vld(result_execute_arithm_fu_317_g_error_ap_vld),
    .ap_return(result_execute_arithm_fu_317_ap_return)
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
        if ((1'b1 == ap_CS_fsm_state4)) begin
            g_pc <= ap_phi_mux_storemerge_phi_fu_311_p4;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_state4) & ((op_code_reg_1148 == 7'd103) | (op_code_reg_1148 == 7'd111)))) begin
        empty_17_reg_229 <= empty_reg_220;
    end else if ((((grp_fu_332_p2 == 1'd0) & (funct3_reg_1153 == 3'd7) & (op_code_reg_1148 == 7'd99) & (1'b1 == ap_CS_fsm_state3)) | ((grp_fu_332_p2 == 1'd1) & (funct3_reg_1153 == 3'd6) & (op_code_reg_1148 == 7'd99) & (1'b1 == ap_CS_fsm_state3)) | ((grp_fu_338_p2 == 1'd0) & (funct3_reg_1153 == 3'd5) & (op_code_reg_1148 == 7'd99) & (1'b1 == ap_CS_fsm_state3)) | ((grp_fu_338_p2 == 1'd1) & (funct3_reg_1153 == 3'd4) & (op_code_reg_1148 == 7'd99) & (1'b1 == ap_CS_fsm_state3)) | ((funct3_reg_1153 == 3'd0) & (op_code_reg_1148 == 7'd99) & (1'b1 == ap_CS_fsm_state3) & (grp_fu_344_p2 == 1'd1)) | ((funct3_reg_1153 == 3'd1) & (op_code_reg_1148 == 7'd99) & (1'b1 == ap_CS_fsm_state3) & (grp_fu_344_p2 == 1'd0)))) begin
        empty_17_reg_229 <= pc_reg_1127;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state3)) begin
        if ((op_code_reg_1148 == 7'd111)) begin
            empty_reg_220 <= pc_reg_1127;
        end else if ((op_code_reg_1148 == 7'd103)) begin
            empty_reg_220 <= g_xreg_q1;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((((1'b1 == ap_CS_fsm_state3) & (((funct3_reg_1153 == 3'd3) & (op_code_reg_1148 == 7'd99)) | ((funct3_reg_1153 == 3'd2) & (op_code_reg_1148 == 7'd99)))) | ((ap_start == 1'b1) & (icmp_ln26_fu_390_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state1)) | (~(funct3_reg_1153 == 3'd5) & ~(funct3_reg_1153 == 3'd2) & ~(funct3_reg_1153 == 3'd0) & ~(funct3_reg_1153 == 3'd1) & ~(funct3_reg_1153 == 3'd4) & (op_code_reg_1148 == 7'd3) & (1'b1 == ap_CS_fsm_state3)) | (~(funct3_reg_1153 == 3'd2) & ~(funct3_reg_1153 == 3'd0) & ~(funct3_reg_1153 == 3'd1) & (op_code_reg_1148 == 7'd35) & (1'b1 == ap_CS_fsm_state3)))) begin
        g_error <= 1'd1;
    end else if ((~(op_code_reg_1148 == 7'd99) & ~(op_code_reg_1148 == 7'd103) & ~(op_code_reg_1148 == 7'd111) & ~(op_code_reg_1148 == 7'd35) & ~(op_code_reg_1148 == 7'd3) & (1'b1 == ap_CS_fsm_state3) & (result_execute_arithm_fu_317_g_error_ap_vld == 1'b1))) begin
        g_error <= result_execute_arithm_fu_317_g_error;
    end
end

always @ (posedge ap_clk) begin
    if (((funct3_reg_1153 == 3'd5) & (op_code_reg_1148 == 7'd3) & (offset_1_fu_839_p2 == 2'd2) & (1'b1 == ap_CS_fsm_state4))) begin
        result_4_reg_275 <= zext_ln160_fu_848_p1;
    end else if (((funct3_reg_1153 == 3'd5) & (op_code_reg_1148 == 7'd3) & (offset_1_fu_839_p2 == 2'd0) & (1'b1 == ap_CS_fsm_state4))) begin
        result_4_reg_275 <= zext_ln158_fu_857_p1;
    end else if (((funct3_reg_1153 == 3'd1) & (op_code_reg_1148 == 7'd3) & (offset_1_fu_839_p2 == 2'd2) & (1'b1 == ap_CS_fsm_state4))) begin
        result_4_reg_275 <= sext_ln139_fu_931_p1;
    end else if (((funct3_reg_1153 == 3'd1) & (op_code_reg_1148 == 7'd3) & (offset_1_fu_839_p2 == 2'd0) & (1'b1 == ap_CS_fsm_state4))) begin
        result_4_reg_275 <= sext_ln137_fu_940_p1;
    end else if (((funct3_reg_1153 == 3'd2) & (op_code_reg_1148 == 7'd3) & (1'b1 == ap_CS_fsm_state4))) begin
        result_4_reg_275 <= memory_q0;
    end else if (((funct3_reg_1153 == 3'd0) & (op_code_reg_1148 == 7'd3) & (1'b1 == ap_CS_fsm_state4))) begin
        result_4_reg_275 <= sext_ln130_fu_1009_p1;
    end else if (((funct3_reg_1153 == 3'd4) & (op_code_reg_1148 == 7'd3) & (1'b1 == ap_CS_fsm_state4))) begin
        result_4_reg_275 <= zext_ln151_fu_926_p1;
    end else if ((~(op_code_reg_1148 == 7'd99) & ~(op_code_reg_1148 == 7'd103) & ~(op_code_reg_1148 == 7'd111) & ~(op_code_reg_1148 == 7'd35) & ~(op_code_reg_1148 == 7'd3) & (1'b1 == ap_CS_fsm_state3))) begin
        result_4_reg_275 <= result_execute_arithm_fu_317_ap_return;
    end
end

always @ (posedge ap_clk) begin
    if (((funct3_reg_1153 == 3'd1) & (op_code_reg_1148 == 7'd99) & (1'b1 == ap_CS_fsm_state3))) begin
        branch_1_reg_1220 <= grp_fu_344_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((funct3_reg_1153 == 3'd4) & (op_code_reg_1148 == 7'd99) & (1'b1 == ap_CS_fsm_state3))) begin
        branch_2_reg_1216 <= grp_fu_338_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((funct3_reg_1153 == 3'd5) & (op_code_reg_1148 == 7'd99) & (1'b1 == ap_CS_fsm_state3))) begin
        branch_3_reg_1212 <= grp_fu_338_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((funct3_reg_1153 == 3'd6) & (op_code_reg_1148 == 7'd99) & (1'b1 == ap_CS_fsm_state3))) begin
        branch_4_reg_1208 <= grp_fu_332_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((funct3_reg_1153 == 3'd7) & (op_code_reg_1148 == 7'd99) & (1'b1 == ap_CS_fsm_state3))) begin
        branch_5_reg_1204 <= grp_fu_332_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((funct3_reg_1153 == 3'd0) & (op_code_reg_1148 == 7'd99) & (1'b1 == ap_CS_fsm_state3))) begin
        branch_reg_1224 <= grp_fu_344_p2;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state2)) begin
        funct3_reg_1153 <= {{memory_q0[14:12]}};
        funct7_reg_1158 <= {{memory_q0[31:25]}};
        imm_8_reg_1179 <= imm_8_fu_741_p3;
        op_code_reg_1148 <= op_code_fu_417_p1;
        rd_reg_1163 <= {{memory_q0[11:7]}};
    end
end

always @ (posedge ap_clk) begin
    if (((op_code_reg_1148 == 7'd35) & (1'b1 == ap_CS_fsm_state3))) begin
        memory_addr_1_reg_1233 <= zext_ln173_fu_816_p1;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state1)) begin
        pc_reg_1127 <= g_pc;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state3)) begin
        result_18_reg_1196 <= g_xreg_q0;
        source1_reg_1189 <= g_xreg_q1;
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

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | ((ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1)))) begin
        ap_done = 1'b1;
    end else begin
        ap_done = 1'b0;
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) & ((op_code_reg_1148 == 7'd103) | (op_code_reg_1148 == 7'd111)))) begin
        ap_phi_mux_empty_17_phi_fu_232_p14 = empty_reg_220;
    end else begin
        ap_phi_mux_empty_17_phi_fu_232_p14 = empty_17_reg_229;
    end
end

always @ (*) begin
    if (((funct3_reg_1153 == 3'd0) & (op_code_reg_1148 == 7'd35) & (offset_fu_1020_p2 == 2'd2) & (1'b1 == ap_CS_fsm_state4))) begin
        ap_phi_mux_p_0_0_03053_phi_fu_252_p18 = result_11_fu_1061_p5;
    end else if (((funct3_reg_1153 == 3'd0) & (op_code_reg_1148 == 7'd35) & (offset_fu_1020_p2 == 2'd1) & (1'b1 == ap_CS_fsm_state4))) begin
        ap_phi_mux_p_0_0_03053_phi_fu_252_p18 = result_10_fu_1074_p5;
    end else if (((funct3_reg_1153 == 3'd0) & (op_code_reg_1148 == 7'd35) & (offset_fu_1020_p2 == 2'd0) & (1'b1 == ap_CS_fsm_state4))) begin
        ap_phi_mux_p_0_0_03053_phi_fu_252_p18 = result_9_fu_1087_p5;
    end else if (((funct3_reg_1153 == 3'd1) & (op_code_reg_1148 == 7'd35) & (offset_fu_1020_p2 == 2'd2) & (1'b1 == ap_CS_fsm_state4))) begin
        ap_phi_mux_p_0_0_03053_phi_fu_252_p18 = result_13_fu_1029_p5;
    end else if (((funct3_reg_1153 == 3'd1) & (op_code_reg_1148 == 7'd35) & (offset_fu_1020_p2 == 2'd0) & (1'b1 == ap_CS_fsm_state4))) begin
        ap_phi_mux_p_0_0_03053_phi_fu_252_p18 = result_12_fu_1045_p5;
    end else if (((funct3_reg_1153 == 3'd2) & (op_code_reg_1148 == 7'd35) & (1'b1 == ap_CS_fsm_state4))) begin
        ap_phi_mux_p_0_0_03053_phi_fu_252_p18 = result_18_reg_1196;
    end else if (((funct3_reg_1153 == 3'd0) & (op_code_reg_1148 == 7'd35) & (offset_fu_1020_p2 == 2'd3) & (1'b1 == ap_CS_fsm_state4))) begin
        ap_phi_mux_p_0_0_03053_phi_fu_252_p18 = result_8_fu_1100_p5;
    end else if (((~(offset_fu_1020_p2 == 2'd2) & ~(offset_fu_1020_p2 == 2'd0) & (funct3_reg_1153 == 3'd1) & (op_code_reg_1148 == 7'd35) & (1'b1 == ap_CS_fsm_state4)) | (~(funct3_reg_1153 == 3'd2) & ~(funct3_reg_1153 == 3'd0) & ~(funct3_reg_1153 == 3'd1) & (op_code_reg_1148 == 7'd35) & (1'b1 == ap_CS_fsm_state4)))) begin
        ap_phi_mux_p_0_0_03053_phi_fu_252_p18 = memory_q0;
    end else begin
        ap_phi_mux_p_0_0_03053_phi_fu_252_p18 = 'bx;
    end
end

always @ (*) begin
    if (((op_code_reg_1148 == 7'd3) & (1'b1 == ap_CS_fsm_state4))) begin
        if (((funct3_reg_1153 == 3'd5) & (offset_1_fu_839_p2 == 2'd2))) begin
            ap_phi_mux_result_4_phi_fu_279_p22 = zext_ln160_fu_848_p1;
        end else if (((funct3_reg_1153 == 3'd5) & (offset_1_fu_839_p2 == 2'd0))) begin
            ap_phi_mux_result_4_phi_fu_279_p22 = zext_ln158_fu_857_p1;
        end else if (((funct3_reg_1153 == 3'd1) & (offset_1_fu_839_p2 == 2'd2))) begin
            ap_phi_mux_result_4_phi_fu_279_p22 = sext_ln139_fu_931_p1;
        end else if (((funct3_reg_1153 == 3'd1) & (offset_1_fu_839_p2 == 2'd0))) begin
            ap_phi_mux_result_4_phi_fu_279_p22 = sext_ln137_fu_940_p1;
        end else if ((funct3_reg_1153 == 3'd2)) begin
            ap_phi_mux_result_4_phi_fu_279_p22 = memory_q0;
        end else if ((funct3_reg_1153 == 3'd0)) begin
            ap_phi_mux_result_4_phi_fu_279_p22 = sext_ln130_fu_1009_p1;
        end else if ((funct3_reg_1153 == 3'd4)) begin
            ap_phi_mux_result_4_phi_fu_279_p22 = zext_ln151_fu_926_p1;
        end else begin
            ap_phi_mux_result_4_phi_fu_279_p22 = result_4_reg_275;
        end
    end else begin
        ap_phi_mux_result_4_phi_fu_279_p22 = result_4_reg_275;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state4)) begin
        if ((1'b1 == ap_condition_327)) begin
            ap_phi_mux_storemerge_phi_fu_311_p4 = add_ln378_fu_827_p2;
        end else if ((1'b1 == ap_condition_303)) begin
            ap_phi_mux_storemerge_phi_fu_311_p4 = grp_fu_350_p2;
        end else begin
            ap_phi_mux_storemerge_phi_fu_311_p4 = 'bx;
        end
    end else begin
        ap_phi_mux_storemerge_phi_fu_311_p4 = 'bx;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state4)) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state4)) begin
        g_xreg_address0 = zext_ln372_1_fu_1113_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        g_xreg_address0 = zext_ln43_fu_476_p1;
    end else if ((1'b1 == ap_CS_fsm_state1)) begin
        g_xreg_address0 = 5'd0;
    end else begin
        g_xreg_address0 = 'bx;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state3)) begin
        g_xreg_address1 = zext_ln372_fu_755_p1;
    end else if ((1'b1 == ap_CS_fsm_state2)) begin
        g_xreg_address1 = zext_ln42_fu_471_p1;
    end else begin
        g_xreg_address1 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state2) | (1'b1 == ap_CS_fsm_state4) | ((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1)))) begin
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
    if ((1'b1 == ap_CS_fsm_state4)) begin
        g_xreg_d0 = ap_phi_mux_result_4_phi_fu_279_p22;
    end else if ((1'b1 == ap_CS_fsm_state1)) begin
        g_xreg_d0 = 32'd0;
    end else begin
        g_xreg_d0 = 'bx;
    end
end

always @ (*) begin
    if ((((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1)) | ((1'b1 == ap_CS_fsm_state4) & ((~(op_code_reg_1148 == 7'd99) & ~(op_code_reg_1148 == 7'd103) & ~(op_code_reg_1148 == 7'd111) & ~(op_code_reg_1148 == 7'd35)) | (~(op_code_reg_1148 == 7'd35) & (op_code_reg_1148 == 7'd3)))))) begin
        g_xreg_we0 = 1'b1;
    end else begin
        g_xreg_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state3) & ((op_code_reg_1148 == 7'd103) | (op_code_reg_1148 == 7'd111)))) begin
        g_xreg_we1 = 1'b1;
    end else begin
        g_xreg_we1 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state4)) begin
        memory_address0 = memory_addr_1_reg_1233;
    end else if (((op_code_reg_1148 == 7'd35) & (1'b1 == ap_CS_fsm_state3))) begin
        memory_address0 = zext_ln173_fu_816_p1;
    end else if (((op_code_reg_1148 == 7'd3) & (1'b1 == ap_CS_fsm_state3))) begin
        memory_address0 = zext_ln122_fu_782_p1;
    end else if ((1'b1 == ap_CS_fsm_state1)) begin
        memory_address0 = zext_ln29_fu_412_p1;
    end else begin
        memory_address0 = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state4) | ((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1)) | ((op_code_reg_1148 == 7'd35) & (1'b1 == ap_CS_fsm_state3)) | ((op_code_reg_1148 == 7'd3) & (1'b1 == ap_CS_fsm_state3)))) begin
        memory_ce0 = 1'b1;
    end else begin
        memory_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((op_code_reg_1148 == 7'd35) & (1'b1 == ap_CS_fsm_state4))) begin
        memory_we0 = 1'b1;
    end else begin
        memory_we0 = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if (((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1))) begin
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
            ap_NS_fsm = ap_ST_fsm_state1;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign add_ln120_fu_766_p2 = (trunc_ln120_1_fu_763_p1 + trunc_ln120_fu_759_p1);

assign add_ln171_fu_800_p2 = (trunc_ln171_1_fu_797_p1 + trunc_ln171_fu_793_p1);

assign add_ln378_fu_827_p2 = (ap_phi_mux_empty_17_phi_fu_232_p14 + imm_8_reg_1179);

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state3 = ap_CS_fsm[32'd2];

assign ap_CS_fsm_state4 = ap_CS_fsm[32'd3];

always @ (*) begin
    ap_condition_303 = ((((((((((funct3_reg_1153 == 3'd3) & (op_code_reg_1148 == 7'd99)) | ((funct3_reg_1153 == 3'd2) & (op_code_reg_1148 == 7'd99))) | ((branch_5_reg_1204 == 1'd1) & (funct3_reg_1153 == 3'd7) & (op_code_reg_1148 == 7'd99))) | ((branch_4_reg_1208 == 1'd0) & (funct3_reg_1153 == 3'd6) & (op_code_reg_1148 == 7'd99))) | ((branch_3_reg_1212 == 1'd1) & (funct3_reg_1153 == 3'd5) & (op_code_reg_1148 == 7'd99))) | ((funct3_reg_1153 == 3'd4) & (op_code_reg_1148 == 7'd99) & (branch_2_reg_1216 == 1'd0))) | (~(funct3_reg_1153 == 3'd5) & ~(funct3_reg_1153 == 3'd6) & ~(funct3_reg_1153 == 3'd7) & ~(funct3_reg_1153 == 3'd1) & ~(funct3_reg_1153 == 3'd4) & (op_code_reg_1148 == 7'd99) & (branch_reg_1224 == 1'd0))) | ((funct3_reg_1153 == 3'd1) & (op_code_reg_1148 == 7'd99) & (branch_1_reg_1220 == 1'd1))) | (~(op_code_reg_1148 == 7'd99) & ~(op_code_reg_1148 == 7'd103) & ~(op_code_reg_1148 == 7'd111)));
end

always @ (*) begin
    ap_condition_327 = ((op_code_reg_1148 == 7'd111) | ((op_code_reg_1148 == 7'd103) | (((((((branch_4_reg_1208 == 1'd1) & (funct3_reg_1153 == 3'd6) & (op_code_reg_1148 == 7'd99)) | ((branch_5_reg_1204 == 1'd0) & (funct3_reg_1153 == 3'd7) & (op_code_reg_1148 == 7'd99))) | ((branch_3_reg_1212 == 1'd0) & (funct3_reg_1153 == 3'd5) & (op_code_reg_1148 == 7'd99))) | ((funct3_reg_1153 == 3'd4) & (op_code_reg_1148 == 7'd99) & (branch_2_reg_1216 == 1'd1))) | (~(funct3_reg_1153 == 3'd5) & ~(funct3_reg_1153 == 3'd6) & ~(funct3_reg_1153 == 3'd7) & ~(funct3_reg_1153 == 3'd3) & ~(funct3_reg_1153 == 3'd2) & ~(funct3_reg_1153 == 3'd1) & ~(funct3_reg_1153 == 3'd4) & (op_code_reg_1148 == 7'd99) & (branch_reg_1224 == 1'd1))) | ((funct3_reg_1153 == 3'd1) & (op_code_reg_1148 == 7'd99) & (branch_1_reg_1220 == 1'd0)))));
end

assign ap_return = g_error;

assign g_xreg_d1 = (pc_reg_1127 + 32'd4);

assign grp_fu_332_p2 = ((g_xreg_q1 < g_xreg_q0) ? 1'b1 : 1'b0);

assign grp_fu_338_p2 = (($signed(g_xreg_q1) < $signed(g_xreg_q0)) ? 1'b1 : 1'b0);

assign grp_fu_344_p2 = ((g_xreg_q1 == g_xreg_q0) ? 1'b1 : 1'b0);

assign grp_fu_350_p2 = (pc_reg_1127 + 32'd4);

assign grp_fu_357_p4 = {{memory_q0[31:16]}};

assign grp_fu_367_p2 = ((offset_1_fu_839_p2 == 2'd0) ? 1'b1 : 1'b0);

assign grp_fu_372_p2 = ((offset_1_fu_839_p2 == 2'd1) ? 1'b1 : 1'b0);

assign grp_fu_377_p2 = ((offset_1_fu_839_p2 == 2'd2) ? 1'b1 : 1'b0);

assign icmp_ln26_fu_390_p2 = ((trunc_ln25_fu_386_p1 == 2'd0) ? 1'b1 : 1'b0);

assign icmp_ln46_1_fu_655_p2 = ((op_code_fu_417_p1 == 7'd35) ? 1'b1 : 1'b0);

assign icmp_ln46_2_fu_673_p2 = ((op_code_fu_417_p1 == 7'd55) ? 1'b1 : 1'b0);

assign icmp_ln46_3_fu_679_p2 = ((op_code_fu_417_p1 == 7'd23) ? 1'b1 : 1'b0);

assign icmp_ln46_4_fu_699_p2 = ((op_code_fu_417_p1 == 7'd3) ? 1'b1 : 1'b0);

assign icmp_ln46_5_fu_705_p2 = ((op_code_fu_417_p1 == 7'd19) ? 1'b1 : 1'b0);

assign icmp_ln46_6_fu_711_p2 = ((op_code_fu_417_p1 == 7'd103) ? 1'b1 : 1'b0);

assign icmp_ln46_7_fu_717_p2 = ((op_code_fu_417_p1 == 7'd115) ? 1'b1 : 1'b0);

assign icmp_ln46_fu_641_p2 = ((op_code_fu_417_p1 == 7'd99) ? 1'b1 : 1'b0);

assign imm_1_fu_515_p3 = {{tmp_1_fu_505_p4}, {tmp_s_fu_495_p4}};

assign imm_2_fu_563_p6 = {{{{{tmp_5_fu_555_p3}, {tmp_4_fu_547_p3}}, {tmp_3_fu_537_p4}}, {tmp_2_fu_527_p4}}, {1'd0}};

assign imm_3_fu_591_p3 = {{tmp_fu_581_p4}, {12'd0}};

assign imm_4_fu_627_p6 = {{{{{tmp_5_fu_555_p3}, {tmp_8_fu_617_p4}}, {tmp_7_fu_609_p3}}, {tmp_6_fu_599_p4}}, {1'd0}};

assign imm_5_fu_647_p3 = ((icmp_ln46_fu_641_p2[0:0] == 1'b1) ? sext_ln392_1_fu_577_p1 : imm_4_fu_627_p6);

assign imm_6_fu_661_p3 = ((icmp_ln46_1_fu_655_p2[0:0] == 1'b1) ? sext_ln392_fu_523_p1 : imm_5_fu_647_p3);

assign imm_7_fu_691_p3 = ((or_ln46_fu_685_p2[0:0] == 1'b1) ? imm_3_fu_591_p3 : sext_ln392_2_fu_669_p1);

assign imm_8_fu_741_p3 = ((or_ln46_3_fu_735_p2[0:0] == 1'b1) ? sext_ln52_fu_491_p1 : imm_7_fu_691_p3);

assign imm_fu_481_p4 = {{memory_q0[31:20]}};

assign lshr_ln_fu_402_p4 = {{g_pc[18:2]}};

assign mem_pos_fu_772_p4 = {{add_ln120_fu_766_p2[18:2]}};

assign memory_d0 = ap_phi_mux_p_0_0_03053_phi_fu_252_p18;

assign offset_1_fu_839_p2 = (trunc_ln120_3_fu_836_p1 + trunc_ln120_2_fu_833_p1);

assign offset_fu_1020_p2 = (trunc_ln171_3_fu_1017_p1 + trunc_ln171_2_fu_1014_p1);

assign op_code_fu_417_p1 = memory_q0[6:0];

assign or_ln125_fu_987_p2 = (grp_fu_377_p2 | grp_fu_372_p2);

assign or_ln146_fu_904_p2 = (grp_fu_377_p2 | grp_fu_372_p2);

assign or_ln46_1_fu_723_p2 = (icmp_ln46_5_fu_705_p2 | icmp_ln46_4_fu_699_p2);

assign or_ln46_2_fu_729_p2 = (icmp_ln46_7_fu_717_p2 | icmp_ln46_6_fu_711_p2);

assign or_ln46_3_fu_735_p2 = (or_ln46_2_fu_729_p2 | or_ln46_1_fu_723_p2);

assign or_ln46_fu_685_p2 = (icmp_ln46_3_fu_679_p2 | icmp_ln46_2_fu_673_p2);

assign result_10_fu_1074_p5 = {{memory_q0[31:16]}, {trunc_ln177_fu_1058_p1}, {memory_q0[7:0]}};

assign result_11_fu_1061_p5 = {{memory_q0[31:24]}, {trunc_ln177_fu_1058_p1}, {memory_q0[15:0]}};

assign result_12_fu_1045_p5 = {{memory_q0[31:16]}, {trunc_ln188_fu_1042_p1}};

assign result_13_fu_1029_p5 = {{trunc_ln190_fu_1026_p1}, {memory_q0[15:0]}};

assign result_14_fu_936_p1 = memory_q0[15:0];

assign result_16_fu_853_p1 = memory_q0[15:0];

assign result_5_fu_1001_p3 = ((or_ln125_fu_987_p2[0:0] == 1'b1) ? select_ln125_fu_979_p3 : select_ln125_1_fu_993_p3);

assign result_6_fu_918_p3 = ((or_ln146_fu_904_p2[0:0] == 1'b1) ? select_ln146_fu_896_p3 : select_ln146_1_fu_910_p3);

assign result_8_fu_1100_p5 = {{trunc_ln177_fu_1058_p1}, {memory_q0[23:0]}};

assign result_9_fu_1087_p5 = {{memory_q0[31:8]}, {trunc_ln177_fu_1058_p1}};

assign rs1_fu_451_p4 = {{memory_q0[19:15]}};

assign rs2_fu_461_p4 = {{memory_q0[24:20]}};

assign select_ln125_1_fu_993_p3 = ((grp_fu_367_p2[0:0] == 1'b1) ? trunc_ln126_fu_955_p1 : tmp_9_fu_945_p4);

assign select_ln125_fu_979_p3 = ((grp_fu_377_p2[0:0] == 1'b1) ? tmp_11_fu_969_p4 : tmp_10_fu_959_p4);

assign select_ln146_1_fu_910_p3 = ((grp_fu_367_p2[0:0] == 1'b1) ? trunc_ln147_fu_872_p1 : tmp_12_fu_862_p4);

assign select_ln146_fu_896_p3 = ((grp_fu_377_p2[0:0] == 1'b1) ? tmp_14_fu_886_p4 : tmp_13_fu_876_p4);

assign sext_ln130_fu_1009_p1 = $signed(result_5_fu_1001_p3);

assign sext_ln137_fu_940_p1 = $signed(result_14_fu_936_p1);

assign sext_ln139_fu_931_p1 = $signed(grp_fu_357_p4);

assign sext_ln392_1_fu_577_p1 = $signed(imm_2_fu_563_p6);

assign sext_ln392_2_fu_669_p1 = $signed(imm_6_fu_661_p3);

assign sext_ln392_fu_523_p1 = $signed(imm_1_fu_515_p3);

assign sext_ln52_fu_491_p1 = $signed(imm_fu_481_p4);

assign tmp_10_fu_959_p4 = {{memory_q0[15:8]}};

assign tmp_11_fu_969_p4 = {{memory_q0[23:16]}};

assign tmp_12_fu_862_p4 = {{memory_q0[31:24]}};

assign tmp_13_fu_876_p4 = {{memory_q0[15:8]}};

assign tmp_14_fu_886_p4 = {{memory_q0[23:16]}};

assign tmp_1_fu_505_p4 = {{memory_q0[31:25]}};

assign tmp_2_fu_527_p4 = {{memory_q0[11:8]}};

assign tmp_3_fu_537_p4 = {{memory_q0[30:25]}};

assign tmp_4_fu_547_p3 = memory_q0[32'd7];

assign tmp_5_fu_555_p3 = memory_q0[32'd31];

assign tmp_6_fu_599_p4 = {{memory_q0[30:21]}};

assign tmp_7_fu_609_p3 = memory_q0[32'd20];

assign tmp_8_fu_617_p4 = {{memory_q0[19:12]}};

assign tmp_9_fu_945_p4 = {{memory_q0[31:24]}};

assign tmp_fu_581_p4 = {{memory_q0[31:12]}};

assign tmp_s_fu_495_p4 = {{memory_q0[11:7]}};

assign trunc_ln120_1_fu_763_p1 = imm_8_reg_1179[18:0];

assign trunc_ln120_2_fu_833_p1 = source1_reg_1189[1:0];

assign trunc_ln120_3_fu_836_p1 = imm_8_reg_1179[1:0];

assign trunc_ln120_fu_759_p1 = g_xreg_q1[18:0];

assign trunc_ln126_fu_955_p1 = memory_q0[7:0];

assign trunc_ln147_fu_872_p1 = memory_q0[7:0];

assign trunc_ln171_1_fu_797_p1 = imm_8_reg_1179[18:0];

assign trunc_ln171_2_fu_1014_p1 = source1_reg_1189[1:0];

assign trunc_ln171_3_fu_1017_p1 = imm_8_reg_1179[1:0];

assign trunc_ln171_fu_793_p1 = g_xreg_q1[18:0];

assign trunc_ln177_fu_1058_p1 = result_18_reg_1196[7:0];

assign trunc_ln188_fu_1042_p1 = result_18_reg_1196[15:0];

assign trunc_ln190_fu_1026_p1 = result_18_reg_1196[15:0];

assign trunc_ln25_fu_386_p1 = g_pc[1:0];

assign write_addr_fu_806_p4 = {{add_ln171_fu_800_p2[18:2]}};

assign zext_ln122_fu_782_p1 = mem_pos_fu_772_p4;

assign zext_ln151_fu_926_p1 = result_6_fu_918_p3;

assign zext_ln158_fu_857_p1 = result_16_fu_853_p1;

assign zext_ln160_fu_848_p1 = grp_fu_357_p4;

assign zext_ln173_fu_816_p1 = write_addr_fu_806_p4;

assign zext_ln29_fu_412_p1 = lshr_ln_fu_402_p4;

assign zext_ln372_1_fu_1113_p1 = rd_reg_1163;

assign zext_ln372_fu_755_p1 = rd_reg_1163;

assign zext_ln42_fu_471_p1 = rs1_fu_451_p4;

assign zext_ln43_fu_476_p1 = rs2_fu_461_p4;

endmodule //processor_do_process
