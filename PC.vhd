----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:11:57 09/24/2016 
-- Design Name: 
-- Module Name:    Program_Counter - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Program_Counter is
    Port ( address : in  STD_LOGIC_VECTOR (5 downto 0);
           w_enable : in  STD_LOGIC;
           increment : in  STD_LOGIC;
           clk : in  STD_LOGIC;
			  reset : in  STD_LOGIC;
           address_out : out  STD_LOGIC_VECTOR (5 downto 0));
end Program_Counter;

architecture Behavioral of Program_Counter is

signal S1 : STD_LOGIC_VECTOR(5 DOWNTO 0) :="000000";

begin
	process(address,w_enable,clk,S1,increment,reset)

	variable pc_adrs : integer;
	variable upd : boolean :=true;
	
	begin
	if(reset ='1') then
		address_out <= "000000";
	elsif(clk='1' and clk'event) then
	
		if(w_enable='1') then --if 1 
			if(upd) then --if 2
				if(increment ='1') then --if 3
					pc_adrs := conv_integer(S1(5 DOWNTO 0))+1;
					S1 <= STD_LOGIC_VECTOR(to_unsigned(pc_adrs,6));
				else
					S1 <= address;
				end if; --end if3
				upd := false;
				
			end if; --end if 2
		else
			upd := true;
		end if; --end if 1
		
		address_out <= S1;
			
	end if; --reset if
	end process;
end Behavioral;

