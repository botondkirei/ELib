----------------------------------------------------------------------------------
-- Company: Technical University of Cluj Napoca
-- Engineer: Rares Marincas, Botond Sandor Kirei
-- Project Name: Power/Area Avare Modeling and Estimation
-- Description: - sxlib standard libary cell file
-- Dependencies: - PAECore.vhd
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_vector.all;
use work.PAECore.all;

package sxlib is

	component and2 is
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
	end component;
	
	component and3 is
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
	end component;
	
	component or3 is
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
	end component;
	
	component aoi21 is
	generic (
		Domain : integer := 1;
		Cin : real := 5.0e-15;
		Cpd : real := 10.0e-15;
		pleack : real := 1.16e-9;
		Area : real := 2.0
		);
	port ( 
	  --pragma synthesis_off
	  vcc : in real;
	 --pragma synthesis_on
	 a,b,c : in std_logic;
	 O : out  std_logic );
	end component;
	
	component aoi22 is
	generic (
		Domain : integer := 1;
		Cin : real := 5.0e-15;
		Cpd : real := 10.0e-15;
		pleack : real := 1.16e-9;
		Area : real := 2.0
		);
	port ( 
	  --pragma synthesis_off
	  vcc : in real;
	 --pragma synthesis_on
	 a,b,c,d : in std_logic;
	 O : out  std_logic );
	end component;
	
	component buff is
	generic (
		Domain : integer := 1;
		Cin : real := 2.6e-15;
		Cpd : real := 15.0e-15;
		pleack : real := 0.88e-9;
		Area : real := 1.3
		);
	port ( 
	  --pragma synthesis_off
	  vcc : in real;
	 --pragma synthesis_on
	 a : in std_logic;
	 O : out  std_logic );
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
	  --pragma synthesis_off
	  vcc : in real;
	 --pragma synthesis_on
	 a : in std_logic;
	 O : out  std_logic );
	end component;
	
	component nand2 is
	generic (
		Domain : integer := 1;
		Cin : real := 4.4e-15;
		Cpd : real := 6.0e-15;
		pleack : real := 0.69e-9;
		Area : real := 1.3
		);
	port ( 
	  --pragma synthesis_off
	  vcc : in real;
	 --pragma synthesis_on
	 a,b : in std_logic;
	 O : out  std_logic );
	 end component;
	 
	component nand3 is
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
	 end component;
	 
	entity nand4 is
	component (
		Domain : integer := 1;
		Cin : real := 5.0e-15;
		Cpd : real := 8.88e-15;
		pleack: real := 1.16e-9;
		Area : real := 2.0
		);
	port ( 
	  --pragma synthesis_off
	  vcc : in real;
	 --pragma synthesis_on
	 a,b,c,d : in std_logic;
	 O : out  std_logic ); 
	end component;
	
	component nor2 is
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
	end component;
	
	component nor3 is
	generic (
		Domain : integer := 1;
		Cin : real := 5.0e-15;
		Cpd : real := 8.1e-15;
		pleack: real := 0.81e-12;
		Area : real := 1.7
		);
	port ( 
	  --pragma synthesis_off
	  vcc : in real;
	 --pragma synthesis_on
	 a,b,c : in std_logic;
	 O : out  std_logic );
	end component;
	
	component oai21 is
	generic (
		Domain : integer := 1;
		Cin : real := 6.1e-15;
		Cpd : real := 9.79e-15;
		pleack : real := 1.16e-9;
		Area : real := 2.0
		);
	port ( 
	  --pragma synthesis_off
	  vcc : in real;
	 --pragma synthesis_on
	 a,b,c : in std_logic;
	 O : out  std_logic );
	end component;
	
	component or2 is
	generic (
		Domain : integer := 1;
		Cin : real := 4.7e-15;
		Cpd : real := 29.1e-15;
		pleack : real := 1.27e-9;
		Area : real := 1.7
		);
	port ( 
	  --pragma synthesis_off
	  vcc : in real;
	 --pragma synthesis_on
	 a,b : in std_logic;
	 O : out  std_logic );
	end component;
	
	component latchSR is
	generic ( 
		Domain : integer := 1;
		CinCLK : real := 4.4e-15;
		CinS : real := 4.4e-15;
		CinR : real := 4.4e-15;
		CpdCLK : real := 26.8e-15;
		CpdSR : real := 12.0e-15;
		--Cpd : real := 16.8e-15;
		pleack : real := 2.76e-9;
		Area : real := 5.2
		);

	port ( Vcc : in real;
			S, R : in std_logic;
		   CLK : in std_logic;
		   Q, Qn:out std_logic);
	end component;
	
	component bistD is
	generic ( 
		Domain : integer := 1;
		CinCLK : real := 7.9e-15;
		CinD : real := 7.9e-15;
		CpdCLK : real := 62.0e-15;
		CpdD : real := 58.5e-15;
		pleack : real := 6.22e-9;
		Area : real := 12.4
		);
	port ( Vcc : in real;
		   D , CLK : in std_logic;
		   Q , Qn : out std_logic);
	end component;
  
