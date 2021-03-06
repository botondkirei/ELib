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

component adderN is  
	generic ( Domain: integer := 1;
			  N : integer := 4);
	port(   
		--pragma synthesis_off
		vcc : in real;
		--pragma synthesis_on
		A,B : in std_logic_vector(N - 1 downto 0);  
		Cin  : in std_logic;  
		SUM : out std_logic_vector(N - 1 downto 0);  
		Cout  : out std_logic);  
end component adderN;  

component Controller
	generic ( Domain: integer := 1);
    port ( Start : in std_logic; CLK : in std_logic;
		LSB : in std_logic; LDM : out std_logic;
		LDHI : out std_logic;  LDLO: out std_logic;
		SHHI : out std_logic; SHLO : out std_logic ;
		Done, CLRHI, CG_EN: out std_logic);
end component;

component Controller_structural is
	generic ( Domain: integer := 1;
			  N : integer := 4;
			  log2N : integer := 3);
	port ( 
		-- power pins
		Vcc : in real;
		-- end power pins
		Start : in std_logic; 
		CLK, CLR : in std_logic;
		LSB : in std_logic; LDM : out std_logic;
		LDHI : out std_logic;  LDLO: out std_logic;
		SHHI : out std_logic; SHLO : out std_logic; 
		Done, CLRHI, CG_EN : out std_logic);
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

component ShiftN is 
	generic ( Domain: integer := 1;
			  N : integer := 4);
	port (
          --pragma synthesis_off
          vcc : in real;
          --pragma synthesis_on
          CLK : in std_logic; CLR : in std_logic;
          LD : in std_logic; SH : in std_logic; 
          DIR : in std_logic;
	      Sin : in std_logic;
          D : in std_logic_Vector(N - 1 downto 0); 
          Q : out std_logic_Vector(N - 1 downto 0));
end component ShiftN;

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
       Q : inout std_logic );end component;

component counter is
generic ( Domain: integer := 1);
port (
    vcc : in real;
    CLK, init, check : in  std_logic; 
    Q : out std_logic_vector(2 downto 0));
end component;

component comp_3biti is
generic (Domain : integer := 1);
port (
	vcc : real;
	eqin: in std_logic;
	a, b: in std_logic_vector(2 downto 0);
	eqout : out std_logic
	);
end component;

component automat is
generic ( Domain: integer := 1);
port (
       vcc : in real;
       CLK,CLR, V,LSB,Start : in  std_logic;
       Q2,Q1,Q0 : out  std_logic);
end component;

component comparator_1bit is
generic (Domain : integer := 1);
port (
	vcc : real; 
	eqin, a, b: in std_logic;
	eqout : out std_logic
	);
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

library ieee;  
use ieee.std_logic_1164.all;  
--use ieee.std_logic_arith.all;  
--use ieee.std_logic_unsigned.all; 
 
entity adderN is  
	generic ( Domain: integer := 1;
			  N : integer := 4);
	port(   
		--pragma synthesis_off
		vcc : in real;
		--pragma synthesis_on
		A,B : in std_logic_vector(N - 1 downto 0);  
		Cin  : in std_logic;  
		SUM : out std_logic_vector(N - 1 downto 0);  
		Cout  : out std_logic);  
end adderN;  

architecture structural of adderN is  

	component full_adder is 
		generic ( Domain: integer := 1);
		port (
	           --pragma synthesis_off
			   vcc : in real;
			   --pragma synthesis_on
			   A,B,Cin : in  std_logic;
			   Sum,Cout : out  std_logic);
	end component;

signal carry: std_logic_vector(N downto 0);

begin 
--U1: full_adder generic map (Domain => Domain) port map  ( a=> A(0), b=> B(0), Cin => '0', SUM => SUM(0), Cout=> C1, vcc => 3.3 );
--U2: full_adder generic map (Domain => Domain) port map  ( a=> A(1), b=> B(1), Cin => C1, SUM => SUM(1), Cout=> C2, vcc => 3.3 );
--U3: full_adder generic map (Domain => Domain) port map  ( a=> A(2), b=> B(2), Cin => C2, SUM => SUM(2), Cout=> C3, vcc => 3.3 );
--U4: full_adder generic map (Domain => Domain) port map  ( a=> A(3), b=> B(3), Cin => C3, SUM => SUM(3), Cout=> C4, vcc => 3.3 );

	Carry(0) <= '0';
	
	add : for I in 0 to N-1 generate
		fa : full_adder generic map (Domain => Domain) 
			port map  ( a=> A(I), b=> B(I), Cin => Carry(I), SUM => SUM(I), Cout=> Carry(I + 1), vcc => 3.3 );
	end generate add;

	Cout <= carry(N);

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

