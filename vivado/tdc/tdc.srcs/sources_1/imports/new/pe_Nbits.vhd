----------------------------------------------------------------------------------
-- Company: Technical University of Cluj Napoca
-- Engineer: Botond Sandor Kirei
-- Project Name: NAPOSIP
-- Description:  Priority encoder on N bits with activity monitoring
--              - the raw bits of a delay line converter must undergo for 
--                "thermal" encoding - priority encoding is  the second stage of the encoding)
--              - parameters :  delay - simulated delay time of an elementary gate
--              - inputs:   bi - bits in
--              - outputs : bo - the priotity number
--                          mo - mask out - to next mask cell
--                          consumption :  port to monitor dynamic and static consumption
--              - dynamic power dissipation can be estimated using the activity signal 
-- Dependencies: nand_gate.vhd, and_gate.vhd, or_gate.vhd
-- Revision:
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all; 

library xil_defaultlib;
use xil_defaultlib.util.all;

entity pe_Nbits is
    Generic ( N: natural := 4;
               delay : time := 0 ns);
    Port ( bi : in STD_LOGIC_VECTOR (N-1 downto 0);
           bo : out STD_LOGIC_VECTOR (log2(N)-1 downto 0);
           consumption : out consumption_monitor_type);
end pe_Nbits;

architecture Behavioral of pe_Nbits is

   signal highest_bit : natural := N-1;

begin

shifting : PROCESS(bi)
   variable i: natural;
begin
   for i in 0 to N-1 loop
      if bi(i) = '1' then 
         highest_bit <= i;
      end if;
   end loop;
end process;

bo <= std_logic_vector(to_unsigned(highest_bit, log2(N))) after delay;
consumption <= (0.0,0.0);

end Behavioral;
