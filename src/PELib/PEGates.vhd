----------------------------------------------------------------------------------
-- Company: Technical University of Cluj Napoca
-- Engineer: Chereja Iulia, Botond Sandor Kirei
-- Project Name: NAPOSIP
-- Description: - PEGates package
--              - defines logic gates with consumption monitoring
-- Dependencies: PECore.vhd
-- 
-- Revision: 0.02  - Updates, merging content of files in PEGates library (tristate_buf.vhd, inv_gate.vhd,
--					xor_gate.vhd, xnor_gate.vhd, and_gate.vhd, and3_gate.vhd, and4_gate.vhd, and5_gate.vhd,
--					or_gate.vhd, or3_gate.vhd, or4_gate.vhd, or9_gate.vhd, nand_gate.vhd, nand4_gate.vhd,
--					nand9_gate.vhd, nor_gate.vhd, nor3_gate.vhd, nor4_gate.vhd, nor8_gate.vhd, nor9_gate.vhd
--					- moving components mux2_1.vhd, mux4_1.vhd, num74163.vhd and dff.vhd into Nbits library
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.PECore.all;

package PEGates is
	
-----------------------------------------------------------------------------------------
	component tristate_buf is
		Generic (delay : time :=1 ns;
				 logic_family : logic_family_t := default_logic_family; -- the logic family of the component
				 Cload : real := 0.0 -- capacitive load
				 );
		Port ( a, en : in STD_LOGIC;
			   y : out STD_LOGIC;
			   -- sim only
			   Vcc : in real; -- supply voltage
		       consumption : out consumption_type := cons_zero
		       );
	end component;
-----------------------------------------------------------------------------------------
	component inv_gate is
		Generic (delay : time :=1 ns;
				 logic_family : logic_family_t := default_logic_family; -- the logic family of the component
				 Cload : real := 0.0 -- capacitive load
				 );
     Port ( a : in STD_LOGIC;
            y : out STD_LOGIC;
            Vcc : in real ; -- supply voltage
		    consumption : out consumption_type := cons_zero
		    );
	end component;
-----------------------------------------------------------------------------------------
	component xor_gate is
		Generic (delay : time := 1 ns;
				 logic_family : logic_family_t := default_logic_family; -- the logic family of the component
				 Cload : real := 0.0 -- capacitive load
				 );
		Port ( a : in STD_LOGIC;
			   b : in STD_LOGIC;
			   y : out STD_LOGIC;
			   Vcc : in real ; -- supply voltage
		       consumption : out consumption_type := cons_zero
		       );
	end component;
-----------------------------------------------------------------------------------------
	component xnor_gate is
        Generic (delay : time := 1 ns;
                     logic_family : logic_family_t := default_logic_family; -- the logic family of the component
                     Cload : real := 0.0 -- capacitive load
                     );
            Port ( a : in STD_LOGIC;
                   b : in STD_LOGIC;
                   y : out STD_LOGIC;
                   Vcc : in real ; -- supply voltage
                   consumption : out consumption_type := cons_zero
                   );
    end component;
-----------------------------------------------------------------------------------------
	component and_gate is
		Generic (delay : time := 1 ns;
				 logic_family : logic_family_t := default_logic_family; -- the logic family of the component
				 Cload : real := 0.0 -- capacitive load 
				 );
		Port ( a : in STD_LOGIC;
			   b : in STD_LOGIC;
			   y : out STD_LOGIC;
			   Vcc : in real ; -- supply voltage
		       consumption : out consumption_type := cons_zero
		       );
	end component;
-----------------------------------------------------------------------------------------
	component and3_gate is
		Generic (delay : time := 1 ns;
				 logic_family : logic_family_t := default_logic_family; -- the logic family of the component
				 Cload : real := 0.0 -- capacitive load
             );
		Port ( a,b,c : in STD_LOGIC;
			   y : out STD_LOGIC;
			   Vcc : in real ; -- supply voltage
		       consumption : out consumption_type := cons_zero
		       );
	end component;
-----------------------------------------------------------------------------------------
	component and4_gate is
		Generic (delay : time := 1 ns;
				 logic_family : logic_family_t := default_logic_family; -- the logic family of the component
				 Cload : real := 0.0 -- capacitive load 
             );
		Port ( a,b,c,d : in STD_LOGIC;
			   y : out STD_LOGIC;
			   Vcc : in real ; -- supply voltage
		       consumption : out consumption_type := cons_zero
		       );
	end component;
-----------------------------------------------------------------------------------------
	component and5_gate is
        Generic (delay : time := 1 ns;
				 logic_family : logic_family_t := default_logic_family; -- the logic family of the component
				 Cload : real := 0.0 -- capacitive load
				 );
        Port ( a,b,c,d,e : in STD_LOGIC;
               y : out STD_LOGIC;
               Vcc : in real ; -- supply voltage
		       consumption : out consumption_type := cons_zero
		       );
    end component;
-----------------------------------------------------------------------------------------
	component or_gate is
		Generic (delay : time := 1 ns;
				 logic_family : logic_family_t := default_logic_family; -- the logic family of the component
				 Cload : real := 0.0 -- capacitive load 
             );
		Port ( a : in STD_LOGIC;
			   b : in STD_LOGIC;
			   y : out STD_LOGIC;
			   Vcc : in real ; -- supply voltage
		       consumption : out consumption_type := cons_zero
		       );
	end component;	
-----------------------------------------------------------------------------------------
	component or3_gate is
		Generic (delay : time := 1 ns;
				 logic_family : logic_family_t := default_logic_family; -- the logic family of the component
				 Cload : real := 0.0 -- capacitive load 
             );
		Port ( a,b,c : in STD_LOGIC;
			   y : out STD_LOGIC;
			   Vcc : in real ; -- supply voltage
		       consumption : out consumption_type := cons_zero
		       );
	end component;
-----------------------------------------------------------------------------------------
    component or4_gate is
        Generic (delay : time :=1 ns;
				 logic_family : logic_family_t := default_logic_family; -- the logic family of the component
				 Cload : real := 0.0 -- capacitive load 
             );
        Port ( a,b,c,d : in STD_LOGIC;
                y: out STD_LOGIC;
                Vcc : in real ; -- supply voltage
		        consumption : out consumption_type := cons_zero
		        );
    end component;	
-----------------------------------------------------------------------------------------
    component or9_gate is
		Generic (delay : time :=1 ns;
				 logic_family : logic_family_t := default_logic_family; -- the logic family of the component
				 Cload : real := 0.0 -- capacitive load 
             );
		Port ( x : in STD_LOGIC_VECTOR(8 downto 0);
			   y : out STD_LOGIC;
			   Vcc : in real ; -- supply voltage
		       consumption : out consumption_type := cons_zero
		       );
    end component;
-----------------------------------------------------------------------------------------
    component nand_gate is
		Generic (delay : time := 1 ns;
				 logic_family : logic_family_t := default_logic_family; -- the logic family of the component
				 Cload : real := 0.0 -- capacitive load  
             );
		Port ( a : in STD_LOGIC;
				 b : in STD_LOGIC;
				 y : out STD_LOGIC;
				 Vcc : in real ; -- supply voltage
		         consumption : out consumption_type := cons_zero
		         );
    end component;	
-----------------------------------------------------------------------------------------
	component nand4_gate is
        Generic (delay : time := 1 ns;
				 logic_family : logic_family_t := default_logic_family; -- the logic family of the component
				 Cload : real := 0.0 -- capacitive load 
             );
        Port ( a,b,c,d : in STD_LOGIC;
               y : out STD_LOGIC;
               Vcc : in real ; 
		       consumption : out consumption_type := cons_zero
		       );
    end component;
------------------------------------------------------------------------------------------
component nand3_gate is
        Generic (delay : time := 1 ns;
				 logic_family : logic_family_t := default_logic_family; -- the logic family of the component
				 Cload : real := 0.0 -- capacitive load 
             );
        Port ( a,b,c: in STD_LOGIC;
               y : out STD_LOGIC;
               Vcc : in real ; 
		       consumption : out consumption_type := cons_zero
		       );
    end component;
-----------------------------------------------------------------------------------------
	component nand9_gate is
		Generic (delay : time :=1 ns;
				 logic_family : logic_family_t := default_logic_family; -- the logic family of the component
				 Cload : real := 0.0 -- capacitive load 
             );
		Port ( x : in STD_LOGIC_VECTOR(8 downto 0);
			   y : out STD_LOGIC;
			   Vcc : in real ; -- supply voltage
		       consumption : out consumption_type := cons_zero
		       );
	end component;
-----------------------------------------------------------------------------------------
	component nor_gate is
		Generic (delay : time := 1 ns;
				 logic_family : logic_family_t := default_logic_family; -- the logic family of the component
				 Cload : real := 0.0 -- capacitive load 
				 );
		Port ( a : in STD_LOGIC;
			   b : in STD_LOGIC;
			   y : out STD_LOGIC;
			   Vcc : in real ;-- supply voltage 
		       consumption : out consumption_type := cons_zero
		       );
	end component;
-----------------------------------------------------------------------------------------
	component nor3_gate is
		Generic (delay : time := 1 ns;
				 logic_family : logic_family_t := default_logic_family; -- the logic family of the component
				 Cload : real := 0.0 -- capacitive load
             );
		Port ( a,b,c : in STD_LOGIC;
			   y : out STD_LOGIC;
			   Vcc : in real ; -- supply voltage
		       consumption : out consumption_type := cons_zero
		       );
	end component;
-----------------------------------------------------------------------------------------
	component nor4_gate is
		Generic (delay : time :=1 ns;
				 logic_family : logic_family_t := default_logic_family; -- the logic family of the component
				 Cload : real := 0.0 -- capacitive load
             );
		Port ( a,b,c,d : in STD_LOGIC;
				y: out STD_LOGIC;
				Vcc : in real ; -- supply voltage
		        consumption : out consumption_type := cons_zero
		        );
	end component;
-----------------------------------------------------------------------------------------
	component nor8_gate is
		Generic (delay : time :=1 ns;
				 logic_family : logic_family_t := default_logic_family; -- the logic family of the component
				 Cload : real := 0.0 -- capacitive load 
             );
		Port ( x : in STD_LOGIC_VECTOR(7 downto 0);
			   y : out STD_LOGIC;
			   Vcc : in real ; -- supply voltage
		       consumption : out consumption_type := cons_zero
		       );
	end component;
-----------------------------------------------------------------------------------------
	component nor9_gate is
		Generic (delay : time :=1 ns;
				 logic_family : logic_family_t := default_logic_family; -- the logic family of the component
				 Cload : real := 0.0 -- capacitive load 
             );
    Port ( x : in STD_LOGIC_VECTOR(8 downto 0);
           y : out STD_LOGIC;
           Vcc : in real ; -- supply voltage
		   consumption : out consumption_type := cons_zero
		   );
	end component;
    
end PEGates;

package body PEGates is


end PEGates;

----------------------------------------------------------------------------------
-- Description: Tristate buffer with consumption monitoring 
--              - parameters :  delay - simulated delay time of an elementary gate
--								logic_family - the logic family of the tristate buffer
--								Cload - load capacitance
--              - inputs:   a - std_logic (1 bit)
--                          VCC -  supply voltage (used to compute static power dissipation)
--                          	   for power estimation only 
--              - outputs : y - not a
--                          consumption :  port to monitor dynamic and static consumption
--									for power estimation only 
-- Dependencies: PECore.vhd
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.PECore.all;

entity tristate_buf is
    Generic (delay : time :=1 ns;
				 logic_family : logic_family_t := default_logic_family; -- the logic family of the component
				 Cload : real := 0.0 -- capacitive load
				 );
		Port ( a, en : in STD_LOGIC;
			   y : out STD_LOGIC;
			   -- sim only
			   Vcc : in real; -- supply voltage
		       consumption : out consumption_type := cons_zero
		       );
end tristate_buf;

architecture primitive of tristate_buf is

    signal internal : std_logic;

begin
    -- behavior
    internal <= a after delay when en = '1' else 'Z' after delay ;
    y<=internal;
    -- consumption monitoring - this section is intended only for simulation
	-- pragma synthesis_off
	cm_i : consumption_monitor generic map ( N=>2, M=>1, logic_family => logic_family, gate => tristate_comp, Cload => Cload)
		port map (sin(0) => a, sin(1) => en,Vcc => Vcc, sout(0) => internal, consumption => consumption);
	-- pragma synthesis_on
end primitive;

----------------------------------------------------------------------------------
-- Description: Inverter gate with consumption monitoring 
--              - parameters :  delay - simulated delay time of an elementary gate
--								logic_family - the logic family of the tristate buffer
--								Cload - load capacitance
--              - inputs:   a - std_logic (1 bit)
--                          VCC -  supply voltage (used to compute static power dissipation)
--                          	   for power estimation only 
--              - outputs : y - not a
--                          consumption :  port to monitor dynamic and static consumption
--									for power estimation only 
-- Dependencies: PECore
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.PECore.all;

entity inv_gate is
   Generic (delay : time :=1 ns;
			logic_family : logic_family_t := default_logic_family; -- the logic family of the component
			Cload : real := 0.0 -- capacitive load
			);
     Port ( a : in STD_LOGIC;
            y : out STD_LOGIC;
            Vcc : in real ; -- supply voltage
		    consumption : out consumption_type := cons_zero
		    );
end inv_gate;

architecture primitive of inv_gate is
    signal internal : std_logic;
begin
    -- behavior
    internal <= not a after delay;
    y<=internal;
	-- consumption monitoring
	-- pragma synthesis_off
	cm_i : consumption_monitor generic map ( N=>1, M=>1, logic_family => logic_family, gate => inv_comp, Cload => Cload)
		port map (sin(0) => a, Vcc => Vcc,  sout(0) => internal, consumption => consumption);
	-- pragma synthesis_on
end primitive;

----------------------------------------------------------------------------------
-- Description: xor gate with consumption monitoring 
--              - parameters :  delay - simulated delay time of an elementary gate
--								logic_family - the logic family of the tristate buffer
--								Cload - load capacitance
--              - inputs:   a, b - std_logic (1 bit)
--                          VCC -  supply voltage (used to compute static power dissipation)
--                          	   for power estimation only 
--              - outputs : y - a xor b
--                          consumption :  port to monitor dynamic and static consumption
--									for power estimation only 
-- Dependencies: PECore.vhd
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.PECore.all;

entity xor_gate is
    Generic (delay : time := 1 ns;
			logic_family : logic_family_t := default_logic_family; -- the logic family of the component
			Cload : real := 0.0 -- capacitive load
			);
		Port ( a : in STD_LOGIC;
			   b : in STD_LOGIC;
			   y : out STD_LOGIC;
			   Vcc : in real ; -- supply voltage
		       consumption : out consumption_type := cons_zero
		       );
end xor_gate;

architecture primitive of xor_gate is

    signal internal : std_logic;
    
begin
    -- behavior
    internal <= a xor b after delay;
    y <= internal;
    -- consumption monitoring - this section is intended only for simulation
	-- pragma synthesis_off
	cm_i : consumption_monitor generic map ( N=>2, M=>1, logic_family => logic_family, gate => xor_comp, Cload => Cload)
		port map (sin(0) => a, sin(1) => b, Vcc => Vcc, sout(0) => internal, consumption => consumption);
	-- pragma synthesis_on
end primitive;

----------------------------------------------------------------------------------
-- Description: xnor gate with consumption monitoring 
--              - parameters :  delay - simulated delay time of an elementary gate
--              - inputs:   a, b - std_logic (1 bit)
--							logic_family - the logic family of the tristate buffer
--							Cload - load capacitance
--                          VCC -  supply voltage (used to compute static power dissipation)
--                          	   for power estimation only 
--              - outputs : y - not (a xor b)
--                          consumption :  port to monitor dynamic and static consumption
--									for power estimation only 
-- Dependencies: PECore.vhd
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.PECore.all;

entity xnor_gate is
    Generic (delay : time := 1 ns;
			 logic_family : logic_family_t := default_logic_family; -- the logic family of the component
			 Cload : real := 0.0 -- capacitive load
			 );
		Port ( a : in STD_LOGIC;
			   b : in STD_LOGIC;
			   y : out STD_LOGIC;
			   Vcc : in real ; 
		       consumption : out consumption_type := cons_zero
		       );
end xnor_gate;

architecture primitive of xnor_gate is

    signal internal : std_logic;
    
begin
    -- behavior
    internal <= a xor b after delay;
    y <= not internal;
    -- consumption monitoring - this section is intended only for simulation
	-- pragma synthesis_off
	cm_i : consumption_monitor generic map ( N=>2, M=>1, logic_family => logic_family, gate => xor_comp, Cload => Cload)
		port map (sin(0) => a, sin(1) => b, Vcc => Vcc, sout(0) => internal, consumption => consumption);
	-- pragma synthesis_on
end primitive;

----------------------------------------------------------------------------------
-- Description: And gate with consumption monitoring 
--              - parameters :  delay - simulated delay time of an elementary gate
--							logic_family - the logic family of the tristate buffer
--							Cload - load capacitance
--              - inputs:   a, b - std_logic (1 bit)
--                          VCC -  supply voltage (used to compute static power dissipation)
--                          	   for power estimation only 
--              - outputs : y - a and b
--                          consumption :  port to monitor dynamic and static consumption
-- Dependencies: PECore.vhd
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.PECore.all;

entity and_gate is
       Generic (delay : time := 1 ns;
				 logic_family : logic_family_t := default_logic_family; -- the logic family of the component
				 Cload : real := 0.0 -- capacitive load 
				 );
		Port ( a : in STD_LOGIC;
			   b : in STD_LOGIC;
			   y : out STD_LOGIC;
			   Vcc : in real ; -- supply voltage
		       consumption : out consumption_type := cons_zero
		       );
end and_gate;

architecture primitive of and_gate is

    signal internal : std_logic;
    
begin
    -- behavior
    internal <= a and b after delay;
    y <= internal;
    -- consumption monitoring - this section is intended only for simulation
	-- pragma synthesis_off
	cm_i : consumption_monitor generic map ( N=>2, M=>1, logic_family => logic_family, gate => and2_comp, Cload => Cload)
		port map (sin(0) => a, sin(1) => b, Vcc => Vcc, sout(0) => internal, consumption => consumption);
	-- pragma synthesis_on

end primitive;

----------------------------------------------------------------------------------
-- Description: And3 gate with consumption monitoring 
--              - parameters :  delay - simulated delay time of an elementary gate
--							logic_family - the logic family of the tristate buffer
--							Cload - load capacitance
--              - inputs:   a,b,c - std_logic
--                          VCC -  supply voltage (used to compute static power dissipation)
--                          	   for power estimation only 
--              - outputs : y - a & b & c
--              			consumption :  port to monitor dynamic and static consumption
-- Dependencies: PECore.vhd
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.PECore.all;

entity and3_gate is
    Generic (delay : time := 1 ns;
				 logic_family : logic_family_t := default_logic_family; -- the logic family of the component
				 Cload : real := 0.0 -- capacitive load
             );
		Port ( a,b,c : in STD_LOGIC;
			   y : out STD_LOGIC;
			   Vcc : in real ; -- supply voltage
		       consumption : out consumption_type := cons_zero
		       );
end and3_gate;

architecture Behavioral of and3_gate is

	signal internal: std_logic;

begin
	-- behavior
	internal <= a and b and c after delay;
	y <= internal;
    -- consumption monitoring - this section is intended only for simulation
	-- pragma synthesis_off
	cm_i : consumption_monitor generic map ( N=>3, M=>1, logic_family => logic_family, gate => and3_comp, Cload => Cload)
		port map (sin(0) => a, sin(1) => b, sin(2) => c, Vcc => Vcc, sout(0) => internal, consumption => consumption);
	-- pragma synthesis_on
end Behavioral;


----------------------------------------------------------------------------------
-- Description: And4 gate with consumption monitoring 
--              - parameters :  delay - simulated delay time of an elementary gate
--							logic_family - the logic family of the tristate buffer
--							Cload - load capacitance
--              - inputs:   a,b,c,d - std_logic
--                          VCC -  supply voltage (used to compute static power dissipation)
--                          	   for power estimation only 
--              - outputs : y - a & b & c & d
--              			consumption :  port to monitor dynamic and static consumption
-- Dependencies: PECore.vhd
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.PECore.all;

entity and4_gate is
    Generic (delay : time := 1 ns;
			 logic_family : logic_family_t := default_logic_family; -- the logic family of the component
			 Cload : real := 0.0 -- capacitive load 
             );
		Port ( a,b,c,d : in STD_LOGIC;
			   y : out STD_LOGIC;
			   Vcc : in real ; -- supply voltage
		       consumption : out consumption_type := cons_zero
		       );
end and4_gate;

architecture Behavioral of and4_gate is

	signal internal: std_logic;

begin
	-- behavior
	internal <= a and b and c and d after delay;
	y <= internal;
    -- consumption monitoring - this section is intended only for simulation
	-- pragma synthesis_off
	cm_i : consumption_monitor generic map ( N=>4, M=>1, logic_family => logic_family, gate => and2_comp, Cload => Cload)
		port map (sin(0) => a, sin(1) => b, sin(2) => c, sin(3) => d, Vcc => Vcc, sout(0) => internal, consumption => consumption);
	-- pragma synthesis_on
end Behavioral;
----------------------------------------------------------------------------------
-- Description: And5 gate with consumption monitoring 
--              - parameters :  delay - simulated delay time of an elementary gate
--							logic_family - the logic family of the tristate buffer
--							Cload - load capacitance
--              - inputs:   a,b,c,d,e - std_logic
--                          VCC -  supply voltage (used to compute static power dissipation)
--                          	   for power estimation only 
--              - outputs : y - a & b & c & d & e
--              			consumption :  port to monitor dynamic and static consumption
-- Dependencies: PECore.vhd
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.PECore.all;

entity and5_gate is
   Generic (delay : time := 1 ns;
			 logic_family : logic_family_t := default_logic_family; -- the logic family of the component
			 Cload : real := 0.0 -- capacitive load
			 );
        Port ( a,b,c,d,e : in STD_LOGIC;
               y : out STD_LOGIC;
               Vcc : in real ; -- supply voltage
		       consumption : out consumption_type := cons_zero
		       );
end and5_gate;

architecture Behavioral of and5_gate is

	signal internal: std_logic;

begin
	--behavior
    internal <= a and b and c and d and e after delay;
    y <= internal; 
    -- consumption monitoring - this section is intended only for simulation
	-- pragma synthesis_off
	cm_i : consumption_monitor generic map ( N=>5, M=>1, logic_family => logic_family, gate => and2_comp, Cload => Cload)
		port map (sin(0) => a, sin(1) => b, sin(2) => c, sin(3) => d, sin(4) => e, Vcc => Vcc, sout(0) => internal, consumption => consumption);
	-- pragma synthesis_on
end Behavioral;

----------------------------------------------------------------------------------
-- Description: Or gate with consumption monitoring 
--              - parameters :  delay - simulated delay time of an elementary gate
--							logic_family - the logic family of the tristate buffer
--							Cload - load capacitance
--              - inputs:   a, b - std_logic
--                          VCC -  supply voltage (used to compute static power dissipation)
--                          	   for power estimation only 
--              - outputs : y - a | b
--              			consumption :  port to monitor dynamic and static consumption
-- Dependencies: PECore.vhd
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.PECore.all;

entity or_gate is
    Generic (delay : time := 1 ns;
			 logic_family : logic_family_t := default_logic_family; -- the logic family of the component
			 Cload : real := 0.0 -- capacitive load 
             );
		Port ( a : in STD_LOGIC;
			   b : in STD_LOGIC;
			   y : out STD_LOGIC;
			   Vcc : in real ; -- supply voltage
		       consumption : out consumption_type := cons_zero
		       );
end or_gate;

architecture primitive of or_gate is

    signal internal : std_logic;

begin
    -- behavior
    internal <= a or b after delay;
    y <= internal;
    -- consumption monitoring - this section is intended only for simulation
	-- pragma synthesis_off
	cm_i : consumption_monitor generic map ( N=>2, M=>1, logic_family => logic_family, gate => or_comp, Cload => Cload)
		port map (sin(0) => a, sin(1) => b, Vcc => Vcc, sout(0) => internal, consumption => consumption);
	-- pragma synthesis_on
end primitive;
----------------------------------------------------------------------------------
-- Description: or3 gate with consumption monitoring 
--              - parameters :  delay - simulated delay time of an elementary gate
--							logic_family - the logic family of the tristate buffer
--							Cload - load capacitance
--              - inputs:   a,b,c - std_logic
--                          VCC -  supply voltage (used to compute static power dissipation)
--                          	   for power estimation only 
--              - outputs : y - a | b | c
--              			consumption :  port to monitor dynamic and static consumption
-- Dependencies: PECore.vhd
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.PECore.all;

entity or3_gate is
    Generic (delay : time := 1 ns;
				 logic_family : logic_family_t := default_logic_family; -- the logic family of the component
				 Cload : real := 0.0 -- capacitive load 
             );
		Port ( a,b,c : in STD_LOGIC;
			   y : out STD_LOGIC;
			   Vcc : in real ; -- supply voltage
		       consumption : out consumption_type := cons_zero
		       );
end or3_gate;

architecture Behavioral of or3_gate is

	signal internal: std_logic;

begin
	--behavior
	internal <= a or b or c after delay;
	y <= internal;
    -- consumption monitoring - this section is intended only for simulation
	-- pragma synthesis_off
	cm_i : consumption_monitor generic map ( N=>3, M=>1, logic_family => logic_family, gate => or_comp, Cload => Cload)
		port map (sin(0) => a, sin(1) => b, sin(2) => c, Vcc => Vcc, sout(0) => internal, consumption => consumption);
	-- pragma synthesis_on
end Behavioral;

----------------------------------------------------------------------------------
-- Company: Technical University of Cluj Napoca
-- Engineer: Chereja Iulia
-- Project Name: NAPOSIP
-- Description: or4 gate with consumption monitoring 
--              - parameters :  delay - simulated delay time of an elementary gate
--							logic_family - the logic family of the tristate buffer
--							Cload - load capacitance
--              - inputs:   a,b,c,d - std_logic
--                          VCC -  supply voltage (used to compute static power dissipation)
--                          	   for power estimation only 
--              - outputs : y - a | b | c | d
--              			consumption :  port to monitor dynamic and static consumption
-- Dependencies: PECore.vhd
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.PECore.all;

entity or4_gate is
    Generic (delay : time :=1 ns;
			 logic_family : logic_family_t := default_logic_family; -- the logic family of the component
			 Cload : real := 0.0 -- capacitive load 
             );
        Port ( a,b,c,d : in STD_LOGIC;
                y: out STD_LOGIC;
                Vcc : in real ; -- supply voltage
		        consumption : out consumption_type := cons_zero
		        );
end or4_gate;

architecture Behavioral of or4_gate is

	signal internal: std_logic;

begin
	--behavior
    internal <= a or b or c or d after delay;
    y <= internal;
    -- consumption monitoring - this section is intended only for simulation
	-- pragma synthesis_off
	cm_i : consumption_monitor generic map ( N=>4, M=>1, logic_family => logic_family, gate => or_comp, Cload => Cload)
		port map (sin(0) => a, sin(1) => b, sin(2) => c, sin(3) => d, Vcc => Vcc, sout(0) => internal, consumption => consumption);
	-- pragma synthesis_on
end Behavioral;

----------------------------------------------------------------------------------
-- Description: or9 gate with consumption monitoring 
--              - parameters :  delay - simulated delay time of an elementary gate
--								logic_family - the logic family of the tristate buffer
--								Cload - load capacitance
--              - inputs:   x(i), i=(0:8)
--                          VCC -  supply voltage (used to compute static power dissipation)
--                          	   for power estimation only 
--              - outputs : y = | x(i)
--              			consumption :  port to monitor dynamic and static consumption
-- Dependencies: PECore.vhd
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.PECore.all;

entity or9_gate is
   Generic (delay : time :=1 ns;
				 logic_family : logic_family_t := default_logic_family; -- the logic family of the component
				 Cload : real := 0.0 -- capacitive load 
             );
		Port ( x : in STD_LOGIC_VECTOR(8 downto 0);
			   y : out STD_LOGIC;
			   Vcc : in real ; -- supply voltage
		       consumption : out consumption_type := cons_zero
		       );
end or9_gate;

architecture Behavioral of or9_gate is

	signal internal: STD_LOGIC;

begin

	internal <= x(0) or x(1) or x(2) or x(3) or x(4) or x(5) or x(6) or x(7) or x(8) after delay;
	y <= internal;

    -- consumption monitoring - this section is intended only for simulation
	-- pragma synthesis_off
	cm_i : consumption_monitor generic map ( N=>9, M=>1, logic_family => logic_family, gate => or_comp, Cload => Cload)
		port map (sin => x, Vcc => Vcc,  sout(0) => internal, consumption => consumption);
	-- pragma synthesis_on
    --- consumption monitoring

end Behavioral;
----------------------------------------------------------------------------------
-- Description: Nand gate with consumption monitoring 
--              - parameters :  delay - simulated delay time of an elementary gate
--								logic_family - the logic family of the tristate buffer
--								Cload - load capacitance
--              - inputs:   a, b - std_logic (1 bit)
--                          VCC -  supply voltage (used to compute static power dissipation)
--                          	   for power estimation only 
--              - outputs : y - a nand b
--                          consumption :  port to monitor dynamic and static consumption
-- Dependencies: PECore.vhd
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.PECore.all;

entity nand_gate is
    Generic (delay : time := 1 ns;
				 logic_family : logic_family_t := default_logic_family; -- the logic family of the component
				 Cload : real := 0.0 -- capacitive load  
             );
		Port ( a : in STD_LOGIC;
				 b : in STD_LOGIC;
				 y : out STD_LOGIC;
				 Vcc : in real ; -- supply voltage
		         consumption : out consumption_type := cons_zero
		         );
end nand_gate;

architecture primitive of nand_gate is

    signal internal : std_logic;

begin
    -- behavior
    internal <= a nand b after delay;
    y <= internal;
    -- consumption monitoring - this section is intended only for simulation
	-- pragma synthesis_off
	cm_i : consumption_monitor generic map ( N=>2, M=>1, logic_family => logic_family, gate => nand_comp, Cload => Cload)
		port map (sin(0) => a, sin(1) => b, Vcc => Vcc, sout(0) => internal, consumption => consumption);
	-- pragma synthesis_on
end primitive;

----------------------------------------------------------------------------------
-- Description: Nand3 gate with consumption monitoring 
--              - parameters :  delay - simulated delay time of an elementary gate
--								logic_family - the logic family of the tristate buffer
--								Cload - load capacitance
--              - inputs:   a, b, c - std_logic (1 bit)
--                          VCC -  supply voltage (used to compute static power dissipation)
--                          	   for power estimation only 
--              - outputs : y - a nand b and c
--                          consumption :  port to monitor dynamic and static consumption
-- Dependencies: PECore.vhd
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.PECore.all;

entity nand3_gate is
    Generic (delay : time := 1 ns;
				 logic_family : logic_family_t := default_logic_family; -- the logic family of the component
				 Cload : real := 0.0 -- capacitive load  
             );
		Port ( a: in STD_LOGIC;
				 b : in STD_LOGIC;
				 c : in STD_LOGIC;
				 y : out STD_LOGIC;
				 Vcc : in real ; -- supply voltage
		         consumption : out consumption_type := cons_zero
		         );
end nand3_gate;

architecture primitive of nand3_gate is

    signal internal : std_logic;

begin
    -- behavior
    internal <= not (a and b and c) after delay;
    y <= internal;
    -- consumption monitoring - this section is intended only for simulation
	-- pragma synthesis_off
	cm_i : consumption_monitor generic map ( N=>3, M=>1, logic_family => logic_family, gate => nand_comp, Cload => Cload)
		port map (sin(0) => a, sin(1) => b, sin(2) => c,  Vcc => Vcc, sout(0) => internal, consumption => consumption);
	-- pragma synthesis_on
end primitive;
----------------------------------------------------------------------------------
-- Description: Nand4 gate with consumption monitoring 
--              - parameters :  delay - simulated delay time of an elementary gate
--								logic_family - the logic family of the tristate buffer
--								Cload - load capacitance
--              - inputs:   a, b, c - std_logic (1 bit)
--                          VCC -  supply voltage (used to compute static power dissipation)
--                          	   for power estimation only 
--              - outputs : y - ! (a & b & c)
--                          consumption :  port to monitor dynamic and static consumption
-- Dependencies: PECore.vhd
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.PECore.all;

entity nand4_gate is
    Generic (delay : time := 1 ns;
				 logic_family : logic_family_t := default_logic_family; -- the logic family of the component
				 Cload : real := 0.0 -- capacitive load 
             );
        Port ( a,b,c,d : in STD_LOGIC;
               y : out STD_LOGIC;
               Vcc : in real ; 
		       consumption : out consumption_type := cons_zero
		       );
end nand4_gate;

architecture Behavioral of nand4_gate is

	signal internal: std_logic;


begin
	--behavior
	internal <= a and b and c and d after delay;
	y <= not internal;
    -- consumption monitoring - this section is intended only for simulation
	-- pragma synthesis_off
	cm_i : consumption_monitor generic map ( N=>4, M=>1, logic_family => logic_family, gate => nand_comp, Cload => Cload)
		port map (sin(0) => a, sin(1) => b, sin(2) => c, sin(3) => d, Vcc => Vcc, sout(0) => internal, consumption => consumption);
	-- pragma synthesis_on
end Behavioral;

----------------------------------------------------------------------------------
-- Description: Nand9 gate with consumption monitoring 
--              - parameters :  delay - simulated delay time of an elementary gate
--								logic_family - the logic family of the tristate buffer
--								Cload - load capacitance
--              - inputs:   x(i), i=(0:8)
--                          VCC -  supply voltage (used to compute static power dissipation)
--                          	   for power estimation only 
--              - outputs : y = ! ( & x(i) )
--              			consumption :  port to monitor dynamic and static consumption
-- Dependencies: PECore.vhd
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.PECore.all;

entity nand9_gate is
   Generic (delay : time :=1 ns;
				 logic_family : logic_family_t := default_logic_family; -- the logic family of the component
				 Cload : real := 0.0 -- capacitive load 
             );
		Port ( x : in STD_LOGIC_VECTOR(8 downto 0);
			   y : out STD_LOGIC;
			   Vcc : in real ; -- supply voltage
		       consumption : out consumption_type := cons_zero
		       );
end nand9_gate;

architecture Behavioral of nand9_gate is

 signal internal : STD_LOGIC;

begin
	-- behavior
	internal <= x(0) and x(1) and x(2) and x(3) and x(4) and x(5) and x(6) and x(7) and x(8) after delay;
	y <= not internal;
    -- consumption monitoring - this section is intended only for simulation
	-- pragma synthesis_off
	cm_i : consumption_monitor generic map ( N=>9, M=>1, logic_family => logic_family, gate => nand_comp, Cload => Cload)
		port map (sin => x, Vcc => Vcc, sout(0) => internal, consumption => consumption);
	-- pragma synthesis_on
end Behavioral;
----------------------------------------------------------------------------------
-- Description: Nor gate with consumption monitoring 
--              - parameters :  delay - simulated delay time of an elementary gate
--								logic_family - the logic family of the tristate buffer
--								Cload - load capacitance
--              - inputs:   a, b - std_logic (1 bit)
--                          VCC -  supply voltage (used to compute static power dissipation)
--                          	   for power estimation only 
--              - outputs : y - a nor b
--                          consumption :  port to monitor dynamic and static consumption
-- Dependencies: PECore.vhd
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.PECore.all;

entity nor_gate is
   Generic (delay : time := 1 ns;
			 logic_family : logic_family_t := default_logic_family; -- the logic family of the component
			 Cload : real := 0.0 -- capacitive load 
			 );
		Port ( a : in STD_LOGIC;
			   b : in STD_LOGIC;
			   y : out STD_LOGIC;
			   Vcc : in real ;-- supply voltage 
		       consumption : out consumption_type := cons_zero
		       );
end nor_gate;

architecture primitive of nor_gate is

    signal internal : std_logic;
    
begin
    -- behavior
    internal <= a nor b after delay;
    y <= internal;
    -- consumption monitoring - this section is intended only for simulation
	-- pragma synthesis_off
	cm_i : consumption_monitor generic map ( N=>2, M=>1, logic_family => logic_family, gate => nor_comp, Cload => Cload)
		port map (sin(0) => a, sin(1) => b, Vcc => Vcc, sout(0) => internal, consumption => consumption);
	-- pragma synthesis_on
end primitive;

----------------------------------------------------------------------------------
-- Description: nor3 gate with consumption monitoring 
--              - parameters :  delay - simulated delay time of an elementary gate
--								logic_family - the logic family of the tristate buffer
--								Cload - load capacitance
--              - inputs:   a, b,c - std_logic (1 bit)
--                          VCC -  supply voltage (used to compute static power dissipation)
--                          	   for power estimation only 
--              - outputs : y - a nor b nor c
--                          consumption :  port to monitor dynamic and static consumption
-- Dependencies: PECore.vhd
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.PECore.all;

entity nor3_gate is
    Generic (delay : time := 1 ns;
				 logic_family : logic_family_t := default_logic_family; -- the logic family of the component
				 Cload : real := 0.0 -- capacitive load
             );
		Port ( a,b,c : in STD_LOGIC;
			   y : out STD_LOGIC;
			   Vcc : in real ; -- supply voltage
		       consumption : out consumption_type := cons_zero
		       );
end nor3_gate;

architecture Behavioral of nor3_gate is

	signal internal: std_logic;

begin
	--behavior
	internal <= not (a or b or c) after delay;
	y <= internal;
    -- consumption monitoring - this section is intended only for simulation
	-- pragma synthesis_off
	cm_i : consumption_monitor generic map ( N=>3, M=>1, logic_family => logic_family, gate => nor_comp, Cload => Cload)
		port map (sin(0) => a, sin(1) => b, sin(2) => c, Vcc => Vcc, sout(0) => internal, consumption => consumption);
	-- pragma synthesis_on
    --- consumption monitoring
end Behavioral;

----------------------------------------------------------------------------------
-- Description: Nor4 gate with consumption monitoring 
--              - parameters :  delay - simulated delay time of an elementary gate
--								logic_family - the logic family of the tristate buffer
--								Cload - load capacitance
--              - inputs:   a, b,c,d - std_logic (1 bit)
--                          VCC -  supply voltage (used to compute static power dissipation)
--                          	   for power estimation only 
--              - outputs : y - a nor b nor c nor d
--                          consumption :  port to monitor dynamic and static consumption
-- Dependencies: PECore.vhd
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.PECore.all;

entity nor4_gate is
    Generic (delay : time :=1 ns;
			 logic_family : logic_family_t := default_logic_family; -- the logic family of the component
			 Cload : real := 0.0 -- capacitive load
             );
		Port ( a,b,c,d : in STD_LOGIC;
				y: out STD_LOGIC;
				Vcc : in real ; -- supply voltage
		        consumption : out consumption_type := cons_zero
		        );
end nor4_gate;

architecture Behavioral of nor4_gate is

	signal internal: std_logic;

begin
	--behavior
	internal <= a or b or c or d after delay;
	y <= not internal;
    -- consumption monitoring - this section is intended only for simulation
	-- pragma synthesis_off
	cm_i : consumption_monitor generic map ( N=>4, M=>1, logic_family => logic_family, gate => nor_comp, Cload => Cload)
		port map (sin(0) => a, sin(1) => b, sin(2) => c, sin(3) => d, Vcc => Vcc, sout(0) => internal, consumption => consumption);
	-- pragma synthesis_on
end Behavioral;

----------------------------------------------------------------------------------
-- Description: Nor8 gate with consumption monitoring 
--              - parameters :  delay - simulated delay time of an elementary gate
--								logic_family - the logic family of the tristate buffer
--								Cload - load capacitance
--              - inputs:   x(i), i=(0:7)
--                          VCC -  supply voltage (used to compute static power dissipation)
--                          	   for power estimation only 
--              - outputs : y - ! ( | x(i))
--                          consumption :  port to monitor dynamic and static consumption
-- Dependencies: PECore.vhd
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.PECore.all;

entity nor8_gate is
    Generic (delay : time :=1 ns;
			 logic_family : logic_family_t := default_logic_family; -- the logic family of the component
			 Cload : real := 0.0 -- capacitive load 
             );
		Port ( x : in STD_LOGIC_VECTOR(7 downto 0);
			   y : out STD_LOGIC;
			   Vcc : in real ; -- supply voltage
		       consumption : out consumption_type := cons_zero
		       );
end nor8_gate;

architecture Behavioral of nor8_gate is

	signal internal : STD_LOGIC;

begin
	-- behavior
	internal <= x(0) or x(1) or x(2) or x(3) or x(4) or x(5) or x(6) or x(7) after delay;
	y <= not internal;
    -- consumption monitoring - this section is intended only for simulation
	-- pragma synthesis_off
	cm_i : consumption_monitor generic map ( N=>8, M=>1, logic_family => logic_family, gate => nor_comp, Cload => Cload)
		port map (sin => x, Vcc => Vcc, sout(0) => internal, consumption => consumption);
	-- pragma synthesis_on
end Behavioral;

----------------------------------------------------------------------------------
-- Description: Nor9 gate with consumption monitoring 
--              - parameters :  delay - simulated delay time of an elementary gate
--								logic_family - the logic family of the tristate buffer
--								Cload - load capacitance
--              - inputs:   x(i), i=(0:8)
--                          VCC -  supply voltage (used to compute static power dissipation)
--                          	   for power estimation only 
--              - outputs : y - ! ( | x(i))
--                          consumption :  port to monitor dynamic and static consumption
-- Dependencies: PECore.vhd
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.PECore.all;

entity nor9_gate is
    Generic (delay : time :=1 ns;
			 logic_family : logic_family_t := default_logic_family; -- the logic family of the component
			 Cload : real := 0.0 -- capacitive load 
             );
    Port ( x : in STD_LOGIC_VECTOR(8 downto 0);
           y : out STD_LOGIC;
           Vcc : in real ; -- supply voltage
		   consumption : out consumption_type := cons_zero
		   );
end nor9_gate;

architecture Behavioral of nor9_gate is

	signal internal: STD_LOGIC;

begin
	-- behavior
	internal <= x(0) or x(1) or x(2) or x(3) or x(4) or x(5) or x(6) or x(7) or x(8) after delay;
	y <= not internal;
    -- consumption monitoring - this section is intended only for simulation
	-- pragma synthesis_off
	cm_i : consumption_monitor generic map ( N=>9, M=>1, logic_family => logic_family, gate => nor_comp, Cload => Cload)
		port map (sin => x, Vcc => Vcc, sout(0) => internal, consumption => consumption);
	-- pragma synthesis_on
end Behavioral;









