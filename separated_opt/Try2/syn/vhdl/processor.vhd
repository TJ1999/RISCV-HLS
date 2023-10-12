-- ==============================================================
-- Generated by Vitis HLS v2023.1.1
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
-- ==============================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity processor is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    memory_address0 : OUT STD_LOGIC_VECTOR (16 downto 0);
    memory_ce0 : OUT STD_LOGIC;
    memory_we0 : OUT STD_LOGIC;
    memory_d0 : OUT STD_LOGIC_VECTOR (31 downto 0);
    memory_q0 : IN STD_LOGIC_VECTOR (31 downto 0);
    error : OUT STD_LOGIC_VECTOR (0 downto 0) );
end;


architecture behav of processor is 
    attribute CORE_GENERATION_INFO : STRING;
    attribute CORE_GENERATION_INFO of behav : architecture is
    "processor_processor,hls_ip_2023_1_1,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=0,HLS_INPUT_PART=xc7a100t-csg324-1,HLS_INPUT_CLOCK=20.000000,HLS_INPUT_ARCH=others,HLS_SYN_CLOCK=10.400571,HLS_SYN_LAT=-1,HLS_SYN_TPT=none,HLS_SYN_MEM=2,HLS_SYN_DSP=0,HLS_SYN_FF=314,HLS_SYN_LUT=2133,HLS_VERSION=2023_1_1}";
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_state1 : STD_LOGIC_VECTOR (4 downto 0) := "00001";
    constant ap_ST_fsm_pp0_stage0 : STD_LOGIC_VECTOR (4 downto 0) := "00010";
    constant ap_ST_fsm_pp0_stage1 : STD_LOGIC_VECTOR (4 downto 0) := "00100";
    constant ap_ST_fsm_pp0_stage2 : STD_LOGIC_VECTOR (4 downto 0) := "01000";
    constant ap_ST_fsm_pp0_stage3 : STD_LOGIC_VECTOR (4 downto 0) := "10000";
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_boolean_0 : BOOLEAN := false;
    constant ap_const_lv32_4 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000100";
    constant ap_const_lv32_1 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000001";
    constant ap_const_lv32_2 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000010";
    constant ap_const_lv32_3 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000011";

    signal ap_enable_reg_pp0_iter0 : STD_LOGIC := '0';
    signal ap_CS_fsm : STD_LOGIC_VECTOR (4 downto 0) := "00001";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_state1 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state1 : signal is "none";
    signal ap_enable_reg_pp0_iter1 : STD_LOGIC := '0';
    signal ap_block_state5_pp0_stage3_iter0 : BOOLEAN;
    signal ap_block_pp0_stage3_subdone : BOOLEAN;
    signal ap_CS_fsm_pp0_stage3 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_pp0_stage3 : signal is "none";
    signal grp_do_process_fu_55_ap_start : STD_LOGIC;
    signal grp_do_process_fu_55_ap_done : STD_LOGIC;
    signal grp_do_process_fu_55_ap_idle : STD_LOGIC;
    signal grp_do_process_fu_55_ap_ready : STD_LOGIC;
    signal grp_do_process_fu_55_memory_address0 : STD_LOGIC_VECTOR (16 downto 0);
    signal grp_do_process_fu_55_memory_ce0 : STD_LOGIC;
    signal grp_do_process_fu_55_memory_we0 : STD_LOGIC;
    signal grp_do_process_fu_55_memory_d0 : STD_LOGIC_VECTOR (31 downto 0);
    signal grp_do_process_fu_55_ap_return : STD_LOGIC_VECTOR (0 downto 0);
    signal grp_do_process_fu_55_ap_start_reg : STD_LOGIC := '0';
    signal ap_CS_fsm_pp0_stage0 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_pp0_stage0 : signal is "none";
    signal ap_block_state2_pp0_stage0_iter0 : BOOLEAN;
    signal ap_block_state6_pp0_stage0_iter1 : BOOLEAN;
    signal ap_block_pp0_stage0_11001 : BOOLEAN;
    signal ap_CS_fsm_pp0_stage1 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_pp0_stage1 : signal is "none";
    signal ap_block_pp0_stage1 : BOOLEAN;
    signal ap_CS_fsm_pp0_stage2 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_pp0_stage2 : signal is "none";
    signal ap_block_pp0_stage2 : BOOLEAN;
    signal ap_block_pp0_stage3 : BOOLEAN;
    signal ap_block_pp0_stage0 : BOOLEAN;
    signal ap_block_state3_pp0_stage1_iter0 : BOOLEAN;
    signal ap_block_pp0_stage1_11001 : BOOLEAN;
    signal ap_block_pp0_stage3_11001 : BOOLEAN;
    signal ap_block_pp0_stage0_01001 : BOOLEAN;
    signal ap_NS_fsm : STD_LOGIC_VECTOR (4 downto 0);
    signal ap_ST_fsm_state1_blk : STD_LOGIC;
    signal ap_block_pp0_stage0_subdone : BOOLEAN;
    signal ap_block_pp0_stage1_subdone : BOOLEAN;
    signal ap_block_state4_pp0_stage2_iter0 : BOOLEAN;
    signal ap_block_pp0_stage2_subdone : BOOLEAN;
    signal ap_block_pp0_stage2_11001 : BOOLEAN;
    signal ap_idle_pp0 : STD_LOGIC;
    signal ap_enable_pp0 : STD_LOGIC;
    signal ap_ce_reg : STD_LOGIC;

    component processor_do_process IS
    port (
        ap_clk : IN STD_LOGIC;
        ap_rst : IN STD_LOGIC;
        ap_start : IN STD_LOGIC;
        ap_done : OUT STD_LOGIC;
        ap_idle : OUT STD_LOGIC;
        ap_ready : OUT STD_LOGIC;
        memory_address0 : OUT STD_LOGIC_VECTOR (16 downto 0);
        memory_ce0 : OUT STD_LOGIC;
        memory_we0 : OUT STD_LOGIC;
        memory_d0 : OUT STD_LOGIC_VECTOR (31 downto 0);
        memory_q0 : IN STD_LOGIC_VECTOR (31 downto 0);
        ap_return : OUT STD_LOGIC_VECTOR (0 downto 0) );
    end component;



