library IEEE;
use IEEE.std_logic_1164.all;
--use IEEE.std_logic_unsigned.all;

package Components is

component full_adder 
	generic ( Domain: integer := 1);
	port (
		--pragma synthesis_off
		vcc : in real;
		--pragma synthesis_on
		a,b,cin : in  std_logic;
		sum,cout : out  std_logic);
end component;

component Adder4
	generic ( Domain: integer := 1);
	port (
		--pragma synthesis_off
		vcc : in real;
		--pragma synthesis_on
		A,B : in std_logic_Vector(3 downto 0);
		Cin: in std_logic;
		Cout : out std_logic;
		Sum : out std_logic_Vector ( 3 downto 0));
end component ;

component Controller
	generic ( Domain: integer := 1);
    port ( Start : in std_logic; CLK : in std_logic;
		LSB : in std_logic; LDM : out std_logic;
		LDHI : out std_logic;  LDLO: out std_logic;
		SHHI : out std_logic; SHLO : out std_logic ;
		Done, CLRHI, CG_EN: out std_logic);
end component;

component clock_gate 
	generic ( Domain: integer := 1);
  	port (
		--pragma synthesis_off
		vcc : in real;
		--pragma synthesis_on
		Enable, CLKin : in  std_logic; 
        CLKout: out std_logic);
end component;

component BistD is
 	generic ( Domain: integer := 1);
 	port (
		--pragma synthesis_off
		vcc : in real;
		--pragma synthesis_on
		PRE, CLR, CLK, D : in  std_logic; 
        Q, Qbar: out std_logic);
end component;

component Shift4 is 
	generic ( Domain: integer := 1);
  	port (
		--pragma synthesis_off
		vcc : in real;
		--pragma synthesis_on            
		CLK : in std_logic; CLR : in std_logic;
		LD : in std_logic; SH : in std_logic; 
		DIR : in std_logic;
		Sin : in std_logic;
		D : in std_logic_Vector(3 downto 0); 
		Q : inout std_logic_Vector(3 downto 0));
end component;

component shift_cell is
	generic ( Domain: integer := 1);
	port (
       --pragma synthesis_off
       vcc : in real;
       --pragma synthesis_on
       CLK,CLR: in std_logic;
       Dir, DirN : in std_logic;
       SH, LD : in std_logic;
       SR, SL : in std_logic;
       D : in std_logic;
       Q : inout std_logic;
       Consum: out real := 0.0);
end component;

end Components;

----------------------------------------------------------------------
----------------------------------------------------------------------

library ieee;  
use ieee.std_logic_1164.all;  
--use ieee.std_logic_arith.all;  
--use ieee.std_logic_unsigned.all; 
 
entity adder4 is  
	generic ( Domain: integer := 1);
	port(   
		--pragma synthesis_off
		vcc : in real;
		--pragma synthesis_on
		A,B : in std_logic_vector(3 downto 0);  
		Cin  : in std_logic;  
		SUM : out std_logic_vector(3 downto 0);  
		Cout  : out std_logic);  
end adder4;  

architecture structural of adder4 is  

	component full_adder is 
		generic ( Domain: integer := 1);
		port (
	           --pragma synthesis_off
			   vcc : in real;
			   --pragma synthesis_on
			   A,B,Cin : in  std_logic;
			   Sum,Cout : out  std_logic);
	end component;

signal C1,C2,C3,C4: std_logic;

begin 
U1: full_adder generic map (Domain => Domain) port map  ( a=> A(0), b=> B(0), Cin => '0', SUM => SUM(0), Cout=> C1, vcc => 3.3 );
U2: full_adder generic map (Domain => Domain) port map  ( a=> A(1), b=> B(1), Cin => C1, SUM => SUM(1), Cout=> C2, vcc => 3.3 );
U3: full_adder generic map (Domain => Domain) port map  ( a=> A(2), b=> B(2), Cin => C2, SUM => SUM(2), Cout=> C3, vcc => 3.3 );
U4: full_adder generic map (Domain => Domain) port map  ( a=> A(3), b=> B(3), Cin => C3, SUM => SUM(3), Cout=> C4, vcc => 3.3 );
Cout <= C4;

