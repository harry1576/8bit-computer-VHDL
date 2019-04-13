----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.03.2019 21:13:54
-- Design Name: 
-- Module Name: tri_8 - Behavioral
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

entity tri_8 is
    Port ( X : in STD_LOGIC_VECTOR (7 downto 0);
           En : in STD_LOGIC;
           F : out STD_LOGIC_VECTOR (7 downto 0));
end tri_8;

architecture Behavioral of tri_8 is

begin
    F <= (others => 'Z') when En = '0' else X;
end Behavioral;