begin
    grp_do_process_fu_55 : component processor_do_process
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst,
        ap_start => grp_do_process_fu_55_ap_start,
        ap_done => grp_do_process_fu_55_ap_done,
        ap_idle => grp_do_process_fu_55_ap_idle,
        ap_ready => grp_do_process_fu_55_ap_ready,
        memory_address0 => grp_do_process_fu_55_memory_address0,
        memory_ce0 => grp_do_process_fu_55_memory_ce0,
        memory_we0 => grp_do_process_fu_55_memory_we0,
        memory_d0 => grp_do_process_fu_55_memory_d0,
        memory_q0 => memory_q0,
        ap_return => grp_do_process_fu_55_ap_return);





    ap_CS_fsm_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_CS_fsm <= ap_ST_fsm_state1;
            else
                ap_CS_fsm <= ap_NS_fsm;
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter0_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter0 <= ap_const_logic_0;
            else
                if ((ap_const_logic_1 = ap_CS_fsm_state1)) then 
                    ap_enable_reg_pp0_iter0 <= ap_const_logic_1;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter1_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter1 <= ap_const_logic_0;
            else
                if (((ap_const_boolean_0 = ap_block_pp0_stage3_subdone) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage3))) then 
                    ap_enable_reg_pp0_iter1 <= ap_enable_reg_pp0_iter0;
                elsif ((ap_const_logic_1 = ap_CS_fsm_state1)) then 
                    ap_enable_reg_pp0_iter1 <= ap_const_logic_0;
                end if; 
            end if;
        end if;
    end process;


    grp_do_process_fu_55_ap_start_reg_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                grp_do_process_fu_55_ap_start_reg <= ap_const_logic_0;
            else
                if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1))) then 
                    grp_do_process_fu_55_ap_start_reg <= ap_const_logic_1;
                elsif ((grp_do_process_fu_55_ap_ready = ap_const_logic_1)) then 
                    grp_do_process_fu_55_ap_start_reg <= ap_const_logic_0;
                end if; 
            end if;
        end if;
    end process;


    ap_NS_fsm_assign_proc : process (ap_CS_fsm, ap_block_pp0_stage3_subdone, ap_block_pp0_stage0_subdone, ap_block_pp0_stage1_subdone, ap_block_pp0_stage2_subdone)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_state1 => 
                ap_NS_fsm <= ap_ST_fsm_pp0_stage0;
            when ap_ST_fsm_pp0_stage0 => 
                if ((ap_const_boolean_0 = ap_block_pp0_stage0_subdone)) then
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage1;
                else
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage0;
                end if;
            when ap_ST_fsm_pp0_stage1 => 
                if ((ap_const_boolean_0 = ap_block_pp0_stage1_subdone)) then
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage2;
                else
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage1;
                end if;
            when ap_ST_fsm_pp0_stage2 => 
                if ((ap_const_boolean_0 = ap_block_pp0_stage2_subdone)) then
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage3;
                else
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage2;
                end if;
            when ap_ST_fsm_pp0_stage3 => 
                if ((ap_const_boolean_0 = ap_block_pp0_stage3_subdone)) then
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage0;
                else
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage3;
                end if;
            when others =>  
                ap_NS_fsm <= "XXXXX";
        end case;
    end process;
    ap_CS_fsm_pp0_stage0 <= ap_CS_fsm(1);
    ap_CS_fsm_pp0_stage1 <= ap_CS_fsm(2);
    ap_CS_fsm_pp0_stage2 <= ap_CS_fsm(3);
    ap_CS_fsm_pp0_stage3 <= ap_CS_fsm(4);
    ap_CS_fsm_state1 <= ap_CS_fsm(0);
    ap_ST_fsm_state1_blk <= ap_const_logic_0;
        ap_block_pp0_stage0 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage0_01001 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage0_11001 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage0_subdone <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage1 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage1_11001 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage1_subdone <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage2 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage2_11001 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage2_subdone <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage3 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage3_11001 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_pp0_stage3_subdone <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state2_pp0_stage0_iter0 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state3_pp0_stage1_iter0 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state4_pp0_stage2_iter0 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state5_pp0_stage3_iter0 <= not((ap_const_boolean_1 = ap_const_boolean_1));
        ap_block_state6_pp0_stage0_iter1 <= not((ap_const_boolean_1 = ap_const_boolean_1));
    ap_enable_pp0 <= (ap_idle_pp0 xor ap_const_logic_1);

    ap_idle_pp0_assign_proc : process(ap_enable_reg_pp0_iter0, ap_enable_reg_pp0_iter1)
    begin
        if (((ap_enable_reg_pp0_iter1 = ap_const_logic_0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_0))) then 
            ap_idle_pp0 <= ap_const_logic_1;
        else 
            ap_idle_pp0 <= ap_const_logic_0;
        end if; 
    end process;

    error <= grp_do_process_fu_55_ap_return;
    grp_do_process_fu_55_ap_start <= grp_do_process_fu_55_ap_start_reg;
    memory_address0 <= grp_do_process_fu_55_memory_address0;
    memory_ce0 <= grp_do_process_fu_55_memory_ce0;
    memory_d0 <= grp_do_process_fu_55_memory_d0;
    memory_we0 <= grp_do_process_fu_55_memory_we0;
end behav;
