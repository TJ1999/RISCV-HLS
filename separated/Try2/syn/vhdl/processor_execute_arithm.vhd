-- ==============================================================
-- Generated by Vitis HLS v2023.1.1
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
-- ==============================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity processor_execute_arithm is
port (
    ap_ready : OUT STD_LOGIC;
    op_code_val : IN STD_LOGIC_VECTOR (6 downto 0);
    funct3_val : IN STD_LOGIC_VECTOR (2 downto 0);
    funct7_val : IN STD_LOGIC_VECTOR (6 downto 0);
    source1_val : IN STD_LOGIC_VECTOR (31 downto 0);
    source2_val : IN STD_LOGIC_VECTOR (31 downto 0);
    imm_I_val : IN STD_LOGIC_VECTOR (11 downto 0);
    imm_U_val : IN STD_LOGIC_VECTOR (31 downto 0);
    old_pc_val : IN STD_LOGIC_VECTOR (31 downto 0);
    g_error : OUT STD_LOGIC_VECTOR (0 downto 0);
    g_error_ap_vld : OUT STD_LOGIC;
    ap_return_0 : OUT STD_LOGIC_VECTOR (31 downto 0);
    ap_return_1 : OUT STD_LOGIC_VECTOR (0 downto 0) );
end;


architecture behav of processor_execute_arithm is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_lv1_0 : STD_LOGIC_VECTOR (0 downto 0) := "0";
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_lv7_17 : STD_LOGIC_VECTOR (6 downto 0) := "0010111";
    constant ap_const_lv7_37 : STD_LOGIC_VECTOR (6 downto 0) := "0110111";
    constant ap_const_lv7_13 : STD_LOGIC_VECTOR (6 downto 0) := "0010011";
    constant ap_const_lv7_33 : STD_LOGIC_VECTOR (6 downto 0) := "0110011";
    constant ap_const_lv7_F : STD_LOGIC_VECTOR (6 downto 0) := "0001111";
    constant ap_const_lv7_73 : STD_LOGIC_VECTOR (6 downto 0) := "1110011";
    constant ap_const_lv1_1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv3_5 : STD_LOGIC_VECTOR (2 downto 0) := "101";
    constant ap_const_lv7_0 : STD_LOGIC_VECTOR (6 downto 0) := "0000000";
    constant ap_const_lv7_20 : STD_LOGIC_VECTOR (6 downto 0) := "0100000";
    constant ap_const_lv3_7 : STD_LOGIC_VECTOR (2 downto 0) := "111";
    constant ap_const_lv3_6 : STD_LOGIC_VECTOR (2 downto 0) := "110";
    constant ap_const_lv3_4 : STD_LOGIC_VECTOR (2 downto 0) := "100";
    constant ap_const_lv3_3 : STD_LOGIC_VECTOR (2 downto 0) := "011";
    constant ap_const_lv3_2 : STD_LOGIC_VECTOR (2 downto 0) := "010";
    constant ap_const_lv3_0 : STD_LOGIC_VECTOR (2 downto 0) := "000";
    constant ap_const_lv3_1 : STD_LOGIC_VECTOR (2 downto 0) := "001";
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_const_lv12_0 : STD_LOGIC_VECTOR (11 downto 0) := "000000000000";

