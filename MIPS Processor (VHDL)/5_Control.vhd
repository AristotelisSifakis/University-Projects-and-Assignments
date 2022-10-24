library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity control is

port( Instr    : in std_logic_vector(5 downto 0);
      RegDst   : out std_logic;
      Branch   : out std_logic;
      MemRead  : out std_logic;
      MemtoReg : out std_logic;
      MemWrite : out std_logic;
      ALUSrc   : out std_logic;
      RegWrite : out std_logic;
      ALUOp    : out std_logic_vector(1 downto 0));

end control;

architecture Behavioral of control is

begin
  
  process(Instr)
    
    begin
      
      case Instr is
	       when "000000"=>
	         RegDst<='1'; 
	         Branch<='0'; 
	         MemRead<='0'; 
	         MemtoReg<='0'; 
	         MemWrite<='0';
	         RegWrite<='1'; 
	         ALUSrc<='0';
	         ALUOp<="10";
	       when "001000"=>
	         RegDst<='0'; 
	         Branch<='0';
	         MemRead<='0'; 
	         MemtoReg<='0'; 
	         MemWrite<='0'; 
	         RegWrite<='1';
	         ALUSrc<='1'; 
	         ALUOp<="00";
	       when "001001"=>
	         RegDst<='0'; 
	         Branch<='0'; 
	         MemRead<='0'; 
	         MemtoReg<='0'; 
	         MemWrite<='0'; 
	         ALUSrc<='1';
	         RegWrite<='1'; 
	         ALUOp<="01";
	       when "001100"=>
	         RegDst<='0';
	         Branch<='0';
	         MemRead<='0';
	         MemtoReg<='0';
	         MemWrite<='0';
	         ALUSrc<='1';
	         RegWrite<='1';
	         ALUOp<="11";
	      when "000100"=>
	         RegDst<='0';
	         Branch<='1'; 
	         MemRead<='0'; 
	         MemtoReg<='0';
	         MemWrite<='0';
	         ALUSrc<='0';
	         RegWrite<='0';
	         ALUOp<="01";
	      when "000101"=>
	         RegDst<='0';
	         Branch<='1';
	         MemRead<='0';
	         MemtoReg<='0';
	         MemWrite<='0';
	         ALUSrc<='0';
	         RegWrite<='0';
	         ALUOp<="11";
	      when "000011"=>
	         RegDst<='0';
	         Branch<='0';
	         MemRead<='0';
	         MemtoReg<='0';
	         MemWrite<='0';
	         ALUSrc<='0';
	         RegWrite<='1';
	         ALUOp<="00";
	when "100100"=>
	  RegDst<='0';
	  Branch<='0';
	  MemRead<='1';
	  MemtoReg<='1';
	  MemWrite<='0';
	  ALUSrc<='1';
	  RegWrite<='1';
	  ALUOp<="00";
	when "100101"=>
	  RegDst<='0';
	  Branch<='0';
	  MemRead<='1';
	  MemtoReg<='1';
	  MemWrite<='0';
	  ALUSrc<='1';
	  RegWrite<='1';
	  ALUOp<="00";
	when "110000"=>
	  RegDst<='0';
	  Branch<='0';
	  MemRead<='1';
	  MemtoReg<='1';
	  MemWrite<='0';
	  ALUSrc<='1';
	  RegWrite<='1';
	  ALUOp<="00";
	when "001111"=>
	  RegDst<='0';
	  Branch<='0';
	  MemRead<='0';
	  MemtoReg<='1';
	  MemWrite<='0';
	  ALUSrc<='1';
	  RegWrite<='1';
	  ALUOp<="00";
	when "100011"=>
	  RegDst<='0';
	  Branch<='0';
	  MemRead<='1';
	  MemtoReg<='1';
	  MemWrite<='0';
	  ALUSrc<='1';
	  RegWrite<='1';
	  ALUOp<="00";
	when "001101"=>
	  RegDst<='0';
	  Branch<='0';
	  MemRead<='0';
	  MemtoReg<='1';
	  MemWrite<='0';
	  ALUSrc<='1';
	  RegWrite<='1';
	  ALUOp<="01";
	when "001010"=>
	  RegDst<='0';
	  Branch<='0';
	  MemRead<='0';
	  MemtoReg<='0';
	  MemWrite<='0';
	  ALUSrc<='1';
	  RegWrite<='1';
	  ALUOp<="00";
	when "001011"=>
	  RegDst<='0';
	  Branch<='0';
	  MemRead<='0';
	  MemtoReg<='0';
	  MemWrite<='0';
	  ALUSrc<='1';
	  RegWrite<='1';
	  ALUOp<="00";
	when "101000"=>
	  RegDst<='0';
	  Branch<='0';
	  MemRead<='0';
	  MemtoReg<='0';
	  MemWrite<='1';
	  ALUSrc<='1';
	  RegWrite<='0';
	  ALUOp<="00";
	when "111000"=>
	  RegDst<='0';
	  Branch<='0';
	  MemRead<='0';
	  MemtoReg<='0';
	  MemWrite<='1';
	  ALUSrc<='1';
	  RegWrite<='0';
	  ALUOp<="00";
	when "101001"=>
	  RegDst<='0';
	  Branch<='0';
	  MemRead<='0';
	  MemtoReg<='0';
	  MemWrite<='1';
	  ALUSrc<='1';
	  RegWrite<='0';
	  ALUOp<="00";
	when "101011"=>
	  RegDst<='0';
	  Branch<='0';
	  MemRead<='0';
	  MemtoReg<='0';
	  MemWrite<='1';
	  ALUSrc<='1';
	  RegWrite<='0';
	  ALUOp<="00";
	when others=>
	  RegDst<='0';
	  Branch<='0';
	  MemRead<='0';
	  MemtoReg<='0';
	  MemWrite<='0';
	  ALUSrc<='0';
	  RegWrite<='0';
	  ALUOp<="00";
   
    end case;

  end process;
  
end Behavioral;