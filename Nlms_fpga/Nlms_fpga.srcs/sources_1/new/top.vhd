----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.08.2021 19:13:39
-- Design Name: 
-- Module Name: top - Behavioral
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
use ieee.std_logic_signed.all;


ENTITY NLMS_ANC IS
-- Declarations
port (
X:in std_logic_vector(31 downto 0);
ref: in std_logic_vector(31 downto 0);
test: in std_logic_vector(31 downto 0);
clk:in std_logic;
Dat: out std_logic_vector(31 downto 0));
END NLMS_ANC ;

-- hds interface_end
ARCHITECTURE NLMS1 OF NLMS_ANC IS
-- component decleration
component Mult1 port (A,B:in std_logic_vector(31 downto 0);
  clk:in std_logic ;
result:out std_logic_vector(63 downto 0));end component ;

component sb1 port (A,B:in std_logic_vector(31 downto 0);
  clk:in std_logic ;
result:out std_logic_vector(31 downto 0)); end component ;

component Mult2  port (A,B:in std_logic_vector(31 downto 0);
  clk:in std_logic ;
result:out std_logic_vector(63 downto 0)); end component ;


component Div port (A,B:in std_logic_vector(31 downto 0);
  clk:in std_logic ;
result:out std_logic_vector(31 downto 0)); end component ;

component Add port (A,B:in std_logic_vector(31 downto 0);
  clk:in std_logic ;
result:out std_logic_vector(31 downto 0)); end component ;

component sb2 port (A,B:in std_logic_vector(31 downto 0);
  clk:in std_logic ;
result:out std_logic_vector(31 downto 0)); end component ;




--configuration zone
for all: Mult1 use entity work.Multiplier(Mult1);
for all: sb1 use entity work.subtractor(sub);
for all: Mult2  use entity work.Multiplier(Mult1) ;
for all: Div use entity work.divider(divid);
for all: Add use entity work.Adder(behavioural);
for all: sb2 use entity work.subtractor(sub);


--Signals zone 
signal  W :  std_logic_vector(31 downto 0); 
--:= "00000000000000000000000000000000";
signal result1 :  std_logic_vector(63 downto 0);   
--:= "0000000000000000000000000000000000000000000000000000000000000000";
signal result2 :  std_logic_vector(31 downto 0);
--:= "00000000000000000000000000000000";
signal result3 :  std_logic_vector(63 downto 0);
--:= "0000000000000000000000000000000000000000000000000000000000000000";
signal result4 :  std_logic_vector(31 downto 0) ;
--:= "00000000000000000000000000000000";
signal result5 :  std_logic_vector(31 downto 0)  ;
--:= "00000000000000000000000000000000"; 
signal result6 :  std_logic_vector(31 downto 0)   ;
--:= "00000000000000000000000000000000";
signal y1 :  std_logic_vector(31 downto 0);
signal y2 :  std_logic_vector(31 downto 0);
BEGIN
--result2<= (others => '0');
 -- process (rst)
 -- begin 
  -- if rst ='0' then 
     --   result1<= (others => '0');
	--	w<= (others => '0');  end if;
   --else
       C1: Mult1 port map (ref,W,clk,result1);
y1<= std_logic_vector(result1(31 downto 0));
C2: sb1 port map (X,y1,clk,result2);
C3: Mult2 port map (result2,ref,clk,result3);
y2<= std_logic_vector(result3(31 downto 0));
C4: Div port map (y2,X,clk,result4);
C5: Add port map (W,result4,clk,result5);
W<= result5 ;
C6:sb2 port map (result2,test,clk,result6);
Dat<=result6;
--end if;
--end process;
END NLMS1;