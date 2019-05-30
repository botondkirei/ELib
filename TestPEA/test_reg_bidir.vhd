library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.PECore.all;
use work.PEGates.all;
use work.Nbits.all;

entity test_reg_bidir is
	generic (width:integer:=4;
	         N : real := 30.0);
end entity;

architecture test of test_reg_bidir is
	
	signal clk, clear, S1, S0, SR, SL : std_logic;
	signal D,Q : std_logic_vector (width-1 downto 0);--8/16/32/64
	constant vcc : real := 5.0;
	constant period : time := 33 ns;
	signal estim: estimation_type;
	signal power1: real := 0.0;

	procedure load (signal clk, clear : in std_logic;
					signal D: inout std_logic_vector (width-1 downto 0);
					signal S1, S0 : out std_logic;
					signal Q: in std_logic_vector (width-1 downto 0)) is
	begin 
		D <= (others => '1');
		S0 <= '1';
		S1 <= '1';			
		wait until rising_edge(clk);   
    end procedure;
    
    procedure noop (signal clk, clear : in std_logic;
					signal D: out std_logic_vector (width-1 downto 0);
					signal S1, S0: out std_logic;
					signal Q: in std_logic_vector (width-1 downto 0)) is
	begin 
		S0 <= '0';
		S1 <= '0';
		wait until rising_edge(clk);  
    end procedure;
    
    procedure sft_left (signal clk, clear : in std_logic;
					signal D: out std_logic_vector (width-1 downto 0);
					signal S1, S0, SL : out std_logic;
					signal Q: in std_logic_vector (width-1 downto 0)) is
	begin 
		SL <= '0';
		S0 <= '0';
		S1 <= '1';
		wait until rising_edge(clk);
    end procedure;
    
    procedure sft_right (signal clk, clear : in std_logic;
					signal D: out std_logic_vector (width-1 downto 0);
					signal S1, S0, SR : out std_logic;
					signal Q: in std_logic_vector (width-1 downto 0)) is
	begin 
		SR <= '0';
		S0 <= '1';
		S1 <= '0';
		wait until rising_edge(clk);
    end procedure;

begin

uut : reg_bidirectional generic map ( width =>  width )
    port map (  
           --synthesis off
           Vcc => Vcc,
           estimation => estim, 
           --synthesis on
           D => D,
           Clear => clear,
           CK => clk,
           S1 => S1,
		   S0 => S0,
           SR => SR,
		   SL => SL,
           Q  => Q
           );
           
clear <='0', '1' after 10 ns;

process
	begin
	clk <= '0';
	wait for 10 ns;
	clk <= '1';
	wait for 10 ns;
end process;

test_sequence : process
begin
    noop (clk => clk, clear => clear, D => D,  S1 => S1, S0 => S0, Q=> Q);
    noop (clk => clk, clear => clear, D => D,  S1 => S1, S0 => S0, Q=> Q);
    load (clk => clk, clear => clear, D => D,  S1 => S1, S0 => S0, Q=> Q);
    noop (clk => clk, clear => clear, D => D,  S1 => S1, S0 => S0, Q=> Q);
    noop (clk => clk, clear => clear, D => D,  S1 => S1, S0 => S0, Q=> Q);
    sft_right (clk => clk, clear => clear, D => D,  S1 => S1, S0 => S0, SR =>SR, Q=> Q);
    load (clk => clk, clear => clear, D => D,  S1 => S1, S0 => S0, Q=> Q);
    sft_left (clk => clk, clear => clear, D => D,  S1 => S1, S0 => S0, SL => SL, Q=> Q);
    noop (clk => clk, clear => clear, D => D,  S1 => S1, S0 => S0, Q=> Q);
    noop (clk => clk, clear => clear, D => D,  S1 => S1, S0 => S0, Q=> Q);
    assert false report "end simulation!" severity failure;
end process;
pe1 : power_estimator generic map (time_window => N * period) 
		             port map (estimation => estim, power => power1);

end architecture;
