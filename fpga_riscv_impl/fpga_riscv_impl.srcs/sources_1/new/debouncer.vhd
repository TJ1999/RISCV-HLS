----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.09.2023 09:31:09
-- Design Name: 
-- Module Name: debouncer - Behavioral
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

entity debouncer is
    generic (
        MAX_COUNT : integer := 500000
    );
    port (
        clk : in std_logic;
        in_pin : in std_logic;
        out_pin : out std_logic
    );
end entity;

architecture behave of debouncer is
    signal count : integer range 0 to MAX_COUNT := 0;
    signal debounced_pin : std_logic := '1';
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if in_pin /= debounced_pin then
                count <= count + 1;
                if count = MAX_COUNT then
                    debounced_pin <= in_pin;
                    count <= 0;
                end if;
            else
                count <= 0;
            end if;
        end if;
    end process;

    out_pin <= debounced_pin;

end architecture;