---------------------------------------------------------
	process (CLK)                          --
	begin                                  --
		if (rising_edge (CLK)) then        --
			if (state = inits) then        --
				counter <= 0;              -- de inclocuit cu counter
			elsif state = checks then      --
				counter <= counter + 1;    --
			end if;                        --
		end if;                            --
    end process;                           --
---------------------------------------------------------
end;	

----------------------------------------------------------------------
----------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Controller_structural is
	generic ( Domain: integer := 1;
			N : integer := 4;
			log2N : integer := 2);
	port ( 
		-- power pins
		Vcc : in real;
		-- end power pins
		Start : in std_logic; 
		CLK, CLR : in std_logic;
		LSB : in std_logic; LDM : out std_logic;
		LDHI : out std_logic;  LDLO: out std_logic;
		SHHI : out std_logic; SHLO : out std_logic; 
		Done, CLRHI, CG_EN : out std_logic);
end Controller_structural;

architecture structural of Controller_structural is

	--component counter is
	--generic ( Domain: integer := 1);
	--port (
    --    vcc : in real;
    --    CLK, init, check : in  std_logic; 
    --    Q : out std_logic_vector(2 downto 0));
    --end component;
    
    component CounterN is
	generic ( Domain: integer := 1;
		  N: integer := 3);
	port (
        vcc : in real;
        CLK, init, check : in  std_logic; 
        Q : out std_logic_vector(N - 1 downto 0));
	end component;
	
	component comp_Nbiti is
	generic (Domain : integer := 1;
			N : integer := 3);
	port (
		vcc : real;
		eqin: in std_logic;
		a, b: in std_logic_vector(N - 1 downto 0);
		eqout : out std_logic
		);
	end component;
    
    --component comp_3biti is
	--generic (Domain : integer := 1);
	--port (
	--	vcc : real;
	--	eqin: in std_logic;
	--	a, b: in std_logic_vector(2 downto 0);
	--	eqout : out std_logic
	--	);
	--end component;
	
	component automat is
	generic ( Domain: integer := 1);
	port (
           vcc : in real;
           CLK,CLR, V,LSB,Start : in  std_logic;
           Q2,Q1,Q0 : out  std_logic);
	end component;
	
	component inv1 is
	generic (
			Domain : integer := 1;
			Cin : real := 3.5e-15;
			Cpd : real := 3.95e-15;
			pleack : real := 0.35e-9;
			Area : real := 1.0
		);
	port (
           vcc : in real;
           a : in  std_logic;
           o : out  std_logic);
	end component;
	
	component nor3
		generic (
			Domain : integer := 1;
			Cin : real := 5.0e-15;
			Cpd : real := 8.1e-15;
			pleack: real := 0.81e-12;
			Area : real := 1.7
		);
		port (
           vcc : in real;
           a,b,c : in  std_logic;
           o : out  std_logic);
    end component;       
	signal Init, Check, v, CLKn : std_logic;
	signal Q : std_logic_vector(log2N downto 0);
	signal state : std_logic_vector( 2 downto 0);
	constant limit : std_logic_vector(log2N downto 0) := std_logic_vector(to_unsigned(N, log2N + 1));
	--constant limit : std_logic_vector(log2N downto 0) := "100";
	
