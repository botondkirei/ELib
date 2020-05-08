ghdl -a --ieee=synopsys --std=08 ./pack.vhd
ghdl -a --ieee=synopsys --std=08 ./Multiplier8.vhd
ghdl -a --ieee=synopsys --std=08 ./Multiplier8CG.vhd
ghdl -a --ieee=synopsys --std=08 ./test_multip.vhd
ghdl --elab-run --ieee=synopsys --std=08 Test_Mult8 --vcd=sim.vcd 
gtkwave -A sim.vcd 
pause
