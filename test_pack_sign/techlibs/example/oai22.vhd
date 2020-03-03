library IEEE;
use IEEE.std_logic_1164.all;
use work.pmonitor.all;

entity oai22 is
	generic (
		Domain : integer := 1;
		Cin : real := 6.1e-15;
		Cpd : real := 11.3e-15;
		pleack : real :=1.16e-9;
		Area : real := 2.3
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
	PM.addLeackage(pleack,1);
end entity;
architecture primitiv of oai22 is
begin
	O <= not ((a or b) and (c or d)); --O=!((a+b)*(c+d))
end architecture;