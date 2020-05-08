library IEEE;
use IEEE.std_logic_1164.all;


package Pmonitor is 

	
	type Atype is protected
		procedure addArea(increment : real ;constant Domain : integer ) ;
		procedure reportArea(constant Domain : integer);
	end protected Atype;
	
	shared variable AM : Atype; 

	type Ptype is protected
		procedure addLeackage(constant pleack: real ; constant Domain : integer);
		procedure inc(variable increment : real; constant Domain : integer);
		procedure reportPower(constant Domain: integer);
		procedure resetPower(constant Domain: integer);
		impure function getPower(constant Domain : integer) return real;
		procedure monitorInput(signal input: std_logic; constant C : real ; signal supply : real; constant Domain : integer) ;	
		procedure monitorInput(signal input: std_logic_vector; constant C : real ; signal supply : real; constant Domain : integer) ;	
	end protected Ptype;
	
	shared variable PM: Ptype;
	
	type real_array is array (1 to 16) of real;
	
end pmonitor;

package body  pmonitor is

	type Ptype is protected body
	
		variable socket : real_array := (others => 0.0);
		variable leack : real_array := (others => 0.0);
		
		procedure addLeackage(constant pleack: real ; constant Domain : integer) is
		begin
			leack(Domain) := leack(Domain) + pleack;
		end procedure;

		procedure inc (variable increment : real; constant Domain : integer) is
		begin
			socket(Domain) := socket(Domain) + increment;
		end procedure;
		
		procedure reportPower(constant Domain: integer) is
		begin
			report "Domain " & integer'image (Domain) & " dynamic power (Joule): " & real'image(socket(Domain));
			report "Domain " & integer'image (Domain) & " leackage power (nW): " & real'image(leack(Domain));
		end procedure;
		
		procedure resetPower(constant Domain: integer) is
		begin
			socket(Domain) := 0.0;
		end procedure;
		
		impure function getPower(constant Domain : integer) return real is
		begin
			return socket(Domain);
		end function;
		
		procedure monitorInput(signal input: std_logic; constant C : real ; signal supply : real; constant Domain : integer) is
			variable increment : real := 1.0;
		begin
			increment := supply*supply*C / 2.0;
			if input'event then
				inc(increment,Domain);
			end if;
		end procedure;

		procedure monitorInput(signal input: std_logic_vector; constant C : real ; signal supply : real; constant Domain : integer) is
			variable increment : real := 1.0;
		begin
			increment := supply*supply*C / 2.0;
			for i in 0 to input'length - 1 loop
				if input(i)'event then
					inc(increment,Domain);
				end if;
			end loop;
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
