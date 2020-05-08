library IEEE;
use IEEE.std_logic_1164.all;
use  work.Components.all;

entity Mult8CG is
   port (A,B : 	in std_logic_Vector(3 downto 0);
      Start : in std_logic;
      Clk : in std_logic;
      Reset : in std_logic;
      Result : out std_logic_Vector(7 downto 0);
      Done : out std_logic;
      consum: out real :=0.0 );
end Mult8CG;

 architecture InterativeAdd of Mult8CG is
--component ShiftN  
      --port ( CLK : in std_logic; CLR : in std_logic;
              --LD : in std_logic; SH : in std_logic; 
              --DIR : in std_logic;
	      --Sin : in std_logic;
              --D : in std_logic_Vector(3 downto 0); 
              --Q : inout std_logic_Vector(3 downto 0);
	--consum: out real :=0.0);
--end component;

 
  signal M, LO, HI: std_logic_Vector(3 downto 0);
   signal ADDout : std_logic_Vector(3 downto 0);
   signal LDM, LDHI, LDLO, SHHI, SHLO, CLRHI: std_logic := '0' ;
   signal High : std_logic := '1' ;
   signal Low : std_logic := '0' ;
   signal OFL : std_logic ;
   signal CG_EN, CLKG : std_logic;
   signal consum1, consum2, consum3, consum4, consum5 : real;
begin
consum <= consum1+consum2+consum3+consum4+consum5;

CG: clock_gate port map (Enable => CG_EN , CLKin => CLK, CLKout => CLKG, consum  => consum5);

   Result <= Hi & Lo;

SR_M: ShiftN  port map
      ( CLK => CLKG, CLR => RESET, LD => LDM, SH => Low,
        DIR => Low, D => A, Q => M, Sin => '0' , consum=> consum2);

SR_LOW:ShiftN port map
      ( CLK => CLKG, CLR => RESET, LD => LDLO, SH => SHLO,
       DIR => Low, D => B, Q => LO, Sin => Hi(0),consum => consum1 ); 

ALU: Adder4 port map
     ( M, Hi, Cin => Low, Cout => OFL, Sum => ADDout, consum =>consum4);

SR_High: ShiftN  port map
      ( CLK => CLK, CLR => CLRHI, LD => LDHI, SH => SHHI,
       DIR => Low, D => ADDout, Q => HI, Sin => OFL, consum=>consum3); 

FSM: Controller port map
( Start, CLK, LO(0), LDM, LDHI, LDLO, SHHI, SHLO, Done, CLRHI, CG_EN);

end;


