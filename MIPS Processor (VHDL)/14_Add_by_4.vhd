library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity addshift4 is
	
        port ( X: in std_logic_vector(31 downto 0);
	       Z: out std_logic_vector(31 downto 0));

end entity;

architecture behavioral of addshift4 is
	
   begin
	
        Z <= X+4;

end behavioral;
