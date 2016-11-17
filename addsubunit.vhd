----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:16:13 05/23/2016 
-- Design Name: 
-- Module Name:    addsubunit - Structural 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity addsubunit is
    Port ( X : in  STD_LOGIC_VECTOR(15 DOWNTO 0);
           Y : in  STD_LOGIC_VECTOR(15 DOWNTO 0);
           Cin : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           Outmain : inout  STD_LOGIC_VECTOR(15 DOWNTO 0); --sum
           Outsecondary : inout  STD_LOGIC; --carry
			  addsub_ack : out std_logic);  --addsub ack
end addsubunit;

architecture Structural of addsubunit is

--components of addsub unit
component sixteenbitadder is
   Port ( P : in  STD_LOGIC_VECTOR(15 DOWNTO 0);
           Q : in  STD_LOGIC_VECTOR(15 DOWNTO 0);
           Cin : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           Cout : inout  STD_LOGIC;	
           Sum : inout  STD_LOGIC_VECTOR(15 DOWNTO 0);	
				adder_ack : out std_logic);
end component sixteenbitadder;

component mux2to1 is
    Port ( A : in  STD_LOGIC_VECTOR(15 DOWNTO 0);
           B : in  STD_LOGIC_VECTOR(15 DOWNTO 0);
           clk : in  STD_LOGIC;
           S : in  STD_LOGIC;
           C : out  STD_LOGIC_VECTOR(15 DOWNTO 0));
end component mux2to1;

component notgate is
    Port ( A : in  STD_LOGIC_VECTOR(15 DOWNTO 0);
           clk : in  STD_LOGIC;
           Z : out  STD_LOGIC_VECTOR(15 DOWNTO 0));
end component notgate;

--signals of addsub unit
Signal S0,S1: STD_LOGIC_VECTOR(15 DOWNTO 0);

--behaviour modeling of addsub unit
begin

--adder port mapping
ADDER_SIXTEEN: sixteenbitadder 
    Port map( P => X,
           Q => S1,
           Cin => Cin,
           clk => clk,
           Sum =>  Outmain,	--sum
           Cout =>  Outsecondary,  --carry
			  adder_ack => addsub_ack);

MUX_S : mux2to1 
    Port map ( A => Y,
					B => S0,
					clk =>clk,
					S=> Cin,
					C => S1);

NOT_G : notgate 
    Port map ( A => Y,
           clk =>clk,
           Z => S0 );
end Structural;

