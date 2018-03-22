----------------------------------------------------------------------------------
-- Company: Technical University of Cluj Napoca
-- Engineer: Chereja Iulia
-- Project Name: NAPOSIP
-- Description: Gated Ring Oscillator with activity monitoring
--              - parameters :  delay - simulated delay time of an elementary gate
--              - inputs:   start - enables the ring osccilator
--              - outputs : CLK - three phase of the clock signal
--                          consumption :  port to monitor dynamic and static consumption
--              - dynamic power dissipation can be estimated using the activity signal 
-- Dependencies: delay_cell.vhd, nand_gate.vhd
-- 
-- Revision: 1.0 - Botond Sandor Kirei
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library xil_defaultlib;
use xil_defaultlib.util.all;

entity GRO is
    Generic (delay : time :=1 ns);
    Port ( start : in STD_LOGIC;
           CLK : out STD_LOGIC_VECTOR (0 to 2);
           consumption : out consumption_monitor_type);
end GRO;

architecture Structural of GRO is
    component nand_gate is
        Generic (delay : time :=1 ns);
        Port ( a : in STD_LOGIC;
               b : in STD_LOGIC;
               y : out STD_LOGIC;
               consumption : out consumption_monitor_type); 
    end component;
    
    component delay_cell is
        Generic (delay : time :=1 ns);
        Port ( a : in STD_LOGIC;
               y : out STD_LOGIC;
               consumption : out consumption_monitor_type);
    end component;
    
    signal net: STD_LOGIC_VECTOR (0 to 2);
    --consumption monitoring
    type cons_t is array (1 to 3) of consumption_monitor_type;
    signal cons : cons_t;
    type sum_t is array (0 to 3) of consumption_monitor_type;
    signal sum : sum_t;
 
begin
    nand_gate_1: nand_gate generic map (delay => delay) port map (a => start, b => net(2), y => net(0), consumption => cons(1));
    delay_cell_1: delay_cell generic map (delay => delay) port map (a => net(0), y => net(1), consumption => cons(2));
    delay_cell_2: delay_cell generic map (delay => delay) port map (a => net(1), y => net(2), consumption => cons(3));
    CLK <= net;
    --+ consumption monitoring
    -- for behavioral simulation only
    sum(0) <= (0.0,0.0);
    sum_up_energy : for I in 1 to 3 generate
          sum_i:    sum(I) <= sum(I-1) + cons(I);
    end generate sum_up_energy;
    consumption <= sum(3);
    -- for simulation only

end Structural;
