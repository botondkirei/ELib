library IEEE;
use IEEE.std_logic_1164.all;
--use IEEE.std_logic_unsigned.all;


package Components is

component full_adder 
    port ( a,b,cin : in  std_logic;
           sum,cout : out  std_logic;
           Consum: out real := 0.0);
end component;

component  and2               
generic (c_comutat : real := 1.0e-8 );

port (a,b: in  std_logic;      
      o: out std_logic;           
      consum : out real := 0.0);
end component;

component or2                  
generic (c_comutat : real := 1.0e-8);

port (a,b: in  std_logic;      
      o: out std_logic;           
      consum : out real := 0.0);
end component;
 component   xor2              
generic (c_comutat : real := 1.0e-8);

port (a,b: in  std_logic;      
      o: out std_logic;           
      consum : out real := 0.0);
end component ;    


component Adder4
         port ( A,B : in std_logic_Vector(3 downto 0);
                 Cin: in std_logic;
                 Cout : out std_logic;
                 Sum : out std_logic_Vector ( 3 downto 0);
		consum : out real := 0.0);
       end component ;

component Controller
             port ( Start : in std_logic; CLK : in std_logic;
                LSB : in std_logic; LDM : out std_logic;
                LDHI : out std_logic;  LDLO: out std_logic;
                SHHI : out std_logic; SHLO : out std_logic ;
                Done, CLRHI, CG_EN: out std_logic);
        end component;

component clock_gate 
	port (Enable, CLKin : in  std_logic; 
        CLKout: out std_logic; 
        Consum: out real := 0.0);
end component;

component LatchD is
port (PRE, CLR, CLK, D : in  std_logic; 
        Q, Qbar: out std_logic; 
        Consum: out real := 0.0);
end component;

component nand3 is                 
generic (c_comutat : real := 1.0e-8 );

port (a,b,c: in  std_logic;      
      o: out std_logic;           
      consum : out real := 0.0);
end component;   

component ShiftN is 
      port ( CLK : in std_logic; CLR : in std_logic;
              LD : in std_logic; SH : in std_logic; 
              DIR : in std_logic;
	      Sin : in std_logic;
              D : in std_logic_Vector(3 downto 0); 
              Q : inout std_logic_Vector(3 downto 0);
	Consum: out real := 0.0);
end component;

component inv is                 
generic (c_comutat : real := 1.0e-8 );

port (a: in  std_logic;      
      o: out std_logic;           
      consum : out real := 0.0);
end component;

component shift_cell is
port ( CLK,CLR: in std_logic;
       Dir, DirN : in std_logic;
       SH, LD : in std_logic;
       SR, SL : in std_logic;
       D : in std_logic;
       Q : inout std_logic;
       Consum: out real := 0.0);
end component;

component and3 is                 
generic (c_comutat : real := 1.0e-8 );

port (a,b,c: in  std_logic;      
      o: out std_logic;           
      consum : out real := 0.0);
end component; 

component nor2 is                 
generic (c_comutat : real := 1.0e-8 );

port (a,b: in  std_logic;      
      o: out std_logic;           
      consum : out real := 0.0);
end component; 

component or4 is                 
generic (c_comutat : real := 1.0e-8 );

port (a,b,c,d: in  std_logic;      
      o: out std_logic;           
      consum : out real := 0.0);
end component;    

end Components;

library ieee;  
use ieee.std_logic_1164.all;  
use ieee.std_logic_arith.all;  
use ieee.std_logic_unsigned.all; 
 
entity adder4 is  
     port(A,B : in std_logic_vector(3 downto 0);  
         Cin  : in std_logic;  
         SUM : out std_logic_vector(3 downto 0);  
         Cout  : out std_logic;
         Consum: out real := 0.0);  
end adder4;  

architecture structural of adder4 is  

component full_adder is 
 port ( A,B,Cin : in  std_logic;
           Sum,Cout : out  std_logic;
           Consum: out real := 0.0);
end component;

signal C1,C2,C3,C4: std_logic;
signal consum1,consum2,consum3,consum4: real;
begin 
 U1: full_adder port map  ( a=> A(0), b=> B(0), Cin => '0', SUM => SUM(0), Cout=> C1, consum => consum1);
 U2: full_adder port map  ( a=> A(1), b=> B(1), Cin => C1, SUM => SUM(1), Cout=> C2, consum => consum2);
 U3: full_adder port map  ( a=> A(2), b=> B(2), Cin => C2, SUM => SUM(2), Cout=> C3, consum => consum3);
 U4: full_adder port map  ( a=> A(3), b=> B(3), Cin => C3, SUM => SUM(3), Cout=> C4, consum => consum4);
 
