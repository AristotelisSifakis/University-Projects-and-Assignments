library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity leftShifter is
    
          Port ( input  : in  STD_LOGIC_VECTOR (31 downto 0);           
	         output : out STD_LOGIC_VECTOR(31 downto 0));			  

end leftShifter;

architecture Behavioral of leftShifter is

begin
	output <=  std_logic_vector(unsigned(input) sll 2);

end Behavioral;

