ghdl -a --std=08 ../../../PAelib_new/pmonitor.vhd
ghdl -a --std=08 ../../../PAelib_new/sxlib/inv1.vhd
rem ghdl -a --std=08 ../../../PAelib_new/sxlib/and2.vhd
rem ghdl -a --std=08 ../../../PAelib_new/sxlib/and4.vhd
ghdl -a --std=08 ../../../PAelib_new/sxlib/or2.vhd
rem ghdl -a --std=08 ../../../PAelib_new/sxlib/xor2.vhd
rem ghdl -a --std=08 ../../../PAelib_new/sxlib/nor2.vhd
ghdl -a --std=08 ../../../PAelib_new/sxlib/and3.vhd
rem ghdl -a --std=08 ../../../PAelib_new/sxlib/nand3.vhd
rem ghdl -a --std=08 ../../../PAelib_new/sxlib/or3.vhd
rem ghdl -a --std=08 ../../../PAelib_new/sxlib/or4.vhd

ghdl -a --ieee=synopsys --std=08 ./pack.vhd
rem ghdl -a --ieee=synopsys --std=08 ./Multiplier8.vhd
rem ghdl -a --ieee=synopsys --std=08 ./Multiplier8CG.vhd
rem ghdl -a --ieee=synopsys --std=08 ./test_multip.vhd
rem ghdl --elab-run --ieee=synopsys --std=08 Test_Mult8 --vcd=sim.vcd 
rem ghdl --elab-run --ieee=synopsys --std=08 Test_automat --vcd=sim.vcd 
ghdl --elab-run --ieee=synopsys --std=08 Test_comp_3biti --vcd=sim.vcd 
gtkwave -A sim.vcd 
pause