attribute shreg_extract : string;
    signal ap_phi_mux_phi_ln371_phi_fu_119_p68 : STD_LOGIC_VECTOR (0 downto 0);
    signal op_code_val_read_read_fu_110_p2 : STD_LOGIC_VECTOR (6 downto 0);
    signal funct3_val_read_read_fu_104_p2 : STD_LOGIC_VECTOR (2 downto 0);
    signal funct7_val_read_read_fu_98_p2 : STD_LOGIC_VECTOR (6 downto 0);
    signal icmp_ln244_fu_314_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal add_ln207_fu_595_p2 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_phi_mux_phi_ln371_1_phi_fu_226_p68 : STD_LOGIC_VECTOR (31 downto 0);
    signal and_ln345_fu_481_p2 : STD_LOGIC_VECTOR (31 downto 0);
    signal ashr_ln256_fu_567_p2 : STD_LOGIC_VECTOR (31 downto 0);
    signal lshr_ln253_fu_582_p2 : STD_LOGIC_VECTOR (31 downto 0);
    signal and_ln241_fu_509_p2 : STD_LOGIC_VECTOR (31 downto 0);
    signal or_ln238_fu_516_p2 : STD_LOGIC_VECTOR (31 downto 0);
    signal xor_ln235_fu_523_p2 : STD_LOGIC_VECTOR (31 downto 0);
    signal zext_ln228_fu_536_p1 : STD_LOGIC_VECTOR (31 downto 0);
    signal zext_ln221_fu_547_p1 : STD_LOGIC_VECTOR (31 downto 0);
    signal add_ln218_fu_552_p2 : STD_LOGIC_VECTOR (31 downto 0);
    signal shl_ln245_fu_502_p2 : STD_LOGIC_VECTOR (31 downto 0);
    signal shl_ln288_fu_448_p2 : STD_LOGIC_VECTOR (31 downto 0);
    signal zext_ln295_fu_429_p1 : STD_LOGIC_VECTOR (31 downto 0);
    signal zext_ln306_fu_412_p1 : STD_LOGIC_VECTOR (31 downto 0);
    signal xor_ln317_fu_393_p2 : STD_LOGIC_VECTOR (31 downto 0);
    signal or_ln338_fu_344_p2 : STD_LOGIC_VECTOR (31 downto 0);
    signal sub_ln279_fu_455_p2 : STD_LOGIC_VECTOR (31 downto 0);
    signal add_ln275_fu_462_p2 : STD_LOGIC_VECTOR (31 downto 0);
    signal ashr_ln328_fu_359_p2 : STD_LOGIC_VECTOR (31 downto 0);
    signal lshr_ln325_fu_374_p2 : STD_LOGIC_VECTOR (31 downto 0);
    signal icmp_ln361_fu_320_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal imm_I_val_cast_fu_310_p0 : STD_LOGIC_VECTOR (11 downto 0);
    signal icmp_ln361_fu_320_p0 : STD_LOGIC_VECTOR (11 downto 0);
    signal trunc_ln328_fu_351_p1 : STD_LOGIC_VECTOR (4 downto 0);
    signal zext_ln328_fu_355_p1 : STD_LOGIC_VECTOR (31 downto 0);
    signal trunc_ln325_fu_366_p1 : STD_LOGIC_VECTOR (4 downto 0);
    signal zext_ln325_fu_370_p1 : STD_LOGIC_VECTOR (31 downto 0);
    signal icmp_ln306_fu_406_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln295_fu_423_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal trunc_ln288_fu_440_p1 : STD_LOGIC_VECTOR (4 downto 0);
    signal zext_ln288_fu_444_p1 : STD_LOGIC_VECTOR (31 downto 0);
    signal trunc_ln245_fu_494_p0 : STD_LOGIC_VECTOR (11 downto 0);
    signal trunc_ln245_fu_494_p1 : STD_LOGIC_VECTOR (4 downto 0);
    signal zext_ln245_fu_498_p1 : STD_LOGIC_VECTOR (31 downto 0);
    signal imm_I_val_cast_fu_310_p1 : STD_LOGIC_VECTOR (31 downto 0);
    signal icmp_ln228_fu_530_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln221_fu_541_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal trunc_ln256_fu_559_p0 : STD_LOGIC_VECTOR (11 downto 0);
    signal trunc_ln256_fu_559_p1 : STD_LOGIC_VECTOR (4 downto 0);
    signal zext_ln256_fu_563_p1 : STD_LOGIC_VECTOR (31 downto 0);
    signal trunc_ln253_fu_574_p0 : STD_LOGIC_VECTOR (11 downto 0);
    signal trunc_ln253_fu_574_p1 : STD_LOGIC_VECTOR (4 downto 0);
    signal zext_ln253_fu_578_p1 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_ce_reg : STD_LOGIC;


