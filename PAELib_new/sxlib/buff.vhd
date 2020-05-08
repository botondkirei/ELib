library IEEE;
use IEEE.std_logic_1164.all;
use work.pmonitor.all;

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
	PM.addLeackage(pleack,1);
end entity;
architecture primitiv of buff is
begin
	O <=  a;
end architecture;