----------------------------------------------------------------------------------
-- Group 20
-- Create Date: 20.03.2019 16:54:47
-- Module Name: display - Behavioral
-- Description: display module for displaying 4 digits
-- digit 1: OPCODE
-- digit 2: selected register
-- digits 3 & 4: output from register G
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity display is
    Port ( disp_in : in STD_LOGIC_VECTOR (7 downto 0);
           instr_in : in STD_LOGIC_VECTOR (3 downto 0);
           reg_in : in STD_LOGIC_VECTOR (1 downto 0);
           clk : in STD_LOGIC;
           seg : out STD_LOGIC_VECTOR (7 downto 0);
           disp_out : out STD_LOGIC_VECTOR (6 downto 0));
end display;

architecture Behavioral of display is

    signal disp_in_4_bit : STD_LOGIC_VECTOR (3 downto 0);

    type state_type is (instr, reg, outA, outB);
    signal state, next_state : state_type;


begin
    state_register: process(Clk)
    begin
      if (Clk'event and Clk = '1') then
        state <= next_state;
      end if;
    end process state_register;
    
    next_state_func: process(state)
    begin
    -- implements a FSM to allow multiplexing between 4 digits of the 7 segment display
        case state is
         when instr =>
           next_state <= reg;
           seg <= "01111111";
           disp_in_4_bit <= instr_in;
         when reg =>
           next_state <= outA;
           seg <= "11101111";
           disp_in_4_bit <= "00" & reg_in;
         when outA =>
           next_state <= outB;
           seg <= "11111101";
           disp_in_4_bit <= disp_in(7 downto 4);
         when outB =>
           next_state <= instr;
           seg <= "11111110";
           disp_in_4_bit <= disp_in(3 downto 0);
        end case;
    end process next_state_func;
    
    seg_proc: process(disp_in_4_bit)
    begin
        case disp_in_4_bit is
            when "0000"   => disp_out <= "1000000"; -- 0
            when "0001"   => disp_out <= "1111001"; -- 1
            when "0010"   => disp_out <= "0100100"; -- 2
            when "0011"   => disp_out <= "0110000"; -- 3
            when "0100"   => disp_out <= "0011001"; -- 4
            when "0101"   => disp_out <= "0010010"; -- 5
            when "0110"   => disp_out <= "0000010"; -- 6
            when "0111"   => disp_out <= "1111000"; -- 7
            when "1000"   => disp_out <= "0000000"; -- 8
            when "1001"   => disp_out <= "0010000"; -- 9
            when "1010"   => disp_out <= "0001000"; -- A
            when "1011"   => disp_out <= "0000011"; -- b
            when "1100"   => disp_out <= "1000110"; -- C
            when "1101"   => disp_out <= "0100001"; -- d
            when "1110"   => disp_out <= "0000110"; -- E
            when others   => disp_out <= "0001110"; -- F
        end case;
    end process seg_proc;
end Behavioral;
