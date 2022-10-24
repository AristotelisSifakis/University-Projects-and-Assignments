library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
use ieee.numeric_std.all;


entity ALU is
    port( clk: in std_logic;
          Input1:in std_logic_vector(31 downto 0);
          Input2:in std_logic_vector(31 downto 0);
          shAmt: in std_logic_vector(4 downto 0);
          aluControlSignal: in std_logic_vector(3 downto 0);
          ZeroOut: out std_logic;
          aluResult:out std_logic_vector(31 downto 0));
end ALU;

architecture Behavioral of ALU is

begin

process (clk,Input1,Input2)

variable tempInt: integer:=0;

variable tempInt2: integer:=0;

begin

if clk='1' and clk'event then
	case aluControlSignal is
	  when "0000"=>
	     ZeroOut<='0';aluResult<=Input1 and Input2;
	  when "0001"=>
	     ZeroOut<='0';aluResult<=Input1 or Input2;
	  when "0010"=>
	     tempInt:=to_integer(signed(Input1)+signed(Input2));
	     ZeroOut<='0';aluResult<=std_logic_vector(to_signed(tempInt,32));
	  when "0011"=>
	     tempInt:=to_integer(signed(shAmt));
	     ZeroOut<='0';aluResult<=std_logic_vector(signed(Input2) sll tempInt);
	  when "0100"=>
	     tempInt:=to_integer(signed(shAmt));
	     ZeroOut<='0';aluResult<=std_logic_vector(signed(Input2) srl tempInt);
	  when "0101"=>
	     ZeroOut<='0';aluResult<=Input1 nor Input2;
	  when "0110"=>
	     tempInt:=to_integer(signed(Input1)-signed(Input2));
	     if tempInt=0 then ZeroOut<='1'; else ZeroOut<='0'; end if;
	     tempInt:=to_integer(signed(Input1)-signed(Input2));
	     aluResult<=std_logic_vector(to_signed(tempInt,32));
	  when "0111"=>
	     if signed(Input1)<signed(Input2) then aluResult<=(0 downto 0=>'1',others=>'0'); else aluResult<=(others=>'0'); end if;
	     ZeroOut<='0';
	  when "1111"=>
	     tempInt:=to_integer(signed(Input1)-signed(Input2));
	     if tempInt=0 then ZeroOut<='0'; else ZeroOut<='1'; end if;
	     aluResult<=Input1 and Input2;
	  when "1000"=>
	     tempInt:=to_integer(signed(Input1)-signed(Input2));
	     if tempInt=0 then ZeroOut<='1'; else ZeroOut<='0'; end if;
	     aluResult<=Input1 or Input2;
	  when others=>
	     ZeroOut<='0';aluResult<=(others=>'0');
	
	end case;

end if;

end process;

end Behavioral;
