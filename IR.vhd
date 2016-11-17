----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:36:28 09/24/2016 
-- Design Name: 
-- Module Name:    Instruction_register - Behavioral 
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

entity Instruction_register is
    Port ( rom_data : in  STD_LOGIC_VECTOR(13 DOWNTO 0);
           w_enable : in  STD_LOGIC;
           clk : in  STD_LOGIC;
			  reset : in  STD_LOGIC;
           opcode : out  STD_LOGIC_VECTOR(4 DOWNTO 0);
           operand1 : out  STD_LOGIC;
			  operand2 :out STD_LOGIC_VECTOR(7 DOWNTO 0) );
end Instruction_register;

architecture Behavioral of Instruction_register is

signal S1: STD_LOGIC_VECTOR (13 downto 0) := "00000000000000";

begin

process(w_enable,clk,rom_data,S1,reset)

	variable pc_adrs : integer;
	variable upd : boolean :=true;
	
	begin
		if (reset ='1') then -- if reset is pressed
			opcode <= "00000";
			operand1 <= '0';
			operand2 <= "00000000";
		elsif (clk='1' and clk'event) then
					
			if(w_enable = '1') then
				S1 <= rom_data;
			end if;
					
				opcode <= S1(13 downto 9);		-- first 5bits are selected as opcode (MSB)
				operand1 <= S1 (8);				-- operand 1 is selected
				operand2 <= S1 (7 downto 0);	-- operand 2	
		end if;
end process;

end Behavioral;

