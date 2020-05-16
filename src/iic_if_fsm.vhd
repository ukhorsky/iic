----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity iic_if_fsm is
    port(
        clk : in std_logic;
        cs : in std_logic;
        d_in : in std_logic_vector(7 downto 0);
        sda_in : in std_logic;
        scl_pd : in std_logic;
        d_out : out std_logic_vector(7 downto 0);        
        sda_pd : out std_logic;
        rst : in std_logic
    );
end iic_if_fsm;

architecture rtl of iic_if_fsm is

    type state is (S0, S1, S2, S3, S4);
    
    signal c_state, n_state : state;
    signal d_buf : std_logic_vector(8 downto 0);
    signal byte_type : std_logic_vector(1 downto 0); -- 

begin

    process (clk)
    begin
        if (rising_edge(clk)) then
            c_state <= n_state;
        end if;
    end process;

    process (c_state)
    begin
        case c_state is
            when S0 =>
            when S1 =>
            when S2 =>
            when others =>
                null;
        end case;
    end process;
    
    process (clk)
    begin
        if (rising_edge(clk)) then
            case c_state is
                when others =>
                    null;
            end case;
        end if;
    end process;
    
end rtl;

