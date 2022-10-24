library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;  

entity RegisterFile is
  
  Port ( ReadRegister1 : in STD_LOGIC_VECTOR (4 downto 0);
         ReadRegister2 : in STD_LOGIC_VECTOR (4 downto 0);
         WriteRegister : in STD_LOGIC_VECTOR (4 downto 0);
         WriteData     : in STD_LOGIC_VECTOR (31 downto 0);
         RegWrite      : in STD_LOGIC;
         ReadData1     : out STD_LOGIC_VECTOR ( 31 downto 0);
         ReadData2     : out STD_LOGIC_VECTOR (31 downto 0));
       
end RegisterFile;

architecture Behavioral of RegisterFile is 

  
  type reg_type is array (0 to 2**5-1 ) of std_logic_vector (31 downto 0);

  signal array_reg : reg_type := (      x"00000000", 
                                        x"11111111",
                                        x"22222222",
                                        x"33333333",
                                        x"44444444",
                                        x"55555555",
                                        x"66666666",
                                        x"77777777",
                                        x"88888888",
                                        x"99999999",
                                        x"aaaaaaaa",
                                        x"bbbbbbbb",
                                        x"cccccccc",
                                        x"dddddddd",
                                        x"eeeeeeee",
                                        x"ffffffff",
                                        x"00000000", 
                                        x"11111111",
                                        x"22222222",
                                        x"33333333",
                                        x"44444444",
                                        x"55555555",
                                        x"66666666",
                                        x"77777777",
                                        x"88888888",
                                        x"99999999",
                                        x"aaaaaaaa",
                                        x"bbbbbbbb",
                                        x"10008000",
                                        x"7FFFF1EC",
                                        x"eeeeeeee",
                                        x"ffffffff" );
begin

  process(RegWrite)
  begin
     if ( RegWrite = '1' ) then
       array_reg(to_integer(unsigned(WriteRegister))) <= WriteData;
     end if;
  end process;
  
  ReadData1 <= array_reg(to_integer(unsigned(ReadRegister1)));
  ReadData2 <= array_reg(to_integer(unsigned(ReadRegister2)));
   
                                      
end Behavioral;

  