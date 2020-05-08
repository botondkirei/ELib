library ieee;
use ieee.std_logic_1164.all;
library work;
use work.pmonitor.all;

entity latchSR is
	generic ( 
		Domain : integer := 1;
		CinCLK : real := 4.4e-15;
		CinS : real := 4.4e-15;
		CinR : real := 4.4e-15;
		CpdCLK : real := 26.8e-15;
		CpdSR : real := 12.0e-15;
		--Cpd : real := 16.8e-15;
		pleack : real := 2.76e-9;
		Area : real := 5.2
		);

	port ( Vcc : in real;
			S, R : in std_logic;
		   CLK : in std_logic;
		   Q, Qn:out std_logic);
begin
	--PM.monitorInput(Q, Cpd, Vcc, Domain);
	--PM.monitorInput(Qn, Cpd, Vcc, Domain);
	PM.monitorInput(CLK, CinCLK + CpdCLK, Vcc, Domain);
	--PM.monitorInput(CLK, CinCLK, Vcc, Domain);
	PM.monitorInput(S, CinS + CpdSR, Vcc, Domain);
	--PM.monitorInput(S, CinS, Vcc, Domain);
	PM.monitorInput(R, CinR + CpdSR, Vcc, Domain);
	--PM.monitorInput(R, CinR, Vcc, Domain);
	AM.addArea(Area,Domain);
	PM.addLeackage(pleack,Domain);
end entity;

architecture behavioral of latchSR is

begin
	
	process (CLK, S, R)
	begin
		if CLK = '1' then
			case (S & R) is
				when "11" => Qn <= Qn;
				when "01" => Qn <= '1';
				when "10" => Qn <= '0';
				when others => Qn <= 'X';
			end case;
		end if;
	end process;
	
	Q <= not Qn;
	
end architecture;
