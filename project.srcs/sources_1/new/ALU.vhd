----------------------------------------------------------------------------------
-- Group 20
-- Create Date: 20.03.2019 12:35:54
-- Module Name: ALU - Behavioral
-- Description: ALU for logic and unsigned integer operations
-- Supports logic operations from opcodes:
-- 0000 -> AND
-- 0001 -> OR
-- 0010 -> Addition
-- 0011 -> Subtraction
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- take two operands, A and B, and perform logic operation specified by OP
entity ALU is
    Port ( OP : in STD_LOGIC_VECTOR (3 downto 0);
           A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           result : out STD_LOGIC_VECTOR (7 downto 0));
end ALU;


architecture Behavioral of ALU is
begin
    acc : process (OP, A, B) is
    begin
     case OP is
       when "1000" => result <= B;
       when "1001" => result <= B;
       when "0000" => result <= A AND B;
       when "0001" => result <= A OR B;
       when "0010" => result <= A + B;
       when others => result <= A - B;
     end case;
    end process acc;
end Behavioral;