end architecture;

----------------------------------------------------------------------
----------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity Controller is
	generic ( Domain: integer := 1);
	port ( Start : in std_logic; CLK : in std_logic;
		LSB : in std_logic; LDM : out std_logic;
		LDHI : out std_logic;  LDLO: out std_logic;
		SHHI : out std_logic; SHLO : out std_logic; 
		Done, CLRHI, CG_EN : out std_logic);
end Controller;


architecture FSM of Controller is
	type States  is ( InitS, Checks, AddS, ShiftS, DoneS );
	signal State : StateS := InitS ;
        signal Counter: integer;
begin
-- Drive control outputs based upon State--
	LDM <= '1' when State = InitS else '0' ;
	LDHI<= '1' when State = addS else '0' ;
	LDLO <= '1' when State = InitS else '0' ;
    SHHI <= '1' when State = ShiftS else '0' ;
	SHLO <= '1' when State = ShiftS else '0' ;
	CLRHI <= '0' when state = Inits else  '1';
	Done <= '1' when State = DoneS else '0' ;
	CG_EN <= '0' when State = Checks or State = Dones or state = adds else '1';
-- Determine Next State from control inputs--
StateMachine :
	process (CLK)
	begin
		if CLK'Event and CLK = '0' then
			case State is
				when Inits =>
					if Start = '1' then 
						state <= checks;
					else 
						state <= initS;
					end if;
				when Checks  =>
					if LSB = '1' then
						State <=  AddS ;
					
					else
						State <= Shifts;
					end if;
				when Adds =>
					State <= Shifts;
				when ShiftS => 
					if counter = 4 then 
						State <= DoneS;
					else 
						state <= checks;
					end if;
				when DoneS => state <= InitS;
			end case;
		end if;
	end process;

	process (CLK)
	begin 
		if (rising_edge (CLK)) then 
			if (state = inits) then 
				counter <= 0;
			elsif state = checks then 
				counter <= counter + 1;
			end if;
		end if;
    end process;

end;	

----------------------------------------------------------------------
----------------------------------------------------------------------

library ieee;  
use ieee.std_logic_1164.all;  
--use ieee.std_logic_arith.all;  
--use ieee.std_logic_unsigned.all; 

entity full_adder is
	generic ( Domain: integer := 1);
	port (
           --pragma synthesis_off
           vcc : in real;
           --pragma synthesis_on
           a,b,cin : in  std_logic;
           sum,cout : out  std_logic);
end full_adder;


architecture fa_str of full_adder is

component xor2              
	generic ( Domain: integer := 1);
	port (
		--pragma synthesis_off
		vcc : in real;
		--pragma synthesis_on
		a,b: in  std_logic;      
		o: out std_logic);
end component ;  

component or2              
	generic ( Domain: integer := 1);
	port (
		--pragma synthesis_off
		vcc : in real;
		--pragma synthesis_on
		a,b: in  std_logic;      
		o: out std_logic);
end component ;  

component and2              
	generic ( Domain: integer := 1);
	port (
		--pragma synthesis_off
		vcc : in real;
		--pragma synthesis_on
		a,b: in  std_logic;      
		o: out std_logic);
end component ;  

signal s1,s2,s3,s4,s5:std_logic;

begin
	x1:xor2 generic map (Domain => Domain) port map(3.3,a,b,s1);
	x2:xor2 generic map (Domain => Domain) port map(3.3,s1,cin,sum);
	r1:and2 generic map (Domain => Domain) port map(3.3,a,b,s2);
	r2:and2 generic map (Domain => Domain) port map(3.3,b,cin,s3);
	r3:and2 generic map (Domain => Domain) port map(3.3,a,cin,s4);
	o1:or2 generic map (Domain => Domain) port map(3.3,s2,s3,s5);
	o2:or2 generic map (Domain => Domain) port map(3.3,s4,s5,cout);
