----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.08.2021 19:06:41
-- Design Name: 
-- Module Name: adder - Behavioral
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
library IEEE;
 use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity Adder is
   
   port
   (
      A,B : in std_logic_vector (31 downto 0);
      clk : in std_logic;  
 
      result     : out std_logic_vector(31 downto 0)); 
    
      
   
end entity Adder;


 
architecture Behavioral of Adder is
   
begin

   Result <= std_logic_vector(unsigned(A) + unsigned(B));
 
end architecture Behavioral;