begin



    add_ln207_fu_595_p2 <= std_logic_vector(unsigned(old_pc_val) + unsigned(imm_U_val));
    add_ln218_fu_552_p2 <= std_logic_vector(signed(imm_I_val_cast_fu_310_p1) + signed(source1_val));
    add_ln275_fu_462_p2 <= std_logic_vector(unsigned(source2_val) + unsigned(source1_val));
    and_ln241_fu_509_p2 <= (source1_val and imm_I_val_cast_fu_310_p1);
    and_ln345_fu_481_p2 <= (source2_val and source1_val);

    ap_phi_mux_phi_ln371_1_phi_fu_226_p68_assign_proc : process(imm_U_val, op_code_val_read_read_fu_110_p2, funct3_val_read_read_fu_104_p2, funct7_val_read_read_fu_98_p2, icmp_ln244_fu_314_p2, add_ln207_fu_595_p2, and_ln345_fu_481_p2, ashr_ln256_fu_567_p2, lshr_ln253_fu_582_p2, and_ln241_fu_509_p2, or_ln238_fu_516_p2, xor_ln235_fu_523_p2, zext_ln228_fu_536_p1, zext_ln221_fu_547_p1, add_ln218_fu_552_p2, shl_ln245_fu_502_p2, shl_ln288_fu_448_p2, zext_ln295_fu_429_p1, zext_ln306_fu_412_p1, xor_ln317_fu_393_p2, or_ln338_fu_344_p2, sub_ln279_fu_455_p2, add_ln275_fu_462_p2, ashr_ln328_fu_359_p2, lshr_ln325_fu_374_p2)
    begin
        if (((funct7_val_read_read_fu_98_p2 = ap_const_lv7_0) and (funct3_val_read_read_fu_104_p2 = ap_const_lv3_5) and (op_code_val_read_read_fu_110_p2 = ap_const_lv7_33))) then 
            ap_phi_mux_phi_ln371_1_phi_fu_226_p68 <= lshr_ln325_fu_374_p2;
        elsif (((funct7_val_read_read_fu_98_p2 = ap_const_lv7_20) and (funct3_val_read_read_fu_104_p2 = ap_const_lv3_5) and (op_code_val_read_read_fu_110_p2 = ap_const_lv7_33))) then 
            ap_phi_mux_phi_ln371_1_phi_fu_226_p68 <= ashr_ln328_fu_359_p2;
        elsif (((funct7_val_read_read_fu_98_p2 = ap_const_lv7_0) and (funct3_val_read_read_fu_104_p2 = ap_const_lv3_0) and (op_code_val_read_read_fu_110_p2 = ap_const_lv7_33))) then 
            ap_phi_mux_phi_ln371_1_phi_fu_226_p68 <= add_ln275_fu_462_p2;
        elsif (((funct7_val_read_read_fu_98_p2 = ap_const_lv7_20) and (funct3_val_read_read_fu_104_p2 = ap_const_lv3_0) and (op_code_val_read_read_fu_110_p2 = ap_const_lv7_33))) then 
            ap_phi_mux_phi_ln371_1_phi_fu_226_p68 <= sub_ln279_fu_455_p2;
        elsif (((icmp_ln244_fu_314_p2 = ap_const_lv1_1) and (funct3_val_read_read_fu_104_p2 = ap_const_lv3_6) and (op_code_val_read_read_fu_110_p2 = ap_const_lv7_33))) then 
            ap_phi_mux_phi_ln371_1_phi_fu_226_p68 <= or_ln338_fu_344_p2;
        elsif (((icmp_ln244_fu_314_p2 = ap_const_lv1_1) and (funct3_val_read_read_fu_104_p2 = ap_const_lv3_4) and (op_code_val_read_read_fu_110_p2 = ap_const_lv7_33))) then 
            ap_phi_mux_phi_ln371_1_phi_fu_226_p68 <= xor_ln317_fu_393_p2;
        elsif (((icmp_ln244_fu_314_p2 = ap_const_lv1_1) and (funct3_val_read_read_fu_104_p2 = ap_const_lv3_3) and (op_code_val_read_read_fu_110_p2 = ap_const_lv7_33))) then 
            ap_phi_mux_phi_ln371_1_phi_fu_226_p68 <= zext_ln306_fu_412_p1;
        elsif (((icmp_ln244_fu_314_p2 = ap_const_lv1_1) and (funct3_val_read_read_fu_104_p2 = ap_const_lv3_2) and (op_code_val_read_read_fu_110_p2 = ap_const_lv7_33))) then 
            ap_phi_mux_phi_ln371_1_phi_fu_226_p68 <= zext_ln295_fu_429_p1;
        elsif (((icmp_ln244_fu_314_p2 = ap_const_lv1_1) and (funct3_val_read_read_fu_104_p2 = ap_const_lv3_1) and (op_code_val_read_read_fu_110_p2 = ap_const_lv7_33))) then 
            ap_phi_mux_phi_ln371_1_phi_fu_226_p68 <= shl_ln288_fu_448_p2;
        elsif (((icmp_ln244_fu_314_p2 = ap_const_lv1_1) and (funct3_val_read_read_fu_104_p2 = ap_const_lv3_1) and (op_code_val_read_read_fu_110_p2 = ap_const_lv7_13))) then 
            ap_phi_mux_phi_ln371_1_phi_fu_226_p68 <= shl_ln245_fu_502_p2;
        elsif (((funct3_val_read_read_fu_104_p2 = ap_const_lv3_0) and (op_code_val_read_read_fu_110_p2 = ap_const_lv7_13))) then 
            ap_phi_mux_phi_ln371_1_phi_fu_226_p68 <= add_ln218_fu_552_p2;
        elsif (((funct3_val_read_read_fu_104_p2 = ap_const_lv3_2) and (op_code_val_read_read_fu_110_p2 = ap_const_lv7_13))) then 
            ap_phi_mux_phi_ln371_1_phi_fu_226_p68 <= zext_ln221_fu_547_p1;
        elsif (((funct3_val_read_read_fu_104_p2 = ap_const_lv3_3) and (op_code_val_read_read_fu_110_p2 = ap_const_lv7_13))) then 
            ap_phi_mux_phi_ln371_1_phi_fu_226_p68 <= zext_ln228_fu_536_p1;
        elsif (((funct3_val_read_read_fu_104_p2 = ap_const_lv3_4) and (op_code_val_read_read_fu_110_p2 = ap_const_lv7_13))) then 
            ap_phi_mux_phi_ln371_1_phi_fu_226_p68 <= xor_ln235_fu_523_p2;
        elsif (((funct3_val_read_read_fu_104_p2 = ap_const_lv3_6) and (op_code_val_read_read_fu_110_p2 = ap_const_lv7_13))) then 
            ap_phi_mux_phi_ln371_1_phi_fu_226_p68 <= or_ln238_fu_516_p2;
        elsif (((funct3_val_read_read_fu_104_p2 = ap_const_lv3_7) and (op_code_val_read_read_fu_110_p2 = ap_const_lv7_13))) then 
            ap_phi_mux_phi_ln371_1_phi_fu_226_p68 <= and_ln241_fu_509_p2;
        elsif (((funct7_val_read_read_fu_98_p2 = ap_const_lv7_0) and (funct3_val_read_read_fu_104_p2 = ap_const_lv3_5) and (op_code_val_read_read_fu_110_p2 = ap_const_lv7_13))) then 
            ap_phi_mux_phi_ln371_1_phi_fu_226_p68 <= lshr_ln253_fu_582_p2;
        elsif (((funct7_val_read_read_fu_98_p2 = ap_const_lv7_20) and (funct3_val_read_read_fu_104_p2 = ap_const_lv3_5) and (op_code_val_read_read_fu_110_p2 = ap_const_lv7_13))) then 
            ap_phi_mux_phi_ln371_1_phi_fu_226_p68 <= ashr_ln256_fu_567_p2;
        elsif (((icmp_ln244_fu_314_p2 = ap_const_lv1_1) and (funct3_val_read_read_fu_104_p2 = ap_const_lv3_7) and (op_code_val_read_read_fu_110_p2 = ap_const_lv7_33))) then 
            ap_phi_mux_phi_ln371_1_phi_fu_226_p68 <= and_ln345_fu_481_p2;
        elsif ((op_code_val_read_read_fu_110_p2 = ap_const_lv7_37)) then 
            ap_phi_mux_phi_ln371_1_phi_fu_226_p68 <= imm_U_val;
        elsif ((op_code_val_read_read_fu_110_p2 = ap_const_lv7_17)) then 
            ap_phi_mux_phi_ln371_1_phi_fu_226_p68 <= add_ln207_fu_595_p2;
        else 
            ap_phi_mux_phi_ln371_1_phi_fu_226_p68 <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        end if; 
    end process;


    ap_phi_mux_phi_ln371_phi_fu_119_p68_assign_proc : process(op_code_val_read_read_fu_110_p2, funct3_val_read_read_fu_104_p2, funct7_val_read_read_fu_98_p2, icmp_ln244_fu_314_p2)
    begin
        if (((op_code_val_read_read_fu_110_p2 = ap_const_lv7_37) or (op_code_val_read_read_fu_110_p2 = ap_const_lv7_17) or ((funct3_val_read_read_fu_104_p2 = ap_const_lv3_0) and (op_code_val_read_read_fu_110_p2 = ap_const_lv7_13)) or ((funct3_val_read_read_fu_104_p2 = ap_const_lv3_2) and (op_code_val_read_read_fu_110_p2 = ap_const_lv7_13)) or ((funct3_val_read_read_fu_104_p2 = ap_const_lv3_3) and (op_code_val_read_read_fu_110_p2 = ap_const_lv7_13)) or ((funct3_val_read_read_fu_104_p2 = ap_const_lv3_4) and (op_code_val_read_read_fu_110_p2 = ap_const_lv7_13)) or ((funct3_val_read_read_fu_104_p2 = ap_const_lv3_6) and (op_code_val_read_read_fu_110_p2 = ap_const_lv7_13)) or ((icmp_ln244_fu_314_p2 = ap_const_lv1_0) and (funct3_val_read_read_fu_104_p2 = ap_const_lv3_1) and (op_code_val_read_read_fu_110_p2 = ap_const_lv7_33)) or ((icmp_ln244_fu_314_p2 = ap_const_lv1_0) and (funct3_val_read_read_fu_104_p2 = ap_const_lv3_1) and (op_code_val_read_read_fu_110_p2 = ap_const_lv7_13)) or ((icmp_ln244_fu_314_p2 = ap_const_lv1_0) and (funct3_val_read_read_fu_104_p2 
    = ap_const_lv3_2) and (op_code_val_read_read_fu_110_p2 = ap_const_lv7_33)) or ((icmp_ln244_fu_314_p2 = ap_const_lv1_0) and (funct3_val_read_read_fu_104_p2 = ap_const_lv3_3) and (op_code_val_read_read_fu_110_p2 = ap_const_lv7_33)) or ((icmp_ln244_fu_314_p2 = ap_const_lv1_0) and (funct3_val_read_read_fu_104_p2 = ap_const_lv3_4) and (op_code_val_read_read_fu_110_p2 = ap_const_lv7_33)) or ((icmp_ln244_fu_314_p2 = ap_const_lv1_0) and (funct3_val_read_read_fu_104_p2 = ap_const_lv3_6) and (op_code_val_read_read_fu_110_p2 = ap_const_lv7_33)) or ((icmp_ln244_fu_314_p2 = ap_const_lv1_0) and (funct3_val_read_read_fu_104_p2 = ap_const_lv3_7) and (op_code_val_read_read_fu_110_p2 = ap_const_lv7_33)) or ((icmp_ln244_fu_314_p2 = ap_const_lv1_1) and (funct3_val_read_read_fu_104_p2 = ap_const_lv3_1) and (op_code_val_read_read_fu_110_p2 = ap_const_lv7_33)) or ((icmp_ln244_fu_314_p2 = ap_const_lv1_1) and (funct3_val_read_read_fu_104_p2 = ap_const_lv3_1) and (op_code_val_read_read_fu_110_p2 = ap_const_lv7_13)) or ((icmp_ln244_fu_314_p2 
    = ap_const_lv1_1) and (funct3_val_read_read_fu_104_p2 = ap_const_lv3_2) and (op_code_val_read_read_fu_110_p2 = ap_const_lv7_33)) or ((icmp_ln244_fu_314_p2 = ap_const_lv1_1) and (funct3_val_read_read_fu_104_p2 = ap_const_lv3_3) and (op_code_val_read_read_fu_110_p2 = ap_const_lv7_33)) or ((icmp_ln244_fu_314_p2 = ap_const_lv1_1) and (funct3_val_read_read_fu_104_p2 = ap_const_lv3_4) and (op_code_val_read_read_fu_110_p2 = ap_const_lv7_33)) or ((icmp_ln244_fu_314_p2 = ap_const_lv1_1) and (funct3_val_read_read_fu_104_p2 = ap_const_lv3_6) and (op_code_val_read_read_fu_110_p2 = ap_const_lv7_33)) or ((icmp_ln244_fu_314_p2 = ap_const_lv1_1) and (funct3_val_read_read_fu_104_p2 = ap_const_lv3_7) and (op_code_val_read_read_fu_110_p2 = ap_const_lv7_33)) or ((funct3_val_read_read_fu_104_p2 = ap_const_lv3_7) and (op_code_val_read_read_fu_110_p2 = ap_const_lv7_13)) or (not((funct7_val_read_read_fu_98_p2 = ap_const_lv7_20)) and not((funct7_val_read_read_fu_98_p2 = ap_const_lv7_0)) and (funct3_val_read_read_fu_104_p2 = ap_const_lv3_0) 
    and (op_code_val_read_read_fu_110_p2 = ap_const_lv7_33)) or (not((funct7_val_read_read_fu_98_p2 = ap_const_lv7_20)) and not((funct7_val_read_read_fu_98_p2 = ap_const_lv7_0)) and (funct3_val_read_read_fu_104_p2 = ap_const_lv3_5) and (op_code_val_read_read_fu_110_p2 = ap_const_lv7_33)) or (not((funct7_val_read_read_fu_98_p2 = ap_const_lv7_20)) and not((funct7_val_read_read_fu_98_p2 = ap_const_lv7_0)) and (funct3_val_read_read_fu_104_p2 = ap_const_lv3_5) and (op_code_val_read_read_fu_110_p2 = ap_const_lv7_13)) or ((funct7_val_read_read_fu_98_p2 = ap_const_lv7_20) and (funct3_val_read_read_fu_104_p2 = ap_const_lv3_0) and (op_code_val_read_read_fu_110_p2 = ap_const_lv7_33)) or ((funct7_val_read_read_fu_98_p2 = ap_const_lv7_20) and (funct3_val_read_read_fu_104_p2 = ap_const_lv3_5) and (op_code_val_read_read_fu_110_p2 = ap_const_lv7_33)) or ((funct7_val_read_read_fu_98_p2 = ap_const_lv7_20) and (funct3_val_read_read_fu_104_p2 = ap_const_lv3_5) and (op_code_val_read_read_fu_110_p2 = ap_const_lv7_13)) or ((funct7_val_read_read_fu_98_p2 
    = ap_const_lv7_0) and (funct3_val_read_read_fu_104_p2 = ap_const_lv3_0) and (op_code_val_read_read_fu_110_p2 = ap_const_lv7_33)) or ((funct7_val_read_read_fu_98_p2 = ap_const_lv7_0) and (funct3_val_read_read_fu_104_p2 = ap_const_lv3_5) and (op_code_val_read_read_fu_110_p2 = ap_const_lv7_33)) or ((funct7_val_read_read_fu_98_p2 = ap_const_lv7_0) and (funct3_val_read_read_fu_104_p2 = ap_const_lv3_5) and (op_code_val_read_read_fu_110_p2 = ap_const_lv7_13)))) then 
            ap_phi_mux_phi_ln371_phi_fu_119_p68 <= ap_const_lv1_1;
        elsif (((op_code_val_read_read_fu_110_p2 = ap_const_lv7_73) or (op_code_val_read_read_fu_110_p2 = ap_const_lv7_F) or (not((op_code_val_read_read_fu_110_p2 = ap_const_lv7_73)) and not((op_code_val_read_read_fu_110_p2 = ap_const_lv7_F)) and not((op_code_val_read_read_fu_110_p2 = ap_const_lv7_33)) and not((op_code_val_read_read_fu_110_p2 = ap_const_lv7_13)) and not((op_code_val_read_read_fu_110_p2 = ap_const_lv7_37)) and not((op_code_val_read_read_fu_110_p2 = ap_const_lv7_17))))) then 
            ap_phi_mux_phi_ln371_phi_fu_119_p68 <= ap_const_lv1_0;
        else 
            ap_phi_mux_phi_ln371_phi_fu_119_p68 <= "X";
        end if; 
    end process;

    ap_ready <= ap_const_logic_1;
    ap_return_0 <= ap_phi_mux_phi_ln371_1_phi_fu_226_p68;
    ap_return_1 <= ap_phi_mux_phi_ln371_phi_fu_119_p68;
    ashr_ln256_fu_567_p2 <= std_logic_vector(shift_right(signed(source1_val),to_integer(unsigned('0' & zext_ln256_fu_563_p1(31-1 downto 0)))));
    ashr_ln328_fu_359_p2 <= std_logic_vector(shift_right(signed(source1_val),to_integer(unsigned('0' & zext_ln328_fu_355_p1(31-1 downto 0)))));
    funct3_val_read_read_fu_104_p2 <= funct3_val;
    funct7_val_read_read_fu_98_p2 <= funct7_val;
    g_error <= ap_const_lv1_1;

    g_error_ap_vld_assign_proc : process(op_code_val_read_read_fu_110_p2, funct3_val_read_read_fu_104_p2, funct7_val_read_read_fu_98_p2, icmp_ln244_fu_314_p2, icmp_ln361_fu_320_p2)
    begin
        if (((op_code_val_read_read_fu_110_p2 = ap_const_lv7_F) or ((icmp_ln244_fu_314_p2 = ap_const_lv1_0) and (funct3_val_read_read_fu_104_p2 = ap_const_lv3_1) and (op_code_val_read_read_fu_110_p2 = ap_const_lv7_33)) or ((icmp_ln244_fu_314_p2 = ap_const_lv1_0) and (funct3_val_read_read_fu_104_p2 = ap_const_lv3_1) and (op_code_val_read_read_fu_110_p2 = ap_const_lv7_13)) or ((icmp_ln244_fu_314_p2 = ap_const_lv1_0) and (funct3_val_read_read_fu_104_p2 = ap_const_lv3_2) and (op_code_val_read_read_fu_110_p2 = ap_const_lv7_33)) or ((icmp_ln244_fu_314_p2 = ap_const_lv1_0) and (funct3_val_read_read_fu_104_p2 = ap_const_lv3_3) and (op_code_val_read_read_fu_110_p2 = ap_const_lv7_33)) or ((icmp_ln244_fu_314_p2 = ap_const_lv1_0) and (funct3_val_read_read_fu_104_p2 = ap_const_lv3_4) and (op_code_val_read_read_fu_110_p2 = ap_const_lv7_33)) or ((icmp_ln244_fu_314_p2 = ap_const_lv1_0) and (funct3_val_read_read_fu_104_p2 = ap_const_lv3_6) and (op_code_val_read_read_fu_110_p2 = ap_const_lv7_33)) or ((icmp_ln244_fu_314_p2 = ap_const_lv1_0) 
    and (funct3_val_read_read_fu_104_p2 = ap_const_lv3_7) and (op_code_val_read_read_fu_110_p2 = ap_const_lv7_33)) or (not((funct7_val_read_read_fu_98_p2 = ap_const_lv7_20)) and not((funct7_val_read_read_fu_98_p2 = ap_const_lv7_0)) and (funct3_val_read_read_fu_104_p2 = ap_const_lv3_0) and (op_code_val_read_read_fu_110_p2 = ap_const_lv7_33)) or (not((funct7_val_read_read_fu_98_p2 = ap_const_lv7_20)) and not((funct7_val_read_read_fu_98_p2 = ap_const_lv7_0)) and (funct3_val_read_read_fu_104_p2 = ap_const_lv3_5) and (op_code_val_read_read_fu_110_p2 = ap_const_lv7_33)) or (not((funct7_val_read_read_fu_98_p2 = ap_const_lv7_20)) and not((funct7_val_read_read_fu_98_p2 = ap_const_lv7_0)) and (funct3_val_read_read_fu_104_p2 = ap_const_lv3_5) and (op_code_val_read_read_fu_110_p2 = ap_const_lv7_13)) or (not((op_code_val_read_read_fu_110_p2 = ap_const_lv7_73)) and not((op_code_val_read_read_fu_110_p2 = ap_const_lv7_F)) and not((op_code_val_read_read_fu_110_p2 = ap_const_lv7_33)) and not((op_code_val_read_read_fu_110_p2 = ap_const_lv7_13)) 
    and not((op_code_val_read_read_fu_110_p2 = ap_const_lv7_37)) and not((op_code_val_read_read_fu_110_p2 = ap_const_lv7_17))) or ((op_code_val_read_read_fu_110_p2 = ap_const_lv7_73) and (icmp_ln361_fu_320_p2 = ap_const_lv1_0)))) then 
            g_error_ap_vld <= ap_const_logic_1;
        else 
            g_error_ap_vld <= ap_const_logic_0;
        end if; 
    end process;

    icmp_ln221_fu_541_p2 <= "1" when (signed(imm_I_val_cast_fu_310_p1) > signed(source1_val)) else "0";
    icmp_ln228_fu_530_p2 <= "1" when (unsigned(imm_I_val_cast_fu_310_p1) > unsigned(source1_val)) else "0";
    icmp_ln244_fu_314_p2 <= "1" when (funct7_val = ap_const_lv7_0) else "0";
    icmp_ln295_fu_423_p2 <= "1" when (signed(source1_val) < signed(source2_val)) else "0";
    icmp_ln306_fu_406_p2 <= "1" when (unsigned(source1_val) < unsigned(source2_val)) else "0";
    icmp_ln361_fu_320_p0 <= imm_I_val;
    icmp_ln361_fu_320_p2 <= "1" when (icmp_ln361_fu_320_p0 = ap_const_lv12_0) else "0";
    imm_I_val_cast_fu_310_p0 <= imm_I_val;
        imm_I_val_cast_fu_310_p1 <= std_logic_vector(IEEE.numeric_std.resize(signed(imm_I_val_cast_fu_310_p0),32));

    lshr_ln253_fu_582_p2 <= std_logic_vector(shift_right(unsigned(source1_val),to_integer(unsigned('0' & zext_ln253_fu_578_p1(31-1 downto 0)))));
    lshr_ln325_fu_374_p2 <= std_logic_vector(shift_right(unsigned(source1_val),to_integer(unsigned('0' & zext_ln325_fu_370_p1(31-1 downto 0)))));
    op_code_val_read_read_fu_110_p2 <= op_code_val;
    or_ln238_fu_516_p2 <= (source1_val or imm_I_val_cast_fu_310_p1);
    or_ln338_fu_344_p2 <= (source2_val or source1_val);
    shl_ln245_fu_502_p2 <= std_logic_vector(shift_left(unsigned(source1_val),to_integer(unsigned('0' & zext_ln245_fu_498_p1(31-1 downto 0)))));
    shl_ln288_fu_448_p2 <= std_logic_vector(shift_left(unsigned(source1_val),to_integer(unsigned('0' & zext_ln288_fu_444_p1(31-1 downto 0)))));
    sub_ln279_fu_455_p2 <= std_logic_vector(unsigned(source1_val) - unsigned(source2_val));
    trunc_ln245_fu_494_p0 <= imm_I_val;
    trunc_ln245_fu_494_p1 <= trunc_ln245_fu_494_p0(5 - 1 downto 0);
    trunc_ln253_fu_574_p0 <= imm_I_val;
    trunc_ln253_fu_574_p1 <= trunc_ln253_fu_574_p0(5 - 1 downto 0);
    trunc_ln256_fu_559_p0 <= imm_I_val;
    trunc_ln256_fu_559_p1 <= trunc_ln256_fu_559_p0(5 - 1 downto 0);
    trunc_ln288_fu_440_p1 <= source2_val(5 - 1 downto 0);
    trunc_ln325_fu_366_p1 <= source2_val(5 - 1 downto 0);
    trunc_ln328_fu_351_p1 <= source2_val(5 - 1 downto 0);
    xor_ln235_fu_523_p2 <= (source1_val xor imm_I_val_cast_fu_310_p1);
    xor_ln317_fu_393_p2 <= (source2_val xor source1_val);
    zext_ln221_fu_547_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(icmp_ln221_fu_541_p2),32));
    zext_ln228_fu_536_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(icmp_ln228_fu_530_p2),32));
    zext_ln245_fu_498_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(trunc_ln245_fu_494_p1),32));
    zext_ln253_fu_578_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(trunc_ln253_fu_574_p1),32));
    zext_ln256_fu_563_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(trunc_ln256_fu_559_p1),32));
    zext_ln288_fu_444_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(trunc_ln288_fu_440_p1),32));
    zext_ln295_fu_429_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(icmp_ln295_fu_423_p2),32));
    zext_ln306_fu_412_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(icmp_ln306_fu_406_p2),32));
    zext_ln325_fu_370_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(trunc_ln325_fu_366_p1),32));
    zext_ln328_fu_355_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(trunc_ln328_fu_351_p1),32));
end behav;
