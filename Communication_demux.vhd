----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    04:41:29 10/19/2016 
-- Design Name: 
-- Module Name:    Communication_demux - Behavioral 
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

entity Communication_demux is
    Port ( send_owner : out  STD_LOGIC_VECTOR (15 downto 0);
           send_type : out  STD_LOGIC_VECTOR (15 downto 0);
           send_location : out  STD_LOGIC_VECTOR (15 downto 0);
           send_fee : out  STD_LOGIC_VECTOR (15 downto 0);
           send_c_type : out  STD_LOGIC_VECTOR (15 downto 0);
           send_balance : out  STD_LOGIC_VECTOR (15 downto 0);
           send_plate : out  STD_LOGIC_VECTOR (15 downto 0);
           update_balance : out  STD_LOGIC_VECTOR (15 downto 0);
			  send_type_ack : out STD_LOGIC;
			  send_location_ack : out STD_LOGIC;
			  send_c_type_ack : out STD_LOGIC;
           demux_sel : in  STD_LOGIC_VECTOR (2 downto 0);
			  demux_enable : in STD_LOGIC;
           clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  type_conv_ack : in  STD_LOGIC; --ack from datawidth convetor
			  loc_conv_ack : in  STD_LOGIC;
			  c_conv_ack : in  STD_LOGIC;
           data_in_demux : in  STD_LOGIC_VECTOR (15 downto 0);
			  send_owner_ack,send_fee_ack,send_plate_ack,send_balance_ack,update_balance_ack : out  STD_LOGIC );
end Communication_demux;

architecture Behavioral of Communication_demux is

begin
process(demux_enable,clk,reset,data_in_demux,type_conv_ack,loc_conv_ack,c_conv_ack)
	begin
		
		if(reset='1') then --reset signals
			send_owner <="0000000000000000";
			send_type <="0000000000000000";
			send_location <="0000000000000000";
			send_fee <="0000000000000000";
			send_c_type<="0000000000000000";
			send_plate <="0000000000000000";
			send_balance <="0000000000000000";
			update_balance<="0000000000000000";
			send_type_ack <='0';
			send_location_ack <='0';
			send_c_type_ack <='0';
			send_owner_ack <='0';
			
		elsif(clk='1' and clk'event) then
			if(demux_enable='1') then
			
			send_type_ack <='0';
			send_location_ack <='0';
			send_c_type_ack <='0';
			
				if(demux_sel="000") then
					send_owner <= data_in_demux;
					send_owner_ack <='1';
					
				elsif(demux_sel="001") then
					send_type <=data_in_demux;
					send_type_ack <='1';
					
				elsif(demux_sel="010") then
					send_location <= data_in_demux;
					send_location_ack <='1';
					
				elsif(demux_sel="011") then
					send_fee <= data_in_demux;
					send_fee_ack <='1';
					
				elsif(demux_sel="100") then
					send_c_type <= data_in_demux;
					send_c_type_ack <='1';
					
				elsif(demux_sel="101") then
					send_plate <= data_in_demux;
					send_plate_ack <='1';
					
				elsif(demux_sel="110") then
					send_balance <= data_in_demux;
					send_balance_ack<='1';
					
				elsif(demux_sel="111") then
					update_balance <= data_in_demux;
					update_balance_ack <='1';
				end if; --demux seletion if
				
			end if;--demux selection
			
			--checking acks from data width convertor
			if(type_conv_ack='1') then
				send_type_ack <='0';
			elsif(loc_conv_ack='1') then 
				send_location_ack<='0';
			elsif(c_conv_ack='1') then
				send_c_type_ack <='0';
			end if;--ack if
			
		end if;--reset if
	end process; 

end Behavioral;

