----------------------------------------------------------------------------------
-- Company: Technical University of Cluj Napoca
-- Engineer: Chereja Iulia
-- Project Name: NAPOSIP
-- Description: Multiplexor with 4 inputs and activity monitoring 
--              - inputs:   I(0:3) - std_logic_vector 
--              - address inputs: A(0:1)-std_logic_vector 
--              - outputs : Y-std_logic
--              - consumption :  port to monitor dynamic and static consumption
-- Dependencies: inv_gate.vhd, and_gate.vhd, or_gate.vhd, mux2_1
-- 
-- Revision: 1.0 - Added comments - Botond Sandor Kirei
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use work.PELib.all;
use work.PEGates.all;

entity mux4_1 is
    Generic (delay : time := 1 ns;
            Cpd, Cin, Cload : real := 20.0e-12; --power dissipation, input and load capacityies
            Icc : real := 2.0e-6 -- questient current at room temperature  
            );
    Port ( I : in STD_LOGIC_VECTOR (0 to 3);
           A : in STD_LOGIC_VECTOR (0 to 1);
           Y : out STD_LOGIC;
           consumption : out consumption_type := (0.0,0.0));
end mux4_1;

architecture Behavioral of mux4_1 is
      signal addr : STD_LOGIC_VECTOR (0 to 1);
      signal internal: STD_LOGIC;
begin

addr <= A;
internal <= I(0) when addr = "00"
       else I(1) when addr = "01"
       else I(2) when addr = "10"
       else I(3) when addr = "11";
Y <= internal;

cm_i : consumption_monitor generic map ( N=>4, M=>1, Cpd =>Cpd, Cin => Cin, Cload => Cload, Icc=>Icc)
		port map (sin(0) => I(0), sin(1) => I(1),sin(2) => I(2),sin(3) => I(3), sout(0) => internal, consumption => consumption);

end Behavioral;

architecture Structural of mux4_1 is
 signal net1,net2: std_logic;
 signal c1,c2,c3 : consumption_type;
begin
mux2_one: mux2_1 port map (I(0) => I(0), I(1) => I(1), A => A(0), Y => net1, consumption => c1);
mux2_two: mux2_1 port map (I(0) => I(2), I(1) => I(3), A => A(0), Y => net2, consumption => c2);
mux2_three: mux2_1 port map (I(0) => net1, I(1) => net2, A => A(1), Y => Y, consumption => c3);
consumption <= (c1 + c2 + c3);
end Structural;