Cout <= C4;
consum <= consum1 + consum2 + consum3 + consum4;

end architecture;


library IEEE;
use IEEE.std_logic_1164.all;

entity Controller is
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
					if Start = '1' then state <= checks;
                                        else state <= initS;
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
					if counter = 4 then State <= DoneS;
                                        else state <= checks;
				         end if;
				when DoneS => state <= InitS;
			end case;
		end if;
	end process;

     process (CLK)
           begin 
                if (rising_edge (CLK)) then 
                     if (state = inits) then counter <= 0;
                     elsif state = checks then counter <= counter + 1;
                      end if;
                end if;
    end process;

end;	

library ieee;  
use ieee.std_logic_1164.all;  
use ieee.std_logic_arith.all;  
use ieee.std_logic_unsigned.all; 



entity full_adder is
    port ( a,b,cin : in  std_logic;
           sum,cout : out  std_logic;
           Consum: out real := 0.0);
end full_adder;


architecture fa_str of full_adder is

component xor2
	port(a,b:in std_logic;
	     f:out std_logic;
             consum : out real := 0.0);
end component;

component or2
	port(a,b:in std_logic;
	     f:out std_logic;
             consum : out real := 0.0);
end component;

component and2
	port(a,b:in std_logic;
	     f:out std_logic;
             consum : out real := 0.0);
end component;

signal s1,s2,s3,s4,s5:std_logic;
signal consum1,consum2,consum3,consum4,consum5,consum6,consum7: real;
begin
	x1:xor2 port map(a,b,s1,consum1);
	x2:xor2 port map(s1,cin,sum,consum2);
	r1:and2 port map(a,b,s2,consum3);
	r2:and2 port map(b,cin,s3,consum4);
	r3:and2 port map(a,cin,s4,consum5);
	o1:or2 port map(s2,s3,s5,consum6);
	o2:or2 port map(s4,s5,cout,consum7);
consum <= consum1 + consum2 + consum3 + consum4 + consum5 + consum6 + consum7;
end fa_str;

library ieee;
use ieee.std_logic_1164.all;



entity or2 is                 
generic (c_comutat : real := 1.0e-8);

port (a,b: in  std_logic;      
      o: out std_logic;           
      consum : out real := 0.0);
end or2;    



architecture primitive of or2 is   
	
signal nr_comutari : real :=0.0;
signal ointern : std_logic;

begin
  
   ointern <= a or b ;                    
                                    

	process (ointern)
 	begin
		nr_comutari <= nr_comutari + 1.0;
	end process;

	consum <= c_comutat * nr_comutari;

	o <= ointern;

end primitive;   
library ieee;
use ieee.std_logic_1164.all;



entity xor2 is                 
generic (c_comutat : real := 1.0e-8);

port (a,b: in  std_logic;      
      o: out std_logic;           
      consum : out real := 0.0);
end xor2;    



architecture primitive of xor2 is   
	
signal nr_comutari : real :=0.0;
signal ointern : std_logic;

begin
  
   ointern <= a xor b ;                    
                                    

	process (ointern)
 	begin
		nr_comutari <= nr_comutari + 1.0;
	end process;

	consum <= c_comutat * nr_comutari;

	o <= ointern;

end primitive;

library ieee;
use ieee.std_logic_1164.all;



entity and2 is
	generic (
		Domain : integer := 1;
		Cin : real := 4.8e-15;
		Cpd : real := 28.9e-15; 
		pleack : real := 1.16e-9;
		Area : real := 1.7
		);
	port ( 
	  --pragma synthesis_off
	  vcc : in real;
	 --pragma synthesis_on
	 a,b : in std_logic;
	 O : out  std_logic );
begin
	PM.monitorInput(o, Cpd, Vcc, Domain);
	PM.monitorInput(a, Cin, Vcc, Domain);
	PM.monitorInput(b, Cin, Vcc, Domain);
	AM.addArea(Area,Domain);
	PM.addLeackage(pleack,1);
end entity;



architecture primitiv of and2 is
begin
	O <= (a and b);
end architecture;

