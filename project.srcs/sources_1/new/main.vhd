----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.03.2019 12:24:49
-- Design Name: 
-- Module Name: main - Behavioral
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

entity main is
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
end main;

architecture Behavioral of main is


component clock_divider
    Port (in_clock  : in std_logic;
          enable    : in std_logic;
          out_clock : out std_logic := '0');
end component;

component ALU
    Port ( OP : in STD_LOGIC_VECTOR (3 downto 0);
           A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           result : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component reg_4
    Port ( D : in STD_LOGIC_VECTOR (3 downto 0);
           Clk : in STD_LOGIC;
           En : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (3 downto 0));
end component;



component btn_reg
    Port ( inp : in STD_LOGIC;
           outp : out STD_LOGIC;
           reset : in STD_LOGIC);
end component;

component debounce
    Port ( inp : in STD_LOGIC;
           cclk : in STD_LOGIC;
           clr : in STD_LOGIC;
           outp : out STD_LOGIC);
end component;

component display
    Port ( disp_in : in STD_LOGIC_VECTOR (7 downto 0);
           instr_in : in STD_LOGIC_VECTOR (3 downto 0);
           reg_in : in STD_LOGIC_VECTOR (1 downto 0);
           clk : in STD_LOGIC;
           seg : out STD_LOGIC_VECTOR (7 downto 0);
           disp_out : out STD_LOGIC_VECTOR (6 downto 0));
end component;

component reg_8
    Port ( D : in STD_LOGIC_VECTOR (7 downto 0);
           Clk : in STD_LOGIC;
           En : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component tri_8
    Port ( X : in STD_LOGIC_VECTOR (7 downto 0);
           En : in STD_LOGIC;
           F : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component FSM
    Port ( input : in STD_LOGIC_VECTOR (7 downto 0);
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
end component;

signal main_clock : std_logic;
signal enable_op : std_logic;

signal opcode : std_logic_vector (3 downto 0);

signal btn_reg_in : std_logic;
signal debounce_clr : std_logic;

signal button : std_logic;
signal btn_reg_reset : std_logic;

signal ALU_out : std_logic_vector (7 downto 0);
signal seven_seg_an : std_logic_vector (7 downto 0);

signal seven_seg_out : std_logic_vector (6 downto 0);

signal data_bus : std_logic_vector (7 downto 0);

signal op_A_out : std_logic_vector (7 downto 0);
signal en_op_A : std_logic;

signal reg_G_out : std_logic_vector (7 downto 0);
signal en_reg_G : std_logic;
signal en_tri_G : std_logic;

signal en_tri_EXT : std_logic;

signal en_regs : std_logic_vector (3 downto 0);
signal en_regs_tri : std_logic_vector (3 downto 0);

signal reg0_tri_in : std_logic_vector (7 downto 0);
signal reg1_tri_in : std_logic_vector (7 downto 0);
signal reg2_tri_in : std_logic_vector (7 downto 0);
signal reg3_tri_in : std_logic_vector (7 downto 0);



begin

    CA <= seven_seg_out(0);
    CB <= seven_seg_out(1);
    CC <= seven_seg_out(2);
    CD <= seven_seg_out(3);
    CE <= seven_seg_out(4);
    CF <= seven_seg_out(5);
    CG <= seven_seg_out(6);


    button_debounce : debounce port map(inp => BTNC, cclk => main_clock, clr => debounce_clr, outp => btn_reg_in);
    button_toggle : btn_reg port map(inp => btn_reg_in, outp => button, reset => btn_reg_reset);
    
    
    reg0: reg_8 port map(D => data_bus, Clk => main_clock, En => en_regs(0), Q => reg0_tri_in);
    reg0_tri: tri_8 port map(X => reg0_tri_in, En => en_regs_tri(0), F => data_bus);
    
    reg1: reg_8 port map(D => data_bus, Clk => main_clock, En => en_regs(1), Q => reg1_tri_in);
    reg1_tri: tri_8 port map(X => reg1_tri_in, En => en_regs_tri(1), F => data_bus);
    
    reg2: reg_8 port map(D => data_bus, Clk => main_clock, En => en_regs(2), Q => reg2_tri_in);
    reg2_tri: tri_8 port map(X => reg2_tri_in, En => en_regs_tri(2), F => data_bus);
        
    reg3: reg_8 port map(D => data_bus, Clk => main_clock, En => en_regs(3), Q => reg3_tri_in);
    reg3_tri: tri_8 port map(X => reg3_tri_in, En => en_regs_tri(3), F => data_bus);
        
    
    op_A: reg_8 port map(D => data_bus, Clk => main_clock, En => en_op_A, Q => op_A_out);
    
    reg_G: reg_8 port map(D => ALU_out, Clk => main_clock, En => en_reg_G, Q => reg_G_out);
    tri_G: tri_8 port map(X => reg_G_out, En => en_tri_G, F => data_bus);
    
    tri_EXT: tri_8 port map(X => SW(7 downto 0), En => en_tri_EXT, F => data_bus);

    clock_div: clock_divider port map(in_clock => CLK100MHZ, enable => '1', out_clock => main_clock);
    main_ALU: ALU port map(OP => opcode, A => op_A_out, B => data_bus, result => ALU_out);
    
    main_FSM: FSM port map(input => SW(15 downto 8), execute => button, op => opcode, Clk => main_clock, btn_reset => btn_reg_reset, 
                           enable_regs => en_regs, enable_regs_tri => en_regs_tri,
                           enable_op_A => en_op_A, enable_reg_G => en_reg_G, enable_tri_G => en_tri_G, enable_tri_EXT => en_tri_EXT);
    
    seven_seg: display port map(disp_in => reg_G_out, instr_in => SW(15 downto 12), reg_in => SW(11 downto 10), clk => main_clock, seg => AN, disp_out => seven_seg_out);
    
    --AN <= seven_seg_an;
    
end Behavioral;