end fa_str;


--------------------------------------------------------------------
--------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity clock_gate is
	generic ( Domain: integer := 1);
	port (
        --pragma synthesis_off
        vcc : in real;
        --pragma synthesis_on
        Enable, CLKin : in  std_logic; 
        CLKout: out std_logic);

end entity clock_gate;

architecture structural of clock_gate is 

	component and2              
	generic ( Domain: integer := 1);
	port (
		  --pragma synthesis_off
		  vcc : in real;
		 --pragma synthesis_on
			a,b: in  std_logic;      
		  o: out std_logic);
	end component ;   

begin 

	U2: and2 generic map (Domain => Domain) port map ( vcc => 3.3, A => Enable, B => CLKin, o=> CLKout);

end architecture;

--------------------------------------------------------------------
--------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity BistD is
	generic ( Domain: integer := 1);
	port (
        --pragma synthesis_off
        vcc : in real;
        --pragma synthesis_on
        PRE, CLR, CLK, D : in  std_logic; 
        Q, Qbar: out std_logic);
end entity BistD;

architecture structural of BistD is 

	component nand3              
	generic ( Domain: integer := 1);
	port (
		  --pragma synthesis_off
		  vcc : in real;
		 --pragma synthesis_on
			a,b,c: in  std_logic;      
		  o: out std_logic);
	end component ;    
	 
	signal U1out,U2out,U3out,U4out,U5out,U6out : std_logic;

begin
	-- implemenation using the edge triggered D type flip flop 74xx74
	U1:nand3 generic map (Domain => Domain) port map (a=> PRE, b=> U4out, c=>  U2out, o=> U1out, vcc => 3.3);
	U2:nand3 generic map (Domain => Domain) port map (a=> U1out, b=> CLR, c=>  CLK, o=> U2out, vcc => 3.3);
	U3:nand3 generic map (Domain => Domain) port map (a=> U2out, b=> CLK, c=>  U4out, o=> U3out, vcc => 3.3);
	U4:nand3 generic map (Domain => Domain) port map (a=> U3out, b=> CLR, c=>  D, o=> U4out, vcc => 3.3);
	U5:nand3 generic map (Domain => Domain) port map (a=> PRE, b => U2out, c=>  U6out, o=> U5out, vcc => 3.3);
	U6:nand3 generic map (Domain => Domain) port map (a=> U5out, b=> CLR, c=>  U3out, o=> U6out, vcc => 3.3);
	Q <= U5out;
	Qbar <= U6out;

end architecture;

--------------------------------------------------------------------
--------------------------------------------------------------------

library ieee;  
use ieee.std_logic_1164.all;  
--use ieee.std_logic_arith.all;  
--use ieee.std_logic_unsigned.all; 

entity Shift4 is 
	generic ( Domain: integer := 1);
	port (
          --pragma synthesis_off
          vcc : in real;
          --pragma synthesis_on
          CLK : in std_logic; CLR : in std_logic;
          LD : in std_logic; SH : in std_logic; 
          DIR : in std_logic;
	      Sin : in std_logic;
          D : in std_logic_Vector(3 downto 0); 
          Q : inout std_logic_Vector(3 downto 0));
end entity;

architecture Behavior of Shift4 is


	component inv1              
	generic ( Domain: integer := 1);
	port (
		  --pragma synthesis_off
		  vcc : in real;
		 --pragma synthesis_on
			a: in  std_logic;      
		  o: out std_logic);
	end component ; 
	
	component shift_cell 
	generic ( Domain: integer := 1);
	port ( 
		   --pragma synthesis_off
		   vcc : in real;
		   --pragma synthesis_on
		   CLK, CLR : in std_logic;
		   Dir, DirN : in std_logic;
		   SH, LD : in std_logic;
		   SR, SL : in std_logic;
		   D : in std_logic;
		   Q : inout std_logic);	end component;

	signal DirN: std_logic;

