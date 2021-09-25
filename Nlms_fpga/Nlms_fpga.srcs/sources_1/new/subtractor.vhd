----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.08.2021 19:12:50
-- Design Name: 
-- Module Name: subtractor - Behavioral
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
 
 
entity sub is  
  port(A,B : in std_logic_vector(31 downto 0);
    clk : in std_logic;    
    result : out std_logic_vector(31 downto 0));  
end sub;  
architecture archi of sub is  
  begin  
    result <= A - B;  
        
end archi; 
