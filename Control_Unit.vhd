----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:44:38 10/20/2016 
-- Design Name: 
-- Module Name:    Control_Unit - Behavioral 
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

entity Control_Unit is
	Port (clk,reset : in std_logic;
			location_address : out std_logic_vector (7 downto 0);
			location_operation : out std_logic;
			pc_address : out std_logic_vector (5 downto 0);
			pc_w_enable : out std_logic;
			pc_increment : out std_logic;
			ir_w_enable : out std_logic;
			opcode : in std_logic_vector(4 downto 0);
			operand_1 : in std_logic;
			operand_2 : in std_logic_vector (7 downto 0);
			GET_OWN : out std_logic;
			VIU_ON_ack,printer_on_ack,update_system_ack,print_ack,clear_printer_ack,police_unit_on_ack: in std_logic;
			OWN_ack,GET_PLATE_ack : in std_logic;
			com_mux_selection : out std_logic_vector (2 downto 0);
			com_regi_w_enable,com_regi_clear : out std_logic;
			com_demux_selection : out std_logic_vector (2 downto 0);
			demux_enable : out std_logic;
			VIU_ON,printer_on : out std_logic;
			GET_TYPE,GET_LOC,GET_PLATES : out std_logic;
			CHK_WRN : in std_logic;
			CHK_CRT : in std_logic;
			MANUAL : in std_logic;
			WARNING : in std_logic;
			send_owner_ack,send_v_type_ack,send_location_ack,send_fee_ack,send_plate_ack,send_balance_ack,update_balance_ack : in std_logic;--ack from demux
			get_v_type_ack,get_loc_ack : in std_logic;
			datawidth_c_enable : out std_logic;
			datawidth_c_selection : out std_logic_vector(1 downto 0);
			sent_type_ack,sent_loc_ack,c_conv_ack : in std_logic; --from datawidth conv
			clear_viu,clear_police_unit : out std_logic;
			cleared_viu_ack,cleared_police_unit_ack : in std_logic;
			get_fee_server,get_bal_server,get_c_type_server : out std_logic;
			get_fee_server_ack,get_bal_server_ack,get_c_type_server_ack : in std_logic;
			write_enable_x,write_enable_y : out std_logic;
			send_c_type_ack : in std_logic;
			calculation_done_ack : in std_logic;
			update_system,print,clear_printer,police_unit_on : out std_logic
			);
	
end Control_Unit;

architecture Behavioral of Control_Unit is

