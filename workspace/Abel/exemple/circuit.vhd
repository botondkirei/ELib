library ieee;
use ieee.std_logic_1164.all;
use work.pmonitor.all;

entity circuit is
		port  
			( a, b : in std_logic;
			  y : out std_logic
			);
begin 
end entity;

architecture struct of circuit is

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

	signal g: std_logic;
	
begin

	inv_1 : inv1 port map (vcc => 3.3, a=>a, o=>g);
	and21 : and2 port map (vcc => 3.3, a=>b, b=>g,o=>y);

end architecture;
		


