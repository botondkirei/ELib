ghdl -a .\test_inv.vhd .\inv.vhd 
ghdl -e test_inv
ghdl -r test_inv --vcd=test.vcd 
gtkwave test.vcd  sim.gtkw