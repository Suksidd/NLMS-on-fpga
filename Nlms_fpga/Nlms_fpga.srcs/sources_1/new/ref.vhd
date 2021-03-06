----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.08.2021 19:14:35
-- Design Name: 
-- Module Name: ref - Behavioral
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
USE ieee.std_logic_arith.all;
USE ieee.numeric_std.all; 
use IEEE.STD_LOGIC_SIGNED.ALL;

ENTITY adaptivefilter IS
  port (
afi: in std_logic_vector(31 downto 0);
bfi: in std_logic_vector(31 downto 0);
mu2: in std_logic_vector(31 downto 0);
ndfi: in std_logic;
rfdfi: out std_logic;
clk: in std_logic;
resultfi: out std_logic_vector(31 downto 0);
rdyfi: out std_logic);
END ENTITY adaptivefilter;

--
ARCHITECTURE Behavioral OF adaptivefilter IS
signal xin0 : std_logic_vector(31 downto 0)
:= "11000000000000000000000000000000";
signal xin1 : std_logic_vector(31 downto 0)
:= "11000000000000000000000000000000";
signal wt0 : std_logic_vector(31 downto 0)
:= "11000000000000000000000000000000";
signal wt1 : std_logic_vector(31 downto 0)
:= "11000000000000000000000000000000";
signal rfdmul0,rfdmul1,rfdmul2,rfdmul3,rfdmul4,rfdad0,rfdad1,
rfdad2,rfdsub0:std_logic:='1';
signal resultad0,resultad1,resultad2,resultmul0,resultmul1,
resultmul2,resultmul3,resultmul4,
resultsub0 : std_logic_vector(31 downto 0)
:= "11000000000000000000000000000000";
signal ndfi2,ndad,ndsub0,rdymul0,rdymul1,rdymul2,
rdymul3,rdymul4,rdyad0,rdyad1,rdyad2,rdysub0:std_logic:='0';
component fadder
port (
a: in std_logic_vector(31 downto 0);
b: in std_logic_vector(31 downto 0);
operation: in std_logic_vector(5 downto 0);
operation_nd: in std_logic;
operation_rfd: out std_logic;
clk: in std_logic;
result: out std_logic_vector(31 downto 0);

rdy: out std_logic);
end component;
component fmultiplier
port (
a: in std_logic_vector(31 downto 0);
b: in std_logic_vector(31 downto 0);
operation_nd: in std_logic;
operation_rfd: out std_logic;
clk: in std_logic;
result: out std_logic_vector(31 downto 0);
rdy: out std_logic);
end component;
begin
mul0: fmultiplier port map(xin0,wt0,ndfi2,rfdmul0,
clk,resultmul0,rdymul0);
mul1: fmultiplier port map(xin1,wt1,ndfi2,
rfdmul1,clk,resultmul1,rdymul1);
ndad<=rdymul0;
add0: fadder port map (resultmul0,resultmul1,
"000000",ndad,rfdad0,clk,resultad0,rdyad0);
sub: fadder port map (bfi,resultad0,
"000001",rdyad0,rfdsub0,clk,resultsub0,rdysub0);

mul2: fmultiplier port map(mu2,resultsub0,
rdysub0,rfdmul2,clk,resultmul2,rdymul2);
mul3: fmultiplier port map(resultmul2,xin0,
rdymul2,rfdmul3,clk,resultmul3,rdymul3);
mul4: fmultiplier port map(resultmul2,xin1,
rdymul2,rfdmul4,clk,resultmul4,rdymul4);
add1: fadder port map (wt0,resultmul3,"000000",
rdymul4,rfdad1,clk,resultad1,rdyad1);
add2: fadder port map (wt1,resultmul4,"000000",
rdymul4,rfdad2,clk,resultad2,rdyad2);
resultfi<=resultad0;
rdyfi<=rdyad2;--last ready output
rfdfi<=rdyad0;--last ready for data;not giving;
process( ndfi)
begin
ndfi2<=ndfi;
end process;
READ_NET: process
begin
wait until ndfi = '1';
xin1<=xin0;
xin0<=afi;
end process READ_NET;
READ_wt: process
Begin
wait until rdyad2= '1';
wt0<=resultad1;
wt1<=resultad2;
end process READ_wt;
END ARCHITECTURE Behavioral;
