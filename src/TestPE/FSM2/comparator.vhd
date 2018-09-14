----------------------------------------------------------------------------------
-- Description: iterative comparator circuit on N bits with activity monitoring  
--              - parameters :  delay - simulated delay time of an elementary gate
--								logic_family - the logic family of the tristate buffer
--								Cload - load capacitance
--                              Area -  area parameter
--              - inputs :  x,y - numbers to be compared 
--                       
--              - outpus :  EQO - result of comparation
--                          Vcc- supply voltage 
--                          consumption :  port to monitor dynamic and static consumption
--                          	   for power estimation only 
-- Dependencies: cmp_cell.vhd 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;
use work.PECore.all;
use work.PEGates.all; 
use work.Nbits.all;


entity comparator is
    Generic ( width: integer :=4 ; 
            delay : time := 1 ns;
            logic_family : logic_family_t := default_logic_family; -- the logic family of the component
            Cload: real := 5.0 ; -- capacitive load
            Area: real := 0.0 --parameter area 
             );
    Port ( x : in STD_LOGIC_VECTOR (width-1 downto 0);
           y : in STD_LOGIC_VECTOR (width-1 downto 0);
           EQO : out STD_LOGIC;
           Vcc : in real ; -- supply voltage
           consumption : out consumption_type := cons_zero
           );
end comparator;

architecture Behavioral of comparator is


signal EQ : STD_LOGIC_VECTOR (width downto 0);
signal cons : consumption_type_array(1 to width);
 
component cmp_cell is
     Generic (delay : time := 0 ns;
            logic_family : logic_family_t; -- the logic family of the component
            Cload: real := 5.0 ; -- capacitive load
            Area: real := 0.0 --parameter area 
             );
    Port ( x : in STD_LOGIC;
           y : in STD_LOGIC;
           EQI : in STD_LOGIC;
           EQO : out STD_LOGIC;
           Vcc : in real ; -- supply voltage
           consumption : out consumption_type := cons_zero);
end component;

begin


EQ(0) <= '1';

gen_cmp_cells:  for i in 0 to width-1 generate
        gen_i : cmp_cell generic map (delay => 0 ns, logic_family => logic_family) port map ( x => x(i), y => y(i), EQI => EQ(i), EQO => EQ(i+1), Vcc => Vcc, consumption => cons(i+1));
end generate gen_cmp_cells;     

EQO  <= EQ(width); 

sum_up_i : sum_up generic map (N => width) port map (cons => cons, consumption => consumption);

end Behavioral;
