----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:17:42 09/24/2016 
-- Design Name: 
-- Module Name:    Register_Y - Behavioral 
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

entity Register_Y is
    Port ( data_in_Y : in  STD_LOGIC_VECTOR (15 downto 0);
           clk : in  STD_LOGIC;
           w_enable_y : in  STD_LOGIC;
			  reset : in  STD_LOGIC;
           data_out_Y : out  STD_LOGIC_VECTOR (15 downto 0));
end Register_Y;

architecture Behavioral of Register_Y is

Signal S1 : STD_LOGIC_VECTOR(15 DOWNTO 0);

begin

process(w_enable_y,clk,reset)
	begin
	if(reset='1') then
		data_out_Y <= "0000000000000000";
		S1 <= "0000000000000000";
	elsif(clk='1' and clk'event) then
		if(w_enable_y ='1') then
			S1 <= data_in_Y;
		else
			data_out_Y <= S1;
		end if;
	end if;
end process;

end Behavioral;


