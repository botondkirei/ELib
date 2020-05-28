----------------------------------------------------------------------------------
-- Company: Technical University of Cluj Napoca
-- Engineer: Botond Sandor Kirei
-- Project Name: Power/Area Avare Modeling and Estimation
-- Description: - 7400 series logic devices
-- Dependencies: - PAECore.vhd
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_vector.all;
use work.PAECore.all;

package ic74xx is generic ( logic_family : string )

	type logic_family_t is (
			"ac",
			"act",
			"hc",
			"hct",
			"cmos"
			); 

	--type component_t is (tristate_buffer, buffer_non_inv, inverter, and2, and3, and4, or2, or3, or4, nand2, nand3, nand4, nor2, nor3, nor4, xor2, xnor2, mux2, mux4, num163, dff_rising_edge, none_comp);
	type component_t is (ic7400, tristate_buffer, buffer_non_inv, inverter, and2, and3, and4, or2, or3, or4, nand2, nand3, nand4, nor2, nor3, nor4, xor2, xnor2, mux2, mux4, num163, dff_rising_edge, none_comp);
 	
	component ic7400 is
		generic (
			Domain : integer := 1;
			Cin : real := 4.8e-15;
			Cpd : real := 28.9e-15; 
			pleack : real := 1.16e-9;
			Area : real := 1
			);
		port ( 
		  --pragma synthesis_off
		  vcc : in real;
		 --pragma synthesis_on
		 a1, b1 : in std_logic;
		 a2, b2 : in std_logic;
		 a3, b3 : in std_logic;
		 a4, b4 : in std_logic;
		 O1,O2,O3,O4 : out  std_logic );
	end component;
	
end package;

package body ic74xx is

end package body;

library ieee;
use ieee.std_logic_vector.all;
use work.PAECore.all;

entity ic7400 is
	generic (
		Domain : integer := 1;
		Cin : real := 4.8e-15;
		Cpd : real := 28.9e-15; 
		pleack : real := 1.16e-9;
		Area : real := 1
		);
	port ( 
	  --pragma synthesis_off
	  vcc : in real;
	  gnd : in real;
	 --pragma synthesis_on
	 a1, b1 : in std_logic;
	 a2, b2 : in std_logic;
	 a3, b3 : in std_logic;
	 a4, b4 : in std_logic;
	 O1,O2,O3,O4 : out  std_logic );
begin
	PM.addNode(a1, Cin, Domain);
	PM.addNode(a2, Cin, Domain);
	PM.addNode(a2, Cin, Domain);
	PM.addNode(a3, Cin, Domain);
	PM.addNode(b1, Cin, Domain);
	PM.addNode(b2, Cin, Domain);
	PM.addNode(b2, Cin, Domain);
	PM.addNode(b3, Cin, Domain);
	PM.addNode(o1, Cpd, Domain);
	PM.addNode(o2, Cpd, Domain);
	PM.addNode(o2, Cpd, Domain);
	PM.addNode(o3, Cpd, Domain);
	AM.addArea(Area,Domain);
end entity;

architecture comportamental of ic7400 is
begin
	o1 <= a1 nand b1;
	o2 <= a2 nand b2;
	o3 <= a3 nand b3;
	o4 <= a4 nand b4;
end architecture;