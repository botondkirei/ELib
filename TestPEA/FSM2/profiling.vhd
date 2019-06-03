-- VHDL package for profiling
-- collect functions for resue in profiling of modules
library ieee;
use ieee.std_logic_1164.all;


package profiling  is 

	component lfsr is
	generic (width : integer range 1 to 16) ;
    Port ( clk : in STD_LOGIC;
           aleator : out STD_LOGIC_VECTOR (width - 1 downto 0));
	end component;

end package;

library ieee;
  use ieee.std_logic_1164.all;

entity lfsr is
	generic (width : integer range 1 to 16) ;
    Port ( clk : in STD_LOGIC;
           aleator : out STD_LOGIC_VECTOR (width - 1 downto 0));
end lfsr;

architecture Behavioral of lfsr is
    
    signal shift : std_logic_vector(15 downto 0):= x"ABCD";

begin

    aleator <= shift(width - 1 downto 0);
    
    process (clk)
    begin
        if rising_edge(clk) then
            shift(14 downto 0) <= shift(15 downto 1);
            shift(15) <= shift(5) xnor shift(3);
        end if;
    end process;

end Behavioral;