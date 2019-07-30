----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/18/2019 04:58:54 PM
-- Design Name: 
-- Module Name: get_IIR_area_DFI - get_area
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


library work;
use work.PECore.all;
use work.PEGates.all; 
use work.Nbits.all;


entity get_IIR_area_DFI is
--  Port ( );
end get_IIR_area_DFI;

architecture get_area of get_IIR_area_DFI is
    
    signal estim : estimation_type;
    signal clk : std_logic;
    signal power1: real;
begin


    area_IIR: IIR Generic map ( 
                N=>10,
                width =>4
                 )
        Port map ( -- pragma synthesis_off
               Vcc => 1.8,
               estimation => estim,
               -- pragma synthesis_on 
               x => (others => '1'),
               y => open,
               clk  =>clk, rst =>'1', load_coeff =>'1',
               coeff  => (others => '1')
               );
 
process begin
    wait for 100000 ns;
    assert false report "end of simulation" severity failure;
end process;

process begin
    clk<='1';
    wait for 5 ns;
    clk <= '0';
    wait for 5 ns;
end process;

pe : power_estimator generic map (time_window => 5000 ns) 
		             port map (estimation => estim, power => power1);

end get_area;
