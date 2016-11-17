----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:38:07 05/23/2016 
-- Design Name: 
-- Module Name:    fulladderstructural - Structural 
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

entity fulladderstructural is
    Port ( P : in  STD_LOGIC;
           Q : in  STD_LOGIC;
           Cin : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           Cout : inout  STD_LOGIC;
           Sum : inout  STD_LOGIC;
			  added_ack : out std_logic);
end fulladderstructural;

architecture Structural of fulladderstructural is

component xorwithclk is
Port ( A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           C : out  STD_LOGIC);
end component xorwithclk;

component andwithclk is
    Port ( A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           C : out  STD_LOGIC);
end component andwithclk;

component orwithclk is
    Port ( A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           C : out  STD_LOGIC);
end component orwithclk;

Signal S1,S2,S3:STD_LOGIC;

begin

	process(P,Q,Cin,clk)
		begin
			if(Cout='1' or Sum='1' or (Cout='0' and Sum='0') ) then
				added_ack <='1';
			end if;
		end process;


XOR_1 : xorwithclk
Port map( A => P,
				B=>Q,
				clk => clk,
				C => S1);

XOR_2 : xorwithclk
Port map( A => S1,
				B=>Cin,
				clk => clk,
				C => Sum);

AND_1 : andwithclk
Port map(A=>P,
			B=> Q,
			clk=> clk,
			C=>S2);

AND_2 : andwithclk
Port map(A=>S1,
			B=> Cin,
			clk=> clk,
			C=>S3);

OR_1 : orwithclk
Port map(A =>S2,
			B=> S3,
			clk=>clk,
			C => Cout);
			
end Structural;

