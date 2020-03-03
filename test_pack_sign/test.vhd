library ieee;
use ieee.std_logic_1164.all;


entity test is
end entity;

architecture prim of test is

	component circuit is
	generic ( PowerDomain : integer);
		port  
			( a, b : in std_logic;
			  y : out std_logic
			);
	end component;
	
	signal a,b,y : std_logic;
	
	
begin

a <= '1', '0' after 10 ns, '1' after 50 ns;
b <= '1', '0' after 20 ns, '1' after 30 ns, '0' after 70 ns, '1' after 100 ns;

process
	begin
		wait for 150 ns;
		assert false report "End sim" severity failure;
	end process;

	dut : circuit generic map (PowerDomain => 1) port map (a=>a, b=>b,y=>y);
	dut2 : circuit generic map (PowerDomain => 2) port map (a=>b, b=>'0',y=>open);
	
end architecture;
		


