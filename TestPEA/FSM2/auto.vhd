library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;
use work.PECore.all;
use work.PEGates.all;
use work.Nbits.all;-- ca sa scoti toate erorile de aici, in modulul pe_Nbits.vhd trebuie sa comentezi total componenta multip.vhd

package auto is 

component auto_behavioral is
generic (width:integer:=32; --4/8/16/32
	delay : time := 0 ns ;
    logic_family : logic_family_t := default_logic_family; -- the logic family of the component
    Cload : real := 0.0 -- capacitive load
    );
port(
	 -- pragma synthesis_off
	 Vcc : in real ; -- supply voltage
     estimation : out estimation_type := est_zero;
     -- pragma synthesis_on
     clk,rn : in std_logic;
	 a : in std_logic;
	 loadLO : inout std_logic;
	 loadHI, loadM, shft, rsthi, done : out std_logic);
end component;


component auto_structural is
generic (width:integer:=32; --4/8/16/32
	delay : time := 0 ns ;
    logic_family : logic_family_t := default_logic_family; -- the logic family of the component
    Cload : real := 0.0 -- capacitive load
    );
port(
     -- pragma synthesis_off
	 Vcc : in real ; -- supply voltage
     estimation : out estimation_type := est_zero;
     -- pragma synthesis_on
     clk,rn : in std_logic;
	 a : in std_logic;
	 loadLO : inout std_logic;
	 loadHI, loadM, shft, rsthi, done : out std_logic);
end component;

end package;


library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;
use work.PECore.all;
use work.PEGates.all;
use work.Nbits.all;

entity auto_behavioral is
generic (
    width:integer:=32; --4/8/16/32
	delay : time := 0 ns ;
    logic_family : logic_family_t := default_logic_family; -- the logic family of the component
    Cload : real := 0.0 -- capacitive load
    );
port(
	 -- pragma synthesis_off
	 Vcc : in real ; -- supply voltage
     estimation : out estimation_type := est_zero;
     -- pragma synthesis_on
     clk,rn : in std_logic;
	 a : in std_logic;
	 loadLO : inout std_logic;
	 loadHI, loadM, shft, rsthi, done : out std_logic);
end entity;

architecture Behavioral of auto_behavioral is
type state_t is (start, adunare, deplasare, gata);
signal current_state, next_state : state_t;
signal cnt : integer :=0;


begin

	process(clk)
	begin
		if rising_edge (clk) then --registru
			if rn = '0' then
				current_state <= gata;
			else
				current_state <= next_state;
			end if;
		end if;
	end process; ---------------------------------

	process (current_state, a, cnt, rn)
	begin
		if rn='0' then
			next_state <= gata;
		else
			case (current_state) is
			when start =>
				if (a = '1') then
					next_state <= adunare;
				else
					next_state <= deplasare; 
				end if;

			when adunare =>
				next_state <= deplasare;

			when deplasare =>
				if (cnt = width) then
					next_state <= gata;
				else
					next_state <= start;
				end if;
			when gata =>
				next_state <= start;

			when others =>
				next_state <= gata;
			end case;
		end if;
	end process;

	process (clk)
	begin
		if rising_edge (clk) then
			if current_state = gata then
				cnt <= 0;
			else if current_state = start then
				cnt <= cnt+1;
				end if;
			end if;
		end if;
	end process;

loadHI <='1' when current_state = adunare else '0';
loadLO <='1' when current_state = gata else '0';
loadM <= loadLO;
shft <= '1' when current_state = deplasare else '0';
rsthi <='0' when current_state = gata else '1';
done <='1' when current_state = gata else '0';

-- pragma synthesis_off
estimation <= est_zero;
-- pragma synthesis_on



end architecture;




library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;
use work.PECore.all;
use work.PEGates.all;
use work.Nbits.all;

entity auto_structural is
generic (width:integer:=32; --4/8/16/32
	delay : time := 0 ns ;
    logic_family : logic_family_t := default_logic_family; -- the logic family of the component
    Cload : real := 0.0 -- capacitive load
    );
port(
	 -- pragma synthesis_off
	 Vcc : in real ; -- supply voltage
     estimation : out estimation_type := est_zero;
     -- pragma synthesis_on
     clk,rn : in std_logic;
	 a : in std_logic;
	 loadLO : inout std_logic;
	 loadHI, loadM, shft, rsthi, done : out std_logic
	 );
end entity;
architecture Structural of auto_structural is

signal Q1, Q0, Q1n, Q0n, rnn, an : std_logic ;
signal D1, D0 : STD_LOGIC; 
signal eq, loadLO0, done0, Loadhi1: std_logic;

signal product : std_logic_vector(1 to 4);
signal cnt : std_logic_vector(width-1 downto 0);
signal cnt_en, en, enn : std_logic;
-- pragma synthesis_off
signal estim : estimation_type_array(1 to 20) := (others => est_zero);
type state is (load,add,shift,stop, error);
signal disp_state : state;
-- pragma synthesis_on

