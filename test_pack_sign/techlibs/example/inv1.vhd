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