end package;

package body sxlib is

end package body;
----------------------------------------------------------------------------------
-- Company: Technical University of Cluj Napoca
-- Engineer: Rares Marincas, Botond Sandor Kirei
-- Project Name: Power/Area Avare Modeling and Estimation
-- Description: - sxlib standard libary cell file
-- Dependencies: - PAECore.vhd
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use work.PAECore.all;

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
	PM.addLeackage(pleack,Domain);
end entity;
architecture primitiv of and2 is
begin
	O <= (a and b);
end architecture;

----------------------------------------------------------------------------------
-- Company: Technical University of Cluj Napoca
-- Engineer: Rares Marincas, Botond Sandor Kirei
-- Project Name: Power/Area Avare Modeling and Estimation
-- Description: - sxlib standard libary cell file
-- Dependencies: - PAECore.vhd
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use work.PAECore.all;

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
	PM.addLeackage(pleack,Domain);
end entity;
architecture primitiv of and3 is
begin
	O <= (a and b and c);
end architecture;
----------------------------------------------------------------------------------
-- Company: Technical University of Cluj Napoca
-- Engineer: Rares Marincas, Botond Sandor Kirei
-- Project Name: Power/Area Avare Modeling and Estimation
-- Description: - sxlib standard libary cell file
-- Dependencies: - PAECore.vhd
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use work.PAECore.all;

