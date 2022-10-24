library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity InstructionMemory is
   Port ( ReadAddress : in STD_LOGIC_VECTOR (31 downto 0);
          Instruction : out STD_LOGIC_VECTOR (31 downto 0));
  

end InstructionMemory;

architecture Behavioral of InstructionMemory is 

  type RAM_16_x_32 is array(0 to 15) of std_logic_vector(31 downto 0);

  signal IM : RAM_16_x_32 := ( x"01285024",
                               x"018b6825",
                               x"01285020",
                               x"01285022",
                               x"0149402a",
                               x"1211fffb",
                               x"01285024",
                               x"018b6825",
                               x"01285020",
                               x"01285022",
                               x"0149402a",
                               x"08100000",
                               x"00000000",
                               x"00000000",
                               x"00000000",
                               x"00000000" );

begin
  
  Instruction <= x"00000000" when ReadAddress = x"003FFFFC" else
            IM( (to_integer(unsigned(ReadAddress))- 4194304)/4 );


end Behavioral;

  
