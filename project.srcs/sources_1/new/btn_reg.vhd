----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.03.2019 13:55:04
-- Design Name: 
-- Module Name: btn_reg - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

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