begin

	negedge_clk: inv1 generic map (Domain => Domain) 
				port map (Vcc => Vcc,
							a => CLK,
							o => CLKn);

	counter_i : counterN generic map (Domain => Domain, N => log2N + 1) 
						port map ( Vcc => Vcc,
								Clk => CLK,
								Init => Init,
								Check => Check,
								Q => Q);
								
	comparator_1: comp_Nbiti generic map (Domain => Domain, N=>log2N + 1) 
							port map (Vcc => Vcc,
									  Eqin => '1',
									  a => Q,
									  b => limit,
									  eqout => v);
									  
	automat_i : automat  generic map (Domain => Domain) 
						port map (Vcc => Vcc,
								 CLK => CLKn, 
								 CLR => CLR, 
								 V => v,
								 LSB => LSB,
								 Start => Start,
								 Q2 => state(2),
								 Q1 => state(1),
								 Q0 => state(0));
								 
	--LDM <= '1' when State = InitS else '0' ;							 
	comparator_2: comp_Nbiti generic map (Domain => Domain) 
							port map (Vcc => Vcc,
									  Eqin => '1',
									  a => state,
									  b => "000",
									  eqout => LDM);	
									  
	--LDHI<= '1' when State = addS else '0' ;
	comparator_3: comp_Nbiti generic map (Domain => Domain) 
							port map (Vcc => Vcc,
									  Eqin => '1',
									  a => state,
									  b => "010",
									  eqout => LDHI);	
	--LDLO <= '1' when State = InitS else '0' ;
	LDLO <= LDM;
	Init <= LDM;
    --SHHI <= '1' when State = ShiftS else '0' ;
 	comparator_4: comp_Nbiti generic map (Domain => Domain) 
							port map (Vcc => Vcc,
									  Eqin => '1',
									  a => state,
									  b => "011",
									  eqout => SHHI);	   
	--SHLO <= '1' when State = ShiftS else '0' ;
	SHLO <= SHHI;
	--CLRHI <= '0' when state = Inits else  '1';
	invert: inv1 generic map (Domain => Domain) 
				port map (Vcc => Vcc,
							a => LDM,
							o => CLRHI);
	--Done <= '1' when State = DoneS else '0' ;
	comparator_5: comp_Nbiti generic map (Domain => Domain) 
							port map (Vcc => Vcc,
									  Eqin => '1',
									  a => state,
									  b => "100",
									  eqout => Done);	
	--CG_EN <= '0' when State = Checks or State = Dones or state = adds else '1';
	comparator_6: comp_Nbiti generic map (Domain => Domain) 
							port map (Vcc => Vcc,
									  Eqin => '1',
									  a => state,
									  b => "001",
									  eqout => check);	
	nor3_i : nor3 generic map (Domain => Domain) 
							port map (Vcc => Vcc,
									  a => check,
									  b => done,
									  c => LDHI,
									  o => CG_EN);
									 
								 
end architecture;

	
    

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
	generic ( Domain: integer := 1 ;
			  delay1 : time := 0.0 ns;
			  delay2 : time := 0.1 ns;
			  delay3 : time := 0.2 ns
			  );
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
	signal U1outd,U2outd,U3outd,U4outd,U5outd,U6outd : std_logic;

begin
	-- implemenation using the edge triggered D type flip flop 74xx74
	U1:nand3 generic map (Domain => Domain) port map (a=> PRE, b=> U4outd, c=>  U2outd, o=> U1out, vcc => 3.3);
	U1outd <= U1out after delay1;
	U2:nand3 generic map (Domain => Domain) port map (a=> U1outd, b=> CLR, c=>  CLK, o=> U2out, vcc => 3.3);
	U2outd <= U2out after delay2;
	U3:nand3 generic map (Domain => Domain) port map (a=> U2outd, b=> CLK, c=>  U4outd, o=> U3out, vcc => 3.3);
	U3outd <= U3out after delay3; 
	U4:nand3 generic map (Domain => Domain) port map (a=> U3outd, b=> CLR, c=>  D, o=> U4out, vcc => 3.3);
	U4outd <= U4out after delay2;
	U5:nand3 generic map (Domain => Domain) port map (a=> PRE, b => U2outd, c=>  U6outd, o=> U5out, vcc => 3.3);
	U5outd <= U5out after delay3;
	U6:nand3 generic map (Domain => Domain) port map (a=> U5outd, b=> CLR, c=>  U3outd, o=> U6out, vcc => 3.3);
	U6outd <= U6out after delay2;
	Q <= U5outd;
	Qbar <= U6outd;

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

library ieee;  
use ieee.std_logic_1164.all;  
--use ieee.std_logic_arith.all;  
--use ieee.std_logic_unsigned.all; 

entity ShiftN is 
	generic ( Domain: integer := 1;
			  N : integer := 4);
	port (
          --pragma synthesis_off
          vcc : in real;
          --pragma synthesis_on
          CLK : in std_logic; CLR : in std_logic;
          LD : in std_logic; SH : in std_logic; 
          DIR : in std_logic;
	      Sin : in std_logic;
          D : in std_logic_Vector(N - 1 downto 0); 
          Q : out std_logic_Vector(N - 1 downto 0));
end entity ShiftN;

