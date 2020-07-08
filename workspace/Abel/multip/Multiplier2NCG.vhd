library IEEE;
use IEEE.std_logic_1164.all;
use  work.Components.all;

entity Mult2NCG is
    generic ( Domain: integer := 1;
			 N : integer := 4 ;
			 log2N : integer := 2);
	port (
		--pragma synthesis_off
		vcc : in real;
		--pragma synthesis_on   
		A,B : 	in std_logic_Vector(N - 1 downto 0);
		Start : in std_logic;
		Clk : in std_logic;
		Reset : in std_logic;
		Result : out std_logic_Vector(2*N - 1 downto 0);
		Done : out std_logic );
end Mult2NCG;

architecture InterativeAdd of Mult2NCG is
 
	signal M, LO, HI: std_logic_Vector(N - 1 downto 0);
	signal ADDout : std_logic_Vector(N - 1 downto 0);
	signal LDM, LDHI, LDLO, SHHI, SHLO, CLRHI: std_logic := '0' ;
	signal High : std_logic := '1' ;
	signal Low : std_logic := '0' ;
	signal OFL : std_logic ;
	signal CG_EN, CLKG : std_logic;

begin


CG: clock_gate generic map (Domain => Domain) port map (Enable => '1' , CLKin => CLK, CLKout => CLKG, vcc => 3.3);
--   CLKG <= CLK;
   Result <= Hi & Lo;

SR_M: ShiftN generic map (Domain => Domain, N=>N) port map
      ( CLK => CLKG, CLR => RESET, LD => LDM, SH => Low,
        DIR => Low, D => A, Q => M, Sin => '0' , vcc => 3.3 );

SR_LOW:ShiftN generic map (Domain => Domain, N=>N) port map
      ( CLK => CLKG, CLR => RESET, LD => LDLO, SH => SHLO,
       DIR => Low, D => B, Q => LO, Sin => Hi(0),vcc => 3.3 ); 

ALU: AdderN generic map (Domain => Domain, N=>N) port map
     ( A => M, B => Hi, Cin => Low, Cout => OFL, Sum => ADDout, vcc => 3.3);

SR_High: ShiftN generic map (Domain => Domain, N=>N) port map
      ( CLK => CLK, CLR => CLRHI, LD => LDHI, SH => SHHI,
       DIR => Low, D => ADDout, Q => HI, Sin => OFL, vcc => 3.3); 

--FSM: Controller generic map (Domain => Domain) port map
--( Start, CLK, LO(0), LDM, LDHI, LDLO, SHHI, SHLO, Done, CLRHI, CG_EN);
FSM: Controller_structural generic map (Domain => Domain, N=>N, log2N => log2N) port map
( 3.3, Start, CLK, Reset, LO(0), LDM, LDHI, LDLO, SHHI, SHLO, Done, CLRHI, CG_EN);

end;


