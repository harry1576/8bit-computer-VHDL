library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity testbench is

end testbench;


architecture Behavioral of testbench is
    component main is
    Port ( SW : in STD_LOGIC_VECTOR (15 downto 0);
           BTNC : in STD_LOGIC;
           CLK100MHZ : in STD_LOGIC;
           AN : out STD_LOGIC_VECTOR (7 downto 0);
           CA : out STD_LOGIC;
           CB : out STD_LOGIC;
           CC : out STD_LOGIC;
           CD : out STD_LOGIC;
           CE : out STD_LOGIC;
           CF : out STD_LOGIC;
           CG : out STD_LOGIC);
    end component;

    signal SW : STD_LOGIC_VECTOR (15 downto 0);
    signal BTNC : STD_LOGIC;
    signal CLK100MHZ : STD_LOGIC;
    signal AN : STD_LOGIC_VECTOR (7 downto 0);
    signal CA : STD_LOGIC;
    signal CB : STD_LOGIC;
    signal CC : STD_LOGIC;
    signal CD : STD_LOGIC;
    signal CE : STD_LOGIC;
    signal CF : STD_LOGIC;
    signal CG : STD_LOGIC;
    
    constant clock_period: TIME := 1ns;
    
begin
    clock: main port map(SW => SW, 
                         BTNC => BTNC, 
                         CLK100MHZ => CLK100MHZ,
                         AN => AN, 
                         CA => CA,
                         CB => CB,
                         CC => CC,
                         CD => CD,
                         CE => CE,
                         CF => CF,
                         CG => CG);

    clock_process: process
    begin
        CLK100MHZ <= '0';
        wait for clock_period;
        CLK100MHZ <= '1';
        wait for clock_period;
    end process;
    
    test_process: process
    begin
        SW <= "1001000010001000";
        BTNC <= '1';
        wait for 20 ns;
        
        BTNC <= '0';
        wait for 20 ns;
        
        SW <= "1011000000111100";
        BTNC <= '1';
        wait for 20 ns;
        
        BTNC <= '0';
        wait for 20 ns;
        
        SW <= "0010000000000000";
        BTNC <= '1';
        wait for 20 ns;
        
        BTNC <= '0';
        SW <= "0000000000000000";
        wait;
        
    end process;
    
    
end Behavioral;
        