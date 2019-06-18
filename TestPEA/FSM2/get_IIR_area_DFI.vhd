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

library std;
use std.textio.all;

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
	Generic (N : integer := 20;
			 width : integer :=6);
end get_IIR_area_DFI;

architecture get_area of get_IIR_area_DFI is
    
    signal estim : estimation_type;

begin

    area_IIR: IIR Generic map ( 
                N=>N,
                width =>width
                 )
        Port map ( -- pragma synthesis_off
               Vcc => 0.0,
               estimation => estim,
               -- pragma synthesis_on 
               x => (others => '1'),
               y => open,
               clk  =>'1', rst =>'1', load_coeff =>'1',
               coeff  => (others => '1')
               );
 
process 
	variable l : line;
begin
    wait for 10 ns;
	write( l, real'image(estim.area));
	writeline( output, l );
    assert false report "end of simulation" severity failure;
end process;

end get_area;
