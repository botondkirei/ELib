library ieee;
use ieee.std_logic_1164.all;
use work.pmonitor.all;

entity and2 is
	generic ( PowerDomain : integer);
	port (
	      -- pragma synthesys_off
		  vcc : in real;
		  -- pragma synthesys_on
		  a, b : in std_logic;
		  y : out std_logic
		);
	constant Cin : real := 5.0e-15;
	constant Cpd : real := 10.0e-15;
	constant Area : real := 0.1;
begin
	PM.monitorInput(a, Cin, Vcc, PowerDomain);
	PM.monitorInput(b, Cin, Vcc, PowerDomain);
	PM.monitorInput(y, Cpd, Vcc, PowerDomain);
	AM.addArea(Area,PowerDomain);
end entity;

architecture prim of and2 is
begin
	y <= a and b;
end architecture;
		


