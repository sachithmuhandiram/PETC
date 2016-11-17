----------------------------------------------------------------------------------
-- Company: ECX-6236
-- Engineer: P.M.S.N.MUHANDIRAM
-- 
-- Create Date:    15:47:24 10/19/2016 
-- Design Name: 		PETC
-- Module Name:    test_unit - Behavioral 
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

entity test_unit is
Port ( 
	  send_type_ack : out  STD_LOGIC; -- to CU
	  SEND_OWN : out STD_LOGIC_VECTOR (15 downto 0);	-- to server
	  UPD_BAL : out STD_LOGIC_VECTOR (15 downto 0); 	
	  SEND_LOC : out std_logic_vector (4 downto 0);
	  SEND_TYPE : out std_logic_vector (3 downto 0);
	  SEND_PLT : out STD_LOGIC_VECTOR (15 downto 0); -- TO police unit
	  GET_UPD_BAL : out STD_LOGIC_VECTOR (15 downto 0); -- TO COM MUX
	  clk : in  STD_LOGIC;
	  reset : in  STD_LOGIC;
	  CHK_WRN,CHK_CRT,WARNING : in std_logic;		-- from server
	  com_regi_clear : in std_logic;	-- 
	  get_owner : in std_logic_vector (15 downto 0); -- from VIU
	  get_v_type : in std_logic_vector (15 downto 0);		-- from VIU
	  get_loction : in std_logic_vector (15 downto 0);		-- from VIU
	  get_fee : in std_logic_vector (15 downto 0);			-- from server	
	  get_c_type : in std_logic_vector (15 downto 0);		-- from server
	  get_balance : in std_logic_vector (15 downto 0);		-- from server
	  get_plate : in std_logic_vector (15 downto 0);			-- from server
	  Location_address : out std_logic_vector (7 downto 0);
	  Location_operation : out std_logic;
	  printer_on,police_unit_on  : out std_logic;	--
	  VIU_ON_ack,printer_on_ack,update_system_ack,clear_printer_ack,police_unit_on_ack,print_ack : in std_logic;
	  clear_police_ack : in std_logic;
	  OWN_ack : in std_logic;
	  MANUAL,WARNINGS: in std_logic;
	  GET_TYPE,VIU_ON,GET_OWN,GET_PLATES,GET_LOC : out std_logic;	-- output indication signals
	  get_v_type_ack,get_loc_ack,viu_reset_ack ,GET_PLATE_ack: in std_logic;
	  VIU_CLEAR : out std_logic;
	  get_fee_server,get_bal_server,get_c_type_server : out std_logic; -- output indications
	  get_fee_server_ack,get_bal_server_ack,get_c_type_server_ack : in std_logic; --ack from server
	  update_system,print,clear_printer,clear_police_unit : out std_logic);	

end test_unit;

architecture Structural of test_unit is
--control unit

component Control_Unit is
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
	GET_OWN,GET_PLATES : out std_logic;
	VIU_ON_ack,printer_on_ack,update_system_ack,print_ack,clear_printer_ack,police_unit_on_ack : in std_logic;
	OWN_ack : in std_logic;
	com_mux_selection : out std_logic_vector (2 downto 0);
	com_regi_w_enable,com_regi_clear : out std_logic;
	com_demux_selection : out std_logic_vector (2 downto 0);
	demux_enable : out std_logic;
	VIU_ON,printer_on,police_unit_on : out std_logic;
	CHK_WRN : in std_logic;
	CHK_CRT : in std_logic;
	MANUAL: in std_logic;
	WARNING : in std_logic;
	GET_TYPE : out std_logic;
	GET_LOC : out std_logic;
	send_owner_ack,send_v_type_ack,send_location_ack,send_fee_ack,send_plate_ack,send_balance_ack,update_balance_ack : in std_logic;
	get_v_type_ack,get_loc_ack,GET_PLATE_ack : in std_logic;
	datawidth_c_enable : out std_logic;
	datawidth_c_selection : out std_logic_vector (1 downto 0);
	sent_type_ack,sent_loc_ack,c_conv_ack : in std_logic;
	clear_viu,clear_police_unit : out std_logic;
	cleared_viu_ack,cleared_police_unit_ack : in std_logic;
	get_fee_server,get_bal_server,get_c_type_server : out std_logic;
	get_fee_server_ack,get_bal_server_ack,get_c_type_server_ack : in std_logic;
	write_enable_x,write_enable_y : out std_logic;
	send_c_type_ack : in std_logic;
	calculation_done_ack : in std_logic;
	update_system,print,clear_printer : out std_logic);

