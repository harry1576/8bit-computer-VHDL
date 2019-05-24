----------------------------------------------------------------------------------
-- Group 20
-- Create Date: 20.03.2019 21:13:54
-- Module Name: tri_8 - Behavioral
-- Description: 8 bit tristate buffer
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tri_8 is
    Port ( X : in STD_LOGIC_VECTOR (7 downto 0);
           En : in STD_LOGIC;
           F : out STD_LOGIC_VECTOR (7 downto 0));
end tri_8;

architecture Behavioral of tri_8 is
begin
    F <= (others => 'Z') when En = '0' else X;
end Behavioral;