entity aoi21 is
	generic (
		Domain : integer := 1;
		Cin : real := 5.0e-15;
		Cpd : real := 10.0e-15;
		pleack : real := 1.16e-9;
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
	PM.addLeackage(pleack,Domain);
end entity;
architecture primitiv of aoi21 is
begin
	O <= not ((a and b) or c); -- !(a*b+c)
end architecture;
----------------------------------------------------------------------------------
-- Company: Technical University of Cluj Napoca
-- Engineer: Rares Marincas, Botond Sandor Kirei
-- Project Name: Power/Area Avare Modeling and Estimation
-- Description: - sxlib standard libary cell file
-- Dependencies: - PAECore.vhd
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use work.PAECore.all;

entity aoi22 is
	generic (
		Domain : integer := 1;
		Cin : real := 5.0e-15;
		Cpd : real := 10.0e-15;
		pleack : real := 1.16e-9;
		Area : real := 2.0
		);
	port ( 
	  --pragma synthesis_off
	  vcc : in real;
	 --pragma synthesis_on
	 a,b,c,d : in std_logic;
	 O : out  std_logic );
begin
	PM.monitorInput(o, Cpd, Vcc, Domain);
	PM.monitorInput(a, Cin, Vcc, Domain);
	PM.monitorInput(b, Cin, Vcc, Domain);
	PM.monitorInput(c, Cin, Vcc, Domain);
	PM.monitorInput(d, Cin, Vcc, Domain);
	AM.addArea(Area,Domain);
	PM.addLeackage(pleack,Domain);
end entity;
architecture primitiv of aoi22 is
begin
	O <= not ((a and b) or (c and d)); --O=!(a*b+c*d);
end architecture;----------------------------------------------------------------------------------
-- Company: Technical University of Cluj Napoca
-- Engineer: Rares Marincas, Botond Sandor Kirei
-- Project Name: Power/Area Avare Modeling and Estimation
-- Description: - sxlib standard libary cell file
-- Dependencies: - PAECore.vhd
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
library work;
use work.PAECore.all;

entity bistD is
	generic ( 
		Domain : integer := 1;
		CinCLK : real := 7.9e-15;
		CinD : real := 7.9e-15;
		CpdCLK : real := 62.0e-15;
		CpdD : real := 58.5e-15;
		pleack : real := 6.22e-9;
		Area : real := 12.4
		);
	port ( Vcc : in real;
		   D , CLK : in std_logic;
		   Q , Qn : out std_logic);
begin
	PM.monitorInput(CLK, CinCLK + CpdCLK, Vcc , Domain);
	PM.monitorInput(D, CinD + CpdD, Vcc , Domain);
	AM.addArea(Area, Domain);
	PM.addLeackage(pleack , Domain);
end entity;

architecture comportamental of bistD is

begin
	
	process (CLK)
	begin
		if falling_edge(clk) then
			if D'event then
				Q <= D;
			else
				Q <= not D;
			end if;
		end if;
	end process;
	
	Qn <= not Q;
	
end architecture;


----------------------------------------------------------------------------------
-- Company: Technical University of Cluj Napoca
-- Engineer: Rares Marincas, Botond Sandor Kirei
-- Project Name: Power/Area Avare Modeling and Estimation
-- Description: - sxlib standard libary cell file
-- Dependencies: - PAECore.vhd
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use work.PAECore.all;

entity buff is
	generic (
		Domain : integer := 1;
		Cin : real := 2.6e-15;
		Cpd : real := 15.0e-15;
		pleack : real := 0.88e-9;
		Area : real := 1.3
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
	PM.addLeackage(pleack,Domain);
end entity;
architecture primitiv of buff is
begin
	O <=  a;
end architecture;----------------------------------------------------------------------------------
-- Company: Technical University of Cluj Napoca
-- Engineer: Rares Marincas, Botond Sandor Kirei
-- Project Name: Power/Area Avare Modeling and Estimation
-- Description: - sxlib standard libary cell file
-- Dependencies: - PAECore.vhd
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use work.PAECore.all;

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
	PM.addLeackage(pleack,Domain);
end entity;
architecture primitiv of inv1 is
begin
	O <= not a;
end architecture;
----------------------------------------------------------------------------------
-- Company: Technical University of Cluj Napoca
-- Engineer: Rares Marincas, Botond Sandor Kirei
-- Project Name: Power/Area Avare Modeling and Estimation
-- Description: - sxlib standard libary cell file
-- Dependencies: - PAECore.vhd
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
library work;
use work.PAECore.all;

entity latchSR is
	generic ( 
		Domain : integer := 1;
		CinCLK : real := 4.4e-15;
		CinS : real := 4.4e-15;
		CinR : real := 4.4e-15;
		CpdCLK : real := 26.8e-15;
		CpdSR : real := 12.0e-15;
		--Cpd : real := 16.8e-15;
		pleack : real := 2.76e-9;
		Area : real := 5.2
		);

	port ( Vcc : in real;
			S, R : in std_logic;
		   CLK : in std_logic;
		   Q, Qn:out std_logic);
begin
	--PM.monitorInput(Q, Cpd, Vcc, Domain);
	--PM.monitorInput(Qn, Cpd, Vcc, Domain);
	PM.monitorInput(CLK, CinCLK + CpdCLK, Vcc, Domain);
	--PM.monitorInput(CLK, CinCLK, Vcc, Domain);
	PM.monitorInput(S, CinS + CpdSR, Vcc, Domain);
	--PM.monitorInput(S, CinS, Vcc, Domain);
	PM.monitorInput(R, CinR + CpdSR, Vcc, Domain);
	--PM.monitorInput(R, CinR, Vcc, Domain);
	AM.addArea(Area,Domain);
	PM.addLeackage(pleack,Domain);
end entity;

architecture behavioral of latchSR is

begin
	
	process (CLK, S, R)
	begin
		if CLK = '1' then
			case (S & R) is
				when "11" => Qn <= Qn;
				when "01" => Qn <= '1';
				when "10" => Qn <= '0';
				when others => Qn <= 'X';
			end case;
		end if;
	end process;
	
	Q <= not Qn;
	
end architecture;
----------------------------------------------------------------------------------
-- Company: Technical University of Cluj Napoca
-- Engineer: Rares Marincas, Botond Sandor Kirei
-- Project Name: Power/Area Avare Modeling and Estimation
-- Description: - sxlib standard libary cell file
-- Dependencies: - PAECore.vhd
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use work.PAECore.all;

entity nand2 is
	generic (
		Domain : integer := 1;
		Cin : real := 4.4e-15;
		Cpd : real := 6.0e-15;
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
	--PM.monitorInput(o, Cpd, Vcc, Domain);
	PM.monitorInput(a, Cin, Vcc, Domain);
	PM.monitorInput(b, Cin, Vcc, Domain);
	AM.addArea(Area,Domain);
	PM.addLeackage(pleack,Domain);
end entity;
architecture primitiv of nand2 is
begin
	--O <= not (a and b);
	process (a,b)
		variable increment : real;
	begin
		O <= not (a and b);
		increment := vcc*vcc*Cpd / 2.0;
		PM.inc(increment,Domain);
	end process;	
	
end architecture;
----------------------------------------------------------------------------------
-- Company: Technical University of Cluj Napoca
-- Engineer: Rares Marincas, Botond Sandor Kirei
-- Project Name: Power/Area Avare Modeling and Estimation
-- Description: - sxlib standard libary cell file
-- Dependencies: - PAECore.vhd
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use work.PAECore.all;

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
	PM.addLeackage(pleack,Domain);
end entity;
architecture primitiv of nand3 is
begin
	O <= not (a and b and c);
end architecture;
----------------------------------------------------------------------------------
-- Company: Technical University of Cluj Napoca
-- Engineer: Rares Marincas, Botond Sandor Kirei
-- Project Name: Power/Area Avare Modeling and Estimation
-- Description: - sxlib standard libary cell file
-- Dependencies: - PAECore.vhd
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use work.PAECore.all;

entity nand4 is
	generic (
		Domain : integer := 1;
		Cin : real := 5.0e-15;
		Cpd : real := 8.88e-15;
		pleack: real := 1.16e-9;
		Area : real := 2.0
		);
	port ( 
	  --pragma synthesis_off
	  vcc : in real;
	 --pragma synthesis_on
	 a,b,c,d : in std_logic;
	 O : out  std_logic );
begin
	PM.monitorInput(o, Cpd, Vcc, Domain);
	PM.monitorInput(a, Cin, Vcc, Domain);
	PM.monitorInput(b, Cin, Vcc, Domain);
	PM.monitorInput(c, Cin, Vcc, Domain);
	PM.monitorInput(d, Cin, Vcc, Domain);
	AM.addArea(Area,Domain);
	PM.addLeackage(pleack,Domain);
end entity;
architecture primitiv of nand4 is
begin
	O <= not (a and b and c and d);
end architecture;
----------------------------------------------------------------------------------
-- Company: Technical University of Cluj Napoca
-- Engineer: Rares Marincas, Botond Sandor Kirei
-- Project Name: Power/Area Avare Modeling and Estimation
-- Description: - sxlib standard libary cell file
-- Dependencies: - PAECore.vhd
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use work.PAECore.all;

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
	PM.addLeackage(pleack,Domain);
end entity;
architecture primitiv of nor2 is
begin
	O <= not (a or b);
end architecture;
----------------------------------------------------------------------------------
-- Company: Technical University of Cluj Napoca
-- Engineer: Rares Marincas, Botond Sandor Kirei
-- Project Name: Power/Area Avare Modeling and Estimation
-- Description: - sxlib standard libary cell file
-- Dependencies: - PAECore.vhd
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use work.PAECore.all;

entity nor3 is
	generic (
		Domain : integer := 1;
		Cin : real := 5.0e-15;
		Cpd : real := 8.1e-15;
		pleack: real := 0.81e-12;
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
	PM.addLeackage(pleack,Domain);
end entity;
architecture primitiv of nor3 is
begin
	O <= not (a or b or c);
end architecture;----------------------------------------------------------------------------------
-- Company: Technical University of Cluj Napoca
-- Engineer: Rares Marincas, Botond Sandor Kirei
-- Project Name: Power/Area Avare Modeling and Estimation
-- Description: - sxlib standard libary cell file
-- Dependencies: - PAECore.vhd
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use work.PAECore.all;

entity oai21 is
	generic (
		Domain : integer := 1;
		Cin : real := 6.1e-15;
		Cpd : real := 9.79e-15;
		pleack : real := 1.16e-9;
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
	PM.addLeackage(pleack,Domain);
end entity;
architecture primitiv of oai21 is
begin
	O <= not ((a or b) and c); -- O=!((a+b)*c);
end architecture;
----------------------------------------------------------------------------------
-- Company: Technical University of Cluj Napoca
-- Engineer: Rares Marincas, Botond Sandor Kirei
-- Project Name: Power/Area Avare Modeling and Estimation
-- Description: - sxlib standard libary cell file
-- Dependencies: - PAECore.vhd
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use work.PAECore.all;

entity or2 is
	generic (
		Domain : integer := 1;
		Cin : real := 4.7e-15;
		Cpd : real := 29.1e-15;
		pleack : real := 1.27e-9;
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
	PM.addLeackage(pleack,Domain);
end entity;
architecture primitiv of or2 is
begin
	O <= (a or b);
end architecture;
----------------------------------------------------------------------------------
-- Company: Technical University of Cluj Napoca
-- Engineer: Rares Marincas, Botond Sandor Kirei
-- Project Name: Power/Area Avare Modeling and Estimation
-- Description: - sxlib standard libary cell file
-- Dependencies: - PAECore.vhd
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use work.PAECore.all;

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
	PM.addLeackage(pleack,Domain);
end entity;
architecture primitiv of or3 is
begin
	O <= (a or b or c);
end architecture;
library ieee;
use ieee.std_logic_vector.all;
library work;
use work.PAECore.all;

package sxlib is

  component 
  end component
  
end package;

package body sxlib is

end package body;
----------------------------------------------------------------------------------
-- Company: Technical University of Cluj Napoca
-- Engineer: Rares Marincas, Botond Sandor Kirei
-- Project Name: Power/Area Avare Modeling and Estimation
-- Description: - sxlib standard libary cell file
-- Dependencies: - PAECore.vhd
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use work.PAECore.all;

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
	PM.addLeackage(pleack,Domain);
end entity;
architecture primitiv of and2 is
begin
	O <= (a and b);
end architecture;

----------------------------------------------------------------------------------
-- Company: Technical University of Cluj Napoca
-- Engineer: Rares Marincas, Botond Sandor Kirei
-- Project Name: Power/Area Avare Modeling and Estimation
-- Description: - sxlib standard libary cell file
-- Dependencies: - PAECore.vhd
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use work.PAECore.all;

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
	PM.addLeackage(pleack,Domain);
end entity;
architecture primitiv of and3 is
begin
	O <= (a and b and c);
end architecture;
----------------------------------------------------------------------------------
-- Company: Technical University of Cluj Napoca
-- Engineer: Rares Marincas, Botond Sandor Kirei
-- Project Name: Power/Area Avare Modeling and Estimation
-- Description: - sxlib standard libary cell file
-- Dependencies: - PAECore.vhd
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use work.PAECore.all;

entity aoi21 is
	generic (
		Domain : integer := 1;
		Cin : real := 5.0e-15;
		Cpd : real := 10.0e-15;
		pleack : real := 1.16e-9;
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
	PM.addLeackage(pleack,Domain);
end entity;
architecture primitiv of aoi21 is
begin
	O <= not ((a and b) or c); -- !(a*b+c)
end architecture;
----------------------------------------------------------------------------------
-- Company: Technical University of Cluj Napoca
-- Engineer: Rares Marincas, Botond Sandor Kirei
-- Project Name: Power/Area Avare Modeling and Estimation
-- Description: - sxlib standard libary cell file
-- Dependencies: - PAECore.vhd
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use work.PAECore.all;

entity aoi22 is
	generic (
		Domain : integer := 1;
		Cin : real := 5.0e-15;
		Cpd : real := 10.0e-15;
		pleack : real := 1.16e-9;
		Area : real := 2.0
		);
	port ( 
	  --pragma synthesis_off
	  vcc : in real;
	 --pragma synthesis_on
	 a,b,c,d : in std_logic;
	 O : out  std_logic );
begin
	PM.monitorInput(o, Cpd, Vcc, Domain);
	PM.monitorInput(a, Cin, Vcc, Domain);
	PM.monitorInput(b, Cin, Vcc, Domain);
	PM.monitorInput(c, Cin, Vcc, Domain);
	PM.monitorInput(d, Cin, Vcc, Domain);
	AM.addArea(Area,Domain);
	PM.addLeackage(pleack,Domain);
end entity;
architecture primitiv of aoi22 is
begin
	O <= not ((a and b) or (c and d)); --O=!(a*b+c*d);
end architecture;----------------------------------------------------------------------------------
-- Company: Technical University of Cluj Napoca
-- Engineer: Rares Marincas, Botond Sandor Kirei
-- Project Name: Power/Area Avare Modeling and Estimation
-- Description: - sxlib standard libary cell file
-- Dependencies: - PAECore.vhd
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
library work;
use work.PAECore.all;

entity bistD is
	generic ( 
		Domain : integer := 1;
		CinCLK : real := 7.9e-15;
		CinD : real := 7.9e-15;
		CpdCLK : real := 62.0e-15;
		CpdD : real := 58.5e-15;
		pleack : real := 6.22e-9;
		Area : real := 12.4
		);
	port ( Vcc : in real;
		   D , CLK : in std_logic;
		   Q , Qn : out std_logic);
begin
	PM.monitorInput(CLK, CinCLK + CpdCLK, Vcc , Domain);
	PM.monitorInput(D, CinD + CpdD, Vcc , Domain);
	AM.addArea(Area, Domain);
	PM.addLeackage(pleack , Domain);
end entity;

architecture comportamental of bistD is

begin
	
	process (CLK)
	begin
		if falling_edge(clk) then
			if D'event then
				Q <= D;
			else
				Q <= not D;
			end if;
		end if;
	end process;
	
	Qn <= not Q;
	
end architecture;


----------------------------------------------------------------------------------
-- Company: Technical University of Cluj Napoca
-- Engineer: Rares Marincas, Botond Sandor Kirei
-- Project Name: Power/Area Avare Modeling and Estimation
-- Description: - sxlib standard libary cell file
-- Dependencies: - PAECore.vhd
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use work.PAECore.all;

entity buff is
	generic (
		Domain : integer := 1;
		Cin : real := 2.6e-15;
		Cpd : real := 15.0e-15;
		pleack : real := 0.88e-9;
		Area : real := 1.3
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
	PM.addLeackage(pleack,Domain);
end entity;
architecture primitiv of buff is
begin
	O <=  a;
end architecture;----------------------------------------------------------------------------------
-- Company: Technical University of Cluj Napoca
-- Engineer: Rares Marincas, Botond Sandor Kirei
-- Project Name: Power/Area Avare Modeling and Estimation
-- Description: - sxlib standard libary cell file
-- Dependencies: - PAECore.vhd
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use work.PAECore.all;

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
	PM.addLeackage(pleack,Domain);
end entity;
architecture primitiv of inv1 is
begin
	O <= not a;
end architecture;
----------------------------------------------------------------------------------
-- Company: Technical University of Cluj Napoca
-- Engineer: Rares Marincas, Botond Sandor Kirei
-- Project Name: Power/Area Avare Modeling and Estimation
-- Description: - sxlib standard libary cell file
-- Dependencies: - PAECore.vhd
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
library work;
use work.PAECore.all;

entity latchSR is
	generic ( 
		Domain : integer := 1;
		CinCLK : real := 4.4e-15;
		CinS : real := 4.4e-15;
		CinR : real := 4.4e-15;
		CpdCLK : real := 26.8e-15;
		CpdSR : real := 12.0e-15;
		--Cpd : real := 16.8e-15;
		pleack : real := 2.76e-9;
		Area : real := 5.2
		);

	port ( Vcc : in real;
			S, R : in std_logic;
		   CLK : in std_logic;
		   Q, Qn:out std_logic);
begin
	--PM.monitorInput(Q, Cpd, Vcc, Domain);
	--PM.monitorInput(Qn, Cpd, Vcc, Domain);
	PM.monitorInput(CLK, CinCLK + CpdCLK, Vcc, Domain);
	--PM.monitorInput(CLK, CinCLK, Vcc, Domain);
	PM.monitorInput(S, CinS + CpdSR, Vcc, Domain);
	--PM.monitorInput(S, CinS, Vcc, Domain);
	PM.monitorInput(R, CinR + CpdSR, Vcc, Domain);
	--PM.monitorInput(R, CinR, Vcc, Domain);
	AM.addArea(Area,Domain);
	PM.addLeackage(pleack,Domain);
end entity;

architecture behavioral of latchSR is

begin
	
	process (CLK, S, R)
	begin
		if CLK = '1' then
			case (S & R) is
				when "11" => Qn <= Qn;
				when "01" => Qn <= '1';
				when "10" => Qn <= '0';
				when others => Qn <= 'X';
			end case;
		end if;
	end process;
	
	Q <= not Qn;
	
end architecture;
----------------------------------------------------------------------------------
-- Company: Technical University of Cluj Napoca
-- Engineer: Rares Marincas, Botond Sandor Kirei
-- Project Name: Power/Area Avare Modeling and Estimation
-- Description: - sxlib standard libary cell file
-- Dependencies: - PAECore.vhd
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use work.PAECore.all;

entity nand2 is
	generic (
		Domain : integer := 1;
		Cin : real := 4.4e-15;
		Cpd : real := 6.0e-15;
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
	--PM.monitorInput(o, Cpd, Vcc, Domain);
	PM.monitorInput(a, Cin, Vcc, Domain);
	PM.monitorInput(b, Cin, Vcc, Domain);
	AM.addArea(Area,Domain);
	PM.addLeackage(pleack,Domain);
end entity;
architecture primitiv of nand2 is
begin
	--O <= not (a and b);
	process (a,b)
		variable increment : real;
	begin
		O <= not (a and b);
		increment := vcc*vcc*Cpd / 2.0;
		PM.inc(increment,Domain);
	end process;	
	
end architecture;
----------------------------------------------------------------------------------
-- Company: Technical University of Cluj Napoca
-- Engineer: Rares Marincas, Botond Sandor Kirei
-- Project Name: Power/Area Avare Modeling and Estimation
-- Description: - sxlib standard libary cell file
-- Dependencies: - PAECore.vhd
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use work.PAECore.all;

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
	PM.addLeackage(pleack,Domain);
end entity;
architecture primitiv of nand3 is
begin
	O <= not (a and b and c);
end architecture;
----------------------------------------------------------------------------------
-- Company: Technical University of Cluj Napoca
-- Engineer: Rares Marincas, Botond Sandor Kirei
-- Project Name: Power/Area Avare Modeling and Estimation
-- Description: - sxlib standard libary cell file
-- Dependencies: - PAECore.vhd
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use work.PAECore.all;

entity nand4 is
	generic (
		Domain : integer := 1;
		Cin : real := 5.0e-15;
		Cpd : real := 8.88e-15;
		pleack: real := 1.16e-9;
		Area : real := 2.0
		);
	port ( 
	  --pragma synthesis_off
	  vcc : in real;
	 --pragma synthesis_on
	 a,b,c,d : in std_logic;
	 O : out  std_logic );
begin
	PM.monitorInput(o, Cpd, Vcc, Domain);
	PM.monitorInput(a, Cin, Vcc, Domain);
	PM.monitorInput(b, Cin, Vcc, Domain);
	PM.monitorInput(c, Cin, Vcc, Domain);
	PM.monitorInput(d, Cin, Vcc, Domain);
	AM.addArea(Area,Domain);
	PM.addLeackage(pleack,Domain);
end entity;
architecture primitiv of nand4 is
begin
	O <= not (a and b and c and d);
end architecture;
----------------------------------------------------------------------------------
-- Company: Technical University of Cluj Napoca
-- Engineer: Rares Marincas, Botond Sandor Kirei
-- Project Name: Power/Area Avare Modeling and Estimation
-- Description: - sxlib standard libary cell file
-- Dependencies: - PAECore.vhd
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use work.PAECore.all;

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
	PM.addLeackage(pleack,Domain);
end entity;
architecture primitiv of nor2 is
begin
	O <= not (a or b);
end architecture;
----------------------------------------------------------------------------------
-- Company: Technical University of Cluj Napoca
-- Engineer: Rares Marincas, Botond Sandor Kirei
-- Project Name: Power/Area Avare Modeling and Estimation
-- Description: - sxlib standard libary cell file
-- Dependencies: - PAECore.vhd
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use work.PAECore.all;

entity nor3 is
	generic (
		Domain : integer := 1;
		Cin : real := 5.0e-15;
		Cpd : real := 8.1e-15;
		pleack: real := 0.81e-12;
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
	PM.addLeackage(pleack,Domain);
end entity;
architecture primitiv of nor3 is
begin
	O <= not (a or b or c);
end architecture;----------------------------------------------------------------------------------
-- Company: Technical University of Cluj Napoca
-- Engineer: Rares Marincas, Botond Sandor Kirei
-- Project Name: Power/Area Avare Modeling and Estimation
-- Description: - sxlib standard libary cell file
-- Dependencies: - PAECore.vhd
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use work.PAECore.all;

entity oai21 is
	generic (
		Domain : integer := 1;
		Cin : real := 6.1e-15;
		Cpd : real := 9.79e-15;
		pleack : real := 1.16e-9;
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
	PM.addLeackage(pleack,Domain);
end entity;
architecture primitiv of oai21 is
begin
	O <= not ((a or b) and c); -- O=!((a+b)*c);
end architecture;
----------------------------------------------------------------------------------
-- Company: Technical University of Cluj Napoca
-- Engineer: Rares Marincas, Botond Sandor Kirei
-- Project Name: Power/Area Avare Modeling and Estimation
-- Description: - sxlib standard libary cell file
-- Dependencies: - PAECore.vhd
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use work.PAECore.all;

entity or2 is
	generic (
		Domain : integer := 1;
		Cin : real := 4.7e-15;
		Cpd : real := 29.1e-15;
		pleack : real := 1.27e-9;
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
	PM.addLeackage(pleack,Domain);
end entity;
architecture primitiv of or2 is
begin
	O <= (a or b);
end architecture;
----------------------------------------------------------------------------------
-- Company: Technical University of Cluj Napoca
-- Engineer: Rares Marincas, Botond Sandor Kirei
-- Project Name: Power/Area Avare Modeling and Estimation
-- Description: - sxlib standard libary cell file
-- Dependencies: - PAECore.vhd
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use work.PAECore.all;

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
	PM.addLeackage(pleack,Domain);
end entity;
architecture primitiv of or3 is
begin
	O <= (a or b or c);
end architecture;
library ieee;
use ieee.std_logic_vector.all;
library work;
use work.PAECore.all;

package sx