begin
compare_cnt_width1: comparator generic map (width => 2, delay => delay, logic_family => logic_family ) 
        port map ( 
        -- pragma synthesis_off
        Vcc => Vcc, estimation => estim(1),
        -- pragma synthesis_on
        x(0) => Q0, x(1) => Q1, y(0) => '0' , y(1) => '0', EQI => '1', EQO => cnt_en);
compare_cnt_width2: comparator generic map (width => width, delay => delay, logic_family => logic_family ) 
        port map (
        -- pragma synthesis_off
        Vcc => Vcc, estimation => estim(2),
        -- pragma synthesis_on
        x => cnt,  y => std_logic_vector(to_unsigned(width,width)), EQI => '1', EQO => eq);
compare_cnt_width3: comparator generic map (width => 2, delay => delay, logic_family => logic_family ) 
        port map ( 
        -- pragma synthesis_off
        Vcc => Vcc, estimation => estim(3),
        -- pragma synthesis_on
        x(0) => Q0, x(1) => Q1, y(0) => '1' , y(1) => '1', EQI => '1', EQO => en);
--counter
inv6: inv_gate generic map (delay => 0 ns, logic_family => logic_family ) 
        port map (
        -- pragma synthesis_off
        Vcc => Vcc, estimation => estim(4),
        -- pragma synthesis_on
        a => en, y => enn);
counter : counter_we_Nbits generic  map (width => width, delay => delay, logic_family => logic_family ) 
        port map (
        -- pragma synthesis_off
        Vcc => Vcc, estimation => estim(5),
        -- pragma synthesis_on
         CLK => clk, Rn => enn ,En => cnt_en, Q => cnt);
--inversoarele
inv4: inv_gate generic map (delay => 0 ns, logic_family => logic_family ) 
        port map (
        -- pragma synthesis_off
        Vcc => Vcc, estimation => estim(20),
        -- pragma synthesis_on
        a => a, y => an);
inv5: inv_gate generic map (delay => 0 ns, logic_family => logic_family ) 
        port map (
        -- pragma synthesis_off
        Vcc => Vcc, estimation => estim(6),
        -- pragma synthesis_on
        a => rn, y => rnn);

-- -- D2
-- and5_gate1: and5_gate generic map(delay => 0 ns, logic_family => logic_family) port map(a => Q2n, b => Q1n, c => Q0n, d => an ,e => rn , y => D2, Vcc => Vcc, estimation => estim(8));
-- -- D1
-- and_gate2: and4_gate generic map (delay => delay, logic_family => logic_family) port map (a => Q2n, b => Q1, c => Q0n, d => eq, y => net(1), Vcc => Vcc, estimation => estim(9));
-- and_gate3: and3_gate generic map (delay => delay, logic_family => logic_family) port map (a => Q2 , b => Q1n , c => Q0n, y => net(2), Vcc => Vcc, estimation => estim(10));
-- and_gate4: and3_gate generic map (delay => delay, logic_family => logic_family) port map (a => Q2n , b => Q1n , c => Q0, y => net(3), Vcc => Vcc, estimation => estim(11));
-- or_gate1: or4_gate generic map (delay => delay, logic_family => logic_family) port map (a => net(1), b => net(2), c => net(3), d => rnn, y => D1, Vcc => Vcc, estimation => estim(12));
-- -- D0
-- and_gate5: and4_gate generic map (delay => delay, logic_family => logic_family) port map (a => Q2n, b => Q1, c => Q0n, d => eq, y => net(4), Vcc => Vcc, estimation => estim(13));
-- and_gate6: and4_gate generic map (delay => delay, logic_family => logic_family) port map (a => Q2n, b => Q1n, c => Q0n, d => a, y => net(5), Vcc => Vcc, estimation => estim(14));
-- or_gate2: or3_gate generic map (delay => delay, logic_family => logic_family) port map (a => net(4), b => net(5), c => rnn, y => D0, Vcc => Vcc, estimation => estim(15));

--Product 1
and_gate1: and3_gate generic map (delay => delay, logic_family => logic_family) 
        port map (
        -- pragma synthesis_off
        Vcc => Vcc, estimation => estim(7),
        -- pragma synthesis_on
        a => Q1 , b => Q0n , c => eq, y => product(1));
--Product 2
and_gate2: and3_gate generic map (delay => delay, logic_family => logic_family) 
        port map (
        -- pragma synthesis_off
        Vcc => Vcc, estimation => estim(8),
        -- pragma synthesis_on
        a => Q1n , b => Q0n , c => a, y => product(2));
--Product 3
and_gate3: and_gate generic map (delay => delay, logic_family => logic_family) 
        port map (
        -- pragma synthesis_off
        Vcc => Vcc, estimation => estim(9),
        -- pragma synthesis_on
        a => Q1n , b => an , y => product(3));
