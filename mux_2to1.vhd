----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:52:56 05/23/2016 
-- Design Name: 
-- Module Name:    mux2to1 - Behavioral 
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

entity mux2to1 is
    Port ( A : in STD_LOGIC_VECTOR(15 DOWNTO 0);
           B : in  STD_LOGIC_VECTOR(15 DOWNTO 0);
           clk : in  STD_LOGIC;
           S : in  STD_LOGIC;
           C : out  STD_LOGIC_VECTOR(15 DOWNTO 0));
end mux2to1;

architecture Behavioral of mux2to1 is

begin
process (A,B,clk,S)
	begin

		if clk'event and clk='1' then

		if S='0' then
		C <= A;
		else C <=B;
		end if;	--mux if statement

		end if;	--process clock event if
	end process;

end Behavioral;

