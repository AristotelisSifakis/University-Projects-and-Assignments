library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity SignExtend is
    
    Port ( input  : in  STD_LOGIC_VECTOR (15 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));

end SignExtend;

architecture behavioral of SignExtend is

begin

	Output <= std_logic_vector(resize(signed(Input), Output'length));

end behavioral;