architecture Behavior of ShiftN is


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
		   Q : inout std_logic);
	end component;

	signal Qint: std_logic_vector(N  downto -1);
	signal DirN : std_logic;

begin

U1 : inv1 generic map (Domain => Domain) port map (a => DIR, o => DirN, vcc => 3.3);
--U2 : shift_cell generic map (Domain => Domain) port map ( CLK => CLK, CLR => CLR, Dir => DIR, DirN => DirN, SH => SH, LD => LD, SR => Sin, SL => Q(2), D=> D(3), Q=>Q(3), vcc => 3.3);
--U3 : shift_cell generic map (Domain => Domain) port map ( CLK => CLK, CLR => CLR, Dir => DIR, DirN => DirN, SH => SH, LD => LD, SR => Q(3), SL => Q(1), D=> D(2), Q=>Q(2), vcc => 3.3);
--U4 : shift_cell generic map (Domain => Domain) port map ( CLK => CLK, CLR => CLR, Dir => DIR, DirN => DirN, SH => SH, LD => LD, SR => Q(2), SL =>  Q(0), D=> D(1), Q=>Q(1), vcc => 3.3);
--U5 : shift_cell generic map (Domain => Domain) port map ( CLK => CLK, CLR => CLR, Dir => DIR, DirN => DirN, SH => SH, LD => LD, SR => Q(1), SL => Sin, D=> D(0), Q=>Q(0), vcc => 3.3);

	shift : for I in 0 to N-1 generate
		sh_cell : shift_cell generic map (Domain => Domain) 
			port map ( CLK => CLK, CLR => CLR, Dir => DIR, DirN => DirN, SH => SH, LD => LD, SR => Qint(I + 1), SL => Qint(I - 1), D => D(I), Q=>Qint(I), vcc => 3.3);
	end generate shift;
	
	Qint(N) <= Sin;
	Qint(-1) <= Sin;
	Q <= Qint(N-1 downto 0);

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
       Q : inout std_logic );end entity;

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

signal R, Rd, L, Load, Dlatch, Hold,Qold: std_logic;

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
	
	signal C, Qint: std_logic_vector(2 downto 0);
	signal initn, checkn, d0, c0n, net1, net2 : std_logic;
	
begin
	
	bist0 : bistD generic map (Domain => Domain) port map (D=>d0	, Q=> Qint(0), Qbar=> C(0), CLK => CLK, CLR => initn, PRE => '1', vcc => 3.3 );
	bist1 : bistD generic map (Domain => Domain) port map (D=>C(1)  , Q=> Qint(1), Qbar=> C(1), CLK => C(0), CLR => initn, PRE => '1', vcc => 3.3 );
	bist2 : bistD generic map (Domain => Domain) port map (D=>C(2)  , Q=> Qint(2), Qbar=> C(2), CLK => C(1), CLR => initn, PRE => '1', vcc => 3.3 );
	
	poarta1: or2 generic map (Domain => Domain) port map (a => net1, b => net2, o => d0, vcc => 3.3);
	poarta2: and3 generic map (Domain => Domain) port map (a => c0n, b => initn, c => checkn, o =>  net1, vcc => 3.3 );
	poarta3: and3 generic map (Domain => Domain) port map (a => c(0), b => initn, c => check, o =>  net2, vcc => 3.3 );
	
	inversor1: inv1 generic map (Domain => Domain) port map (a => init, o => initn, vcc => 3.3 );
	inversor2: inv1 generic map (Domain => Domain) port map (a => check, o => checkn, vcc => 3.3 );
	inversor3: inv1 generic map (Domain => Domain) port map (a => C(0), o => c0n, vcc => 3.3 );
	
	Q <= Qint;
	
end architecture;


--------------------------------------------------------------------
--------------------------------------------------------------------


library IEEE;
use ieee.std_logic_1164.all; 

entity CounterN is
generic ( Domain: integer := 1;
		  N: integer := 3);
	port (
        vcc : in real;
        CLK, init, check : in  std_logic; 
        Q : out std_logic_vector(N - 1 downto 0));
end entity CounterN;

architecture structural of CounterN is

	
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
	
	signal C, Qint: std_logic_vector(N-1 downto 0);
	signal initn, checkn, d0, c0n, net1, net2 : std_logic;
	
