ghdl -a --std=08 ../../../PAelib_new/pmonitor.vhd
ghdl -a --std=08 ../../../PAelib_new/sxlib/inv1.vhd
ghdl -a --std=08 ../../../PAelib_new/sxlib/and2.vhd
ghdl -a --std=08 ./circuit.vhd
ghdl -a --std=08 ./test.vhd
ghdl --elab-run --std=08 test --vcd=sim.vcd 
gtkwave -A sim.vcd 
pause
