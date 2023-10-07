library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb is
end tb;

architecture behavior of tb is
   -- Inputs
   signal i_clk : std_logic := '0';
   signal i_reset : std_logic := '0';

    -- Outputs
   signal o_done : STD_LOGIC_VECTOR ( 0 to 0 );
   signal o_start : STD_LOGIC_VECTOR ( 0 to 0 );
   signal o_error : STD_LOGIC_VECTOR ( 0 to 0 );
   
   signal o_IO39 : STD_LOGIC;
   signal o_IO40 : STD_LOGIC;
   signal o_IO41 : STD_LOGIC;
   signal o_LED0 : STD_LOGIC;

   -- Clock period definitions 100Mhz
   constant clk_period : time := 10 ns;

begin
	-- Instantiate the Unit Under Test (UUT)
   dut: entity work.top_wrapper(STRUCTURE) port map (
          CLK_100Mhz => i_clk,
          DONE => o_done,
          ERROR => o_error,
          IO39 => o_IO39,
          IO40 => o_IO40,
          IO41 => o_IO41,
          LED0 => o_LED0,
          RESET => i_reset,
          START => o_start
        );

	-- Clock process definitions
   process
   begin
		for i in 0 to 10000 loop
		  i_clk <= '1';
		  wait for clk_period / 2;
		  i_clk <= '0';
		  wait for clk_period / 2;
		end loop;
		wait;
   end process;
  
end behavior;