--Product 4
and_gate4: and_gate generic map (delay => delay, logic_family => logic_family) 
        port map (
        -- pragma synthesis_off
        Vcc => Vcc, estimation => estim(10),
        -- pragma synthesis_on
        a => Q1n , b => Q0 , y => product(4));

--D1
or_gate1: or4_gate generic map (delay => delay, logic_family => logic_family) 
        port map (
        -- pragma synthesis_off
        Vcc => Vcc, estimation => estim(11),
        -- pragma synthesis_on
        a => product(1), b => product(3), c => product(4), d => rnn, y => D1);
--D0
or_gate2: or3_gate generic map (delay => delay, logic_family => logic_family) 
        port map (
        -- pragma synthesis_off
        Vcc => Vcc, estimation => estim(12),
        -- pragma synthesis_on
        a => product(1), b => product(2), c => rnn, y => D0);

--bistabilele
--dff2: dff_Nbits generic map( active_edge => true, delay => delay, logic_family => logic_family ) port map ( D => D2, Ck => clk, Rn => '1', Q => Q2, Qn => Q2n, Vcc => Vcc, estimation => estim(16));
dff1: dff_Nbits generic map( active_edge => true, delay => 0 ns, logic_family => logic_family ) 
        port map (
        -- pragma synthesis_off
        Vcc => Vcc, estimation => estim(13),
        -- pragma synthesis_on
         D => D1, Ck => clk, Rn => '1', Q => Q1, Qn => Q1n);
dff0: dff_Nbits generic map( active_edge => true, delay => delay, logic_family => logic_family ) 
        port map (
        -- pragma synthesis_off
        Vcc => Vcc, estimation => estim(14),
        -- pragma synthesis_on
         D => D0, Ck => clk, Rn => '1', Q => Q0, Qn => Q0n);
 
--loadHI <='1' when current_state = adunare else '0';
--compare1: comparator generic map (width => 3, delay => delay, logic_family => logic_family ) port map ( x(0) => Q0, x(1) => Q1, x(2) => Q2,  y(0) => '1' , y(1) => '0',  y(2) => '0' , EQI => '1', EQO => loadHI, Vcc => Vcc, estimation => estim(19));
compare1: comparator generic map (width => 2, delay => delay, logic_family => logic_family ) 
        port map ( 
        -- pragma synthesis_off
        Vcc => Vcc, estimation => estim(15),
        -- pragma synthesis_on
        x(0) => Q0, x(1) => Q1, y(0) => '1' , y(1) => '0',  EQI => '1', EQO => loadHI1);
--loadLO <='1' when current_state = gata else '0';                                                                                                                      
compare2: comparator generic map (width => 2, delay => delay, logic_family => logic_family ) 
        port map ( 
        -- pragma synthesis_off
        Vcc => Vcc, estimation => estim(16),
        -- pragma synthesis_on
        x(0) => Q0, x(1) => Q1, y(0) => '1' , y(1) => '1',  EQI => '1', EQO => loadLO0);
--shft <= '1' when current_state = deplasare else '0';                                                                                                                        
compare3: comparator generic map (width => 2, delay => delay, logic_family => logic_family ) 
        port map (
        -- pragma synthesis_off
        Vcc => Vcc, estimation => estim(17),
        -- pragma synthesis_on
         x(0) => Q0, x(1) => Q1, y(0) => '0' , y(1) => '1',  EQI => '1', EQO => shft);
--done0                                                                                                                        
compare4: comparator generic map (width => 2, delay => delay, logic_family => logic_family ) 
        port map ( 
        -- pragma synthesis_off
        Vcc => Vcc, estimation => estim(18),
        -- pragma synthesis_on
        x(0) => Q0, x(1) => Q1, y(0) => '1' , y(1) => '1',  EQI => '1', EQO => done0);
--rsthi
inv7 : inv_gate generic map (delay => 0 ns, logic_family => logic_family ) 
        port map (
        -- pragma synthesis_off
        Vcc => Vcc, estimation => estim(19),
        -- pragma synthesis_on
        a => done0, y => rsthi);


loadLO <= loadLO0;
loadM <= loadLO0;
done <= done0;
Loadhi <= Loadhi1;

-- pragma synthesis_off
sum_up_i : sum_up generic map (N => 20) port map (estim => estim, estimation => estimation);
process (Q1, Q0)
	variable curr_state : std_logic_vector(1 downto 0);
begin
	curr_state := Q1 & Q0;
	case curr_state is
		when "00" => disp_state <= load;
		when "01" => disp_state <= add;
		when "10" => disp_state <= shift;
		when "11" => disp_state <= stop;
		when others => disp_state <= error;
	end case;
end process;
-- pragma synthesis_on

end Structural;


