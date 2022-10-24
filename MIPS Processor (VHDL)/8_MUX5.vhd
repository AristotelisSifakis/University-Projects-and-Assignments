library IEEE;
use IEEE.std_logic_1164.all;

entity Mux5bit is
    
    Port ( input0  : in  STD_LOGIC_VECTOR(4 downto 0);
           input1  : in  STD_LOGIC_VECTOR(4 downto 0);
	   select0 : in  STD_LOGIC;
           output  : out STD_LOGIC_VECTOR(4 downto 0));

end Mux5bit;

architecture behave of Mux5bit is

begin

process(select0,input0,input1)

begin

if select0 = '0' then
 	output <= input0;

elsif select0 = '1' then
	output <= input1;

end if;

end process;

end behave;