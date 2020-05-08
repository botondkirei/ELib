library ieee;
use ieee.std_logic_1164.all;
library work;
use work.pmonitor.all;

entity test is
end entity;

architecture prim of test is

	component circuit is
		port  
			( a, b : in std_logic;
			  y : out std_logic
			);
	end component;
	
	signal a,b,y : std_logic;
	
	
begin

a <= '1', '0' after 10 ns, '1' after 50 ns;
b <= '1', '0' after 20 ns, '1' after 30 ns, '0' after 70 ns, '1' after 100 ns;

dut : circuit port map (a=>a, b=>b,y=>y);

process
	begin
		PM.resetPower(1);
		wait for 150 ns;
		PM.reportPower(1);
		AM.reportArea(1);
		assert false report "End sim" severity failure;
	end process;


	
end architecture;
		


