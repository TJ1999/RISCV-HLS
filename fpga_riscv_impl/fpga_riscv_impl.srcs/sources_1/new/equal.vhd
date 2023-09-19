----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.09.2023 17:11:14
-- Design Name: 
-- Module Name: equal - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity equal is
  port (
    a : in std_logic_vector(31 downto 0); -- first input
    b : in std_logic_vector(31 downto 0); -- second input
    clk : in std_logic;
    rst: in std_logic;
    z : out std_logic -- output
    
  );
end;

architecture behavior of equal is

signal out_temp : std_logic := '0';

begin
  process (clk)
  begin
    if rising_edge(clk) then
      if (rst = '1') then
        out_temp <= '0';
      elsif (a = b) then
        out_temp <= '1';
      end if;
    end if;
  end process;
  z <= out_temp;
end;
