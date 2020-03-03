library ieee;
use ieee.std_logic_1164.all;
use work.pmonitor.all;

entity inv is
	generic (
		constant PowerDomain : integer := 1;
		constant Cin : real := 5.0e-15;
		constant Cpd : real := 10.0e-15;
		constant Area : real := 0.1
		);
	port ( 
	  -- pragma synthesys_off
	  vcc : in real;
	  -- pragma synthesys_on
	  a : in std_logic;
	  y : out std_logic
	);
begin 
	PM.monitorInput(a, Cin, Vcc, PowerDomain);
	PM.monitorInput(a, Cpd, Vcc, PowerDomain);
	AM.addArea(Area,PowerDomain);
end entity;
architecture prim of inv is
begin
	y <= not a;
end architecture;
	

