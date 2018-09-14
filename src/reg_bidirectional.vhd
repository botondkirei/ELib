----------------------------------------------------------------------------------
-- Description: N bit universal shift register with activity monitoring and Clear
--              - parameters :  delay - simulated delay time of an elementary gate
--                          	width - the length of the words
--								logic_family - the logic family of the tristate buffer
--								Cload - load capacitance
--              - inputs :  Input--the input word 
--                          Clear--the signal for reset
--                          CK-- clock signal
--                          S0,S1--conditioning signals (S0='0', S1='0' - no change; S0='0', S1='1' - shift right; S0='1', S1='0' - shift left; S0='1', S1='1' - parallel load)
--              - outpus :  A - the output word
--                          Vcc  -- supply voltage
--                          consumption :  port to monitor dynamic and static consumption
--									for power estimation only 
-- Dependencies: PECore.vhd, PeGates.vhd, Nbits.vhd, dff_Nbits.vhd, mux4_1.vhd
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;
use work.PECore.all;
use work.PEGates.all; 
use work.Nbits.all;

entity reg_bidirectional is
    Generic ( width: integer :=4 ; 
            delay : time := 1 ns;
            logic_family : logic_family_t; -- the logic family of the component
            Cload: real := 5.0 ; -- capacitive load
            Area: real := 0.0 --parameter area 
             );
    Port ( Input : in STD_LOGIC_VECTOR (width-1 downto 0);
           Clear : in STD_LOGIC;
           CK : in STD_LOGIC;
           S1,S0 : in STD_LOGIC;
           A : out STD_LOGIC_VECTOR (width-1 downto 0);
           Vcc : in real ; -- supply voltage
           consumption : out consumption_type := cons_zero
           );
end entity;

architecture Behavioral of reg_bidirectional is


signal outmux: STD_LOGIC_VECTOR (width-1 downto 0);
signal outdff: STD_LOGIC_VECTOR (width-1 downto 0);
signal cons : consumption_type_array(1 to 2*width);

begin

gen_cells:  for i in  width-1 downto 0 generate
        gen_dff: dff_Nbits generic map (delay => 0 ns, active_edge => TRUE, logic_family => logic_family) port map (D => outmux(i) , Ck => CK, Rn => Clear, Q => outdff(i), Qn => open, Vcc => Vcc, consumption => cons(i + 1));
        gen_mux: mux4_1 generic map( delay => 0 ns, logic_family => logic_family ) port map( I(3) => Input(i), I(2) => outdff(i-1), I(1) => outdff(i+1), I(0) => outdff(i), A(1) => S1, A(0) => S0, Y => outmux(i), Vcc => Vcc, consumption => cons(i + width + 1));
end generate gen_cells;        

A <= outdff;

sum_up_i : sum_up generic map (N =>2*width) port map (cons => cons, consumption => consumption);


end Behavioral;
