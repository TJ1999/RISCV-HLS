// ==============================================================
// Generated by Vitis HLS v2023.1.1
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// ==============================================================

`timescale 1 ns / 1 ps 

(* CORE_GENERATION_INFO="processor_processor,hls_ip_2023_1_1,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=0,HLS_INPUT_PART=xc7a100t-csg324-1,HLS_INPUT_CLOCK=10.000000,HLS_INPUT_ARCH=others,HLS_SYN_CLOCK=7.061600,HLS_SYN_LAT=-1,HLS_SYN_TPT=none,HLS_SYN_MEM=0,HLS_SYN_DSP=0,HLS_SYN_FF=1450,HLS_SYN_LUT=3073,HLS_VERSION=2023_1_1}" *)

module processor (
        ap_clk,
        ap_rst,
        instr_memory_address0,
        instr_memory_ce0,
        instr_memory_q0,
        data_memory_address0,
        data_memory_ce0,
        data_memory_we0,
        data_memory_d0,
        data_memory_q0,
        error
);

parameter    ap_ST_fsm_state1 = 4'd1;
parameter    ap_ST_fsm_pp0_stage0 = 4'd2;
parameter    ap_ST_fsm_pp0_stage1 = 4'd4;
parameter    ap_ST_fsm_pp0_stage2 = 4'd8;

input   ap_clk;
input   ap_rst;
output  [15:0] instr_memory_address0;
output   instr_memory_ce0;
input  [31:0] instr_memory_q0;
output  [15:0] data_memory_address0;
output   data_memory_ce0;
output   data_memory_we0;
output  [31:0] data_memory_d0;
input  [31:0] data_memory_q0;
output  [0:0] error;

reg    ap_enable_reg_pp0_iter0;
(* fsm_encoding = "none" *) reg   [3:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
reg    ap_enable_reg_pp0_iter1;
wire    ap_block_state4_pp0_stage2_iter0;
wire    ap_block_state7_pp0_stage2_iter1;
wire    ap_block_pp0_stage2_subdone;
wire    ap_CS_fsm_pp0_stage2;
reg    ap_enable_reg_pp0_iter2;
wire    grp_do_process_fu_117_ap_start;
wire    grp_do_process_fu_117_ap_done;
wire    grp_do_process_fu_117_ap_idle;
wire    grp_do_process_fu_117_ap_ready;
wire   [15:0] grp_do_process_fu_117_instr_memory_address0;
wire    grp_do_process_fu_117_instr_memory_ce0;
wire   [15:0] grp_do_process_fu_117_data_memory_address0;
wire    grp_do_process_fu_117_data_memory_ce0;
wire    grp_do_process_fu_117_data_memory_we0;
wire   [31:0] grp_do_process_fu_117_data_memory_d0;
wire   [0:0] grp_do_process_fu_117_ap_return;
reg    grp_do_process_fu_117_ap_start_reg;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_block_state2_pp0_stage0_iter0;
wire    ap_block_state5_pp0_stage0_iter1;
wire    ap_block_state8_pp0_stage0_iter2;
wire    ap_block_pp0_stage0_11001;
wire    ap_CS_fsm_pp0_stage1;
wire    ap_block_pp0_stage1;
wire    ap_block_pp0_stage2;
wire    ap_block_pp0_stage0;
wire    ap_block_state3_pp0_stage1_iter0;
wire    ap_block_state6_pp0_stage1_iter1;
wire    ap_block_pp0_stage1_11001;
wire    ap_block_pp0_stage0_01001;
reg   [3:0] ap_NS_fsm;
wire    ap_ST_fsm_state1_blk;
wire    ap_block_pp0_stage0_subdone;
wire    ap_block_pp0_stage1_subdone;
wire    ap_block_pp0_stage2_11001;
reg    ap_idle_pp0;
wire    ap_enable_pp0;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_enable_reg_pp0_iter0 = 1'b0;
#0 ap_CS_fsm = 4'd1;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
#0 ap_enable_reg_pp0_iter2 = 1'b0;
#0 grp_do_process_fu_117_ap_start_reg = 1'b0;
end

processor_do_process grp_do_process_fu_117(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(grp_do_process_fu_117_ap_start),
    .ap_done(grp_do_process_fu_117_ap_done),
    .ap_idle(grp_do_process_fu_117_ap_idle),
    .ap_ready(grp_do_process_fu_117_ap_ready),
    .instr_memory_address0(grp_do_process_fu_117_instr_memory_address0),
    .instr_memory_ce0(grp_do_process_fu_117_instr_memory_ce0),
    .instr_memory_q0(instr_memory_q0),
    .data_memory_address0(grp_do_process_fu_117_data_memory_address0),
    .data_memory_ce0(grp_do_process_fu_117_data_memory_ce0),
    .data_memory_we0(grp_do_process_fu_117_data_memory_we0),
    .data_memory_d0(grp_do_process_fu_117_data_memory_d0),
    .data_memory_q0(data_memory_q0),
    .ap_return(grp_do_process_fu_117_ap_return)
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
        ap_enable_reg_pp0_iter0 <= 1'b0;
    end else begin
        if ((1'b1 == ap_CS_fsm_state1)) begin
            ap_enable_reg_pp0_iter0 <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if (((1'b0 == ap_block_pp0_stage2_subdone) & (1'b1 == ap_CS_fsm_pp0_stage2))) begin
            ap_enable_reg_pp0_iter1 <= ap_enable_reg_pp0_iter0;
        end else if ((1'b1 == ap_CS_fsm_state1)) begin
            ap_enable_reg_pp0_iter1 <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter2 <= 1'b0;
    end else begin
        if (((1'b0 == ap_block_pp0_stage2_subdone) & (1'b1 == ap_CS_fsm_pp0_stage2))) begin
            ap_enable_reg_pp0_iter2 <= ap_enable_reg_pp0_iter1;
        end else if ((1'b1 == ap_CS_fsm_state1)) begin
            ap_enable_reg_pp0_iter2 <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        grp_do_process_fu_117_ap_start_reg <= 1'b0;
    end else begin
        if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            grp_do_process_fu_117_ap_start_reg <= 1'b1;
        end else if ((grp_do_process_fu_117_ap_ready == 1'b1)) begin
            grp_do_process_fu_117_ap_start_reg <= 1'b0;
        end
    end
end

assign ap_ST_fsm_state1_blk = 1'b0;

always @ (*) begin
    if (((ap_enable_reg_pp0_iter2 == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            ap_NS_fsm = ap_ST_fsm_pp0_stage0;
        end
        ap_ST_fsm_pp0_stage0 : begin
            if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage1;
            end else begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end
        end
        ap_ST_fsm_pp0_stage1 : begin
            if ((1'b0 == ap_block_pp0_stage1_subdone)) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage2;
            end else begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage1;
            end
        end
        ap_ST_fsm_pp0_stage2 : begin
            if ((1'b0 == ap_block_pp0_stage2_subdone)) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end else begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage2;
            end
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_pp0_stage1 = ap_CS_fsm[32'd2];

assign ap_CS_fsm_pp0_stage2 = ap_CS_fsm[32'd3];

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage0_01001 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage0_11001 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage0_subdone = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage1 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage1_11001 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage1_subdone = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage2 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage2_11001 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage2_subdone = ~(1'b1 == 1'b1);

assign ap_block_state2_pp0_stage0_iter0 = ~(1'b1 == 1'b1);

assign ap_block_state3_pp0_stage1_iter0 = ~(1'b1 == 1'b1);

assign ap_block_state4_pp0_stage2_iter0 = ~(1'b1 == 1'b1);

assign ap_block_state5_pp0_stage0_iter1 = ~(1'b1 == 1'b1);

assign ap_block_state6_pp0_stage1_iter1 = ~(1'b1 == 1'b1);

assign ap_block_state7_pp0_stage2_iter1 = ~(1'b1 == 1'b1);

assign ap_block_state8_pp0_stage0_iter2 = ~(1'b1 == 1'b1);

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign data_memory_address0 = grp_do_process_fu_117_data_memory_address0;

assign data_memory_ce0 = grp_do_process_fu_117_data_memory_ce0;

assign data_memory_d0 = grp_do_process_fu_117_data_memory_d0;

assign data_memory_we0 = grp_do_process_fu_117_data_memory_we0;

assign error = grp_do_process_fu_117_ap_return;

assign grp_do_process_fu_117_ap_start = grp_do_process_fu_117_ap_start_reg;

assign instr_memory_address0 = grp_do_process_fu_117_instr_memory_address0;

assign instr_memory_ce0 = grp_do_process_fu_117_instr_memory_ce0;

endmodule //processor
