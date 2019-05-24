----------------------------------------------------------------------------------
-- Group 20
-- Create Date: 20.03.2019 13:55:04
-- Module Name: btn_reg - Behavioral
-- Description: SR latch for button toggling
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity btn_reg is
    Port ( inp : in STD_LOGIC;
           outp : out STD_LOGIC;
           reset : in STD_LOGIC);
end btn_reg;

architecture Behavioral of btn_reg is

begin
    process(inp, reset)
    begin
        if inp'event and inp = '0' then
            outp <= '1';
        end if;
        if reset = '1' then
            outp <= '0';
        end if;
    end process;
end Behavioral;