end component Control_Unit;

--data width convetor
component Datawidth_Conveter is
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
end component Datawidth_Conveter;


--Communication Demux
component Communication_demux is
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
	  send_owner_ack,send_fee_ack,send_plate_ack,send_balance_ack,update_balance_ack  : out  STD_LOGIC);
end component Communication_demux;

-- Communocation MUX
component Communication_MUX is
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
end component Communication_MUX;

-- Communication Register
component Communication_register is
Port ( data_in_com : in  STD_LOGIC_VECTOR (15 downto 0);
	  clk : in  STD_LOGIC;
	  w_enable_com : in  STD_LOGIC;
	  reset : in  STD_LOGIC;
	  data_out_com : out  STD_LOGIC_VECTOR (15 downto 0));
end component Communication_register;

--ROM
component Instruction_Memory is
Port ( rom_address : in  STD_LOGIC_VECTOR (5 downto 0);
	  clk : in  STD_LOGIC;
	  reset : STD_LOGIC;	
	  instruction : out  STD_LOGIC_VECTOR (13 downto 0));
end component Instruction_Memory;

--IR
component Instruction_register is
Port ( rom_data : in  STD_LOGIC_VECTOR(13 DOWNTO 0);
	  w_enable : in  STD_LOGIC;
	  clk : in  STD_LOGIC;
	  reset : in  STD_LOGIC;
	  opcode : out  STD_LOGIC_VECTOR(4 DOWNTO 0);
	  operand1 : out  STD_LOGIC;
	  operand2 :out STD_LOGIC_VECTOR(7 DOWNTO 0) );
end component Instruction_register;

--PC
component Program_Counter is
Port ( address : in  STD_LOGIC_VECTOR (5 downto 0);
	  w_enable : in  STD_LOGIC;
	  increment : in  STD_LOGIC;
	  clk : in  STD_LOGIC;
	  reset : in  STD_LOGIC;
	  address_out : out  STD_LOGIC_VECTOR (5 downto 0));
end component Program_Counter;

--add sub unit
component addsubunit is
Port ( X : in  STD_LOGIC_VECTOR(15 DOWNTO 0);
	  Y : in  STD_LOGIC_VECTOR(15 DOWNTO 0);
	  Cin : in  STD_LOGIC;
	  clk : in  STD_LOGIC;
	  Outmain : inout  STD_LOGIC_VECTOR(15 DOWNTO 0); --sum
	  Outsecondary : inout  STD_LOGIC; --carry
	  addsub_ack : out std_logic);  --addsub ack
end component addsubunit;

--register X
component  Register_X is
Port ( w_enable_x : in  STD_LOGIC;
	  data_in_X : in  STD_LOGIC_VECTOR (15 downto 0);
	  clk : in  STD_LOGIC;
	  reset : in  STD_LOGIC;
	  data_out_X : out  STD_LOGIC_VECTOR (15 downto 0));
end component Register_X;

--register Y
component Register_Y is
Port ( data_in_Y : in  STD_LOGIC_VECTOR (15 downto 0);
	  clk : in  STD_LOGIC;
	  w_enable_y : in  STD_LOGIC;
	  reset : in  STD_LOGIC;
	  data_out_Y : out  STD_LOGIC_VECTOR (15 downto 0));
end component  Register_Y;

