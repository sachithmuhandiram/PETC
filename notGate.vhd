----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:48:19 05/23/2016 
-- Design Name: 
-- Module Name:    notgate - Behavioral 
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

entity notgate is
    Port ( A : in  STD_LOGIC_VECTOR (15 DOWNTO 0);
           clk : in  STD_LOGIC;
           Z : out  STD_LOGIC_VECTOR (15 DOWNTO 0));
end notgate;

architecture Behavioral of notgate is

begin
process (A,clk)
begin

if clk'event and clk='1' then
Z(15 DOWNTO 0) <= not A(15 DOWNTO 0);

end if;

end process;
end Behavioral;

