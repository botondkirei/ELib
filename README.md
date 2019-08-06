# Energy/Power/Area Aware Modeling (PEAAM)

Logic Design is facing new challanges with the development of integrated circuit (IC) manufacturing technologies. Due to the minimization of CMOS tranzistor sizes, the prelevant power dissipation source becomes the leakage current instead of capacitive switching. In this context, a power/energy/area estimated is required of the design in an early design stage (ie. RTL description) of digital systems. A such estimate of a new design  can be provided by applying the Energy/Power/Area Aware Modeling concept. Power Estimation Library (PElib), later Power and Aria Estimation Library (PAElib) consist of energy/power/area aware components that can be used in strctural descriptins and provides power and area estimation in an early design phase.  PAElib is written in VHDL, thus estimations are obtained in a VHDL simulator. Note that, the power/area estimation concept is suitable to be "translated" in any HDL language, Verilog or SystemC. 

There are other applications of the power/energy/area aware modeling concept, ie. the "digitization" of analog functional blocks. The effort to replace analog circuits with digital ones is propelled by the advantages offered by digital design flow: easy reuse of a design, scalability, portability, etc. For example, the achivement of an all-digital (fully synthesizable) frequency synthesizer could be a significant aid for IC designers, as its implementation would be carried out by an EDA software. As analog circuits are far more efficient then their digital counterparts - because analog components are customized and optimized for a certain functionality - early estimations of power and area characteristics of the digital implementation is required. Thus, a designer can make a comparison of an analog and digital implementation. Cosidering the example at hand, an all-digital frequency synthesizer can be desicrbed using HDL, but its power and area demand is found only after the synthesis and the technology mapping of the digital circuit itself. Moreover, power and area estimates are provided by specialized software, which are not royalty free. PAELib gives a free alternative for the designer in the assesment of power and area requirement.

A third application of the PEAAM concept is the estimation of power and area requirements agains the complexity of a circuit. 

# Repostory Organization

## PElib 

This directory hold the source code (currently in VHDL) of PElib. 

## TestPE

TestPE library is the test suite of PElib. The continuous development of the test suite is desired. Currently some simple circuits
(ring oscillator and finite state machines) were assambled using discrete electronic components form HCT family. Their implementation
was carried out using PElib. Measurement and simulation results are compared in the testsuite.

## docs

Project related publications. The test circuits used in the suite are given in these papers.

# References

[1] B. S. Kirei, V.-I.-M. Chereja, S. Hintea, M. D. Topa, "PAELib: A VHDL Library for Area and Power Dissipation Estimation of CMOS Logic Circuits," Advances in Electrical and Computer Engineering, vol.19, no.1, pp.9-16, 2019, doi:10.4316/AECE.2019.01002
[2] Verginia-Iulia-Maria Chereja, Adriana-Ioana Potarniche, Sergiu-Alex Ranga, Botond Sandor Kirei și Marina Dana Țopa, "Power Dissipation Estimation of CMOS Digital Circuits at the Gate Level in VHDL",  International Symposium on Electronics and Telecommunications 2018, Nov. 7-9, Timisoara, Romania 
