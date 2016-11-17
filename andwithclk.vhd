----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:29:12 05/23/2016 
-- Design Name: 
-- Module Name:    andwithclk - Behavioral 
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

entity andwithclk is
    Port ( A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           C : out  STD_LOGIC);
end andwithclk;

architecture Behavioral of andwithclk is
begin
	process(A,B,clk)
		begin

			if clk'event and clk='1' then
			 C <= A and B;
			end if;
	end process;

end Behavioral;

