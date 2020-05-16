----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity iic_if_fsm is
    port(
        clk : in std_logic;
        cs : in std_logic;
        w : in std_logic;
        byte : in std_logic;
        sda : in std_logic;
        scl_int : in std_logic;
        scl_ce : out std_logic;
        sda_pd : out std_logic;
        nb : out std_logic;
        rst : in std_logic
    );
end iic_if_fsm;

architecture rtl of iic_if_fsm is

    type state is (S0, S1, S2, S3, S4);
    
    signal c_state, n_state : state;

begin

    process (clk)
    begin
        if (rst = '1') then
            c_state <= S0;
        elsif (rising_edge(clk)) then
            c_state <= n_state;
        end if;
    end process;

    process (c_state, cs, byte, sda, scl_int)
    begin
        case c_state is
            when S0 =>
                if (cs = '1') then
                    n_state <= S1;
                else
                    n_state <= S0;
                end if;
            when S1 =>
                if (scl_int = '0') then                
                    n_state <= S2;
                else
                    n_stae <= S1;
                end if;
            when S2 =>
            when S3 =>
            when S4 =>
                if (scl_int = '1') then                
                    n_state <= S0;
                else
                    n_stae <= S4;
                end if;
            when others =>
                null;
        end case;
    end process;
    
    process (clk)
    begin
        if (rst = '1') then
            scl_ce <= '0';
            sda_pd <= '0';
            nxt <= '0';
        elsif (rising_edge(clk)) then
            case c_state is
                when S0 =>
                    scl_ce <= '0';
                    sda_pd <= '0';
                    nxt <= '0';
                when S1 =>
                    scl_ce <= '1';
                    sda_pd <= '1';
                    nxt <= '0';
                when S2 =>
                    scl_ce <= '1';
                    sda_pd <= '0';
                    nxt <= '0';
                when S3 =>
                    scl_ce <= '1';
                    sda_pd <= '0';
                    nxt <= '0';
                when S4 =>
                    scl_ce <= '0';
                    sda_pd <= '0';
                    nxt <= '0';
                when others =>
                    null;
            end case;
        end if;
    end process;
    
end rtl;

