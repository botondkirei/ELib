
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;
--use ieee.std_logic_arith.all;  
--use ieee.std_logic_unsigned.all;

use work.components.all;
use work.pmonitor.all; 

entity Test_Mult2N is 
	generic ( N : integer := 4;
			  log2N : integer := 2);
end entity;

architecture Driver of Test_Mult2N is
 
    component Mult2N
    generic ( Domain: integer := 1;
				 N : integer := 4;
				 log2n : integer := 2);
	port (
		--pragma synthesis_off
		vcc : in real;
		--pragma synthesis_on   
		A,B : 	in std_logic_Vector(N-1 downto 0);
		Start : in std_logic;
		Clk : in std_logic;
		Reset : in std_logic;
		Result : out std_logic_Vector(2*N-1 downto 0);
		Done : out std_logic );
     end component;
     
    component Mult2NCG
    generic ( Domain: integer := 1;
				N : integer := 4;
				log2n : integer := 2);
	port (
		--pragma synthesis_off
		vcc : in real;
		--pragma synthesis_on   
		A,B : 	in std_logic_Vector(N-1 downto 0);
		Start : in std_logic;
		Clk : in std_logic;
		Reset : in std_logic;
		Result : out std_logic_Vector(2*N-1 downto 0);
		Done : out std_logic );
     end component;

     signal A,B : std_logic_Vector(N-1 downto 0);
     signal Start, Done1, Done2 : std_logic := '0' ;
     signal CLK : std_logic ;
     signal Reset : std_logic;
     signal Result1, Result2 : std_logic_Vector (2*N-1 downto 0);
     

begin
 
	UUT: Mult2N generic map (Domain => 1, N => N, log2N => log2N ) port map (3.3,A,B,Start,CLK,Reset,Result1, Done1);
	UUT_CG: Mult2NCG generic map (Domain => 2, N => N, log2N => log2N) port map (3.3, A,B,Start,CLK,Reset,Result2, Done2);

	Clock_generation: process
	begin
		clk <= '0';
		wait for 5 ns;
		clk <= '1';
		wait for 5 ns;
	end process;

	Reset <= '0', '1' after 10 ns;
	Stimulus: process
	
	     variable seed1, seed2 : integer := 999;
     
		impure function rand_slv(len : integer) return std_logic_vector is
			variable r : real;
			variable slv : std_logic_vector(len - 1 downto 0);
		begin
			for i in slv'range loop
				uniform(seed1, seed2, r);
				slv(i) := '1' when r > 0.5 else '0';
			end loop;
			return slv;
		end function; 
		
		variable op_a, op_b, res : integer;
		
	begin
	
		wait until RESET = '1';
		for i in 1 to 1000 loop
			A <= rand_slv(N);
			B <= rand_slv(N); 
			wait until CLK'Event and CLK='1';
			Start <='1', '0' after 10 ns;
			wait until Done1 ='1';
			assert (Result1 = Result2) report "implementation mismathc " severity error;
			op_a := to_integer(unsigned(A));
			op_b := to_integer(unsigned(B));
			res  := to_integer(unsigned(Result1));
			assert (op_a * op_b = res) report "product incorrect at: " & time'image(now) severity error;
			wait until CLK'Event and CLK = '1';
		end loop;
	end process;
		
	execution_control: process
	begin
		PM.RESETPOWER(1);
		PM.RESETPOWER(2);	
		wait for 30000 ns;
		AM.REPORTAREA(1);
		AM.REPORTAREA(2);
		PM.REPORTPOWER(1);
		PM.REPORTPOWER(2);
		assert false report "End Simulation" severity failure;				
	end process;


  end; 
  

