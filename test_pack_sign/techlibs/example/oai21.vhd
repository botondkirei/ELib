library IEEE;
use IEEE.std_logic_1164.all;
use work.pmonitor.all;

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
	PM.addLeackage(pleack,1);
end entity;
architecture primitiv of oai21 is
begin
	O <= not ((a or b) and c); -- O=!((a+b)*c);
end architecture;
