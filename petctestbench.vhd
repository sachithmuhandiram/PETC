  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;

  ENTITY testbench IS
  END testbench;

  ARCHITECTURE behavior OF testbench IS 

  -- Component Declaration
   component test_unit is
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

end component test_unit;

--signals
--Inputs
Signal clk,reset : std_logic :='0';
Signal VIU_ON_ack : std_logic :='0';
Signal get_owner,get_v_type,get_loction,get_fee,get_balance : std_logic_vector (15 downto 0) :="0000000000000000";
          
--outputs
signal SEND_OWN,SEND_LOC : std_logic_vector (15 downto 0) :="0000000000000000";

  BEGIN

  -- Component Instantiation
          uut:  test_unit PORT MAP(
                 clk => clk,
					  reset => reset,
					  VIU_ON_ack => VIU_ON_ack,
					  get_owner => get_owner,
					  get_loction => get_loction,
					  SEND_OWN => SEND_OWN,
					  SEND_LOC => SEND_LOC
          );


  --  Test Bench Statements
     tb : PROCESS
     BEGIN

        wait for 10 ns; -- wait until global set/reset completes

        clk <='1';
		  VIU_ON_ack <='1';
		  get_owner <="0011101010011101";

        --wait; -- will wait forever
     END PROCESS tb;
  --  End Test Bench 

  END;
