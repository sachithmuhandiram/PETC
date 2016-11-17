----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:37:24 05/23/2016 
-- Design Name: 
-- Module Name:    eightbitadder - Structural 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sixteenbitadder is
    Port ( P : in  STD_LOGIC_VECTOR(15 DOWNTO 0);
           Q : in  STD_LOGIC_VECTOR(15 DOWNTO 0);
           Cin : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           Cout : inout  STD_LOGIC;	
           Sum : inout  STD_LOGIC_VECTOR(15 DOWNTO 0);	
				adder_ack : out std_logic);
end sixteenbitadder;

architecture Structural of sixteenbitadder is

component fulladderstructural is
    Port ( P : in  STD_LOGIC;
           Q : in  STD_LOGIC;
           Cin : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           Cout : inout  STD_LOGIC;
           Sum : inout  STD_LOGIC;
			  added_ack : out std_logic);
end component fulladderstructural;

Signal S : STD_LOGIC_VECTOR(15 DOWNTO 0);
Signal added_ack : std_logic_vector (15 downto 0);
begin
	
	process(P,Q,Cin,clk)
		begin
			
			if(added_ack(0)='1' and added_ack(1)='1' and added_ack(2)='1' and added_ack(3)='1' and added_ack(4)='1' and added_ack(5)='1' and added_ack(6)='1' and added_ack(7)='1' and added_ack(8)='1' and added_ack(9)='1' and added_ack(10)='1' and added_ack(11)='1' and added_ack(12)='1' and added_ack(13)='1' and added_ack(14)='1' and added_ack(15)='1') then
				adder_ack <='1';
			end if;
		end process;

adder_1 : fulladderstructural
Port map( P => P(0),
				Q=>Q(0),
				Cin => Cin,
				clk => clk,
				Sum => Sum(0),
				Cout => S(0),
				added_ack => added_ack(0));
				
adder_2 : fulladderstructural
Port map( P => P(1),
				Q=>Q(1),
				Cin => S(0),
				clk => clk,
				Sum => Sum(1),
				Cout => S(1),
				added_ack => added_ack(1));

adder_3 : fulladderstructural
Port map( P => P(2),
				Q=>Q(2),
				Cin => S(1),
				clk => clk,
				Sum => Sum(2),
				Cout => S(2),
				added_ack => added_ack(2));
				
adder_4 : fulladderstructural
Port map( P => P(3),
				Q=>Q(3),
				Cin => S(2),
				clk => clk,
				Sum => Sum(3),
				Cout => S(3),
				added_ack => added_ack(3));

adder_5 : fulladderstructural
Port map( P => P(4),
				Q=>Q(4),
				Cin => S(3),
				clk => clk,
				Sum => Sum(4),
				Cout => S(4),
				added_ack => added_ack(4));

adder_6 : fulladderstructural
Port map( P => P(5),
				Q=>Q(5),
				Cin => S(4),
				clk => clk,
				Sum => Sum(5),
				Cout => S(5),
				added_ack => added_ack(5));

adder_7 : fulladderstructural
Port map( P => P(6),
				Q=>Q(6),
				Cin => S(5),
				clk => clk,
				Sum => Sum(6),
				Cout => S(6),
				added_ack => added_ack(6));

adder_8 : fulladderstructural
Port map( P => P(7),
				Q=>Q(7),
				Cin => S(6),
				clk => clk,
				Sum => Sum(7),
				Cout => S(7),
				added_ack => added_ack(7));

adder_9 : fulladderstructural
Port map( P => P(8),
				Q=>Q(8),
				Cin => S(7),
				clk => clk,
				Sum => Sum(8),
				Cout => S(8),
				added_ack => added_ack(8));

adder_10 : fulladderstructural
Port map( P => P(9),
				Q=>Q(9),
				Cin => S(7),
				clk => clk,
				Sum => Sum(9),
				Cout => S(9),
				added_ack => added_ack(9));

adder_11 : fulladderstructural
Port map( P => P(10),
				Q=>Q(10),
				Cin => S(8),
				clk => clk,
				Sum => Sum(10),
				Cout => S(10),
				added_ack => added_ack(10));

adder_12 : fulladderstructural
Port map( P => P(11),
				Q=>Q(11),
				Cin => S(9),
				clk => clk,
				Sum => Sum(11),
				Cout => S(11),
				added_ack => added_ack(11));

adder_13 : fulladderstructural
Port map( P => P(12),
				Q=>Q(12),
				Cin => S(10),
				clk => clk,
				Sum => Sum(12),
				Cout => S(12),
				added_ack => added_ack(12));

adder_14 : fulladderstructural
Port map( P => P(13),
				Q=>Q(13),
				Cin => S(11),
				clk => clk,
				Sum => Sum(13),
				Cout => S(13),
				added_ack => added_ack(13));				
				
adder_15 : fulladderstructural
Port map( P => P(14),
				Q=>Q(14),
				Cin => S(12),
				clk => clk,
				Sum => Sum(14),
				Cout => S(14),
				added_ack => added_ack(14));

adder_16 : fulladderstructural
Port map( P => P(15),
				Q=>Q(15),
				Cin => S(13),
				clk => clk,
				Sum => Sum(15),
				Cout => S(15),
				added_ack => added_ack(15));
end Structural;

