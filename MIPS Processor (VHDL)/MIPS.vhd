library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_signed.all;


entity MIPS is
    Port ( reset : in STD_LOGIC;
           clk   : in STD_LOGIC);
end MIPS;

architecture struct of MIPS is

component addshift4
    port ( X : in std_logic_vector(31 downto 0);
           Z : out std_logic_vector(31 downto 0));
end component;

component add
    port (X,Y : in std_logic_vector(31 downto 0);
            Z : out std_logic_vector(31 downto 0));
end component;

component ALU_Reg
    port( clk      : in std_logic;
          Input1   : in std_logic_vector(31 downto 0);
          Input2   : in std_logic_vector(31 downto 0);
          shAmt    : in std_logic_vector(4 downto 0);
          aluControlSignal : in std_logic_vector(3 downto 0);
          ZeroOut : out std_logic;
          aluResult :out std_logic_vector(31 downto 0));
end component;

component ProgramCounter
    Port ( input  : in  STD_LOGIC_VECTOR (31 downto 0);
           reset  : in  STD_LOGIC;
           clk    : in  STD_LOGIC;
           output : out STD_LOGIC_VECTOR (31 downto 0));
end component;

component SignExtend
    Port ( input : in  STD_LOGIC_VECTOR (15 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component Mux32bit
    Port ( input0  : in   STD_LOGIC_VECTOR(31 downto 0);
           input1  : in   STD_LOGIC_VECTOR(31 downto 0);
           select0 : in   STD_LOGIC;
           output  : out  STD_LOGIC_VECTOR(31 downto 0));
end component;

component Mux5bit
    Port ( input0  : in  STD_LOGIC_VECTOR(4 downto 0);
           input1  : in     STD_LOGIC_VECTOR(4 downto 0);
           select0 : in STD_LOGIC;
           output  : out  STD_LOGIC_VECTOR(4 downto 0));
end component;

component instructionmem
   port ( read_addr : in STD_LOGIC_VECTOR (31 downto 0);
          instruct  : out STD_LOGIC_VECTOR (31 downto 0));
end component;

component aluControl
   port( clk : in std_logic;
         aluOp : in std_logic_vector(1 downto 0); 
         Instr : in std_logic_vector(5 downto 0); 
         aluControlInstr : out std_logic_vector(3 downto 0));
end component;

component Reg
    port (  ReadAddress1 : in std_logic_vector(4 downto 0);
            ReadAddress2 : in std_logic_vector(4 downto 0);
            writeAddress : in std_logic_vector(4 downto 0);
            write_data   : in STD_LOGIC_VECTOR (31 downto 0);
            clk,RegWrite : in STD_LOGIC;
            read_data1   : out STD_LOGIC_VECTOR (31 downto 0);
            read_data2   : out STD_LOGIC_VECTOR (31 downto 0));
end component;

component memory
    port ( address    : in STD_LOGIC_VECTOR (31 downto 0);
           write_data : in STD_LOGIC_VECTOR (31 downto 0);
           MemWrite   : in STD_LOGIC;
           MemRead    : in STD_LOGIC;
           ck         : in STD_LOGIC;
           read_data  : out STD_LOGIC_VECTOR (31 downto 0));
end component;

component control
   port(  Instr    : in std_logic_vector(5 downto 0);
          RegDst   : out std_logic;
          Branch   : out std_logic;
          MemRead  : out std_logic;
          MemtoReg : out std_logic;
          MemWrite : out std_logic;
          ALUSrc   : out std_logic;
          RegWrite : out std_logic;
          ALUOp    : out std_logic_vector(1 downto 0));
end component;

           -- SIGNAL DECLARING

             -- MUX 32 out
signal mux1out   :STD_LOGIC_VECTOR (31 downto 0);
signal mux2out   :STD_LOGIC_VECTOR (31 downto 0);
signal mux3out   :STD_LOGIC_VECTOR (31 downto 0);
signal muxchoise : STD_LOGIC;

              -- Mux 5 out
signal mux5bitout : STD_LOGIC_VECTOR(4 downto 0);

              -- Control Out
signal RegDst   : std_logic;
signal Branch   : std_logic;
signal MemRead  : std_logic;
signal MemtoReg : std_logic;
signal MemWrite : std_logic;
signal ALUSrc   : std_logic;
signal RegWrite : std_logic;
signal ALUOp    : std_logic_vector(1 downto 0);

              -- add 4 out
signal add4out : STD_LOGIC_VECTOR (31 downto 0);

                 -- PC out
signal pc_out : STD_LOGIC_VECTOR (31 downto 0);

         -- instruction memory out
signal instr31_0 : STD_LOGIC_VECTOR(31 downto 0);

           -- register read out
signal registerRead1 : STD_LOGIC_VECTOR (31 downto 0);
signal registerRead2 : STD_LOGIC_VECTOR (31 downto 0);

             -- sign extend out
signal signExtendout : STD_LOGIC_VECTOR (31 downto 0);
 
     --add(with alu result then goes into mux 1) out
signal add_out : STD_LOGIC_VECTOR (31 downto 0);

                  -- ALU out
signal aluResultOut : std_logic_vector(31 downto 0);
signal aluZeroOut : STD_LOGIC;

                 -- Memory out
signal memoryOut : std_logic_vector(31 downto 0);

              -- ALU Control Out
signal aluControlOut : std_logic_vector(3 downto 0);

                 -- START WIRING

 
 begin
      
 
      pc:        ProgramCounter   port map(mux2out,clk,reset,pc_out);

      add4:      addshift4        port map(pc_out, add4out);

      instmem:   instructionmem   port map(pc_out,instr31_0);

      ctrl:      control          port map(instr31_0(31 downto 26),RegDst,Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite,ALUOp);

      mx2:       Mux5bit          port map(instr31_0(20 downto 16),instr31_0(15 downto 11), RegDst, mux5bitout);

      mainReg:   Reg              port map(instr31_0(25 downto 21), instr31_0(20 downto 16), mux5bitout, mux3out,clk,RegWrite,registerRead1,registerRead2);

      signEx:    SignExtend       port map(instr31_0(15 downto 0), signExtendout);

      ad:        add              port map(add4out,add_out);
      
      mx1:       Mux32bit         port map(add4out, add_out, muxchoise, mux1out);
     
      mx3:       Mux32bit         port map(registerRead2,signExtendout,ALUSrc,mux2out);

      mx4:       Mux32bit         port map(aluResultOut,memoryOut,MemtoReg,mux3out);
    
      alu:       ALU_Reg          port map(clk, registerRead1, mux3out, instr31_0(10 downto 6), aluControlOut,aluZeroOut,aluResultOut);

      aluC:      aluControl       port map(clk, ALUOp,instr31_0(5 downto 0),aluControlOut);

      mem:       memory           port map(aluResultOut,registerRead2,MemWrite,MemRead,clk, memoryOut);

end struct;
