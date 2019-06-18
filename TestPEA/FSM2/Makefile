
GHDL=c:\GHDL\0.36-mingw32-mcode\bin\ghdl.exe
GHDLFLAGS=
GHDLRUNFLAGS= --vcd=dump.vcd

# Default target : elaborate
all : elab

# Elaborate target.  Almost useless
elab : force
	$(GHDL) -c $(GHDLFLAGS) -e get_IIR_area_DFI

# Run target
run : force
	$(GHDL) -c $(GHDLFLAGS) -r get_IIR_area_DFI $(GHDLRUNFLAGS)

# Targets to analyze libraries
init: force
	$(GHDL) -a $(GHDLFLAGS) ..\..\PAELib\VHDL\PECore.vhd
	$(GHDL) -a $(GHDLFLAGS) ..\..\PAELib\VHDL\PEGates.vhd
	$(GHDL) -a $(GHDLFLAGS) ..\..\PAELib\VHDL\Nbits.vhd
	$(GHDL) -a $(GHDLFLAGS) .\get_IIR_area_DFI.vhd
#	$(GHDL) -a $(GHDLFLAGS) .\test_multiplicator.vhd
	$(GHDL) -a $(GHDLFLAGS) .\auto.vhd
	$(GHDL) -a $(GHDLFLAGS) .\multiplicator.vhd

force:
