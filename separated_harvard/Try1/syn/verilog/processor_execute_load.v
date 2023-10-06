// ==============================================================
// Generated by Vitis HLS v2023.1.1
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// ==============================================================

`timescale 1 ns / 1 ps 

module processor_execute_load (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        funct3_val,
        imm_I_val,
        data_memory_address0,
        data_memory_ce0,
        data_memory_q0,
        source1_val,
        g_error,
        g_error_ap_vld,
        ap_return
);

parameter    ap_ST_fsm_state1 = 5'd1;
parameter    ap_ST_fsm_state2 = 5'd2;
parameter    ap_ST_fsm_state3 = 5'd4;
parameter    ap_ST_fsm_state4 = 5'd8;
parameter    ap_ST_fsm_state5 = 5'd16;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
input  [2:0] funct3_val;
input  [11:0] imm_I_val;
output  [15:0] data_memory_address0;
output   data_memory_ce0;
input  [31:0] data_memory_q0;
input  [31:0] source1_val;
output  [0:0] g_error;
output   g_error_ap_vld;
output  [31:0] ap_return;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg[15:0] data_memory_address0;
reg data_memory_ce0;
reg g_error_ap_vld;
reg[31:0] ap_return;

(* fsm_encoding = "none" *) reg   [4:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
wire   [2:0] funct3_val_read_read_fu_98_p2;
wire   [15:0] pos_6_fu_443_p4;
reg   [15:0] pos_6_reg_648;
wire   [2:0] select_ln119_fu_489_p3;
reg   [2:0] select_ln119_reg_664;
wire   [0:0] or_ln123_fu_503_p2;
reg   [0:0] or_ln123_reg_668;
wire    ap_CS_fsm_state2;
wire    ap_CS_fsm_state4;
wire    ap_CS_fsm_state5;
reg   [0:0] ap_phi_mux_g_error_flag_1_phi_fu_217_p36;
reg   [0:0] g_error_flag_1_reg_213;
wire    ap_CS_fsm_state3;
reg   [31:0] ap_phi_mux_phi_ln168_phi_fu_260_p36;
reg   [31:0] phi_ln168_reg_256;
wire   [31:0] zext_ln160_1_fu_538_p1;
wire   [31:0] zext_ln158_1_fu_547_p1;
wire   [31:0] zext_ln153_1_fu_552_p1;
wire   [31:0] zext_ln151_1_fu_557_p1;
wire   [31:0] zext_ln149_1_fu_562_p1;
wire   [31:0] zext_ln147_1_fu_571_p1;
wire  signed [31:0] sext_ln139_fu_576_p1;
wire  signed [31:0] sext_ln137_fu_585_p1;
wire  signed [31:0] sext_ln132_fu_590_p1;
wire  signed [31:0] sext_ln130_fu_595_p1;
wire  signed [31:0] sext_ln128_fu_600_p1;
wire  signed [31:0] sext_ln126_fu_609_p1;
wire   [63:0] zext_ln143_fu_509_p1;
wire   [63:0] zext_ln160_fu_514_p1;
wire   [63:0] zext_ln158_fu_518_p1;
wire   [63:0] zext_ln153_fu_522_p1;
wire   [63:0] zext_ln151_fu_526_p1;
wire   [63:0] zext_ln149_fu_530_p1;
wire   [63:0] zext_ln147_fu_534_p1;
wire   [63:0] zext_ln139_fu_620_p1;
wire   [63:0] zext_ln137_fu_624_p1;
wire   [63:0] zext_ln132_fu_628_p1;
wire   [63:0] zext_ln130_fu_632_p1;
wire   [63:0] zext_ln128_fu_636_p1;
wire   [63:0] zext_ln126_fu_640_p1;
wire  signed [11:0] imm_I_val_cast_fu_343_p0;
wire  signed [11:0] sext_ln112_fu_351_p0;
wire   [33:0] zext_ln112_fu_347_p1;
wire  signed [33:0] sext_ln112_fu_351_p1;
wire   [33:0] add_ln112_fu_355_p2;
wire  signed [11:0] sext_ln112_1_fu_369_p0;
wire  signed [11:0] sext_ln112_2_fu_377_p0;
wire  signed [31:0] imm_I_val_cast_fu_343_p1;
wire  signed [27:0] sext_ln112_2_fu_377_p1;
wire   [27:0] trunc_ln112_2_fu_373_p1;
wire  signed [28:0] sext_ln112_1_fu_369_p1;
wire   [28:0] trunc_ln112_1_fu_365_p1;
wire   [28:0] add_ln112_3_fu_393_p2;
wire   [0:0] tmp_fu_399_p3;
wire   [27:0] add_ln112_2_fu_387_p2;
wire   [25:0] tmp_s_fu_413_p4;
wire   [27:0] pos_3_fu_423_p3;
wire   [31:0] zext_ln112_1_fu_431_p1;
wire   [31:0] pos_fu_381_p2;
wire   [31:0] pos_4_fu_435_p3;
wire   [1:0] trunc_ln112_fu_361_p1;
wire   [1:0] sub_ln119_fu_461_p2;
wire   [2:0] p_and_t_fu_467_p3;
wire   [0:0] tmp_12_fu_453_p3;
wire   [2:0] sub_ln119_1_fu_475_p2;
wire   [2:0] tmp_19_fu_481_p3;
wire   [0:0] icmp_ln120_fu_497_p2;
wire   [0:0] xor_ln113_fu_407_p2;
wire   [15:0] grp_fu_303_p4;
wire   [15:0] trunc_ln158_fu_543_p1;
wire   [7:0] grp_fu_313_p4;
wire   [7:0] grp_fu_323_p4;
wire   [7:0] grp_fu_333_p4;
wire   [7:0] trunc_ln147_fu_567_p1;
wire   [15:0] trunc_ln137_fu_581_p1;
wire   [7:0] trunc_ln126_fu_605_p1;
reg   [31:0] ap_return_preg;
reg   [4:0] ap_NS_fsm;
reg    ap_ST_fsm_state1_blk;
wire    ap_ST_fsm_state2_blk;
wire    ap_ST_fsm_state3_blk;
wire    ap_ST_fsm_state4_blk;
wire    ap_ST_fsm_state5_blk;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_CS_fsm = 5'd1;
#0 ap_return_preg = 32'd0;
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_return_preg <= 32'd0;
    end else begin
        if ((1'b1 == ap_CS_fsm_state3)) begin
            ap_return_preg <= ap_phi_mux_phi_ln168_phi_fu_260_p36;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b1) & ((funct3_val_read_read_fu_98_p2 == 3'd3) | ((funct3_val_read_read_fu_98_p2 == 3'd6) | (funct3_val_read_read_fu_98_p2 == 3'd7))))) begin
        g_error_flag_1_reg_213 <= 1'd1;
    end else if (((1'b1 == ap_CS_fsm_state4) | ((select_ln119_reg_664 == 3'd1) & (funct3_val_read_read_fu_98_p2 == 3'd4) & (1'b1 == ap_CS_fsm_state3)) | ((select_ln119_reg_664 == 3'd1) & (funct3_val_read_read_fu_98_p2 == 3'd0) & (1'b1 == ap_CS_fsm_state3)) | ((select_ln119_reg_664 == 3'd3) & (funct3_val_read_read_fu_98_p2 == 3'd4) & (1'b1 == ap_CS_fsm_state3)) | ((select_ln119_reg_664 == 3'd3) & (funct3_val_read_read_fu_98_p2 == 3'd0) & (1'b1 == ap_CS_fsm_state3)) | ((select_ln119_reg_664 == 3'd0) & (funct3_val_read_read_fu_98_p2 == 3'd4) & (1'b1 == ap_CS_fsm_state3)) | ((select_ln119_reg_664 == 3'd0) & (funct3_val_read_read_fu_98_p2 == 3'd5) & (1'b1 == ap_CS_fsm_state3)) | ((select_ln119_reg_664 == 3'd0) & (funct3_val_read_read_fu_98_p2 == 3'd0) & (1'b1 == ap_CS_fsm_state3)) | ((select_ln119_reg_664 == 3'd0) & (funct3_val_read_read_fu_98_p2 == 3'd1) & (1'b1 == ap_CS_fsm_state3)) | ((select_ln119_reg_664 == 3'd2) & (funct3_val_read_read_fu_98_p2 == 3'd4) & (1'b1 == ap_CS_fsm_state3)) | ((select_ln119_reg_664 == 3'd2) & (funct3_val_read_read_fu_98_p2 
    == 3'd5) & (1'b1 == ap_CS_fsm_state3)) | ((select_ln119_reg_664 == 3'd2) & (funct3_val_read_read_fu_98_p2 == 3'd0) & (1'b1 == ap_CS_fsm_state3)) | ((select_ln119_reg_664 == 3'd2) & (funct3_val_read_read_fu_98_p2 == 3'd1) & (1'b1 == ap_CS_fsm_state3)) | (~(select_ln119_reg_664 == 3'd1) & ~(select_ln119_reg_664 == 3'd3) & ~(select_ln119_reg_664 == 3'd0) & ~(select_ln119_reg_664 == 3'd2) & (funct3_val_read_read_fu_98_p2 == 3'd4) & (1'b1 == ap_CS_fsm_state2)) | (~(select_ln119_reg_664 == 3'd1) & ~(select_ln119_reg_664 == 3'd3) & ~(select_ln119_reg_664 == 3'd0) & ~(select_ln119_reg_664 == 3'd2) & (funct3_val_read_read_fu_98_p2 == 3'd0) & (1'b1 == ap_CS_fsm_state5)) | (~(select_ln119_reg_664 == 3'd0) & ~(select_ln119_reg_664 == 3'd2) & (funct3_val_read_read_fu_98_p2 == 3'd5) & (1'b1 == ap_CS_fsm_state2)) | (~(select_ln119_reg_664 == 3'd0) & ~(select_ln119_reg_664 == 3'd2) & (funct3_val_read_read_fu_98_p2 == 3'd1) & (1'b1 == ap_CS_fsm_state5)))) begin
        g_error_flag_1_reg_213 <= or_ln123_reg_668;
    end
end

always @ (posedge ap_clk) begin
    if (((select_ln119_reg_664 == 3'd0) & (funct3_val_read_read_fu_98_p2 == 3'd0) & (1'b1 == ap_CS_fsm_state3))) begin
        phi_ln168_reg_256 <= sext_ln126_fu_609_p1;
    end else if (((select_ln119_reg_664 == 3'd1) & (funct3_val_read_read_fu_98_p2 == 3'd0) & (1'b1 == ap_CS_fsm_state3))) begin
        phi_ln168_reg_256 <= sext_ln128_fu_600_p1;
    end else if (((select_ln119_reg_664 == 3'd2) & (funct3_val_read_read_fu_98_p2 == 3'd0) & (1'b1 == ap_CS_fsm_state3))) begin
        phi_ln168_reg_256 <= sext_ln130_fu_595_p1;
    end else if (((select_ln119_reg_664 == 3'd3) & (funct3_val_read_read_fu_98_p2 == 3'd0) & (1'b1 == ap_CS_fsm_state3))) begin
        phi_ln168_reg_256 <= sext_ln132_fu_590_p1;
    end else if (((select_ln119_reg_664 == 3'd0) & (funct3_val_read_read_fu_98_p2 == 3'd1) & (1'b1 == ap_CS_fsm_state3))) begin
        phi_ln168_reg_256 <= sext_ln137_fu_585_p1;
    end else if (((select_ln119_reg_664 == 3'd2) & (funct3_val_read_read_fu_98_p2 == 3'd1) & (1'b1 == ap_CS_fsm_state3))) begin
        phi_ln168_reg_256 <= sext_ln139_fu_576_p1;
    end else if (((select_ln119_reg_664 == 3'd0) & (funct3_val_read_read_fu_98_p2 == 3'd4) & (1'b1 == ap_CS_fsm_state3))) begin
        phi_ln168_reg_256 <= zext_ln147_1_fu_571_p1;
    end else if (((select_ln119_reg_664 == 3'd1) & (funct3_val_read_read_fu_98_p2 == 3'd4) & (1'b1 == ap_CS_fsm_state3))) begin
        phi_ln168_reg_256 <= zext_ln149_1_fu_562_p1;
    end else if (((select_ln119_reg_664 == 3'd2) & (funct3_val_read_read_fu_98_p2 == 3'd4) & (1'b1 == ap_CS_fsm_state3))) begin
        phi_ln168_reg_256 <= zext_ln151_1_fu_557_p1;
    end else if (((select_ln119_reg_664 == 3'd3) & (funct3_val_read_read_fu_98_p2 == 3'd4) & (1'b1 == ap_CS_fsm_state3))) begin
        phi_ln168_reg_256 <= zext_ln153_1_fu_552_p1;
    end else if (((select_ln119_reg_664 == 3'd0) & (funct3_val_read_read_fu_98_p2 == 3'd5) & (1'b1 == ap_CS_fsm_state3))) begin
        phi_ln168_reg_256 <= zext_ln158_1_fu_547_p1;
    end else if (((select_ln119_reg_664 == 3'd2) & (funct3_val_read_read_fu_98_p2 == 3'd5) & (1'b1 == ap_CS_fsm_state3))) begin
        phi_ln168_reg_256 <= zext_ln160_1_fu_538_p1;
    end else if ((1'b1 == ap_CS_fsm_state4)) begin
        phi_ln168_reg_256 <= data_memory_q0;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state1)) begin
        or_ln123_reg_668 <= or_ln123_fu_503_p2;
        pos_6_reg_648 <= {{pos_4_fu_435_p3[17:2]}};
        select_ln119_reg_664 <= select_ln119_fu_489_p3;
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

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state3) | ((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b0)))) begin
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
    if ((((select_ln119_reg_664 == 3'd1) & (funct3_val_read_read_fu_98_p2 == 3'd4) & (1'b1 == ap_CS_fsm_state3)) | ((select_ln119_reg_664 == 3'd1) & (funct3_val_read_read_fu_98_p2 == 3'd0) & (1'b1 == ap_CS_fsm_state3)) | ((select_ln119_reg_664 == 3'd3) & (funct3_val_read_read_fu_98_p2 == 3'd4) & (1'b1 == ap_CS_fsm_state3)) | ((select_ln119_reg_664 == 3'd3) & (funct3_val_read_read_fu_98_p2 == 3'd0) & (1'b1 == ap_CS_fsm_state3)) | ((select_ln119_reg_664 == 3'd0) & (funct3_val_read_read_fu_98_p2 == 3'd4) & (1'b1 == ap_CS_fsm_state3)) | ((select_ln119_reg_664 == 3'd0) & (funct3_val_read_read_fu_98_p2 == 3'd5) & (1'b1 == ap_CS_fsm_state3)) | ((select_ln119_reg_664 == 3'd0) & (funct3_val_read_read_fu_98_p2 == 3'd0) & (1'b1 == ap_CS_fsm_state3)) | ((select_ln119_reg_664 == 3'd0) & (funct3_val_read_read_fu_98_p2 == 3'd1) & (1'b1 == ap_CS_fsm_state3)) | ((select_ln119_reg_664 == 3'd2) & (funct3_val_read_read_fu_98_p2 == 3'd4) & (1'b1 == ap_CS_fsm_state3)) | ((select_ln119_reg_664 == 3'd2) & (funct3_val_read_read_fu_98_p2 == 3'd5) 
    & (1'b1 == ap_CS_fsm_state3)) | ((select_ln119_reg_664 == 3'd2) & (funct3_val_read_read_fu_98_p2 == 3'd0) & (1'b1 == ap_CS_fsm_state3)) | ((select_ln119_reg_664 == 3'd2) & (funct3_val_read_read_fu_98_p2 == 3'd1) & (1'b1 == ap_CS_fsm_state3)))) begin
        ap_phi_mux_g_error_flag_1_phi_fu_217_p36 = or_ln123_reg_668;
    end else begin
        ap_phi_mux_g_error_flag_1_phi_fu_217_p36 = g_error_flag_1_reg_213;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state3)) begin
        if (((select_ln119_reg_664 == 3'd0) & (funct3_val_read_read_fu_98_p2 == 3'd0))) begin
            ap_phi_mux_phi_ln168_phi_fu_260_p36 = sext_ln126_fu_609_p1;
        end else if (((select_ln119_reg_664 == 3'd1) & (funct3_val_read_read_fu_98_p2 == 3'd0))) begin
            ap_phi_mux_phi_ln168_phi_fu_260_p36 = sext_ln128_fu_600_p1;
        end else if (((select_ln119_reg_664 == 3'd2) & (funct3_val_read_read_fu_98_p2 == 3'd0))) begin
            ap_phi_mux_phi_ln168_phi_fu_260_p36 = sext_ln130_fu_595_p1;
        end else if (((select_ln119_reg_664 == 3'd3) & (funct3_val_read_read_fu_98_p2 == 3'd0))) begin
            ap_phi_mux_phi_ln168_phi_fu_260_p36 = sext_ln132_fu_590_p1;
        end else if (((select_ln119_reg_664 == 3'd0) & (funct3_val_read_read_fu_98_p2 == 3'd1))) begin
            ap_phi_mux_phi_ln168_phi_fu_260_p36 = sext_ln137_fu_585_p1;
        end else if (((select_ln119_reg_664 == 3'd2) & (funct3_val_read_read_fu_98_p2 == 3'd1))) begin
            ap_phi_mux_phi_ln168_phi_fu_260_p36 = sext_ln139_fu_576_p1;
        end else if (((select_ln119_reg_664 == 3'd0) & (funct3_val_read_read_fu_98_p2 == 3'd4))) begin
            ap_phi_mux_phi_ln168_phi_fu_260_p36 = zext_ln147_1_fu_571_p1;
        end else if (((select_ln119_reg_664 == 3'd1) & (funct3_val_read_read_fu_98_p2 == 3'd4))) begin
            ap_phi_mux_phi_ln168_phi_fu_260_p36 = zext_ln149_1_fu_562_p1;
        end else if (((select_ln119_reg_664 == 3'd2) & (funct3_val_read_read_fu_98_p2 == 3'd4))) begin
            ap_phi_mux_phi_ln168_phi_fu_260_p36 = zext_ln151_1_fu_557_p1;
        end else if (((select_ln119_reg_664 == 3'd3) & (funct3_val_read_read_fu_98_p2 == 3'd4))) begin
            ap_phi_mux_phi_ln168_phi_fu_260_p36 = zext_ln153_1_fu_552_p1;
        end else if (((select_ln119_reg_664 == 3'd0) & (funct3_val_read_read_fu_98_p2 == 3'd5))) begin
            ap_phi_mux_phi_ln168_phi_fu_260_p36 = zext_ln158_1_fu_547_p1;
        end else if (((select_ln119_reg_664 == 3'd2) & (funct3_val_read_read_fu_98_p2 == 3'd5))) begin
            ap_phi_mux_phi_ln168_phi_fu_260_p36 = zext_ln160_1_fu_538_p1;
        end else begin
            ap_phi_mux_phi_ln168_phi_fu_260_p36 = phi_ln168_reg_256;
        end
    end else begin
        ap_phi_mux_phi_ln168_phi_fu_260_p36 = phi_ln168_reg_256;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state3)) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state3)) begin
        ap_return = ap_phi_mux_phi_ln168_phi_fu_260_p36;
    end else begin
        ap_return = ap_return_preg;
    end
end

always @ (*) begin
    if (((select_ln119_reg_664 == 3'd0) & (funct3_val_read_read_fu_98_p2 == 3'd0) & (1'b1 == ap_CS_fsm_state5))) begin
        data_memory_address0 = zext_ln126_fu_640_p1;
    end else if (((select_ln119_reg_664 == 3'd1) & (funct3_val_read_read_fu_98_p2 == 3'd0) & (1'b1 == ap_CS_fsm_state5))) begin
        data_memory_address0 = zext_ln128_fu_636_p1;
    end else if (((select_ln119_reg_664 == 3'd2) & (funct3_val_read_read_fu_98_p2 == 3'd0) & (1'b1 == ap_CS_fsm_state5))) begin
        data_memory_address0 = zext_ln130_fu_632_p1;
    end else if (((select_ln119_reg_664 == 3'd3) & (funct3_val_read_read_fu_98_p2 == 3'd0) & (1'b1 == ap_CS_fsm_state5))) begin
        data_memory_address0 = zext_ln132_fu_628_p1;
    end else if (((select_ln119_reg_664 == 3'd0) & (funct3_val_read_read_fu_98_p2 == 3'd1) & (1'b1 == ap_CS_fsm_state5))) begin
        data_memory_address0 = zext_ln137_fu_624_p1;
    end else if (((select_ln119_reg_664 == 3'd2) & (funct3_val_read_read_fu_98_p2 == 3'd1) & (1'b1 == ap_CS_fsm_state5))) begin
        data_memory_address0 = zext_ln139_fu_620_p1;
    end else if (((select_ln119_reg_664 == 3'd0) & (funct3_val_read_read_fu_98_p2 == 3'd4) & (1'b1 == ap_CS_fsm_state2))) begin
        data_memory_address0 = zext_ln147_fu_534_p1;
    end else if (((select_ln119_reg_664 == 3'd1) & (funct3_val_read_read_fu_98_p2 == 3'd4) & (1'b1 == ap_CS_fsm_state2))) begin
        data_memory_address0 = zext_ln149_fu_530_p1;
    end else if (((select_ln119_reg_664 == 3'd2) & (funct3_val_read_read_fu_98_p2 == 3'd4) & (1'b1 == ap_CS_fsm_state2))) begin
        data_memory_address0 = zext_ln151_fu_526_p1;
    end else if (((select_ln119_reg_664 == 3'd3) & (funct3_val_read_read_fu_98_p2 == 3'd4) & (1'b1 == ap_CS_fsm_state2))) begin
        data_memory_address0 = zext_ln153_fu_522_p1;
    end else if (((select_ln119_reg_664 == 3'd0) & (funct3_val_read_read_fu_98_p2 == 3'd5) & (1'b1 == ap_CS_fsm_state2))) begin
        data_memory_address0 = zext_ln158_fu_518_p1;
    end else if (((select_ln119_reg_664 == 3'd2) & (funct3_val_read_read_fu_98_p2 == 3'd5) & (1'b1 == ap_CS_fsm_state2))) begin
        data_memory_address0 = zext_ln160_fu_514_p1;
    end else if ((1'b1 == ap_CS_fsm_state1)) begin
        data_memory_address0 = zext_ln143_fu_509_p1;
    end else begin
        data_memory_address0 = 'bx;
    end
end

always @ (*) begin
    if ((((select_ln119_reg_664 == 3'd1) & (funct3_val_read_read_fu_98_p2 == 3'd4) & (1'b1 == ap_CS_fsm_state2)) | ((select_ln119_reg_664 == 3'd1) & (funct3_val_read_read_fu_98_p2 == 3'd0) & (1'b1 == ap_CS_fsm_state5)) | ((select_ln119_reg_664 == 3'd3) & (funct3_val_read_read_fu_98_p2 == 3'd4) & (1'b1 == ap_CS_fsm_state2)) | ((select_ln119_reg_664 == 3'd3) & (funct3_val_read_read_fu_98_p2 == 3'd0) & (1'b1 == ap_CS_fsm_state5)) | ((select_ln119_reg_664 == 3'd0) & (funct3_val_read_read_fu_98_p2 == 3'd4) & (1'b1 == ap_CS_fsm_state2)) | ((select_ln119_reg_664 == 3'd0) & (funct3_val_read_read_fu_98_p2 == 3'd5) & (1'b1 == ap_CS_fsm_state2)) | ((select_ln119_reg_664 == 3'd0) & (funct3_val_read_read_fu_98_p2 == 3'd0) & (1'b1 == ap_CS_fsm_state5)) | ((select_ln119_reg_664 == 3'd0) & (funct3_val_read_read_fu_98_p2 == 3'd1) & (1'b1 == ap_CS_fsm_state5)) | ((select_ln119_reg_664 == 3'd2) & (funct3_val_read_read_fu_98_p2 == 3'd4) & (1'b1 == ap_CS_fsm_state2)) | ((select_ln119_reg_664 == 3'd2) & (funct3_val_read_read_fu_98_p2 == 3'd5) 
    & (1'b1 == ap_CS_fsm_state2)) | ((select_ln119_reg_664 == 3'd2) & (funct3_val_read_read_fu_98_p2 == 3'd0) & (1'b1 == ap_CS_fsm_state5)) | ((select_ln119_reg_664 == 3'd2) & (funct3_val_read_read_fu_98_p2 == 3'd1) & (1'b1 == ap_CS_fsm_state5)) | ((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b1)))) begin
        data_memory_ce0 = 1'b1;
    end else begin
        data_memory_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state3) & (ap_phi_mux_g_error_flag_1_phi_fu_217_p36 == 1'd1))) begin
        g_error_ap_vld = 1'b1;
    end else begin
        g_error_ap_vld = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if (((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b1) & ((funct3_val_read_read_fu_98_p2 == 3'd1) | (funct3_val_read_read_fu_98_p2 == 3'd0)))) begin
                ap_NS_fsm = ap_ST_fsm_state5;
            end else if (((funct3_val_read_read_fu_98_p2 == 3'd2) & (1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b1))) begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end else if (((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b1) & ((funct3_val_read_read_fu_98_p2 == 3'd3) | ((funct3_val_read_read_fu_98_p2 == 3'd6) | (funct3_val_read_read_fu_98_p2 == 3'd7))))) begin
                ap_NS_fsm = ap_ST_fsm_state3;
            end else if (((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b1) & ((funct3_val_read_read_fu_98_p2 == 3'd4) | (funct3_val_read_read_fu_98_p2 == 3'd5)))) begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end
        end
        ap_ST_fsm_state2 : begin
            ap_NS_fsm = ap_ST_fsm_state3;
        end
        ap_ST_fsm_state3 : begin
            ap_NS_fsm = ap_ST_fsm_state1;
        end
        ap_ST_fsm_state4 : begin
            ap_NS_fsm = ap_ST_fsm_state3;
        end
        ap_ST_fsm_state5 : begin
            ap_NS_fsm = ap_ST_fsm_state3;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign add_ln112_2_fu_387_p2 = ($signed(sext_ln112_2_fu_377_p1) + $signed(trunc_ln112_2_fu_373_p1));

assign add_ln112_3_fu_393_p2 = ($signed(sext_ln112_1_fu_369_p1) + $signed(trunc_ln112_1_fu_365_p1));

assign add_ln112_fu_355_p2 = ($signed(zext_ln112_fu_347_p1) + $signed(sext_ln112_fu_351_p1));

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state3 = ap_CS_fsm[32'd2];

assign ap_CS_fsm_state4 = ap_CS_fsm[32'd3];

assign ap_CS_fsm_state5 = ap_CS_fsm[32'd4];

assign funct3_val_read_read_fu_98_p2 = funct3_val;

assign g_error = 1'd1;

assign grp_fu_303_p4 = {{data_memory_q0[31:16]}};

assign grp_fu_313_p4 = {{data_memory_q0[31:24]}};

assign grp_fu_323_p4 = {{data_memory_q0[23:16]}};

assign grp_fu_333_p4 = {{data_memory_q0[15:8]}};

assign icmp_ln120_fu_497_p2 = ((pos_4_fu_435_p3 > 32'd204799) ? 1'b1 : 1'b0);

assign imm_I_val_cast_fu_343_p0 = imm_I_val;

assign imm_I_val_cast_fu_343_p1 = imm_I_val_cast_fu_343_p0;

assign or_ln123_fu_503_p2 = (xor_ln113_fu_407_p2 | icmp_ln120_fu_497_p2);

assign p_and_t_fu_467_p3 = {{1'd0}, {sub_ln119_fu_461_p2}};

assign pos_3_fu_423_p3 = {{tmp_s_fu_413_p4}, {2'd0}};

assign pos_4_fu_435_p3 = ((tmp_fu_399_p3[0:0] == 1'b1) ? zext_ln112_1_fu_431_p1 : pos_fu_381_p2);

assign pos_6_fu_443_p4 = {{pos_4_fu_435_p3[17:2]}};

assign pos_fu_381_p2 = ($signed(imm_I_val_cast_fu_343_p1) + $signed(source1_val));

assign select_ln119_fu_489_p3 = ((tmp_12_fu_453_p3[0:0] == 1'b1) ? sub_ln119_1_fu_475_p2 : tmp_19_fu_481_p3);

assign sext_ln112_1_fu_369_p0 = imm_I_val;

assign sext_ln112_1_fu_369_p1 = sext_ln112_1_fu_369_p0;

assign sext_ln112_2_fu_377_p0 = imm_I_val;

assign sext_ln112_2_fu_377_p1 = sext_ln112_2_fu_377_p0;

assign sext_ln112_fu_351_p0 = imm_I_val;

assign sext_ln112_fu_351_p1 = sext_ln112_fu_351_p0;

assign sext_ln126_fu_609_p1 = $signed(trunc_ln126_fu_605_p1);

assign sext_ln128_fu_600_p1 = $signed(grp_fu_333_p4);

assign sext_ln130_fu_595_p1 = $signed(grp_fu_323_p4);

assign sext_ln132_fu_590_p1 = $signed(grp_fu_313_p4);

assign sext_ln137_fu_585_p1 = $signed(trunc_ln137_fu_581_p1);

assign sext_ln139_fu_576_p1 = $signed(grp_fu_303_p4);

assign sub_ln119_1_fu_475_p2 = (3'd0 - p_and_t_fu_467_p3);

assign sub_ln119_fu_461_p2 = (2'd0 - trunc_ln112_fu_361_p1);

assign tmp_12_fu_453_p3 = add_ln112_fu_355_p2[32'd33];

assign tmp_19_fu_481_p3 = {{1'd0}, {trunc_ln112_fu_361_p1}};

assign tmp_fu_399_p3 = add_ln112_3_fu_393_p2[32'd28];

assign tmp_s_fu_413_p4 = {{add_ln112_2_fu_387_p2[27:2]}};

assign trunc_ln112_1_fu_365_p1 = source1_val[28:0];

assign trunc_ln112_2_fu_373_p1 = source1_val[27:0];

assign trunc_ln112_fu_361_p1 = add_ln112_fu_355_p2[1:0];

assign trunc_ln126_fu_605_p1 = data_memory_q0[7:0];

assign trunc_ln137_fu_581_p1 = data_memory_q0[15:0];

assign trunc_ln147_fu_567_p1 = data_memory_q0[7:0];

assign trunc_ln158_fu_543_p1 = data_memory_q0[15:0];

assign xor_ln113_fu_407_p2 = (tmp_fu_399_p3 ^ 1'd1);

assign zext_ln112_1_fu_431_p1 = pos_3_fu_423_p3;

assign zext_ln112_fu_347_p1 = source1_val;

assign zext_ln126_fu_640_p1 = pos_6_reg_648;

assign zext_ln128_fu_636_p1 = pos_6_reg_648;

assign zext_ln130_fu_632_p1 = pos_6_reg_648;

assign zext_ln132_fu_628_p1 = pos_6_reg_648;

assign zext_ln137_fu_624_p1 = pos_6_reg_648;

assign zext_ln139_fu_620_p1 = pos_6_reg_648;

assign zext_ln143_fu_509_p1 = pos_6_fu_443_p4;

assign zext_ln147_1_fu_571_p1 = trunc_ln147_fu_567_p1;

assign zext_ln147_fu_534_p1 = pos_6_reg_648;

assign zext_ln149_1_fu_562_p1 = grp_fu_333_p4;

assign zext_ln149_fu_530_p1 = pos_6_reg_648;

assign zext_ln151_1_fu_557_p1 = grp_fu_323_p4;

assign zext_ln151_fu_526_p1 = pos_6_reg_648;

assign zext_ln153_1_fu_552_p1 = grp_fu_313_p4;

assign zext_ln153_fu_522_p1 = pos_6_reg_648;

assign zext_ln158_1_fu_547_p1 = trunc_ln158_fu_543_p1;

assign zext_ln158_fu_518_p1 = pos_6_reg_648;

assign zext_ln160_1_fu_538_p1 = grp_fu_303_p4;

assign zext_ln160_fu_514_p1 = pos_6_reg_648;

endmodule //processor_execute_load