begin
  
   ointern <= a and b ;                    
                                     

	process (ointern)
 	begin
		nr_comutari <= nr_comutari + 1.0;
	end process;

	consum <= c_comutat * nr_comutari;

	o <= ointern after 1 ns;

end primitive;    

library ieee;
use ieee.std_logic_1164.all;

entity clock_gate is

port (Enable, CLKin : in  std_logic; 
        CLKout: out std_logic; 
        Consum: out real := 0.0);

end entity clock_gate;

architecture structural of clock_gate is 


component and2 
port (a,b: in  std_logic;     
      o: out std_logic;            
      consum : out real := 0.0);
end component;  

signal consum1: real;

begin 
U2: and2 port map ( A => Enable, B => CLKin, o=> CLKout, consum => consum1);

consum <= consum1 ;
end architecture;


library ieee;
use ieee.std_logic_1164.all;

entity LatchD is

port (PRE, CLR, CLK, D : in  std_logic; 
        Q, Qbar: out std_logic; 
        Consum: out real := 0.0);

end entity LatchD;

architecture structural of LatchD is 

component nand3 
port (a,b,c: in  std_logic;     
      o: out std_logic;            
      consum : out real := 0.0);
end component;   
 
signal U1out,U2out,U3out,U4out,U5out,U6out : std_logic;
signal consum1,consum2,consum3,consum4,consum5,consum6: real;


begin

U1:nand3 port map (a=> PRE, b=> U4out, c=>  U2out, o=> U1out, consum=> consum1);
U2:nand3 port map (a=> U1out, b=> CLR, c=>  CLK, o=> U2out, consum=> consum2);
U3:nand3 port map (a=> U2out, b=> CLK, c=>  U4out, o=> U3out, consum=> consum3);
U4:nand3 port map (a=> U3out, b=> CLR, c=>  D, o=> U4out, consum=> consum4);
U5:nand3 port map (a=> PRE, b=> U2out, c=>  U6out, o=> U5out, consum=> consum5);
U6:nand3 port map (a=> U5out, b=> CLR, c=>  U3out, o=> U6out, consum=> consum6);
 Q <= U5out;
 Qbar <= U6out;
consum <= consum1+consum2+consum3+consum4+consum5+consum6;

end architecture;


library ieee;
use ieee.std_logic_1164.all;

library IEEE;
use IEEE.std_logic_1164.all;
use work.pmonitor.all;

entity nand3 is
	generic (
		Domain : integer := 1;
		Cin : real := 5.0e-15;
		Cpd : real := 7.77e-15;
		pleack : real := 0.9e-9;
		Area : real := 1.7
		);
	port ( 
	  --pragma synthesis_off
	  vcc : in real;
	 --pragma synthesis_on
	 a,b,c : in std_logic;
	 O : out  std_logic );
begin
	PM.monitorInput(o, Cpd, Vcc, Domain);
	PM.monitorInput(a, Cin, Vcc, Domain);
	PM.monitorInput(b, Cin, Vcc, Domain);
	PM.monitorInput(c, Cin, Vcc, Domain);
	AM.addArea(Area,Domain);
	PM.addLeackage(pleack,1);
end entity;
architecture primitiv of nand3 is
begin
	O <= not (a and b and c);
end architecture;

begin
  
   ointern <= not (a and b and c);                    
                                     

	process (ointern)
 	begin
		nr_comutari <= nr_comutari + 1.0;
	end process;

	consum <= c_comutat * nr_comutari;

	o <= ointern after 1 ns;

end primitive;    

library ieee;  
use ieee.std_logic_1164.all;  
use ieee.std_logic_arith.all;  
use ieee.std_logic_unsigned.all; 

entity ShiftN is 
      port ( CLK : in std_logic; CLR : in std_logic;
              LD : in std_logic; SH : in std_logic; 
              DIR : in std_logic;
	      Sin : in std_logic;
              D : in std_logic_Vector(3 downto 0); 
              Q : inout std_logic_Vector(3 downto 0);
	Consum: out real := 0.0);
end entity;

architecture Behavior of ShiftN is


	component inv is 
	generic (c_comutat : real := 1.0e-8 );

	port ( a: in std_logic;
		   o: out std_logic;
			Consum: out real := 0.0);
	end component;
	
	component shift_cell 
	port ( CLK, CLR : in std_logic;
		   Dir, DirN : in std_logic;
		   SH, LD : in std_logic;
		   SR, SL : in std_logic;
		   D : in std_logic;
		   Q : inout std_logic;
		   Consum: out real := 0.0);
	end component;

	signal DirN: std_logic;

	signal consum1, consum2, consum3, consum4, consum5: real;

