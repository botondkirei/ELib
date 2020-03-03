library IEEE;
use IEEE.std_logic_1164.all;


package Pmonitor is 

	
	type Atype is protected
		procedure addArea(increment : real ;constant Domain : integer ) ;
		procedure reportArea(constant Domain : integer);
	end protected Atype;
	
	shared variable AM : Atype; 

	type Ptype is protected
		procedure inc(variable increment : real; constant PowerDomain : integer);
		procedure reportPower(constant PowerDomain: integer);
		procedure monitorInput(signal input: std_logic; constant C : real ; signal supply : real; constant PowerDomain : integer) ;	
	end protected Ptype;
	
	shared variable PM: Ptype;
	
	type real_array is array (1 to 16) of real;
	
end pmonitor;

package body  pmonitor is

	type Ptype is protected body
	
		variable socket : real_array := (others => 0.0);

		procedure inc (variable increment : real; constant PowerDomain : integer) is
		begin
			socket(PowerDomain) := socket(PowerDomain) + increment;
		end procedure;
		
		procedure reportPower(constant PowerDomain: integer) is
		begin
			report "PowerDomain " & integer'image (PowerDomain) & ": " & real'image(socket(PowerDomain));
		end procedure;
		
		procedure monitorInput(signal input: std_logic; constant C : real ; signal supply : real; constant PowerDomain : integer) is
			variable increment : real := 1.0;
		begin
			increment := supply*supply*C / 2.0;
			if input'event then
				inc(increment,PowerDomain);
			end if;
		end procedure;
		
	end protected body Ptype;
	
	type Atype is protected body
	
		variable totalArea : real_array := (others => 0.0);
	
		procedure addArea(increment : real ; constant Domain : integer) is
		begin
			totalArea(Domain) := totalArea(Domain) + increment;
		end procedure;
		
		procedure reportArea(constant Domain : integer) is
		begin
			report "Domain " & integer'image (Domain) & " area: " & real'image(totalArea(Domain));
		end procedure;
		
	end protected body Atype;
	

	
end package body;