begin

U1 : inv1 generic map (Domain => Domain) port map (a => DIR, o => DirN, vcc => 3.3);
U2 : shift_cell generic map (Domain => Domain) port map ( CLK => CLK, CLR => CLR, Dir => DIR, DirN => DirN, SH => SH, LD => LD, SR => Sin, SL => Q(2), D=> D(3), Q=>Q(3), vcc => 3.3);
U3 : shift_cell generic map (Domain => Domain) port map ( CLK => CLK, CLR => CLR, Dir => DIR, DirN => DirN, SH => SH, LD => LD, SR => Q(3), SL => Q(1), D=> D(2), Q=>Q(2), vcc => 3.3);
U4 : shift_cell generic map (Domain => Domain) port map ( CLK => CLK, CLR => CLR, Dir => DIR, DirN => DirN, SH => SH, LD => LD, SR => Q(2), SL =>  Q(0), D=> D(1), Q=>Q(1), vcc => 3.3);
U5 : shift_cell generic map (Domain => Domain) port map ( CLK => CLK, CLR => CLR, Dir => DIR, DirN => DirN, SH => SH, LD => LD, SR => Q(1), SL => Sin, D=> D(0), Q=>Q(0), vcc => 3.3);

end architecture;

--------------------------------------------------------------------
--------------------------------------------------------------------

library IEEE;
use ieee.std_logic_1164.all;  

entity shift_cell is
	generic ( Domain: integer := 1);
	port ( 
	   --pragma synthesis_off
	   vcc : in real;
	   --pragma synthesis_on
	   CLK,CLR: in std_logic;
       Dir, DirN : in std_logic;
       SH, LD : in std_logic;
       SR, SL : in std_logic;
       D : in std_logic;
       Q : inout std_logic );
end entity;

architecture structural of shift_cell is

	component and3              
	generic ( Domain: integer := 1);
	port (
		  --pragma synthesis_off
		  vcc : in real;
		 --pragma synthesis_on
			a,b,c: in  std_logic;      
		  o: out std_logic);
	end component ;

	component and2              
	generic ( Domain: integer := 1);
	port (
		  --pragma synthesis_off
		  vcc : in real;
		 --pragma synthesis_on
			a,b: in  std_logic;      
		  o: out std_logic);
	end component ;

	component nor2              
	generic ( Domain: integer := 1);
	port (
		  --pragma synthesis_off
		  vcc : in real;
		 --pragma synthesis_on
			a,b: in  std_logic;      
		  o: out std_logic);
	end component ;
	
	component or4              
	generic ( Domain: integer := 1);
	port (
		  --pragma synthesis_off
		  vcc : in real;
		 --pragma synthesis_on
			a,b,c,d: in  std_logic;      
		  o: out std_logic);
	end component ;

	component inv1              
	generic ( Domain: integer := 1);
	port (
		  --pragma synthesis_off
		  vcc : in real;
		 --pragma synthesis_on
			a : in  std_logic;      
		  o: out std_logic);
	end component ;

	component BistD --.//slxlib/bistD -- de discutat
	generic ( Domain: integer := 1);
	port ( 
		--pragma synthesis_off
		vcc : in real;
		--pragma synthesis_on
		PRE, CLR, CLK, D : in  std_logic; 
		Q, Qbar: out std_logic );
	end component;

signal R,L, Load, Dlatch, Hold,Qold: std_logic;