begin
	
	bist0 : bistD generic map (Domain => Domain) port map (D=>d0	, Q=> Q(0), Qbar=> C(0), CLK => CLK, CLR => initn, PRE => '1', vcc => 3.3 );

	ffd : for I in 1 to N-1 generate
		bist : bistD generic map (Domain => Domain) port map
			(D => C(I), Q => Q(I), Qbar => C(I), CLK => C(I-1), CLR => initn, PRE => '1', vcc => 3.3);
	end generate ffd;
	
	poarta1: or2 generic map (Domain => Domain) port map (a => net1, b => net2, o => d0, vcc => 3.3);
	poarta2: and3 generic map (Domain => Domain) port map (a => c0n, b => initn, c => checkn, o =>  net1, vcc => 3.3 );
	poarta3: and3 generic map (Domain => Domain) port map (a => c(0), b => initn, c => check, o =>  net2, vcc => 3.3 );
	
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

	component Counter  is
	generic ( Domain: integer := 1);
	port (
        vcc : in real;
        CLK, init, check : in  std_logic; 
        Q : out std_logic_vector(2 downto 0));
	
    end component;
    
    component CounterN  is
	generic ( Domain: integer := 1;
			N: integer := 3);
	port (
        vcc : in real;
        CLK, init, check : in  std_logic; 
        Q : out std_logic_vector(N - 1 downto 0));
	
    end component;
        
	signal clk, init, check : std_logic;
	
	signal count : std_logic_vector(2 downto 0);
	signal count2 : std_logic_vector(2 downto 0);

begin

	instanta_counter : counter port map (vcc => 3.3,clk=>clk,init=>init,check=>check,Q=>count);
	instanta_counter2 : counterN port map (vcc => 3.3,clk=>clk,init=>init,check=>check,Q=>count2);
	
	generare_semnal_tact: process
	begin
		clk <= '0';
		wait for 5 ns;
		clk <= '1';
		wait for 5 ns;
	end process;
	
	init <= '1' , '0' after 55 ns;
	check <= '1', '0' after 65 ns, '1' after 75 ns;
	process begin
		wait for 1000 ns;
		assert false report "end simulation" severity failure;
		end process;
end architecture;

-----------------------------------------------------------------------


library IEEE;
use ieee.std_logic_1164.all; 
   entity automat is
	generic ( Domain: integer := 1);
	port (
           vcc : in real;
           CLK,CLR, V,LSB,Start : in  std_logic;
           Q2,Q1,Q0 : out  std_logic);
end automat;
architecture structural of automat is


