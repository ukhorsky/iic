----------------------------------------------------------------------------------

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity iic_top is
    generic ( mode : character := 'M' );
    port(
        clk : in std_logic;
        d_in : in std_logic_vector(15 downto 0);
        scl_bus : in std_logic;
        sda_bus : in std_logic;
        d_out : out std_logic_vector(15 downto 0);
        scl_pd : out std_logic;
        sda_pd : out std_logic;
        rst : in std_logic
    );
end iic_top;

architecture rtl of iic_top is

    signal mask_reg : std_logic_vector(7 downto 0);
    signal data_reg : std_logic_vector(7 downto 0);

begin
    
    
    -- data processing registers
    
    
    process (reg_rst, clk)
    begin
        if (reg_rst = '1') then
            mask_reg <= (others => '0');
        elsif (rising_edge(clk)) then
            if (mask_ce = '1') then
                mask_reg <= '1' & mask_reg(7 downto 1);
            end if;
        end if;    
    end process;
    
    process (clk)
    begin
        if (rising_edge(clk)) then
            if (data_reg_l = '1') then
                -- data_reg <= 
            elsif (data_reg_ce = '1') then
            end if;
        end if;    
    end process;
    

end rtl;

