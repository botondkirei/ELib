library IEEE;
use IEEE.std_logic_1164.all;
use work.pmonitor.all;

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
	PM.monitorInput(o, Cpd, Vcc, Domain);
	PM.monitorInput(a, Cin, Vcc, Domain);
	PM.monitorInput(b, Cin, Vcc, Domain);
	AM.addArea(Area,Domain);
	PM.addLeackage(pleack,1);
end entity;
architecture primitiv of nand2 is
begin
	O <= not (a and b);
end architecture;
