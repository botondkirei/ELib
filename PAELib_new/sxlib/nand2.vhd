----------------------------------------------------------------------------------
-- Company: Technical University of Cluj Napoca
-- Engineer: Rares Marincas, Botond Sandor Kirei
-- Project Name: Power/Area Avare Modeling and Estimation
-- Description: - sxlib standard libary cell file
-- Dependencies: - PAECore.vhd
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
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
	--PM.monitorInput(o, Cpd, Vcc, Domain);
	PM.monitorInput(a, Cin, Vcc, Domain);
	PM.monitorInput(b, Cin, Vcc, Domain);
	AM.addArea(Area,Domain);
	PM.addLeackage(pleack,Domain);
end entity;
architecture primitiv of nand2 is
begin
	--O <= not (a and b);
	process (a,b)
		variable increment : real;
	begin
		O <= not (a and b);
		increment := vcc*vcc*Cpd / 2.0;
		PM.inc(increment,Domain);
	end process;	
	
end architecture;
