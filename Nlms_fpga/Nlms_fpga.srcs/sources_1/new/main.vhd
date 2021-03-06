----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.08.2021 19:08:46
-- Design Name: 
-- Module Name: main - Behavioral
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
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all; 
use IEEE.STD_LOGIC_SIGNED.ALL;
ENTITY Gard IS
port (
X:in std_logic_vector(31 downto 0);
ref: in std_logic_vector(31 downto 0);
clk:in std_logic;
Dat: out std_logic_vector(31 downto 0));
END ENTITY Gard;

--
ARCHITECTURE project OF Gard IS
-- component decleration
component Mult1  port (A,B:in std_logic_vector(31 downto 0);
  clk:in std_logic ;
result:out std_logic_vector(63 downto 0)); end component ;

component div port (B:in std_logic_vector(31 downto 0);
  clk:in std_logic ;
result:out std_logic_vector(31 downto 0)); end component ;

component Mult2 port (A,B:in std_logic_vector(31 downto 0);
  clk:in std_logic ;
result:out std_logic_vector(63 downto 0));end component ;

component sb port (A,B:in std_logic_vector(31 downto 0);
  clk:in std_logic ;
result:out std_logic_vector(31 downto 0)); end component ;

component Add port (A,B:in std_logic_vector(31 downto 0);
  clk:in std_logic ;
result:out std_logic_vector(31 downto 0)); end component ;

component Mult3  port (A,B:in std_logic_vector(31 downto 0);
  clk:in std_logic ;
result:out std_logic_vector(63 downto 0)); end component ;

component Mult4  port (A,B:in std_logic_vector(31 downto 0);
  clk:in std_logic ;
result:out std_logic_vector(63 downto 0)); end component ;

--configuration zone
for all: Mult1  use entity work.Multiplier_VHDL(Behavioral);
for all: div use entity work.divider(RTL);
for all: Mult2 use entity work.Multiplier_VHDL(Behavioral);
for all: sb use entity work.sub(archi);
for all: Add use entity work.Adder(behavioral);
for all: Mult3  use entity work.Multiplier_VHDL(Behavioral) ;
for all: Mult4 use entity work.Multiplier_VHDL(Behavioral);

--Signals zone 
signal result1 :  std_logic_vector(63 downto 0);
signal result2 :  std_logic_vector(31 downto 0)
:= "00000000000000000000000000000001";
signal result3 :  std_logic_vector(31 downto 0);
signal result4 :  std_logic_vector(63 downto 0); 
signal result5 :  std_logic_vector(31 downto 0); 
signal result6 :  std_logic_vector(31 downto 0); 
signal result7 :  std_logic_vector(63 downto 0); 
signal result8 :  std_logic_vector(63 downto 0);
signal y1 :  std_logic_vector(31 downto 0);
signal y2 :  std_logic_vector(31 downto 0);
signal y3 :  std_logic_vector(31 downto 0);
BEGIN
C1: Mult1 port map (X,X,clk,result1);
y1<= std_logic_vector(result1(63 downto 32));
C2: div port map (y1,clk,result3);
--C3: Mult2 port map (ref,result2,clk,result4);
--y2<= std_logic_vector(result4(63 downto 32));
--C4: sb port map (X,y2,clk,result5);
C4: sb port map (X,ref,clk,result5);
C5: Add port map (result2,result3,clk,result6);
C6: Mult3 port map (result6,result5,clk,result7);
y3<= std_logic_vector(result7(63 downto 32));
C7: Mult4 port map (y3,ref,clk,result8);
Dat<= std_logic_vector(result8(63 downto 32));
END ARCHITECTURE project;
