library ieee;
use ieee.std_logic_1164.all;
use work.pmonitor.all;

entity circuit is
	generic ( PowerDomain : integer);
		port  
			( a, b : in std_logic;
			  y : out std_logic
			);
begin 
	--registerPowerDomain(PowerDomain);
	process 
	begin
		wait for 10 ns;
		report circuit'instance_name;
		am.reportArea(1);
	end process;
end entity;

architecture struct of circuit is

	component and2 is
		generic ( PowerDomain : integer);
		port( 
			  -- pragma synthesys_off
			  vcc : in real;
			  -- pragma synthesys_on
			  a, b : in std_logic;
			  y : out std_logic
			);
	end component;
	
	component inv is
		generic ( PowerDomain : integer);
		port ( 			
			  -- pragma synthesys_off
			  vcc : in real;
			  -- pragma synthesys_on
			  a : in std_logic;
			  y : out std_logic
			);
	end component;

	signal g: std_logic;
	
begin

	inv1 : inv generic map (PowerDomain => PowerDomain) port map (vcc => 5.0, a=>a, y=>g);
	and21 : and2 generic map (PowerDomain => PowerDomain) port map (vcc => 5.0, a=>b, b=>g,y=>y);

end architecture;
		


