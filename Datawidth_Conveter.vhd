----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:10:11 10/19/2016 
-- Design Name: 
-- Module Name:    Datawidth_Conveter - Behavioral 
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

entity Datawidth_Conveter is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  datawidth_enable : in  STD_LOGIC;
           datawidth_selector : in  STD_LOGIC_VECTOR (1 downto 0);
           send_type_in : in  STD_LOGIC_VECTOR (15 downto 0);
           send_location_in : in  STD_LOGIC_VECTOR (15 downto 0);
           send_c_type_in : in  STD_LOGIC_VECTOR (15 downto 0);
           send_type : out  STD_LOGIC_VECTOR (3 downto 0);
           send_loc : out  STD_LOGIC_VECTOR (4 downto 0);
           send_c_type : out  STD_LOGIC;
			  c_conv_ack : out  STD_LOGIC;
			  type_conv_ack : out  STD_LOGIC;
			  loc_conv_ack : out  STD_LOGIC);
end Datawidth_Conveter;

architecture Behavioral of Datawidth_Conveter is

begin
process(clk,reset,datawidth_enable,datawidth_selector,send_type_in,send_location_in,send_c_type_in)
	begin 
		if(reset='1') then
			send_type <="0000";
			send_loc <="00000";
			send_c_type <='0';
			
		elsif(clk='1' and clk'event) then
			if(datawidth_enable='1') then
			type_conv_ack <='0';
			loc_conv_ack <='0';
			c_conv_ack <='0';
			
				if(datawidth_selector="00") then
					send_type <= send_type_in(3 downto 0);
					type_conv_ack <='1';
					
				elsif(datawidth_selector="01") then 
					send_loc <= send_location_in(4 downto 0);
					loc_conv_ack <='1';
					
				elsif(datawidth_selector="10") then
					send_c_type <= send_c_type_in(0);
					c_conv_ack <='1';
				end if; --data width selector if
				
				
			end if; --datawidth enable if
		end if; --reset if
	end process;
end Behavioral;

