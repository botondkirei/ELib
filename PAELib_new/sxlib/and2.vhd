library IEEE;
use IEEE.std_logic_1164.all;
use work.pmonitor.all;

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
