----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.03.2019 13:10:56
-- Design Name: 
-- Module Name: FSM - Behavioral
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

entity FSM is
    Port ( input : in STD_LOGIC_VECTOR (15 downto 8);
           execute : in STD_LOGIC;
           op : out STD_LOGIC_VECTOR (3 downto 0);
           Clk : in STD_LOGIC;
           btn_reset : out STD_LOGIC;
           
           enable_regs : out STD_LOGIC_VECTOR (3 downto 0);
           enable_regs_tri : out STD_LOGIC_VECTOR (3 downto 0);
           
           enable_op_A : out STD_LOGIC;
           enable_reg_G : out STD_LOGIC;
           enable_tri_G : out STD_LOGIC;
           enable_tri_EXT : out STD_LOGIC);
end FSM;

architecture Behavioral of FSM is

    type state_type is ( idle, load_reg, load_data, out_to_reg, data_to_reg, ALU_op_1, ALU_op_2 );
    signal state, next_state : state_type;

begin

    op <= input(15 downto 12);

    state_register: process(Clk, execute)
    begin
      if (Clk'event and Clk = '1') then
        state <= next_state;
      end if;
    end process state_register;
    
    next_state_func : process (state, execute)
    begin
      case state is
        --only do state changes here - logic in a seperate process
        when idle =>
            if (execute = '1') then
                case input(15 downto 12) is
                    when "1000" => next_state <= load_reg;      --load data from register to reg G
                    when "1001" => next_state <= load_data;     --load data from input to reg G
                    when "1010" => next_state <= out_to_reg;    --write G into register
                    when "1011" => next_state <= data_to_reg;   --write data from input into register
                    when others => next_state <= ALU_op_1;
                end case;
            else
                next_state <= idle;
            end if;
        when load_reg => next_state <= idle;
        when load_data => next_state <= idle;
        when out_to_reg => next_state <= idle;
        when data_to_reg => next_state <= idle;
        when ALU_op_1 => next_state <= ALU_op_2;
        when ALU_op_2 => next_state <= idle;
      end case;
    end process next_state_func;
    
    datapath_func : process (state)
    begin
    case state is
        when idle =>
            btn_reset <= '0';
            
        
            enable_regs_tri <= "0000";
            enable_regs <= "0000";
            
            enable_op_A <= '0';
            enable_reg_G <= '0';
            enable_tri_G <= '0';
            enable_tri_EXT <= '0';
        when load_reg =>                --load data from register to reg G
            btn_reset <= '1';
            enable_regs <= "0000";
            case input(11 downto 10) is --enable register outputs
                when "00" => enable_regs_tri <= "0001";
                when "01" => enable_regs_tri <= "0010";
                when "10" => enable_regs_tri <= "0100";
                when "11" => enable_regs_tri <= "1000";
            end case;
            enable_op_A <= '0';
            enable_reg_G <= '1';
            enable_tri_G <= '0';
            enable_tri_EXT <= '0';
        when load_data =>               --load data from input to reg G
            btn_reset <= '1';
            enable_regs <= "0000";
            enable_regs_tri <= "0000";
            enable_op_A <= '0';
            enable_reg_G <= '1';
            enable_tri_G <= '0';
            enable_tri_EXT <= '1';
        when out_to_reg =>              --write G into register
            btn_reset <= '1';
            case input(11 downto 10) is --enable register inputs
                when "00" => enable_regs <= "0001";
                when "01" => enable_regs <= "0010";
                when "10" => enable_regs <= "0100";
                when "11" => enable_regs <= "1000";
            end case;
            enable_regs_tri <= "0000";
            enable_op_A <= '0';
            enable_reg_G <= '0';
            enable_tri_G <= '1';
            enable_tri_EXT <= '0';
        when data_to_reg =>             --write data from input into register
            btn_reset <= '1';
            case input(11 downto 10) is --enable register inputs
                when "00" => enable_regs <= "0001";
                when "01" => enable_regs <= "0010";
                when "10" => enable_regs <= "0100";
                when "11" => enable_regs <= "1000";
            end case;
            enable_regs_tri <= "0000";            
            enable_op_A <= '0';
            enable_reg_G <= '0';
            enable_tri_G <= '0';
            enable_tri_EXT <= '1';
        when ALU_op_1 =>                --ALU operation with reg G and another register
            btn_reset <= '1';
            enable_regs <= "0000";
            enable_regs_tri <= "0000";
            enable_op_A <= '1';
            enable_reg_G <= '0';
            enable_tri_G <= '1';
            enable_tri_EXT <= '0';
        when ALU_op_2 =>
            btn_reset <= '0';
            enable_regs <= "0000";
            case input(11 downto 10) is --enable register outputs
                when "00" => enable_regs_tri <= "0001";
                when "01" => enable_regs_tri <= "0010";
                when "10" => enable_regs_tri <= "0100";
                when "11" => enable_regs_tri <= "1000";
            end case;
            enable_op_A <= '0';
            enable_reg_G <= '1';
            enable_tri_G <= '0';
            enable_tri_EXT <= '0';
    end case;
    end process datapath_func;
    


end Behavioral;
