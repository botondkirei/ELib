library ieee;
use ieee.std_logic_1164.all;
library work;
use work.pmonitor.all;

entity bistD is
	generic ( 
		Domain : integer := 1;
		CinCLK : real := 7.9e-15;
		CinD : real := 7.9e-15;
		CpdCLK : real := 62.0e-15;
		CpdD : real := 58.5e-15;
		pleack : real := 6.22e-9;
		Area : real := 12.4
		);
	port ( Vcc : in real;
		   D , CLK : in std_logic;
		   Q , Qn : out std_logic);
begin
	PM.monitorInput(CLK, CinCLK + CpdCLK, Vcc , Domain);
	PM.monitorInput(D, CinD + CpdD, Vcc , Domain);
	AM.addArea(Area, Domain);
	PM.addLeackage(pleack , Domain);
end entity;

architecture comportamental of bistD is

begin
	
	process (CLK)
	begin
		if falling_edge(clk) then
			if D'event then
				Q <= D;
			else
				Q <= not D;
			end if;
		end if;
	end process;
	
	Qn <= not Q;
	
end architecture;


