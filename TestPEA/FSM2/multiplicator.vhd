----------------------------------------------------------------------------------
-- Description: multiplier on N bits with power and area estimation  
--              - parameters :  delay - simulated delay time of an elementary gate
--                          	width - the lenght of the numbers
--								logic_family - the logic family of the tristate buffer
--								Cload - load capacitance
--              - inputs :  ma, mb - the numbers for multiplication
--                          clk- clock signal
--                          Rn - reset signal also function as an enable signal
--              - outpus :  mp - result of multiplication
--                          done- indicate the final of multiplication
--                          Vcc- supply voltage 
--                          estimation :  port to monitor dynamic and static estimation
--                          	   for power estimation only 
-- Dependencies: PECore.vhd, PeGates.vhd, Nbits.vhd, auto.vhd, reg_dep.vhd
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_unsigned.all;

use work.PECore.all;
use work.PEGates.all;
use work.Nbits.all;
use work.auto.all;

entity multiplicator is 
	generic (width:integer:=32 ;
	         delay : time := 0 ns ;
	         logic_family : logic_family_t := default_logic_family ; -- the logic family of the component
             Cload : real := 0.0 -- capacitive load
	         );	
	port (
	      -- pragma synthesis_off
	      Vcc : in real ; -- supply voltage
          estimation : out estimation_type := est_zero;
          -- pragma synthesis_on
	      ma,mb : in std_logic_vector (width-1 downto 0); --4/8/16/32
	      clk, rn : in std_logic;
	      mp : out std_logic_vector (2*width-1 downto 0);--8/16/32/64
	      done : out std_logic
          );
end entity;

architecture behavioral of multiplicator is 

signal my, sum, lo, hi : std_logic_vector (width-1 downto 0);--4/8/16/32
signal  a1 : std_logic;
signal loadHI, loadLO, loadM, shft, rsthi, carry : std_logic;
signal estim : estimation_type_array(1 to 7);
signal rst : std_logic;
 signal loadLO_shft, loadHi_shft : std_logic;

begin
rst <=  not rn;
a1 <= lo(0);

 or2_gate1 : or_gate generic map (delay => 0 ns) port map 
	 ( 
	 -- pragma synthesis_off
      Vcc => Vcc, --supply voltage
      estimation => estim(6),       
      -- pragma synthesis_on
	  a => loadLo, b=> shft, y => loadLO_shft);
 or2_gate2 : or_gate generic map (delay => 0 ns) port map 
	 ( -- pragma synthesis_off
      Vcc => Vcc, --supply voltage
      estimation => estim(7),       
      -- pragma synthesis_on
	  a => loadHi, b=> shft, y => loadHi_shft);
--b1 <= '1' when out1=31 else '0';
control : auto_structural generic map (width=> width, delay => delay, logic_family => logic_family ) port map 	
    ( -- pragma synthesis_off
     Vcc => Vcc, --supply voltage
     estimation => estim(1),       
     -- pragma synthesis_on
    clk => clk, rn => rst, a => a1, loadHI => loadHI, loadLO => loadLO, loadM => loadM, shft => shft, rsthi => rsthi, done => done);
M_i : ureg generic map (width => width, delay => delay, logic_family => logic_family) port map  	
    ( -- pragma synthesis_off
     Vcc => Vcc, --supply voltage
     estimation => estim(2),       
     -- pragma synthesis_on
    D => ma, CK => clk, Clear => '1', S1 => loadM, S0 => loadM, SR => '0', SL => '0', Q => my);
LO_i: ureg generic map (width => width, delay => delay, logic_family => logic_family) port map  	
    ( -- pragma synthesis_off
     Vcc => Vcc, --supply voltage
     estimation => estim(3),       
     -- pragma synthesis_on
    D => mb, CK => clk, Clear => '1', S0 => loadLO_shft, S1 => loadLo, SL => hi(0), SR => hi(0), Q => lo);
HI_i: ureg generic map (width => width, delay => delay, logic_family => logic_family) port map  	
    ( -- pragma synthesis_off
     Vcc => Vcc, --supply voltage
     estimation => estim(4),       
     -- pragma synthesis_on
    D => sum, CK => clk, Clear => rsthi, S0 => loadHi_shft, S1 => loadHi, SL => Carry, SR => Carry, Q => hi);

mp <= hi&lo;
--sum <= my+hi;
adder: adder_Nbits generic map (width => width, delay => 0.1 ns) port map
	( -- pragma synthesis_off
     Vcc => Vcc, --supply voltage
     estimation => estim(5),       
     -- pragma synthesis_on
    A => my, B => hi, Cin => '0', Cout => Carry, S => sum );
    
    
-- pragma synthesis_off
consum: sum_up generic map (N=>7) port map (estim=>estim, estimation=>estimation);
-- pragma synthesis_on
end architecture;