----------------------------------------------------------------------------------
-- Group 20
-- Create Date: 20.03.2019 13:45:27
-- Module Name: debounce - Behavioral
-- Description: Delays button inputs for 3 clock cycles, outputs '1' when all delays are '1'
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity debounce is
    Port ( inp : in STD_LOGIC;
           clk : in STD_LOGIC;
           clr : in STD_LOGIC;
           outp : out STD_LOGIC);
end debounce;

architecture Behavioral of debounce is
signal delay1, delay2, delay3: STD_LOGIC;
begin
    process(clk, clr)
    begin
        if clr = '1' then
            delay1 <= '0';
            delay2 <= '0';
            delay3 <= '0';
        elsif clk'event and clk = '1' then
            delay1 <= inp;
            delay2 <= delay1;
            delay3 <= delay2;
        end if;
    end process;
    outp <= delay1 and delay2 and delay3;
end Behavioral;
