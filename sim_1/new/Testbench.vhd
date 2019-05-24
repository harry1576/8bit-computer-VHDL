----------------------------------------------------------------------------------
-- Group 20
-- Description: Testbench for testing button debounce module
-- enables input for 1 clock cycle, 2 cycles, 3 cycles, and 4 cycles. disables
-- input for 1 clock cycle between each test.
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity testbench is

end testbench;


architecture Behavioral of testbench is
    component debounce is
    Port ( inp : in STD_LOGIC;
           clk : in STD_LOGIC;
           clr : in STD_LOGIC;
           outp : out STD_LOGIC);
    end component;

    signal inp : STD_LOGIC;
    signal clk : STD_LOGIC;
    signal clr : STD_LOGIC;
    signal outp : STD_LOGIC;
    
    constant clock_period: TIME := 1ns;
    
begin
    clock: debounce port map(   inp => inp,
                                clk => clk,
                                clr => clr,
                                outp => outp);

    clock_process: process
    begin
        clk <= '0';
        wait for clock_period / 2;
        clk <= '1';
        wait for clock_period / 2;
    end process;
    
    test_process: process
    begin
        inp <= '1'; 
        wait for clock_period;
        
        inp <= '0'; 
        wait for clock_period;
        
        inp <= '1'; 
        wait for 2 * clock_period;
        
        inp <= '0'; 
        wait for clock_period;
        
        inp <= '1'; 
        wait for 3 * clock_period;
                
        inp <= '0'; 
        wait for clock_period;
                
        inp <= '1'; 
        wait for 4 * clock_period;
                        
        inp <= '0'; 
        wait for clock_period;
    end process;
end Behavioral;
        