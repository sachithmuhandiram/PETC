----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:46:02 09/24/2016 
-- Design Name: 
-- Module Name:    ROM - Behavioral 
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

entity Instruction_Memory is
    Port ( rom_address : in  STD_LOGIC_VECTOR (5 downto 0);
           clk : in  STD_LOGIC;
			  reset : STD_LOGIC;	
           instruction : out  STD_LOGIC_VECTOR (13 downto 0));
end Instruction_Memory;

architecture Behavioral of Instruction_Memory is

type rom_type is array (0 to 63) of std_logic_vector(13 downto 0);
signal rom: rom_type;

begin
			--[opcode] [operand1][operand2]
			--[5-bit] [1-bit] [8-bit]
--IN:			
rom(0) <= "00001110000011";	-- ON VIU
rom(1) <= "01111000000000";	-- GET_OWN
rom(2) <= "00010100000000";	-- SEND_OWN
rom(3) <= "00011100000111";	-- SJMP 1 OUT
rom(4) <= "00011100010010";	-- SJMP 1 WARNING
rom(5) <= "01000110000011";	-- GET_TYPE
rom(6) <= "00100100000000";	-- SEND_TYPE
rom(7) <= "10001110000011";	-- GET_LOC
rom(8) <= "00101100000000";	-- SEND_LOC
rom(9) <= "01110110000011";	-- CLEAR VIU
rom(10) <= "11001100000000";	-- JMP IN

--OUT
rom(11) <= "00011100001101";	-- SJMP 1 MANUAL
rom(12) <= "00111000000000";	-- GET_FEE
rom(13) <= "10010000000000";	-- SEND_FEE
rom(14) <= "01001000000000";	-- GET_BAL
rom(15) <= "10100000000000";	-- SEND_BAL
rom(16) <= "10000000000000";	-- GET_C_TYPE
rom(17) <= "10011000000000";	-- SEND_C_TYPE
rom(18) <= "10111000000000";	-- CAL_BAL
rom(19) <= "10101000000000";	-- UPD_BAL
rom(20) <= "11001100001011";	-- JMP OUT

--MANUAL
rom(21) <= "00001111110000";	-- ON PRINTER
rom(22) <= "01100000000000";	-- UPD_SYS
rom(23) <= "01011000000000";	-- PRINT
rom(24) <= "01110111110000";	-- CLEAR PRINTER   
rom(25) <= "11001100010101";	-- JMP MANUAL

--WARNING
rom(26) <= "00001111111110"; 	-- ON POLICE UNIT
rom(27) <= "11000000000000";	-- GET_PLT
rom(28) <= "01101000000000";	-- SEND_PLT
rom(29) <= "01110000000011";	-- CLEAR VIU
rom(30) <= "01110011111110";	-- CLEAR POLICE UNIT
rom(31) <= "11001100011010";	-- JMP WARNING

process (clk,rom_address,reset)
	begin
		if (reset ='1') then
			instruction <= "00000000000000";
		elsif(clk = '1' and clk'event) then
			instruction <= rom(conv_integer(rom_address));
		end if;
end process;
			
end Behavioral;

