----------------------------------------------------------------------------------
-- Company: Technical University of Cluj Napoca
-- Engineer: Botond Sandor Kirei
-- Project Name: NAPOSIP
-- Description:  Mask on N bits (the raw bits of a delay line converter must undergo for "thermal" encoding - masking is a fisrt stage of the encoding)
--              - parameters :  delay1 - simulated delay time of an nand gate
--              - inputs:   cb - current bit
--                          pb - previous bit
--                          mi - mask in - from previous mask cell
--              - outputs : bo - masked bit out
--                          mo - mask out - to next mask cell
--                          consumption :  port to monitor dynamic and static consumption
--              - dynamic power dissipation can be estimated using the activity signal 
-- Dependencies: nand_gate.vhd, and_gate.vhd, or_gate.vhd, util.vhd
-- Revision:
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--library work;
use work.PECore.all;
use work.PEGates.all;

entity mask is
    Generic (delay: time:=0 ns;
            logic_family : logic_family_t := default_logic_family; -- the logic family of the component
            Cload: real := 5.0 -- capacitive load
            );
    Port ( cb : in STD_LOGIC; -- current bit
           pb : in STD_LOGIC; --previous bit
           mi : in STD_LOGIC; -- mask in bit
           b : out STD_LOGIC; -- masked bit - output of the current stage
           mo : out STD_LOGIC; --mask out bit
           Vcc : in real ; -- supply voltage
           consumption : out consumption_type := cons_zero); -- consumption monitoring
end mask;

architecture Behavioral of mask is
begin
    b <= cb and (not mi);
    mo <= mi  or ( (not cb) and pb);
    consumption <= cons_zero;
end Behavioral;

architecture Structural of mask is

    -- consumption monitoring signals
    signal mi_n, cb_n, net : std_logic;
     signal cons : consumption_type_array(1 to 5);
    
 begin
 
     inv_g1: inv_gate generic map (delay => delay) port map (
                -- pragma synthesis_off
                consumption => cons(1),
                Vcc => Vcc,
                -- pragma synthesis_on
                a => mi, y => mi_n);
     and_g1: and_gate generic map (delay => delay) port map (a => cb, b=>mi_n, y =>b, Vcc => Vcc, consumption => cons(2));
     
     inv_g2: inv_gate generic map (delay => delay) port map (
                -- pragma synthesis_off
                consumption => cons(3),
                Vcc => Vcc,
                -- pragma synthesis_on
                a => cb, y => cb_n);
     and_g2: and_gate generic map (delay => delay) port map (a=>pb, b=> cb_n, y=>net, Vcc => Vcc, consumption => cons(4));
     or_g1: or_gate generic map (delay => delay) port map (a=> mi, b=> net, y=>mo, Vcc => Vcc, consumption => cons(5));

    --+ consumption monitoring
    -- for simulation only - to be ignored for synthesis 
    -- pragma synthesis_off
sum : sum_up generic map ( N => 5) port map (cons => cons, consumption => consumption);
    -- for simulation only - to be ignored for synthesis 
    -- pragma synthesis_on    
      
 end architecture;