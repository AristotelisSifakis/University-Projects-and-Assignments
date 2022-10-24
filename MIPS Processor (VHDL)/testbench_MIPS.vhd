library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_signed.all;

entity testbench_MIPS is
end testbench_MIPS;

architecture behavioral of testbench_MIPS is
component MIPS
port( clk : in std_logic;
      reset : in std_logic;
      MemRead : out std_logic_vector(31 downto 0);
      MemWrite : out std_logic_vector(31 downto 0);
      memoryOut : out std_logic_vector(4 downto 0);
      aluZeroOut: out std_logic;
      Branch : out std_logic;
      pc_out : out std_logic_vector(31 downto 0);
      instr31_0 : out std_logic_vector(31 downto 0);
      instr31_01 : out std_logic_vector(4 downto 0));
end component;

signal output1 : std_logic_vector(31 downto 0);
signal output2 : std_logic_vector(31 downto 0);
signal output3 : std_logic_vector(4 downto 0);
signal output4 : std_logic;
signal output5 : std_logic_vector(31 downto 0);
signal output6 : std_logic_vector(31 downto 0);
signal output7 : std_logic_vector(4 downto 0);
signal clk1    : std_logic :='0';
signal reset1  : std_logic:='0';


begin
  M1:MIPS port map( 
        clk=>clk1,
        reset=> reset1,
        MemRead => output1,
        MemWrite => output2 ,
        memoryOut => output3,
        aluZeroOut => output4,
        pc_out => output5,
        instr31_0 => output6,
        instr31_01 => output7);
 
 CLOCK_process: process
    begin
    clk1 <= '0';
    wait for 5 ns;
    clk1 <= '1';
    wait for 5 ns;
 end process;
 
 reset_process: process
    begin
    reset1 <= '1';
    wait for 10 ns;
    reset1 <= '0';
    wait;
  end process;
end behavioral;

