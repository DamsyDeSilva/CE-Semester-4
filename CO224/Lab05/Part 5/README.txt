1.Compile
	iverilog -o cpu.vvp cpu_testbench.v

2.Run
	vvp cpu.vvp

3.Open with gtkwave tool
	gtkwave cpu_wavedata.vcd
