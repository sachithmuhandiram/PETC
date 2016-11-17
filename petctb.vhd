--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:22:39 10/26/2016
-- Design Name:   
-- Module Name:   C:/Users/Sachith-PC/Desktop/xi/PETC_test/petctb.vhd
-- Project Name:  PETC_test
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: test_unit
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY petctb IS
END petctb;
 
ARCHITECTURE behavior OF petctb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT test_unit
    PORT(
         send_type_ack : OUT  std_logic;
         SEND_OWN : OUT  std_logic_vector(15 downto 0);
         UPD_BAL : OUT  std_logic_vector(15 downto 0);
         SEND_LOC : OUT  std_logic_vector(4 downto 0);
         SEND_TYPE : OUT  std_logic_vector(3 downto 0);
         SEND_PLT : OUT  std_logic_vector(15 downto 0);
         GET_UPD_BAL : OUT  std_logic_vector(15 downto 0);
         clk : IN  std_logic;
         reset : IN  std_logic;
         CHK_WRN : IN  std_logic;
         CHK_CRT : IN  std_logic;
         WARNING : IN  std_logic;
         com_regi_clear : IN  std_logic;
         get_owner : IN  std_logic_vector(15 downto 0);
         get_v_type : IN  std_logic_vector(15 downto 0);
         get_loction : IN  std_logic_vector(15 downto 0);
         get_fee : IN  std_logic_vector(15 downto 0);
         get_c_type : IN  std_logic_vector(15 downto 0);
         get_balance : IN  std_logic_vector(15 downto 0);
         get_plate : IN  std_logic_vector(15 downto 0);
         Location_address : OUT  std_logic_vector(7 downto 0);
         Location_operation : OUT  std_logic;
         printer_on : OUT  std_logic;
         police_unit_on : OUT  std_logic;
         VIU_ON_ack : IN  std_logic;
         printer_on_ack : IN  std_logic;
         update_system_ack : IN  std_logic;
         clear_printer_ack : IN  std_logic;
         police_unit_on_ack : IN  std_logic;
         print_ack : IN  std_logic;
         clear_police_ack : IN  std_logic;
         OWN_ack : IN  std_logic;
         MANUAL : IN  std_logic;
         WARNINGS : IN  std_logic;
         GET_TYPE : OUT  std_logic;
         VIU_ON : OUT  std_logic;
         GET_OWN : OUT  std_logic;
         GET_PLATES : OUT  std_logic;
         GET_LOC : OUT  std_logic;
         get_v_type_ack : IN  std_logic;
         get_loc_ack : IN  std_logic;
         viu_reset_ack : IN  std_logic;
         GET_PLATE_ack : IN  std_logic;
         VIU_CLEAR : OUT  std_logic;
         get_fee_server : OUT  std_logic;
         get_bal_server : OUT  std_logic;
         get_c_type_server : OUT  std_logic;
         get_fee_server_ack : IN  std_logic;
         get_bal_server_ack : IN  std_logic;
         get_c_type_server_ack : IN  std_logic;
         update_system : OUT  std_logic;
         print : OUT  std_logic;
         clear_printer : OUT  std_logic;
         clear_police_unit : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal CHK_WRN : std_logic := '0';
   signal CHK_CRT : std_logic := '0';
   signal WARNING : std_logic := '0';
   signal com_regi_clear : std_logic := '0';
   signal get_owner : std_logic_vector(15 downto 0) := (others => '0');
   signal get_v_type : std_logic_vector(15 downto 0) := (others => '0');
   signal get_loction : std_logic_vector(15 downto 0) := (others => '0');
   signal get_fee : std_logic_vector(15 downto 0) := (others => '0');
   signal get_c_type : std_logic_vector(15 downto 0) := (others => '0');
   signal get_balance : std_logic_vector(15 downto 0) := (others => '0');
   signal get_plate : std_logic_vector(15 downto 0) := (others => '0');
   signal VIU_ON_ack : std_logic := '0';
   signal printer_on_ack : std_logic := '0';
   signal update_system_ack : std_logic := '0';
   signal clear_printer_ack : std_logic := '0';
   signal police_unit_on_ack : std_logic := '0';
   signal print_ack : std_logic := '0';
   signal clear_police_ack : std_logic := '0';
   signal OWN_ack : std_logic := '0';
   signal MANUAL : std_logic := '0';
   signal WARNINGS : std_logic := '0';
   signal get_v_type_ack : std_logic := '0';
   signal get_loc_ack : std_logic := '0';
   signal viu_reset_ack : std_logic := '0';
   signal GET_PLATE_ack : std_logic := '0';
   signal get_fee_server_ack : std_logic := '0';
   signal get_bal_server_ack : std_logic := '0';
   signal get_c_type_server_ack : std_logic := '0';

 	--Outputs
   signal send_type_ack : std_logic;
   signal SEND_OWN : std_logic_vector(15 downto 0);
   signal UPD_BAL : std_logic_vector(15 downto 0);
   signal SEND_LOC : std_logic_vector(4 downto 0);
   signal SEND_TYPE : std_logic_vector(3 downto 0);
   signal SEND_PLT : std_logic_vector(15 downto 0);
   signal GET_UPD_BAL : std_logic_vector(15 downto 0);
   signal Location_address : std_logic_vector(7 downto 0);
   signal Location_operation : std_logic;
   signal printer_on : std_logic;
   signal police_unit_on : std_logic;
   signal GET_TYPE : std_logic;
   signal VIU_ON : std_logic;
   signal GET_OWN : std_logic;
   signal GET_PLATES : std_logic;
   signal GET_LOC : std_logic;
   signal VIU_CLEAR : std_logic;
   signal get_fee_server : std_logic;
   signal get_bal_server : std_logic;
   signal get_c_type_server : std_logic;
   signal update_system : std_logic;
   signal print : std_logic;
   signal clear_printer : std_logic;
   signal clear_police_unit : std_logic;

   -- Clock period definitions
   constant clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: test_unit PORT MAP (
          send_type_ack => send_type_ack,
          SEND_OWN => SEND_OWN,
          UPD_BAL => UPD_BAL,
          SEND_LOC => SEND_LOC,
          SEND_TYPE => SEND_TYPE,
          SEND_PLT => SEND_PLT,
          GET_UPD_BAL => GET_UPD_BAL,
          clk => clk,
          reset => reset,
          CHK_WRN => CHK_WRN,
          CHK_CRT => CHK_CRT,
          WARNING => WARNING,
          com_regi_clear => com_regi_clear,
          get_owner => get_owner,
          get_v_type => get_v_type,
          get_loction => get_loction,
          get_fee => get_fee,
          get_c_type => get_c_type,
          get_balance => get_balance,
          get_plate => get_plate,
          Location_address => Location_address,
          Location_operation => Location_operation,
          printer_on => printer_on,
          police_unit_on => police_unit_on,
          VIU_ON_ack => VIU_ON_ack,
          printer_on_ack => printer_on_ack,
          update_system_ack => update_system_ack,
          clear_printer_ack => clear_printer_ack,
          police_unit_on_ack => police_unit_on_ack,
          print_ack => print_ack,
          clear_police_ack => clear_police_ack,
          OWN_ack => OWN_ack,
          MANUAL => MANUAL,
          WARNINGS => WARNINGS,
          GET_TYPE => GET_TYPE,
          VIU_ON => VIU_ON,
          GET_OWN => GET_OWN,
          GET_PLATES => GET_PLATES,
          GET_LOC => GET_LOC,
          get_v_type_ack => get_v_type_ack,
          get_loc_ack => get_loc_ack,
          viu_reset_ack => viu_reset_ack,
          GET_PLATE_ack => GET_PLATE_ack,
          VIU_CLEAR => VIU_CLEAR,
          get_fee_server => get_fee_server,
          get_bal_server => get_bal_server,
          get_c_type_server => get_c_type_server,
          get_fee_server_ack => get_fee_server_ack,
          get_bal_server_ack => get_bal_server_ack,
          get_c_type_server_ack => get_c_type_server_ack,
          update_system => update_system,
          print => print,
          clear_printer => clear_printer,
          clear_police_unit => clear_police_unit
        );

   -- Clock process definitions
   clk_process :process
   begin

		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.


      wait for 100 ns;
		
		VIU_ON_ack <='1';
		
		wait for 100 ns;
		
		wait for 100 ns;
		
		get_owner <= "0001111010010110";
		OWN_ack <='1';
		
	wait for 100 ns;

      --wait;
   end process;

END;
