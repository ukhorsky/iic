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

    constant scl_low_period : std_logic_vector(7 downto 0) := x"3f"; -- (128 - 65)
    constant scl_high_period : std_logic_vector(7 downto 0) := x"60"; -- (128 - 65)
    
    signal ct_reg : std_logic_vector(7 downto 0);
    signal ct_reg_load : std_logic_vector(7 downto 0);
    signal scl_pd_int : std_logic;
    signal l : std_logic;
    signal q : std_logic;
    
begin
    
    scl_pd <= scl_pd_int;    
    q <= ct_reg(ct_reg'left);    
    l <= not ce or scl_pd_int;
    ct_reg_load <= scl_low_period when (l = '0') else scl_high_period;
    
    process (rst, clk)
    begin
        if (rst = '1') then
            ct_reg <= (others => '1');
        elsif (rising_edge(clk)) then            
            if (q = '1') then
                ct_reg <= ct_reg_load;
            elsif (ce = '1') then
                ct_reg <= conv_std_logic_vector(conv_integer(ct_reg) + 1, ct_reg'length);
            end if;
        end if;
    end process;

    process(ce, clk)
    begin
        if (ce = '0') then
            scl_pd_int <= '0';
        elsif (rising_edge(clk)) then
            scl_pd_int <= scl_pd_int xor q;
        end if;
    end process;

end rtl;

