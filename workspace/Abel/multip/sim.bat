ghdl -a --std=08 ../../../PAelib_new/pmonitor.vhd
ghdl -a --std=08 ../../../PAelib_new/sxlib/inv1.vhd
ghdl -a --std=08 ../../../PAelib_new/sxlib/and2.vhd
ghdl -a --std=08 ../../../PAelib_new/sxlib/or2.vhd
ghdl -a --std=08 ../../../PAelib_new/sxlib/xor2.vhd
ghdl -a --std=08 ../../../PAelib_new/sxlib/nor2.vhd
ghdl -a --std=08 ../../../PAelib_new/sxlib/and3.vhd
ghdl -a --std=08 ../../../PAelib_new/sxlib/nand3.vhd
ghdl -a --std=08 ../../../PAelib_new/sxlib/or3.vhd
ghdl -a --std=08 ../../../PAelib_new/sxlib/or4.vhd

ghdl -a --ieee=synopsys --std=08 ./pack.vhd
ghdl -a --ieee=synopsys --std=08 ./Multiplier8.vhd
ghdl -a --ieee=synopsys --std=08 ./Multiplier8CG.vhd
ghdl -a --ieee=synopsys --std=08 ./test_multip.vhd
rem ghdl --elab-run --ieee=synopsys --std=08 Test_Mult8 --vcd=sim.vcd 
ghdl --elab-run --ieee=synopsys --std=08 Test_counter --vcd=sim.vcd 
gtkwave -A sim.vcd 
pause
