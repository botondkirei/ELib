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
