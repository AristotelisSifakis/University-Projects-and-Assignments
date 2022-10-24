library IEEE;
use IEEE.std_logic_1164.all;

entity ProgramCounter is
    Port ( input  : in  STD_LOGIC_VECTOR (31 downto 0);
           reset  : in  STD_LOGIC;
           clk    : in  STD_LOGIC;
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end ProgramCounter;

architecture behavioral of ProgramCounter is

begin

process(reset,clk)
  
begin
    if reset='1' then
       output <= (others=>'0');
    else
       if clk='1' and clk'event then
             output<=input;
       end if;
    end if;  
  end process;
  
end behavioral;

