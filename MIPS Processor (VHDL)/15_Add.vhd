library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity add is
	
        port ( X,Y : in std_logic_vector(31 downto 0);
	         Z : out std_logic_vector(31 downto 0));

end entity;

architecture behavioral of add is
	
    begin
	
         Z <= X+Y;

end behavioral;
