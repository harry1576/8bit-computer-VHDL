----------------------------------------------------------------------------------
-- Group 20
-- Create Date: 20.03.2019 20:58:18
-- Module Name: reg_8 - Behavioral
-- Description: 8 bit register
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg_8 is
    Port ( D : in STD_LOGIC_VECTOR (7 downto 0);
           Clk : in STD_LOGIC;
           En : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (7 downto 0));
end reg_8;

architecture Behavioral of reg_8 is
begin
    process(Clk)
    begin
        if Clk'event and Clk = '1' then
            if En = '1' then
                Q <= D;
            end if;
        end if;
    end process;
end Behavioral;
