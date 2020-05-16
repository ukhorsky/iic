----------------------------------------------------------------------------------
-- SCL signal generator for IIC master. A very simole Moore machine :)
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity iic_scl_gen is
    port(
        clk : in std_logic;
        ce : in std_logic;
        mode : in std_logic; --! 0 for Fast Mode and 1 for High-Speed Mode
        scl_pd : out std_logic;
        rst : in std_logic
    );
end iic_scl_gen;

architecture rtl of iic_scl_gen is

    signal ct_reg : std_logic_vector(5 downto 0);
    signal lh_reg : std_logic_vector(9 downto 0);
    signal scl_pd_int : std_logic;
    signal n : std_logic;
    signal q : std_logic;
    
begin
    
    scl_pd <= scl_pd_int;    
    q <= ct_reg(ct_reg'left);    
    
    process(ce, clk)
    begin
        if (ce = '0') then
            ct_reg <= "000001";
        elsif (rising_edge(clk)) then
            ct_reg <= ct_reg(ct_reg'left - 1 downto 0) & ct_reg(ct_reg'left);
        end if;
    end process;

    -- n signal logic
    process (mode, lh_reg, q, scl_pd_int)
    begin
        case mode is
            when '0' =>
                n <= (not scl_pd_int and q and lh_reg(3)) or (lh_reg(9) and q);                
            when '1' =>
                n <= (not scl_pd_int and q) or (lh_reg(1) and q);
            when others =>
                null;
        end case;
    end process;

    process(rst, clk)
    begin
        if (rst = '1') then
            lh_reg <= (others =>  '0');
        elsif (rising_edge(clk)) then
            if (n ='1') then
                lh_reg <= (others => '0');
            elsif (q = '1') then
                lh_reg <= lh_reg(lh_reg'left - 1 downto 0) & '1';
            end if;
        end if;
    end process;

    -- Moore FSM
    process(ce, clk)
    begin
        if (ce = '0') then
            scl_pd_int <= '0';
        elsif (rising_edge(clk)) then
            if (n = '1') then
                scl_pd_int <= scl_pd_int xor q;
            end if;
        end if;
    end process;

end rtl;

