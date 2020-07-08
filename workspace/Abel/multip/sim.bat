ghdl -a --std=08 ../../../PAelib_new/pmonitor.vhd
ghdl -a --std=08 ../../../PAelib_new/sxlib/inv1.vhd
ghdl -a --std=08 ../../../PAelib_new/sxlib/and2.vhd
ghdl -a --std=08 ../../../PAelib_new/sxlib/and4.vhd
ghdl -a --std=08 ../../../PAelib_new/sxlib/nor2.vhd
ghdl -a --std=08 ../../../PAelib_new/sxlib/nor3.vhd
ghdl -a --std=08 ../../../PAelib_new/sxlib/xor2.vhd
ghdl -a --std=08 ../../../PAelib_new/sxlib/nor2.vhd
ghdl -a --std=08 ../../../PAelib_new/sxlib/and3.vhd
ghdl -a --std=08 ../../../PAelib_new/sxlib/nand3.vhd
ghdl -a --std=08 ../../../PAelib_new/sxlib/or2.vhd
ghdl -a --std=08 ../../../PAelib_new/sxlib/or3.vhd
ghdl -a --std=08 ../../../PAelib_new/sxlib/or4.vhd

ghdl -a --ieee=synopsys --std=08 ./pack.vhd
ghdl -a --ieee=synopsys --std=08 ./Multiplier2N.vhd
ghdl -a --ieee=synopsys --std=08 ./Multiplier2NCG.vhd
ghdl -a --ieee=synopsys --std=08 ./test_multip2N.vhd
ghdl --elab-run --ieee=synopsys --std=08 Test_Mult2N --vcd=sim.vcd 
rem ghdl --elab-run --ieee=synopsys --std=08 Test_Counter --vcd=sim.vcd 
rem ghdl --elab-run --ieee=synopsys --std=08 Test_automat --vcd=sim.vcd 
rem ghdl --elab-run --ieee=synopsys --std=08 Test_comp_3biti --vcd=sim.vcd 
rem ghdl --elab-run --ieee=synopsys --std=08 Test_controller --vcd=sim.vcd 
gtkwave -A sim.vcd 
pause