component inv1              
	generic ( Domain: integer := 1);
	port (
		  vcc : in real;
		  a : in  std_logic;      
		  o : out std_logic);
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
	
	component and4              
	generic ( Domain: integer := 1);
	port (
		  vcc : in real;
		  a, b, c, d : in  std_logic;      
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

	
	component bistD is
		generic ( Domain: integer := 1);
		port (
        --pragma synthesis_off
        vcc : in real;
        --pragma synthesis_on
        PRE, CLR, CLK, D : in  std_logic; 
        Q, Qbar: out std_logic);
    end component;


	signal  Qbar2,Qbar1,Qbar0,Vbar, LSBn : std_logic;
	signal  out_poarta,out_poarta_A,out_poarta_B,out_poarta_C,out_poarta_D: std_logic;
	signal out_poarta_1,out_poarta_2,out_poarta_3,out_poarta_4,out_poarta_5,out_poarta_6,out_poarta_7,out_poarta_8,out_poarta_9,out_poarta_10,out_poarta_11,out_poarta_12,out_poarta_13,out_poarta_14: std_logic;

begin
	 

--porti pt D2
--    poarta: or2 generic map (Domain => Domain) port map (a=>V,b=>Q1,o=>out_poarta,vcc => 3.3 );
	D2: and4 generic map (Domain => Domain) port map (  a=> Qbar2,b=>Q1,c=>Q0, d=>V, o=>out_poarta_A, vcc => 3.3);
	bist2 : bistD generic map (Domain => Domain) port map (D=>out_poarta_A	, Q=>Q2 , Qbar=>Qbar2 , CLK => CLK, CLR => CLR, PRE => '1', vcc => 3.3 );
	
--porti pt D1

	  
poartaB: and3 generic map (Domain => Domain) port map (  a=> Qbar2,b=>Qbar1,c=>Q0,o=>out_poarta_B, vcc => 3.3);
poartaC: and3 generic map (Domain => Domain) port map (  a=> Qbar2,b=>Q1,c=>Qbar0,o=>out_poarta_C, vcc => 3.3);
D1: or2 generic map (Domain => Domain) port map (a=>out_poarta_B,b=>out_poarta_C,o =>out_poarta_D, vcc =>3.3);
bist1 : bistD generic map (Domain => Domain) port map (D=>out_poarta_D	, Q=>Q1 , Qbar=>Qbar1 , CLK => CLK, CLR => CLR, PRE => '1', vcc => 3.3 );


--porti pt D0	 

poarta1: and2 generic map (Domain => Domain) port map (  a=> Start,b=>Qbar0,o=>out_poarta_1, vcc => 3.3);
poarta2: and2 generic map (Domain => Domain) port map (  a=> Qbar1,b=>Qbar2,o=>out_poarta_2, vcc => 3.3);

LSB_neg: inv1  generic map (Domain => Domain) port map (  a=> LSB,o=>LSBn, vcc => 3.3);
poarta3: and2 generic map (Domain => Domain) port map (  a=> LSBn,b=>Q0,o=>out_poarta_3, vcc => 3.3);
poarta4: and2 generic map (Domain => Domain) port map (  a=> Qbar1,b=>Qbar2,o=>out_poarta_4, vcc => 3.3);


poarta5: inv1 generic map (Domain => Domain) port map (a => v,o => vbar, vcc => 3.3);
poarta6: and2 generic map (Domain => Domain) port map (  a=> Vbar,b=>Q0,o=>out_poarta_6, vcc => 3.3);
poarta7: and2 generic map (Domain => Domain) port map (  a=> Q1,b=>Qbar2,o=>out_poarta_7, vcc => 3.3);

poarta8:and2 generic map (Domain => Domain) port map (  a=> out_poarta_1,b=>out_poarta_2,o=>out_poarta_8, vcc => 3.3);
poarta9:and2 generic map (Domain => Domain) port map (  a=> out_poarta_3,b=>out_poarta_4,o=>out_poarta_9, vcc => 3.3);
poarta10:and2 generic map (Domain => Domain) port map (  a=> out_poarta_6,b=>out_poarta_7,o=>out_poarta_10, vcc => 3.3);
poarta11:and3 generic map (Domain => Domain) port map (  a=> Qbar0,b=>Q1,c=>Qbar2,o=>out_poarta_11, vcc => 3.3);

poarta12:or2 generic map (Domain => Domain) port map (a=>out_poarta_8,b=>out_poarta_9,o=>out_poarta_12 ,vcc => 3.3 );
poarta13:or2 generic map (Domain => Domain) port map (a=>out_poarta_10,b=>out_poarta_11,o=>out_poarta_13, vcc => 3.3 );

D0: or2 generic map (Domain => Domain) port map (a=>out_poarta_12,b=>out_poarta_13,o=>out_poarta_14, vcc => 3.3 );
bist0 : bistD generic map (Domain => Domain) port map (D=>out_poarta_14	, Q=>Q0 , Qbar=>Qbar0 , CLK => CLK, CLR => CLR, PRE => '1', vcc => 3.3 );
	
end architecture;

-----------------------------------------------------------------------

library IEEE;
use ieee.std_logic_1164.all; 

entity Test_automat is
end entity;

architecture Test of Test_automat is

	component automat  is
	generic ( Domain: integer := 1);
	port (
         
           vcc : in real;
           CLK,CLR,V,LSB,Start : in  std_logic;
           Q2, Q1, Q0 : out  std_logic);
    end component;
    
        
	signal CLK,CLR,V,LSB,Start : std_logic;
	
	signal count : std_logic_vector(2 downto 0);

begin

	instanta_automat : automat port map (vcc => 3.3,CLK=>CLK,CLR=>CLR ,V=>V,LSB=>LSB,Start=>Start,Q2=>count(2),Q1=>count(1),Q0=>count(0));
	
	generare_semnal_tact: process
	begin
		clk <= '0';
		wait for 5 ns;
		clk <= '1';
		wait for 5 ns;
	end process;
	
	CLR <= '0', '1' after 10 ns;
	
	V <= '0' , '1' after 175 ns, '0' after 220 ns;
	LSB <= '1', '0' after 105 ns, '1' after 135 ns;
	START <= '0', '1' after 65 ns, '0' after 75 ns;
	
	process begin
		wait for 1000 ns;
		assert false report "end simulation" severity failure;
		end process;
end architecture;


-----------------------------------------------------------------------

library IEEE;
use ieee.std_logic_1164.all; 

entity comparator_1bit is
	generic (Domain : integer := 1);
	port (
		vcc : real; 
		eqin, a, b: in std_logic;
		eqout : out std_logic
		);
end entity;

architecture structural of comparator_1bit is

	component and3              
	generic ( Domain: integer := 1);
	port (
		  vcc : in real;
		  a, b, c : in  std_logic;      
		  o: out std_logic);
	end component ;
	
	component or2              
	generic ( Domain: integer := 1);
	port (
		  vcc : in real;
		  a, b : in  std_logic;      
		  o: out std_logic);
	end component ;
	
	component inv1              
	generic ( Domain: integer := 1);
	port (
		  vcc : in real;
		  a : in  std_logic;      
		  o : out std_logic);
	end component ;
	
	signal abar, bbar : std_logic;
	signal out_poarta_x1,out_poarta_x2 : std_logic;
	
begin

	i1 : inv1 generic map (Domain => Domain) port map ( a=> a, o => abar, vcc => vcc);
	i2 : inv1 generic map (Domain => Domain) port map ( a=> b, o => bbar, vcc => vcc);

	x1: and3 generic map (Domain => Domain) port map ( a=> eqin,  b=>a, c=>b, o=>out_poarta_x1, vcc => vcc);
	x2: and3 generic map (Domain => Domain) port map ( a=> eqin,  b=>abar, c=>bbar, o=>out_poarta_x2, vcc => vcc); 
	
	y: or2 generic map (Domain => Domain) port map ( a=> out_poarta_x1 ,  b=>out_poarta_x2 ,  o=> eqout , vcc => vcc);
	
end architecture;


-----------------------------------------------------------------------
-----------------------------------------------------------------------

library IEEE;
use ieee.std_logic_1164.all; 

entity comp_3biti is
	generic (Domain : integer := 1);
	port (
		vcc : real;
		eqin: in std_logic;
		a, b: in std_logic_vector(2 downto 0);
		eqout : out std_logic
		);
end entity;

architecture structural of comp_3biti is

	component comparator_1bit is
	generic (Domain : integer := 1);
	port (
		vcc : real; 
		eqin, a, b: in std_logic;
		eqout : out std_logic
		);
	end component;
	
	signal net1, net2 : std_logic;

begin

	comp1 : comparator_1bit generic map (Domain => Domain) port map (eqin =>eqin, a =>a(2), b => b(2), eqout =>net1, vcc => vcc); 
	comp2 : comparator_1bit generic map (Domain => Domain) port map (eqin =>net1, a =>a(1), b => b(1), eqout =>net2, vcc => vcc); 
	comp3 : comparator_1bit generic map (Domain => Domain) port map (eqin =>net2, a =>a(0), b => b(0), eqout =>eqout, vcc => vcc); 
		
end architecture;

-----------------------------------------------------------------------
-----------------------------------------------------------------------

library IEEE;
use ieee.std_logic_1164.all; 

entity comp_Nbiti is
	generic (Domain : integer := 1;
			N : integer := 3);
	port (
		vcc : real;
		eqin: in std_logic;
		a, b: in std_logic_vector(N - 1 downto 0);
		eqout : out std_logic
		);
end entity;

architecture structural of comp_Nbiti is

	component comparator_1bit is
	generic (Domain : integer := 1);
	port (
		vcc : real; 
		eqin, a, b: in std_logic;
		eqout : out std_logic
		);
	end component;
	
	signal nets : std_logic_vector(N downto 0);

begin

	--comp1 : comparator_1bit generic map (Domain => Domain) port map (eqin =>eqin, a =>a(2), b => b(2), eqout =>net1, vcc => vcc); 
	--comp2 : comparator_1bit generic map (Domain => Domain) port map (eqin =>net1, a =>a(1), b => b(1), eqout =>net2, vcc => vcc); 
	--comp3 : comparator_1bit generic map (Domain => Domain) port map (eqin =>net2, a =>a(0), b => b(0), eqout =>eqout, vcc => vcc); 
	comparators : for I in 0 to N-1 generate
		bist : comparator_1bit generic map (Domain => Domain) 
				port map (eqin => nets(I), a =>a(I), b => b(I), eqout =>nets(I+1), vcc => vcc); 
	end generate comparators;
	
	nets(0) <= eqin;
	eqout <= nets(N);
		
end architecture;




-----------------------------------------------------------------------
-----------------------------------------------------------------------

library IEEE;
use ieee.std_logic_1164.all; 

entity test_comp_3biti is
end entity;

architecture test of test_comp_3biti is

	component comp_3biti is
	generic (Domain : integer := 1);
	port ( 
		vcc : real;
		eqin: in std_logic;
		a, b: in std_logic_vector(2 downto 0);
		eqout : out std_logic
		);
	end component;
	
	component comp_Nbiti is
	generic (Domain : integer := 1;
			N : integer := 3);
	port (
		vcc : real;
		eqin: in std_logic;
		a, b: in std_logic_vector(N - 1 downto 0);
		eqout : out std_logic
		);
	end component;

	signal eqin, eqout, eqout2: std_logic;
	signal a, b : std_logic_vector(2 downto 0);
	
begin

	instanta_comp_3biti : comp_3biti port map ( vcc => 3.3, eqin=>eqin, a=>a , b=>b, eqout=>eqout);
	instanta_comp_Nbiti : comp_Nbiti port map ( vcc => 3.3, eqin=>eqin, a=>a , b=>b, eqout=>eqout2);
	
	eqin <= '1', '1' after 40 ns, '1' after 80 ns;
	a <= "000", "101" after 10 ns, "110" after 20 ns;
	b <= "000", "100" after 10 ns, "110" after 20 ns;
	
	
	process begin
		wait for 100 ns;
		assert false report "end simulation" severity failure;
	end process;
	
end architecture;


-----------------------------------------------------------------------
-----------------------------------------------------------------------


library IEEE;
use ieee.std_logic_1164.all; 

entity test_controller is
end entity;

architecture test of test_controller is

	component Controller_structural is
	generic ( Domain: integer := 1;
			 N : integer := 4;
			 log2N : integer := 2);
	port ( 
		-- power pins
		Vcc : in real;
		-- end power pins
		Start : in std_logic; 
		CLK, CLR : in std_logic;
		LSB : in std_logic; LDM : out std_logic;
		LDHI : out std_logic;  LDLO: out std_logic;
		SHHI : out std_logic; SHLO : out std_logic; 
		Done, CLRHI, CG_EN : out std_logic);
	end component;

	component Controller is
	generic ( Domain: integer := 1);
	port ( 
		Start : in std_logic; 
		CLK : in std_logic;
		LSB : in std_logic; LDM : out std_logic;
		LDHI : out std_logic;  LDLO: out std_logic;
		SHHI : out std_logic; SHLO : out std_logic; 
		Done, CLRHI, CG_EN : out std_logic);
	end component;
	
	signal Start, CLK, CLR, LSB :  std_logic;
	signal LDM, LDHI, LDLO,SHHI, SHLO, Done, CLRHI, CG_EN : std_logic;
	signal LDM2, LDHI2, LDLO2, SHHI2, SHLO2, Done2, CLRHI2, CG_EN2 : std_logic;

begin

	c1 : controller port map (CLK => CLK, Start => Start, LSB => LSB,
							LDM		=> LDM	, 
							LDHI	=> LDHI	, 
							LDLO	=> LDLO	,
							SHHI	=> SHHI	, 
							SHLO	=> SHLO	, 
							Done	=> Done	, 
							CLRHI	=> CLRHI, 
							CG_EN   => CG_EN  );
	c2 : controller_structural generic map (Domain =>1 )
					port map (Vcc => 3.3, 
							CLK => CLK, CLR => CLR, Start => Start, LSB => LSB,
							LDM		=> LDM2	, 
							LDHI	=> LDHI2, 
							LDLO	=> LDLO2,
							SHHI	=> SHHI2, 
							SHLO	=> SHLO2, 
							Done	=> Done2, 
							CLRHI	=> CLRHI2, 
							CG_EN   => CG_EN2  );							
							
	generare_semnal_tact: process
	begin
		clk <= '0';
		wait for 5 ns;
		clk <= '1';
		wait for 5 ns;
	end process;
	
	
	LSB <= '1', '0' after 105 ns, '1' after 135 ns;
	START <= '0', '1' after 65 ns, '0' after 75 ns;
	CLR <= '0', '1' after 1 ns;
	
	process begin
		wait for 500 ns;
		assert false report "end simulation" severity failure;
	end process;

end architecture;

