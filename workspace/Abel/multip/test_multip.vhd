
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_arith.all;  
use ieee.std_logic_unsigned.all;

use work.components.all;
use work.pmonitor.all; 

entity Test_Mult8 is end;

architecture Driver of Test_Mult8 is
 
    component Mult8
    generic ( Domain: integer := 1);
	port (
		--pragma synthesis_off
		vcc : in real;
		--pragma synthesis_on   
		A,B : 	in std_logic_Vector(3 downto 0);
		Start : in std_logic;
		Clk : in std_logic;
		Reset : in std_logic;
		Result : out std_logic_Vector(7 downto 0);
		Done : out std_logic );
     end component;
     
    component Mult8CG
    generic ( Domain: integer := 1);
	port (
		--pragma synthesis_off
		vcc : in real;
		--pragma synthesis_on   
		A,B : 	in std_logic_Vector(3 downto 0);
		Start : in std_logic;
		Clk : in std_logic;
		Reset : in std_logic;
		Result : out std_logic_Vector(7 downto 0);
		Done : out std_logic );
     end component;

     signal A,B : std_logic_Vector(3 downto 0);
     signal Start, Done1, Done2 : std_logic := '0' ;
     signal CLK : std_logic ;
     signal Reset : std_logic;
     signal Result1, Result2 : std_logic_Vector ( 7 downto 0);

begin
 
	UUT: Mult8 generic map (Domain => 1) port map (3.3,A,B,Start,CLK,Reset,Result1, Done1);
	UUT_CG: Mult8CG generic map (Domain => 2) port map (3.3, A,B,Start,CLK,Reset,Result2, Done2);

	Clock_generation: process
	begin
		clk <= '0';
		wait for 5 ns;
		clk <= '1';
		wait for 5 ns;
	end process;

	Reset <= '0', '1' after 10 ns;
	Stimulus: process
	begin
		--report "start simulation" severity note;
		PM.RESETPOWER(1);
		PM.RESETPOWER(2);
		
		wait until RESET = '1';
		for i in 2 to 5 loop
			for j in 4 to 7 loop
				--report "inner loop" severity note;
				A <= Conv_std_logic_vector (i, A'Length );
				B <= Conv_std_logic_vector (j, B'Length ); 
				wait until CLK'Event and CLK='1';
				Start <='1', '0' after 10 ns;
				wait until Done1 ='1';
				assert (Result1 = Result2) report "product incorrect" severity error;
				wait until CLK'Event and CLK = '1';
			end loop;
		end loop;
		AM.REPORTAREA(1);
		AM.REPORTAREA(2);
		PM.REPORTPOWER(1);
		PM.REPORTPOWER(2);
		assert false report "End Simulation" severity failure;
		end process;

  end; 