-- signals 
Signal S0 : std_logic_vector (13 downto 0);
Signal data_address : std_logic_vector (5 downto 0);
Signal data_in_com_reg,data_out_com_reg,send_type_convertor,send_loc_convertor,send_c_type_convetor : std_logic_vector (15 downto 0);
signal updated_bal,data_from_x,data_from_y,SEND_BAL,SEND_FEE : std_logic_vector(15 downto 0);
Signal type_conv_ack,loc_conv_ack,c_conv_ack ,SEND_C_TYPE : std_logic;
Signal notused_signal: std_logic;
Signal opcode : std_logic_vector(4 downto 0);
Signal pc_address : std_logic_vector(5 downto 0);
Signal pc_w_enable,pc_increment,operand1,ir_w_en,com_reg_clear : std_logic;
Signal operand2 : std_logic_vector(7 downto 0);
Signal com_mux_select,com_demux_select : std_logic_vector (2 downto 0);
signal com_regi_w_enable,demux_enable,send_owner_ack,datawidth_c_enable,send_v_type_ack,send_loc_ack : std_logic;
signal datawidth_c_selection : std_logic_vector (1 downto 0);
signal sent_fee_ack,sent_plate_ack,sent_balance_ack,update_balance_ack,updated_balance_ack : std_logic;
signal write_enable_x,write_enable_y : std_logic;
signal send_c_type_ack,addsub_unit_ack : std_logic;


begin

PC_1 : Program_Counter 
Port map ( address => pc_address,
			w_enable => pc_w_enable,
			increment => pc_increment,
			clk => clk,
			reset => reset,
			address_out => data_address);
			
ROM_1: Instruction_Memory
Port map ( rom_address => data_address,
			clk => clk,
			reset => reset,	
			instruction => S0);

IR_1 : Instruction_register 
Port map( rom_data => S0,
	  w_enable => ir_w_en,
	  clk => clk,
	  reset => reset,
	  opcode => opcode,
	  operand1 => operand1,
	  operand2 => operand2 );

Com_reg : Communication_register 
Port map ( data_in_com => data_in_com_reg,
			clk => clk,
			w_enable_com => com_regi_w_enable,
			reset => com_reg_clear,
			data_out_com => data_out_com_reg );
			

com_demux : Communication_demux 
Port map ( send_owner => SEND_OWN,
			send_type => send_type_convertor,
			send_location => send_loc_convertor,
			send_fee => SEND_FEE,
			send_c_type => send_c_type_convetor,
			send_balance => SEND_BAL,
			send_plate => SEND_PLT,
			update_balance => UPD_BAL,
			send_type_ack => send_v_type_ack,
			send_location_ack => send_loc_ack,
			send_c_type_ack => send_c_type_ack,
			demux_sel => com_demux_select,
			demux_enable => demux_enable,
			clk => clk,
			reset => reset,
			type_conv_ack => type_conv_ack, --ack from datawidth convetor
			loc_conv_ack => loc_conv_ack,
			c_conv_ack => c_conv_ack,
			data_in_demux => data_out_com_reg,
			send_owner_ack => send_owner_ack,
			send_fee_ack => sent_fee_ack,
			send_plate_ack => sent_plate_ack,
			send_balance_ack => sent_balance_ack,
			update_balance_ack => updated_balance_ack);
			
		
data_width : Datawidth_Conveter 
Port map ( clk => clk,
		  reset => reset,
		  datawidth_enable => datawidth_c_enable,
		  datawidth_selector => datawidth_c_selection,
		  send_type_in => send_type_convertor,
		  send_location_in => send_loc_convertor,
		  send_c_type_in => send_c_type_convetor,
		  send_type => SEND_TYPE,
		  send_loc => SEND_LOC,
		  send_c_type => SEND_C_TYPE,
		  c_conv_ack => c_conv_ack,
		  type_conv_ack => type_conv_ack,
		  loc_conv_ack => loc_conv_ack);

