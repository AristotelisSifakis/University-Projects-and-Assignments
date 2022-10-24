library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DataMemory is
  Port ( Address   : in STD_LOGIC_VECTOR (31 downto 0);
         WriteData : in STD_LOGIC_VECTOR (31 downto 0);
         MemRead   : in STD_LOGIC;
         MemWrite  : in STD_LOGIC;
         ReadData  : out STD_LOGIC_VECTOR (31 downto 0));
end DataMemory;

architecture Behavioral of DataMemory is
  
  type RAM_16_x_32 is array(0 to 15) of std_logic_vector(31 downto 0);
  
  signal DM : RAM_16_x_32 := ( x"00000000",
                               x"00000000",
                               x"00000000",
                               x"00000000",
                               x"00000000",
                               x"00000000",
                               x"00000000",
                               x"00000000",
                               x"00000000",
                               x"00000000",
                               x"00000000",
                               x"00000000",
                               x"00000000",
                               x"00000000",
                               x"00000000",
                               x"00000000" );
  
begin

  process(MemWrite, MemRead)
  begin
		if ( MemWrite = '1' ) then
			DM(   ( to_integer(unsigned(Address))- 268500992  )/4  ) <= WriteData;
		end if;
		
		if ( MemRead = '1' ) then
			ReadData <= DM(   ( to_integer(unsigned(Address))- 268500992  )/4  );
		end if;
	end process;

end Behavioral;