begin

U1 : inv port map (a => DIR, o => DirN, consum =>consum1);
U2 : shift_cell port map ( CLK => CLK, CLR => CLR, Dir => DIR, DirN => DirN, SH => SH, LD => LD, SR => Sin, SL => Q(2), D=> D(3), Q=>Q(3), consum => consum2);
U3 : shift_cell port map ( CLK => CLK, CLR => CLR, Dir => DIR, DirN => DirN, SH => SH, LD => LD, SR => Q(3), SL => Q(1), D=> D(2), Q=>Q(2), consum => consum3);
U4 : shift_cell port map ( CLK => CLK, CLR => CLR, Dir => DIR, DirN => DirN, SH => SH, LD => LD, SR => Q(2), SL =>  Q(0), D=> D(1), Q=>Q(1), consum => consum4);
U5 : shift_cell port map ( CLK => CLK, CLR => CLR, Dir => DIR, DirN => DirN, SH => SH, LD => LD, SR => Q(1), SL => Sin, D=> D(0), Q=>Q(0), consum => consum5);

consum<=consum1+consum2+consum3+consum4+consum5;

end architecture;


library ieee;
use ieee.std_logic_1164.all;

library IEEE;
use IEEE.std_logic_1164.all;
use work.pmonitor.all;

entity inv1 is
	generic (
		Domain : integer := 1;
		Cin : real := 3.5e-15;
		Cpd : real := 3.95e-15;
		pleack : real := 0.35e-9;
		Area : real := 1.0
		);
	port ( 
	  --pragma synthesis_off
	  vcc : in real;
	 --pragma synthesis_on
	 a : in std_logic;
	 O : out  std_logic );
begin
	PM.monitorInput(o, Cpd, Vcc, Domain);
	PM.monitorInput(a, Cin, Vcc, Domain);
	AM.addArea(Area,Domain);
	PM.addLeackage(pleack,1);
end entity;
architecture primitiv of inv1 is
begin
	O <= not a;
end architecture;


begin
  
   ointern <= not a ;                    
                                    

	process (ointern)
 	begin
		nr_comutari <= nr_comutari + 1.0;
	end process;

	consum <= c_comutat * nr_comutari;

	o <= ointern;

end primitive;    

library IEEE;
use ieee.std_logic_1164.all;  

entity shift_cell is
port ( CLK,CLR: in std_logic;
       Dir, DirN : in std_logic;
       SH, LD : in std_logic;
       SR, SL : in std_logic;
       D : in std_logic;
       Q : inout std_logic;
       Consum: out real := 0.0);
end entity;

architecture structural of shift_cell is

component  and3              
generic (c_comutat : real := 1.0e-8 );

port (a,b,c: in  std_logic;      
      o: out std_logic;           
      consum : out real := 0.0);
end component;

component  and2              
generic (c_comutat : real := 1.0e-8 );

port (a,b: in  std_logic;      
      o: out std_logic;           
      consum : out real := 0.0);
end component;

component nor2              
generic (c_comutat : real := 1.0e-8 );

port (a,b: in  std_logic;      
      o: out std_logic;           
      consum : out real := 0.0);
end component;

component or4                  
generic (c_comutat : real := 2.5e-8 );

port (a,b,c,d: in  std_logic;      
      o: out std_logic;           
      consum : out real := 0.0);
end component;

component inv is 
generic (c_comutat : real := 1.0e-8 );

port ( a: in std_logic;
       o: out std_logic;
        Consum: out real := 0.0);
end component;

component latchD --.//slxlib/bistD -- de discutat
port ( PRE, CLR, CLK, D : in  std_logic; 
        Q, Qbar: out std_logic; 
	consum : out real := 0.0 );
end component;

signal R,L, Load, Dlatch, Hold,Qold: std_logic;
signal consum1, consum2, consum3, consum4, consum5, consum6, consum7 : real;

