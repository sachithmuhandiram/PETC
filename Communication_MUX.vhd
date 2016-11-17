----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    04:21:39 10/19/2016 
-- Design Name: 
-- Module Name:    Communication_MUX - Behavioral 
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

entity Communication_MUX is
    Port ( get_owner : in  STD_LOGIC_VECTOR (15 downto 0);
           get_v_type : in  STD_LOGIC_VECTOR (15 downto 0);
           get_loc : in  STD_LOGIC_VECTOR (15 downto 0);
           get_fee : in  STD_LOGIC_VECTOR (15 downto 0);
           get_c_type : in  STD_LOGIC_VECTOR (15 downto 0);
           get_balance : in  STD_LOGIC_VECTOR (15 downto 0);
           get_plate : in  STD_LOGIC_VECTOR (15 downto 0);
           get_upd_bal : in  STD_LOGIC_VECTOR (15 downto 0);
           clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  selection_mux : in  STD_LOGIC_VECTOR (2 downto 0);
           mux_out : out  STD_LOGIC_VECTOR (15 downto 0));
end Communication_MUX;

architecture Behavioral of Communication_MUX is

begin

process(clk,reset,selection_mux,get_owner,get_v_type,get_loc,get_fee,get_c_type,get_balance,get_plate,get_upd_bal)
	
		begin
			
			if(reset='1') then 
				mux_out <="0000000000000000";
			
			elsif(clk='1' and clk'event) then
				
				if(selection_mux="000") then
					mux_out <=get_owner;
					
				elsif(selection_mux="001") then
					mux_out <=get_v_type;
					
				elsif(selection_mux="010") then
					mux_out <=get_loc;
					
				elsif(selection_mux="011") then
					mux_out <=get_fee;
					
				elsif(selection_mux="100") then
					mux_out <=get_c_type;
					
				elsif(selection_mux="101") then
					mux_out <=get_balance;
					
				elsif(selection_mux="110") then
					mux_out <=get_plate;
					
				elsif(selection_mux="111") then
					mux_out <=get_upd_bal;
				end if; --mux seletion if
				
				
			end if; --reset if
		end process;
end Behavioral;