begin

	U1: and3 generic map (Domain => Domain) port map (a=>SR, b=>SH, c=>DIRN,o=>R, vcc => 3.3 );
	U2: and3 generic map (Domain => Domain) port map (a=>SL, b=>SH, c=>DIR,o=>L, vcc => 3.3 );
	U3: and2 generic map (Domain => Domain) port map (a=>LD, b=>D, o=>LOAD, vcc => 3.3  );
	U4: nor2 generic map (Domain => Domain) port map (a=> LD, b => SH, o => Hold, vcc => 3.3 );
	U5: and2 generic map (Domain => Domain) port map  (a=> Hold, b => Q, o => Qold, vcc => 3.3 );
	U6: or4 generic map (Domain => Domain) port map (a=>R, b=>L, c=> LOAD, d => Qold, o=>DLatch, vcc => 3.3 );
	U7: BistD generic map (Domain => Domain) port map (D=>DLatch  , Q=> Q, CLK => CLK, CLR => CLR, PRE => '1', vcc => 3.3 );

end architecture;


--------------------------------------------------------------------
--------------------------------------------------------------------


library IEEE;
use ieee.std_logic_1164.all; 

entity Counter is
generic ( Domain: integer := 1);
	port (
        vcc : in real;
        CLK, init, check : in  std_logic; 
        Q : out std_logic_vector(2 downto 0));
end entity Counter;

architecture structural of Counter is

	
	component inv1              
	generic ( Domain: integer := 1);
	port (
		  vcc : in real;
		  a : in  std_logic;      
		  o: out std_logic);
	end component ;
	
	component or2              
	generic ( Domain: integer := 1);
	port (
		  vcc : in real;
		  a, b : in  std_logic;      
		  o: out std_logic);
	end component ;
	
	component and3              
	generic ( Domain: integer := 1);
	port (
		  vcc : in real;
		  a, b, c : in  std_logic;      
		  o: out std_logic);
	end component ;
	
	component bistD is
		generic ( Domain: integer := 1);
		port (
        --pragma synthesis_off
        vcc : in real;
        --pragma synthesis_on
        PRE, CLR, CLK, D : in  std_logic; 
        Q, Qbar: out std_logic);
    end component;
	
	signal C: std_logic_vector(2 downto 0);
	signal initn, checkn, c0n, net1, net2 : std_logic;
	
begin
	
	bist0 : bistD generic map (Domain => Domain) port map (D=>C(0)  , Q=> C(0), CLK => CLK, CLR => init, PRE => '1', vcc => 3.3 );
	bist1 : bistD generic map (Domain => Domain) port map (D=>C(1)  , Q=> C(1), CLK => C(0), CLR => init, PRE => '1', vcc => 3.3 );
	bist2 : bistD generic map (Domain => Domain) port map (D=>C(2)  , Q=> C(2), CLK => C(1), CLR => init, PRE => '1', vcc => 3.3 );
	
	poarta1: or2 generic map (Domain => Domain) port map (a => net1, b => net2, o => C(0), vcc => 3.3);
	poarta2: and3 generic map (Domain => Domain) port map (a => C(0), b => initn, c => checkn, o =>  net1, vcc => 3.3 );
	poarta3: and3 generic map (Domain => Domain) port map (a => c0n, b => initn, c => check, o =>  net2, vcc => 3.3 );
	
	inversor1: inv1 generic map (Domain => Domain) port map (a => init, o => initn, vcc => 3.3 );
	inversor2: inv1 generic map (Domain => Domain) port map (a => check, o => checkn, vcc => 3.3 );
	inversor3: inv1 generic map (Domain => Domain) port map (a => C(0), o => c0n, vcc => 3.3 );
	
	
end architecture;


--------------------------------------------------------------------
--------------------------------------------------------------------



library IEEE;
use ieee.std_logic_1164.all; 

entity Test_Counter is
end entity;

architecture Test of Test_Counter is

	component Counter ...
	
	signal clk, init, check : std_logic;
	
	signal count : std_logic_vector(2 downto 0);

begin

	instanta_counter : counter port map ( ...
	
	generare_semnal_tact: process
	begin
		clk <= '0';
		wait for 5 ns;
		clk <= '1';
		wait for 5 ns;
	end process;
	
	init <= '0' , '1' after 50 ns;
	check <= '1', '0' after 60 ns, '1' after 70 ns;
	
end architecture;


		
   