begin
	process(clk, reset,opcode,operand_1,operand_2)
		begin
			
	if(reset='1') then
		location_address <="00000000";
		location_operation <='0';
		pc_address <= "000000";
		pc_w_enable <='0';
		ir_w_enable <='0';
		
		elsif(clk='1' and clk'event) then
			
			pc_address <="000000";
			pc_w_enable <='1';
			ir_w_enable <='1';
			
			if(opcode="00001") then
				location_address <= operand_2;
				location_operation <=operand_1;
				VIU_ON <= operand_1;
				pc_w_enable <='0';
			end if; --end ON VIU
			
			IF(VIU_ON_ack='1') THEN 
				pc_increment <='1';
				pc_w_enable <='1';
			--END IF; --VIU_START ACK
			
			if(opcode="01111") then
				GET_OWN <= '1';
				pc_increment <='0';
				pc_w_enable <='0';
			end if; -- get owner if
			
			--end if; 
			
			if(OWN_ack='1') then
				pc_increment <='1';
				pc_w_enable <='1';
				com_mux_selection <="000";
				com_regi_w_enable <='1';
				
			end if;		--com_regi_w_enable <='0' after 300ps;
			
			
			if(opcode="00010") then	--send owner
				com_regi_w_enable <='0';
				com_demux_selection <="000";
				demux_enable <='1';
				pc_increment <='0';
				pc_w_enable <='0';
				--pc_w_enable <='1';
			end if; --send owner if
			
			if(send_owner_ack='1') then 
				pc_increment <='1';
				pc_w_enable <='1';
				
			end if;
			
			--pc_w_enable <='0';
			if(opcode="00011" and operand_2="00000111") then	--SJMP CHK_CRT OUT
				pc_increment <='0';
				pc_w_enable <='0';
				
				--com_regi_clear <='1';
				if(CHK_CRT='1') then
					pc_address <="001011";
					pc_w_enable <='1';
					
					com_regi_clear <='1';
					com_regi_w_enable <='1';
					
				elsif (CHK_CRT='0') then
					pc_increment <='1';
					pc_w_enable <='1';
					com_regi_clear <='1';
					com_regi_w_enable <='1';
				end if;
			end if; --JUM OUT
			
			if(opcode="00011" and operand_2="00010010") then -- SJMP CHK_WRN 
				pc_increment <='0';
				pc_w_enable <='0';
				
				
					if(CHK_WRN='1') then
						pc_address <="011001";
						pc_w_enable <='1';
						com_regi_clear <='0';
						com_regi_w_enable <='1';
					elsif (CHK_WRN='0') then
						com_regi_clear <='0';
						pc_increment <='1';
						pc_w_enable <='1';
						com_regi_w_enable <='1';
							
					
					end if; --end of crt_wrn
			end if;
			
			if(opcode="01000") then -- get type
				pc_increment <='0';
				pc_w_enable <='0';
				GET_TYPE <='1';
				com_regi_w_enable <='1';
			end if;
			
			if(get_v_type_ack='1') then
				
				com_mux_selection <="001";
				com_demux_selection <="001";
				demux_enable <='1';
				com_regi_w_enable <='1';
			end if;
			
				if(send_v_type_ack='1') then -- communication demux
					pc_increment <='1';
					pc_w_enable <='1';
					com_regi_w_enable <='0';
				end if;
				
				if(opcode="00100") then
					datawidth_c_enable <='1';
					datawidth_c_selection <="00";
					pc_increment <='0';
					pc_w_enable <='0';
				end if;
			
			if(sent_type_ack='1') then
				pc_increment <='1';
				pc_w_enable <='1';
			end if;
			
			
			if(opcode="10001") then	-- GET_LOC
				pc_increment <='0';
				pc_w_enable <='0';
				
				GET_LOC <='1';
			
			end if;
			
			if (get_loc_ack='1') then
				com_mux_selection <="010";
				com_demux_selection <="010";
				demux_enable <='1';
				com_regi_w_enable <='1';
			end if;
			
			if(send_location_ack='1') then
				pc_increment <='1';
				pc_w_enable <='1';
				com_regi_w_enable <='0';
			end if;
			
			if(opcode="00101") then
				datawidth_c_selection <="01";
				pc_increment <='0';
				pc_w_enable <='0';
			end if;
			
			if(sent_loc_ack='1') then
				pc_increment <='1';
				pc_w_enable <='1';
			end if;
			
			if(opcode="01110" and operand_1='1' and operand_2="10000011") then
				pc_increment <='0';
				pc_w_enable <='0';
				
				clear_viu <='1';
			end if;
			
			if(cleared_viu_ack='1') then
				pc_increment <='1';
				pc_w_enable <='1';
			end if;
			
			if(opcode="11001") then
				pc_increment <='0';
				pc_w_enable <='0';
				
				if(opcode="11001" and operand_1='1' and operand_2="00000000") then
					pc_address<="000000";
					pc_w_enable <='1';
					
				end if;
			end if;
			
			
			--OUT gate operations
			
			if(opcode="00011" and operand_2="00001101") then --SJMP MANUAL
				pc_increment <='0';
				pc_w_enable <='0';
				com_regi_clear <='1';
				
				if(MANUAL='1') then 
					pc_address <="010100";
					pc_w_enable <='1';
					
				elsif(MANUAL='0') then
				
					pc_increment <='1';
					pc_w_enable <='1';
				end if;
			end if; -- SJMP MANUAL
			
			if(opcode="00111") then --get fee
				get_fee_server <='1';
				pc_increment <='0';
				pc_w_enable <='0';
				com_regi_clear <='0';
			end if;
			
			if(get_fee_server_ack='1') then
				pc_increment <='1';
				pc_w_enable <='1';
				
				com_mux_selection <="011";
				com_regi_w_enable <='1';
			end if;
			
			if(opcode="10010") then	-- send_fee
				pc_increment <='0';
				pc_w_enable <='0';
				
				com_regi_w_enable <='0';
				com_demux_selection <="011";
				demux_enable <='1';
				
			end if;
			
			if(send_fee_ack='1') then
				pc_increment <='1';
				pc_w_enable <='1';
				
				write_enable_y <='1';
			end if;
			
			if(opcode="01001") then	--get balance
				pc_increment <='0';
				pc_w_enable <='0';
				get_bal_server <='1';
				com_regi_clear <='0';
			end if;
			
			if(get_bal_server_ack='1') then
				pc_increment <='1';
				pc_w_enable <='1';
				
				com_mux_selection <="101";
				com_regi_w_enable <='1';
			end if;
			
			if(opcode="10100") then		--send balance
				pc_increment <='0';
				pc_w_enable <='0';
				
				com_regi_w_enable <='0';
				com_demux_selection <="110";
				demux_enable <='1';
				write_enable_x <='1';
			end if;
			
			if(send_balance_ack='1') then
				pc_increment <='1';
				pc_w_enable <='1';
				
				
			end if;
			
			if(opcode="10000" and operand_1='0' and operand_2="00000000") then	--get card type
			
				pc_increment <='0';
				pc_w_enable <='0';
				
				get_c_type_server <='1';
				demux_enable <='0';
				com_regi_clear <='0';
			end if;
			
			if(get_c_type_server_ack='1') then
				pc_increment <='1';
				pc_w_enable <='1';
				
				com_mux_selection <="100";
				com_regi_w_enable <='1';
			end if;
			
			if(opcode="10011") then		--send card type
				pc_increment <='0';
				pc_w_enable <='0';
				
				com_regi_w_enable <='0';
				com_demux_selection <="100";
				demux_enable <='1';
				
			end if;
			
			if(send_c_type_ack='1') then	--internally getting signal
				datawidth_c_enable <='1';
				datawidth_c_selection <="10";
				
			end if;
			
			if(c_conv_ack ='1') then
				pc_increment <='1';
				pc_w_enable <='1';
			end if;
				
			if(opcode="10111") then		-- cal bal
				pc_increment <='0';
				pc_w_enable <='0';
				
				write_enable_x <='0';
				write_enable_y <='0';
				
				com_mux_selection <="111";
				com_regi_w_enable <='1';
				
				
			end if;
			
			if(calculation_done_ack='1') then
				pc_increment <='1';
				pc_w_enable <='1';
				
				com_regi_w_enable <='0';
				com_demux_selection <="111";
			end if;
			
			if(opcode="10101") then
				pc_increment <='0';
				pc_w_enable <='0';
				
				com_regi_w_enable <='0';
				com_demux_selection <="111";
				demux_enable <='1';
			end if;
			
			if(update_balance_ack='1') then
				pc_increment <='1';
				pc_w_enable <='1';
			end if;
			
			if(opcode="11001") then
				pc_increment <='0';
				pc_w_enable <='0';
				
				if(opcode="11001" and operand_1='1' and operand_2="00001011") then
					pc_address<="001011";
					pc_w_enable <='1';
					
				end if;
			end if;
			
			--manual settings
			
			if(opcode="00001" and operand_2="11110000") then
				pc_increment <='0';
				pc_w_enable <='0';
				
				printer_on <='1';
			end if;
			
			if(printer_on_ack='1') then
				pc_increment <='1';
				pc_w_enable <='1';
			end if;
			
			if(opcode="01100") then
				pc_increment <='0';
				pc_w_enable <='0';
				
				update_system <='1';
			end if;
			
			if(update_system_ack='1') then
				pc_increment <='1';
				pc_w_enable <='1';
			end if;
			
			if(opcode="01011") then
				pc_increment <='0';
				pc_w_enable <='0';
				
				print<='1';
			end if;
			
			if(print_ack='1') then
				pc_increment <='1';
				pc_w_enable <='1';
			end if;
			
			if(opcode="01110" and operand_2="11110000") then
				pc_increment <='0';
				pc_w_enable <='0';
				
				clear_printer <='1';
			end if;
			
			if(clear_printer_ack='1') then
				pc_increment <='1';
				pc_w_enable <='1';
			end if;
			
			if(opcode="11001" and operand_2="00010101") then
				pc_increment <='0';
				pc_w_enable <='0';
				
				if(opcode="11001" and operand_1='1' and operand_2="00010101") then
					pc_address<="010101";
					pc_w_enable <='1';
					
				end if;
			end if;
			
			if(opcode="00001" and operand_2="11111110") then
				pc_increment <='0';
				pc_w_enable <='0';
				
				police_unit_on <='1';
			end if;
			
			if(police_unit_on_ack='1') then
				pc_increment <='1';
				pc_w_enable <='1';
			end if;
			
			if(opcode="11000") then
				pc_increment <='0';
				pc_w_enable <='0';
				
				com_regi_clear <='0';
				GET_PLATES <='1';
			end if;
			
			if(GET_PLATE_ack='1') then
				pc_increment <='1';
				pc_w_enable <='1';
				
				com_mux_selection <="110";
				com_regi_w_enable <='1';
				
			end if;
			
			if(opcode="01101") then
				pc_increment <='0';
				pc_w_enable <='0';
				
				demux_enable <='1';
				com_regi_w_enable <='0';
				com_demux_selection <="101";
			end if;
			
			if(send_plate_ack='1') then
				pc_increment <='1';
				pc_w_enable <='1';
			end if;
			
			if(opcode="01110" and operand_1='0' and operand_2="10000011") then
				pc_increment <='0';
				pc_w_enable <='0';
				
				clear_viu <='1';
			end if;
			
			if(cleared_viu_ack='1') then
				pc_increment <='1';
				pc_w_enable <='1';
			end if;
			
			if(opcode="01110" and operand_2="11111110") then
				pc_increment <='0';
				pc_w_enable <='0';
				clear_police_unit <='1';
			end if;
			
			if(cleared_police_unit_ack='1') then
				pc_increment <='1';
				pc_w_enable <='1';
			end if;
			
			if(opcode="11001" and operand_2="00011010") then
			
				pc_increment <='0';
				pc_w_enable <='0';
				
				if(opcode="11001" and operand_1='1' and operand_2="00001011") then
					pc_address<="011010";
					pc_w_enable <='1';
					
				end if;
				
			end if;
					
					
				end if; --viu ack
			end if; --end reset if
	end process;
end Behavioral;

