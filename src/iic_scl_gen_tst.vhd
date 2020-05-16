--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY iic_scl_gen_tst IS
END iic_scl_gen_tst;
 
ARCHITECTURE behavior OF iic_scl_gen_tst IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT iic_scl_gen
    PORT(
         clk : IN  std_logic;
         ce : IN  std_logic;
         mode : in std_logic;
         scl_pd : OUT  std_logic;
         rst : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal ce : std_logic := '0';
   signal mode : std_logic := '0';
   signal rst : std_logic := '0';

 	--Outputs
   signal scl_pd : std_logic;

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: iic_scl_gen PORT MAP (
          clk => clk,
          ce => ce,
          mode => mode,
          scl_pd => scl_pd,
          rst => rst
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
      rst <= '1';
      ce <= '0';
      mode <= '0';
      wait for 25 ns;	
      rst <= '0';
      
      wait for clk_period*5;
      ce <= '1';
      wait for 15 us;
      ce <= '0';
      wait for clk_period;
      ce <= '1';
      wait for 15 us;
      ce <= '0';
      
      wait for clk_period;
      mode <= '1';
      ce <= '1';
      wait for 15 us;
      ce <= '0';
      
      wait for clk_period;
      ce <= '1';
      wait for 15 us;
      ce <= '0';
      wait;
   end process;

END;