addsub : addsubunit 
Port map ( X => data_from_x,
			  Y => data_from_y,
			  Cin => SEND_C_TYPE,
			  clk => clk,
			  Outmain => updated_bal,
			  Outsecondary => notused_signal,
			  addsub_ack => addsub_unit_ack);

com_mux : Communication_MUX 
Port map ( get_owner => get_owner,
			  get_v_type  => get_v_type,
			  get_loc => get_loction,
			  get_fee => get_fee,
			  get_c_type => get_c_type,
			  get_balance => get_balance,
			  get_plate => get_plate,
			  get_upd_bal => updated_bal,
			  clk => clk,
			  reset => reset,
			  selection_mux => com_mux_select,
			  mux_out => data_in_com_reg);

regi_X : Register_X
Port map ( w_enable_x => write_enable_x,
			  data_in_X => SEND_BAL,
			  clk => clk,
			  reset =>reset,
			  data_out_X => data_from_x);

regi_Y : Register_Y
Port map ( w_enable_y => write_enable_y,
			  data_in_Y => SEND_FEE,
			  clk => clk,
			  reset =>reset,
			  data_out_Y => data_from_y);					  


CU : Control_Unit 
Port map (clk => clk,reset=>reset, 
			location_address => Location_address,
			location_operation => Location_operation,
			pc_address => pc_address,
			pc_w_enable => pc_w_enable,
			pc_increment =>pc_increment,
			ir_w_enable => ir_w_en,
			opcode => opcode,
			operand_1 => operand1,
			operand_2 => operand2, 
			GET_OWN => GET_OWN,
			VIU_ON_ack => VIU_ON_ack,
			OWN_ack => OWN_ack,
			com_regi_w_enable => com_regi_w_enable,
			com_regi_clear => com_reg_clear,
			com_mux_selection => com_mux_select,
			com_demux_selection =>com_demux_select,
			demux_enable => demux_enable,
			VIU_ON => VIU_ON,
			CHK_WRN => CHK_WRN,
			CHK_CRT=> CHK_CRT,
			MANUAL  => MANUAL,
			WARNING => WARNING,
			GET_TYPE => GET_TYPE,
			send_owner_ack => send_owner_ack,
			get_v_type_ack => get_v_type_ack,--send_v_type_ack,
			datawidth_c_enable => datawidth_c_enable,
			datawidth_c_selection => datawidth_c_selection,
			send_v_type_ack => send_v_type_ack,
			sent_type_ack => type_conv_ack,
			GET_LOC => GET_LOC,
			get_loc_ack => get_loc_ack,
			send_location_ack => send_loc_ack,
			sent_loc_ack => loc_conv_ack,
			clear_viu => VIU_CLEAR,
			cleared_viu_ack => viu_reset_ack,
			get_fee_server => get_fee_server,
			get_fee_server_ack =>get_fee_server_ack,
			send_fee_ack => sent_fee_ack,
			send_plate_ack => sent_plate_ack,
			send_balance_ack => sent_balance_ack,
			update_balance_ack => updated_balance_ack,
			write_enable_y => write_enable_y,
			write_enable_x => write_enable_x,
			get_bal_server => get_bal_server,
			get_bal_server_ack => get_bal_server_ack,
			get_c_type_server => get_c_type_server,
			get_c_type_server_ack => get_c_type_server_ack,
			send_c_type_ack => send_c_type_ack,
			c_conv_ack => c_conv_ack,
			calculation_done_ack => addsub_unit_ack,
			printer_on => printer_on,
			printer_on_ack => printer_on_ack,
			update_system => update_system,
			update_system_ack => update_system_ack,
			print => print,
			print_ack => print_ack,
			clear_printer => clear_printer,
			clear_printer_ack => clear_printer_ack,
			police_unit_on => police_unit_on,
			police_unit_on_ack => police_unit_on_ack,
			GET_PLATES => GET_PLATES,
			GET_PLATE_ack => GET_PLATE_ack,
			clear_police_unit => clear_police_unit,
			cleared_police_unit_ack => clear_police_ack);

end Structural;