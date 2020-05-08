
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_arith.all;  
use ieee.std_logic_unsigned.all;

use work.components.all;

entity Test_Mult8 is end;

architecture Driver of Test_Mult8 is 
    component Mult8
       port(A,B : in std_logic_Vector(3 downto 0);
            Start : in std_logic;
            CLK : in std_logic;
            Reset : in std_logic;
            Result: out std_logic_Vector(7 downto 0);
            Done : out std_logic;
	    consum: out real := 0.0);
     end component;
    component Mult8CG
       port(A,B : in std_logic_Vector(3 downto 0);
            Start : in std_logic;
            CLK : in std_logic;
            Reset : in std_logic;
            Result: out std_logic_Vector(7 downto 0);
            Done : out std_logic;
	    consum: out real := 0.0);
     end component;

     signal A,B : std_logic_Vector(3 downto 0);
     signal Start, Done1, Done2 : std_logic := '0' ;
     signal CLK : std_logic ;
     signal Reset : std_logic;
     signal Result1, Result2 : std_logic_Vector ( 7 downto 0);
     signal consum1, energie1, consum2, energie2 : real :=0.0;

begin
 
      UUT: Mult8 port map (A,B,Start,CLK,Reset,Result1, Done1, consum1);
      UUT_CG: Mult8CG port map (A,B,Start,CLK,Reset,Result2, Done2, consum2);

 process
	begin
		clk <= '0';
		wait for 5 ns;
		clk <= '1';
		wait for 5 ns;
	end process;

      Reset <= '0', '1' after 10 ns;
      Stimulus:
          process
          begin
		wait until RESET = '1';
              for i in 2 to 5 loop
                   for j in 4 to 7 loop
                       A <= Conv_std_logic_vector (i, A'Length );
                       B <= Conv_std_logic_vector (j, B'Length ); 
                       wait until CLK'Event and CLK='1';
                       Start <='1', '0' after 20 ns;
                       wait until Done1 ='1';
                       wait until CLK'Event and CLK = '1';
                    end loop;
                end loop;
           assert false report "End Simulation" severity failure;
           end process;
	energie1 <= 5.0*5.0*consum1*0.5;
	energie2 <= 5.0*5.0*consum2*0.5;
  end; 