begin

	U1: and3 port map (a=>SR, b=>SH, c=>DIRN,o=>R, consum=>consum1 );
	U2: and3 port map (a=>SL, b=>SH, c=>DIR,o=>L, consum=>consum2);
	U3: and2 port map (a=>LD, b=>D, o=>LOAD, consum=>consum3 );
	U4: nor2 port map (a=> LD, b => SH, o => Hold, consum => consum4);
	U5: and2 port map  (a=> Hold, b => Q, o => Qold, consum => consum5);
	U6: or4 port map (a=>R, b=>L, c=> LOAD, d => Qold, o=>DLatch,consum=>consum6);
	U7: latchD port map (D=>DLatch  , Q=> Q, CLK=> CLK, CLR => CLR, PRE => '1', consum=> consum7);

	consum<=consum1+consum2+consum3+consum4+consum5+consum6+consum7;

end architecture;


library ieee;
use ieee.std_logic_1164.all;

library IEEE;
use IEEE.std_logic_1164.all;
use work.pmonitor.all;

entity and3 is
	generic (
		Domain : integer := 1;
		Cin : real := 4.9e-15;
		Cpd : real := 38.7e-15;
		pleack : real := 1.62e-9;
		Area : real := 2.0
		);
	port ( 
	  --pragma synthesis_off
	  vcc : in real;
	 --pragma synthesis_on
	 a,b,c : in std_logic;
	 O : out  std_logic );
begin
	PM.monitorInput(o, Cpd, Vcc, Domain);
	PM.monitorInput(a, Cin, Vcc, Domain);
	PM.monitorInput(b, Cin, Vcc, Domain);
	PM.monitorInput(c, Cin, Vcc, Domain);
	AM.addArea(Area,Domain);
	PM.addLeackage(pleack,1);
end entity;
architecture primitiv of and3 is
begin
	O <= (a and b and c);
end architecture;


begin
  
   ointern <= a and b and c;                    
                                     

	process (ointern)
 	begin
		nr_comutari <= nr_comutari + 1.0;
	end process;

	consum <= c_comutat * nr_comutari;

	o <= ointern after 1 ns;

end primitive;    


library ieee;
use ieee.std_logic_1164.all;



library IEEE;
use IEEE.std_logic_1164.all;
use work.pmonitor.all;

entity nor2 is
	generic (
		Domain : integer := 1;
		Cin : real := 5.0e-15;
		Cpd : real := 7.0e-15;
		pleack : real := 0.69e-9;
		Area : real := 1.3
		);
	port ( 
	  --pragma synthesis_off
	  vcc : in real;
	 --pragma synthesis_on
	 a,b : in std_logic;
	 O : out  std_logic );
begin
	PM.monitorInput(o, Cpd, Vcc, Domain);
	PM.monitorInput(a, Cin, Vcc, Domain);
	PM.monitorInput(b, Cin, Vcc, Domain);
	AM.addArea(Area,Domain);
	PM.addLeackage(pleack,1);
end entity;
architecture primitiv of nor2 is
begin
	O <= not (a or b);
end architecture;


begin
  
   ointern <= a nor b ;                    
                                     

	process (ointern)
 	begin
		nr_comutari <= nr_comutari + 1.0;
	end process;

	consum <= c_comutat * nr_comutari;

	o <= ointern after 1 ns;

end primitive;    



library ieee;
use ieee.std_logic_1164.all;



library IEEE;
use IEEE.std_logic_1164.all;
use work.pmonitor.all;

entity or3 is
	generic (
		Domain : integer := 1;
		Cin : real := 4.4e-15;
		Cpd : real := 30.7e-15;
		pleack: real := 1.39e-12;
		Area : real := 2.0
		);
	port ( 
	  --pragma synthesis_off
	  vcc : in real;
	 --pragma synthesis_on
	 a,b,c : in std_logic;
	 O : out  std_logic );
begin
	PM.monitorInput(o, Cpd, Vcc, Domain);
	PM.monitorInput(a, Cin, Vcc, Domain);
	PM.monitorInput(b, Cin, Vcc, Domain);
	PM.monitorInput(c, Cin, Vcc, Domain);
	AM.addArea(Area,Domain);
	PM.addLeackage(pleack,1);
end entity;
architecture primitiv of or3 is
begin
	O <= (a or b or c);
end architecture;


begin
  
   ointern <= a or b or c or d;                    
                                    

	process (ointern)
 	begin
		nr_comutari <= nr_comutari + 1.0;
	end process;

	consum <= c_comutat * nr_comutari;

	o <= ointern;

end primitive;    

    


 



		
   
