library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity aluControl is

port(clk        : in std_logic;
     aluOp      : in std_logic_vector(1 downto 0); 
     Instr      : in std_logic_vector(5 downto 0); 
     aluControlInstr: out std_logic_vector(3 downto 0));

end aluControl;

architecture Behavioral of aluControl is

begin

process(clk,aluOp)

begin

if clk='1' and clk'event then
	
	if aluOp="00" then aluControlInstr<="0010";
	
	elsif aluOp="01" then aluControlInstr<="1000";
	
	elsif aluOp="10" then
		case Instr is
		   when "100000"=>
			aluControlInstr<="0010";
		   
		   when "100001"=>
			aluControlInstr<="0010";
		   
		   when "100100"=>
			aluControlInstr<="0010";
		   
		   when "001000"=>
			aluControlInstr<="0010";
		   
		   when "100111"=>
			aluControlInstr<="0101";
		   
		   when "100101"=>
			aluControlInstr<="0001";
		   
		   when "101010"=>
			aluControlInstr<="0111";
		   
		   when "101011"=>
			aluControlInstr<="0111";
		   
		   when "000000"=>
			aluControlInstr<="0011";
		   
		   when "000010"=>
			aluControlInstr<="0100";
		   
		   when "100010"=>
			aluControlInstr<="0110";
		   
		   when "100011"=>
			aluControlInstr<="0110";
		   
		   when others=>
			aluControlInstr<="1110";
		
		end case;
	
	else aluControlInstr<="1111";
	
	end if;

end if;

end process;

end Behavioral;