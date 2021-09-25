----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.08.2021 19:07:39
-- Design Name: 
-- Module Name: divider - Behavioral
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
use ieee.std_logic_unsigned.all; 
use ieee.numeric_std.all;
--use IEEE.MATH_REAL.ALL;





entity divider is
port(B: in std_logic_vector(31 downto 0);
clk:in std_logic;
result:out std_logic_vector(31 downto 0));

end divider;


architecture RTL of divider is
signal temp: std_logic_vector( 31 downto 0):="01000011000110111101111010000010";
begin
 

Result <= std_logic_vector(unsigned(temp) / unsigned(B));
end RTL;

